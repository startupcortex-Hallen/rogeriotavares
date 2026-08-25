-- ============================================================
-- 07_reparo.sql — REPARO DO ADMIN (Supabase atual)
--
-- Para quê: se ao rodar o seed você receber
--   ERROR 42883: function gen_salt(...) does not exist  (pgcrypto fora do public)
--   ou
--   ERROR 42P10: no unique or exclusion constraint matching the ON CONFLICT
--                (auth.users.email NÃO é UNIQUE no Supabase atual)
--
-- Este arquivo cria/atualiza a função seed_admin_user da forma
-- correta para o Supabase de hoje: schema das extensões coberto
-- pelo search_path e verificação de email SEM ON CONFLICT.
--
-- Uso (SQL Editor do Supabase):
--   1) Cole este arquivo inteiro.
--   2) Teste:  select public.seed_admin_user('admin@rogeriotavares.com.br','45788Admin','Administrador Geral');
--   3) Recole o 06_seeds.sql COMPLETO (o seed inteiro é revertido
--      quando qualquer linha falha).
-- ============================================================

-- Garante a extensão de bcrypt (idempotente; pode vir do 00)
create extension if not exists pgcrypto;

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

-- Diagnóstico rápido (opcional)
-- select extname, nspname from pg_extension e
--   join pg_namespace n on n.oid = e.extnamespace where extname = 'pgcrypto';
-- select public.seed_admin_user('admin@rogeriotavares.com.br','45788Admin','Administrador Geral');