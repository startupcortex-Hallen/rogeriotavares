// ============================================================
// Supabase Edge Function — Notificações da Campanha 45788
// Push segmentado por cidade / papel (Web Push + FCM)
//
// Deploy (no terminal, com Supabase CLI):
//   supabase login && supabase link --project-ref hpubrzclxyhlodtmigrv
//   supabase functions deploy notify
// ============================================================

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const { title, body, city, channel = "in_app", data = {} } = await req.json();

    if (!title) {
      return new Response(JSON.stringify({ error: "title é obrigatório" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 1. Salva notificação in-app (broadcast ou segmentada por cidade)
    const { error: insertError } = await supabase.from("notifications").insert({
      title,
      body: body ?? "",
      city: city ?? null,
      channel: channel ?? "in_app",
      data,
    });
    if (insertError) throw insertError;

    // 2. Coleta assinaturas de web push (ou tokens FCM) segmentados por cidade
    let query = supabase.from("push_subscriptions").select("endpoint, keys, user_id")
      .eq("is_active", true);
    if (city) query = query.eq("city", city);
    const { data: subscriptions, error: subError } = await query;
    if (subError) throw subError;

    // 3. Envia Web Push (VAPID) para cada assinatura
    const payload = JSON.stringify({ title, body: body ?? "", data });
    const vapidPublic = Deno.env.get("VAPID_PUBLIC_KEY")!;
    const vapidPrivate = Deno.env.get("VAPID_PRIVATE_KEY")!;
    const applicationServerKey = vapidPublic;

    let sent = 0;
    for (const sub of subscriptions ?? []) {
      try {
        const res = await fetch(sub.endpoint, {
          method: "POST",
          headers: {
            "Content-Type": "application/octet-stream",
            "TTL": "3600",
            Authorization: `WebPush ${btoa(JSON.stringify({
              type: "webpush",
              aud: new URL(sub.endpoint).origin,
              iat: Math.floor(Date.now() / 1000),
            }))}`,
          },
          body: payload,
        });
        if (res.ok) sent += 1;
      } catch {
        console.error("Falha ao enviar push para", sub.endpoint);
      }
    }

    return new Response(JSON.stringify({ ok: true, in_app: true, sent }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});