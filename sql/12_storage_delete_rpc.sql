-- ============================================================
-- 12_storage_delete_rpc.sql — REMOÇÃO DE FOTOS À PROVA DE RLS
--
-- O Supabase, em alguns ambientes, não cria corretamente as
-- políticas de DELETE em storage.objects (upload funciona, delete
-- responde 403 AccessDenied).
--
-- Esta função executa a remoção com privilégio de admim
-- (SECURITY DEFINER) e só pode ser chamada por um usuário
-- com papel admin. Use no painel: a foto antiga é removida
-- automaticamente ao trocar a imagem.
-- Idempotente.
-- ============================================================

create or replace function public.admin_delete_storage_object(p_bucket text, p_path text)
returns boolean
language plpgsql security definer set search_path = storage, public
as $$
begin
  -- Somente papel admin (registro ativo)
  if not public.is_admin() then
    return false;
  end if;

  delete from storage.objects
  where bucket_id = p_bucket and name = p_path;

  return found;
end;
$$;

-- Permite que o papel autenticado execute a função (a RLS da função
-- fica protegida pelo check interno "is_admin").
grant execute on function public.admin_delete_storage_object(text, text) to authenticated;