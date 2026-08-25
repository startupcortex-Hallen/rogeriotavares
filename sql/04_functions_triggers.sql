-- ============================================================
-- 04_functions_triggers.sql
-- Funções e triggers: updated_at, novo usuário, admin seed, likes, views, auditoria
-- ============================================================

-- Extensão necessária para o bcrypt do admin (pode vir do 00; aqui fica à prova de esquecimento)
create extension if not exists pgcrypto;

-- ------------------------------------------------------------
-- TRIGGER: updated_at automático em todas as tabelas
-- ------------------------------------------------------------
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

do $$
declare t text;
begin
  foreach t in array array[
    'profiles','admin_users','news_categories','news','plan_categories','government_plan',
    'cities','events','gallery','videos','volunteers','messages','reports','downloads',
    'social_links','settings','notifications','comments','banner_home','campaign_numbers',
    'faq','team','testimonials'
  ] loop
    execute format('drop trigger if exists trg_%s_updated_at on public.%I;', t, t);
    execute format('create trigger trg_%s_updated_at before update on public.%I for each row execute function public.set_updated_at();', t, t);
  end loop;
end $$;

-- ------------------------------------------------------------
-- TRIGGER: cria profile automaticamente ao registrar
-- ------------------------------------------------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name, email)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'full_name', ''),
    coalesce(new.email, '')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ------------------------------------------------------------
-- SEED: cria o usuário ADMIN padrão (login do painel)
-- Uso: select public.seed_admin_user('admin@rogeriotavares.com.br','45788Admin','Administrador Geral');
--
-- Versão "select-first": NÃO usa ON CONFLICT em auth.users porque o
-- Supabase atual não possui constraint UNIQUE em auth.users.email.
-- search_path amplo (public, extensions, auth) cobre o schema das extensões.
-- ------------------------------------------------------------
create or replace function public.seed_admin_user(p_email text, p_password text, p_full_name text default 'Administrador Geral')
returns uuid
language plpgsql security definer set search_path = public, extensions, auth
as $$
declare
  v_id uuid;
  v_encrypted text;
begin
  select crypt(p_password, gen_salt('bf', 10)) into v_encrypted;

  -- 1) Verifica se o email já existe em auth.users (sem depender de ON CONFLICT)
  select id into v_id from auth.users where email = p_email limit 1;

  if v_id is null then
    v_id := gen_random_uuid();

    insert into auth.users (
      instance_id, id, aud, role, email, encrypted_password,
      email_confirmed_at, invited_at, confirmation_token, recovery_token,
      email_change_token_new, email_change, created_at, updated_at,
      raw_app_meta_data, raw_user_meta_data, is_super_admin
    ) values (
      '00000000-0000-0000-0000-000000000000', v_id, 'authenticated', 'authenticated', p_email, v_encrypted,
      now(), now(), '', '', '', p_email, now(), now(),
      '{"provider":"email","providers":["email"]}',
      jsonb_build_object('full_name', p_full_name), false
    );
  else
    -- Usuário existente: apenas re-sincroniza senha e nome
    update auth.users
       set encrypted_password = v_encrypted,
           email = p_email,
           updated_at = now(),
           raw_user_meta_data = jsonb_build_object('full_name', p_full_name)
     where id = v_id;
  end if;

  -- 2) Identity (sem ON CONFLICT por colunas — verificação manual)
  if not exists (
    select 1 from auth.identities
    where provider_id = p_email and user_id = v_id
  ) then
    insert into auth.identities (
      provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at
    ) values (
      p_email, v_id,
      jsonb_build_object('sub', v_id::text, 'email', p_email, 'email_verified', true, 'phone_verified', false),
      'email', now(), now(), now()
    );
  end if;

  -- 3) Tabelas do app (essas TÊM unique — podem usar ON CONFLICT)
  insert into public.admin_users (auth_user_id, email, full_name, role, is_active)
  values (v_id, p_email, p_full_name, 'admin', true)
  on conflict (email) do update set auth_user_id = excluded.auth_user_id,
    full_name = excluded.full_name, role = 'admin', is_active = true;

  insert into public.profiles (id, full_name, email, role, is_active)
  values (v_id, p_full_name, p_email, 'admin', true)
  on conflict (id) do update set full_name = excluded.full_name,
    email = excluded.email, role = 'admin', is_active = true;

  return v_id;
end;
$$;

-- ------------------------------------------------------------
-- RPC: toggle like (+ atualiza contador na tabela alvo)
-- ------------------------------------------------------------
create or replace function public.toggle_like(p_target_type public.target_type, p_target_id uuid)
returns boolean
language plpgsql security definer set search_path = public
as $$
declare
  v_user uuid := auth.uid();
  v_exists boolean;
