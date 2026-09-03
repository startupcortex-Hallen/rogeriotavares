-- ============================================================
-- 15_crud_restante.sql — AUDITORIA: itens que faltavam no banco
--
-- 1) Comentários passam a exigir moderação (is_approved default false).
-- 2) Funções de gestão de equipe (criar admin/editor/moderador e
--    atualizar papel/status) — usadas pela nova tela "Usuários".
-- 3) Seed das tabelas que estavam VAZIAS e afetam o site:
--    social_links (Redes), faq (FAQ) e testimonials (Depoimentos).
-- Idempotente — pode rodar no SQL Editor do Supabase.
-- ============================================================

-- ------------------------------------------------------------
-- 1) Comentários exigem aprovação do moderador
-- ------------------------------------------------------------
alter table public.comments alter column is_approved set default false;

-- ------------------------------------------------------------
-- 2) GESTÃO DE EQUIPE (RPCs security definer — só admin)
-- ------------------------------------------------------------

-- Cria um usuário de equipe (auth.users + identity + profiles + admin_users)
-- com o papel desejado. Reaproveita a lógica do seed_admin_user.
create or replace function public.create_staff_user(
  p_email text,
  p_password text,
  p_full_name text default '',
  p_role public.user_role default 'editor'
) returns uuid
language plpgsql security definer set search_path = public, extensions, auth
as $$
declare
  v_id uuid;
  v_encrypted text;
begin
  if not public.is_admin() then
    raise exception 'Apenas administradores podem criar usuários';
  end if;

  select crypt(p_password, gen_salt('bf', 10)) into v_encrypted;

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
    update auth.users
       set encrypted_password = v_encrypted,
           email = p_email,
           updated_at = now(),
           raw_user_meta_data = jsonb_build_object('full_name', p_full_name)
     where id = v_id;
  end if;

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

  insert into public.admin_users (auth_user_id, email, full_name, role, is_active)
  values (v_id, p_email, p_full_name, p_role, true)
  on conflict (email) do update set auth_user_id = excluded.auth_user_id,
    full_name = excluded.full_name, role = excluded.role, is_active = true;

  insert into public.profiles (id, full_name, email, role, is_active)
  values (v_id, p_full_name, p_email, p_role, true)
  on conflict (id) do update set full_name = excluded.full_name,
    email = excluded.email, role = excluded.role, is_active = true;

  return v_id;
end;
$$;

-- Atualiza papel e/ou status ativo de um usuário (admin).
-- Sincroniza profiles + admin_users (o painel admin usa admin_users
-- para validar o login; o app usa profiles para os papéis).
create or replace function public.admin_update_profile(
  p_user_id uuid,
  p_role public.user_role default null,
  p_is_active boolean default null
) returns void
language plpgsql security definer set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Apenas administradores podem atualizar usuários';
  end if;

  update public.profiles
     set role = coalesce(p_role, role),
         is_active = coalesce(p_is_active, is_active)
   where id = p_user_id;

  update public.admin_users
     set role = coalesce(p_role, role),
         is_active = coalesce(p_is_active, is_active)
   where auth_user_id = p_user_id;
end;
$$;

-- ------------------------------------------------------------
-- 3) SEED: tabelas que estavam vazias
-- ------------------------------------------------------------

truncate table public.social_links restart identity cascade;
truncate table public.faq restart identity cascade;
truncate table public.testimonials restart identity cascade;

-- REDES SOCIAIS (edite os usuários pelo painel: Admin → Redes Sociais)
insert into public.social_links (platform, url, username, sort_order, is_active) values
('instagram',  'https://www.instagram.com/rogeriotavares45788',  '@rogeriotavares45788', 1, true),
('youtube',    'https://www.youtube.com/@rogeriotavares45788',    '@rogeriotavares45788', 2, true),
('facebook',   'https://www.facebook.com/rogeriotavares45788',    'rogeriotavares45788', 3, true),
('whatsapp',   'https://wa.me/5571999998888',                     '(71) 99999-8888', 4, true),
('telegram',   'https://t.me/rogeriotavares45788',                '@rogeriotavares45788', 5, true),
('email',      'mailto:contato@rogeriotavares.com.br',            'contato@rogeriotavares.com.br', 6, true);

-- FAQ (edite pelo painel: Admin → Conteúdo & Config → FAQ)
insert into public.faq (question, answer, category, sort_order, is_active) values
('Quem é Rogério Tavares?',
 'Rogério Tavares é candidato a Deputado Estadual da Bahia na eleição de 2026, pelo PSDB, com o número 45788. Barreirense, construiu sua história na liderança comunitária e no serviço público municipal.',
 'Geral', 1, true),
('Como posso me cadastrar como voluntário?',
 'Acesse o menu Participe do site, preencha o formulário com seus dados, áreas e disponibilidade. A equipe analisa e aprova o cadastro no painel.',
 'Participação', 2, true),
('Como envio uma demanda da minha cidade?',
 'No menu Demanda, escolha a categoria, descreva o problema e (se possível) envie uma foto e a localização. As demandas aprovadas aparecem no Mapa da Bahia.',
 'Participação', 3, true),
('Como falo diretamente com a campanha?',
 'Use o menu Fale conosco para enviar uma mensagem ou o Gabinete Digital (chat) para conversar em tempo real. Também respondemos pelas redes sociais.',
 'Contato', 4, true),
('Onde encontro o Plano de Governo?',
 'No menu Plano você encontra as propostas organizadas por eixo (educação, saúde, segurança, infraestrutura e outros) com status e avanço de cada uma.',
 'Conteúdo', 5, true),
('Onde baixo os materiais da campanha?',
 'No menu Downloads estão disponíveis o Plano de Governo em PDF, santinhos, logos e banners oficiais da campanha.',
 'Conteúdo', 6, true),
('Como acompanho a agenda do candidato?',
 'No menu Agenda você vê os compromissos públicos, com data, horário, cidade e local de cada evento.',
 'Agenda', 7, true),
('As notícias do site são oficiais?',
 'Sim. O conteúdo de notícias é publicado e revisado pela equipe de comunicação da campanha pelo painel administrativo.',
 'Geral', 8, true);

-- DEPOIMENTOS (edite pelo painel: Admin → Conteúdo & Config → Depoimentos)
insert into public.testimonials (author_name, city, role, content, rating, sort_order, is_active) values
('Maria dos Santos', 'Barreiras', 'Comerciante',
 'Conheço o trabalho do Rogério de longa data. É uma liderança que escuta o povo e sempre esteve ao lado das comunidades do Oeste.',
 5, 1, true),
('João Pedro Lima', 'Luís Eduardo Magalhães', 'Agricultor',
 'Acompanho as propostas para o interior e para o agronegócio. O plano de governo é sério e tem compromisso com quem produz.',
 5, 2, true),
('Ana Carolina Souza', 'Barreiras', 'Professora',
 'A educação sempre foi prioridade na trajetória dele. Acredito nas propostas para valorizar os professores e ampliar o ensino técnico.',
 5, 3, true);