begin
  if v_user is null then
    raise exception 'Autenticação necessária';
  end if;

  select exists(
    select 1 from public.likes where user_id = v_user and target_type = p_target_type and target_id = p_target_id
  ) into v_exists;

  if v_exists then
    delete from public.likes where user_id = v_user and target_type = p_target_type and target_id = p_target_id;
  else
    insert into public.likes (user_id, target_type, target_id) values (v_user, p_target_type, p_target_id);
  end if;

  if p_target_type = 'news'::public.target_type then
    update public.news set likes_count = (select count(*) from public.likes where target_type = p_target_type and target_id = p_target_id)
    where id = p_target_id;
  elsif p_target_type = 'proposal'::public.target_type then
    update public.government_plan set likes_count = (select count(*) from public.likes where target_type = p_target_type and target_id = p_target_id)
    where id = p_target_id;
  elsif p_target_type = 'event'::public.target_type then
    update public.events set rsvp_count = (select count(*) from public.likes where target_type = p_target_type and target_id = p_target_id)
    where id = p_target_id;
  elsif p_target_type = 'gallery'::public.target_type then
    update public.gallery set likes_count = (select count(*) from public.likes where target_type = p_target_type and target_id = p_target_id)
    where id = p_target_id;
  end if;

  return not v_exists;
end;
$$;

-- ------------------------------------------------------------
-- RPC: toggle favorito
-- ------------------------------------------------------------
create or replace function public.toggle_favorite(p_target_type public.target_type, p_target_id uuid)
returns boolean
language plpgsql security definer set search_path = public
as $$
declare
  v_user uuid := auth.uid();
  v_exists boolean;
begin
  if v_user is null then
    raise exception 'Autenticação necessária';
  end if;

  select exists(
    select 1 from public.favorites where user_id = v_user and target_type = p_target_type and target_id = p_target_id
  ) into v_exists;

  if v_exists then
    delete from public.favorites where user_id = v_user and target_type = p_target_type and target_id = p_target_id;
  else
    insert into public.favorites (user_id, target_type, target_id) values (v_user, p_target_type, p_target_id);
  end if;

  return not v_exists;
end;
$$;

-- ------------------------------------------------------------
-- RPC: incrementar views (notícia / vídeo)
-- ------------------------------------------------------------
create or replace function public.increment_views(p_entity text, p_id uuid, p_amount int default 1)
returns void
language plpgsql security definer set search_path = public
as $$
begin
  if p_entity = 'news' then
    update public.news set views_count = views_count + p_amount where id = p_id;
  elsif p_entity = 'video' then
    update public.videos set views_count = views_count + p_amount where id = p_id;
  end if;
end;
$$;

-- ------------------------------------------------------------
-- RPC: confirmar presença (RSVP) em evento
-- ------------------------------------------------------------
create or replace function public.confirm_rsvp(p_event_id uuid)
returns void
language plpgsql security definer set search_path = public
as $$
begin
  update public.events set rsvp_count = rsvp_count + 1 where id = p_event_id;
end;
$$;

-- ------------------------------------------------------------
-- TRIGGER: notificação interna ao publicar conteúdo
-- ------------------------------------------------------------
create or replace function public.notify_new_content()
returns trigger
language plpgsql security definer set search_path = public
as $$
begin
  if new.status = 'published'::public.content_status then
    insert into public.notifications (user_id, title, body, channel, city)
    values (null, 'Novo conteúdo publicado', new.title, 'in_app', null);
  end if;
  return new;
end;
$$;

drop trigger if exists trg_news_notify on public.news;
create trigger trg_news_notify
  after insert on public.news
  for each row execute function public.notify_new_content();

-- ------------------------------------------------------------
-- TRIGGER: auditoria automática das alterações do admin
-- ------------------------------------------------------------
create or replace function public.log_admin_action()
returns trigger
language plpgsql security definer set search_path = public
as $$
declare
  v_email text;
  v_id uuid;
  v_row jsonb;
begin
  select coalesce(email, '') into v_email from public.profiles where id = auth.uid();
  v_id := coalesce(new.id, old.id);
  v_row := case when tg_op = 'DELETE' then to_jsonb(old) else to_jsonb(new) end;
  insert into public.admin_audit_log (admin_id, admin_email, action, entity, entity_id, details)
  values (auth.uid(), v_email, tg_op::text, tg_table_name, v_id, v_row);
  return coalesce(new, old);
end;
$$;

drop trigger if exists trg_log_news on public.news;
create trigger trg_log_news after insert or update or delete on public.news
  for each row execute function public.log_admin_action();

drop trigger if exists trg_log_plan on public.government_plan;
create trigger trg_log_plan after insert or update or delete on public.government_plan
  for each row execute function public.log_admin_action();

drop trigger if exists trg_log_events on public.events;
create trigger trg_log_events after insert or update or delete on public.events
  for each row execute function public.log_admin_action();