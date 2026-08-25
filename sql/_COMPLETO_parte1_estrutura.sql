// ============================================================
// PARTE 1 — ESTRUTURA COMPLETA (extensões + tabelas + RLS + views + funções + storage)
// Cole ESTE bloco primeiro + depois PARTE 2 (conteúdo)
// ============================================================

-- ============================================================
-- 00_extensions.sql
-- Extensões necessárias: busca fulltext, bcrypt para admin, uuid
-- ============================================================

create extension if not exists pgcrypto;
create extension if not exists pg_trgm;
create extension if not exists "uuid-ossp";
-- ============================================================
-- 01_tables.sql
-- Banco de dados completo do App Oficial Rogério Tavares 45788
-- Todas as tabelas possuem: id uuid PK, created_at, updated_at
-- ============================================================

-- ------------------------------------------------------------
-- ENUMS
-- ------------------------------------------------------------
do $$ begin
  if to_regtype('public.user_role') is null then
    create type public.user_role as enum ('admin','editor','moderator','volunteer','user');
  end if;
end $$;
do $$ begin
  if to_regtype('public.content_status') is null then
    create type public.content_status as enum ('draft','published','archived');
  end if;
end $$;
do $$ begin
  if to_regtype('public.plan_status') is null then
    create type public.plan_status as enum ('planejado','em_andamento','concluido');
  end if;
end $$;
do $$ begin
  if to_regtype('public.event_status') is null then
    create type public.event_status as enum ('agendado','acontecendo','concluido','cancelado');
  end if;
end $$;
do $$ begin
  if to_regtype('public.report_status') is null then
    create type public.report_status as enum ('pendente','aprovado','recusado','em_andamento','concluido');
  end if;
end $$;
do $$ begin
  if to_regtype('public.volunteer_status') is null then
    create type public.volunteer_status as enum ('pendente','aprovado','ativo','inativo');
  end if;
end $$;
do $$ begin
  if to_regtype('public.message_status') is null then
    create type public.message_status as enum ('novo','em_atendimento','respondido','arquivado');
  end if;
end $$;
do $$ begin
  if to_regtype('public.channel_type') is null then
    create type public.channel_type as enum ('form','chat');
  end if;
end $$;
do $$ begin
  if to_regtype('public.target_type') is null then
    create type public.target_type as enum ('news','proposal','event','gallery','video');
  end if;
end $$;
do $$ begin
  if to_regtype('public.download_type') is null then
    create type public.download_type as enum ('pdf','imagem','video','logo','banner','santinho','adesivo','outro');
  end if;
end $$;
do $$ begin
  if to_regtype('public.social_platform') is null then
    create type public.social_platform as enum ('instagram','facebook','tiktok','youtube','whatsapp','telegram','x','email','site');
  end if;
end $$;
do $$ begin
  if to_regtype('public.notification_channel') is null then
    create type public.notification_channel as enum ('in_app','push','web');
  end if;
end $$;
do $$ begin
  if to_regtype('public.media_type') is null then
    create type public.media_type as enum ('foto','video','story','album');
  end if;
end $$;

-- ------------------------------------------------------------
-- PROFILES — usuários & papéis (admin, editor, moderador, voluntário)
-- ------------------------------------------------------------
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  full_name text not null default '',
  email text not null default '',
  phone text default '',
  city text default '',
  role public.user_role not null default 'user',
  avatar_url text default '',
  bio text default '',
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- ADMIN_USERS — registro de credenciais administrativas (login do painel)
-- ------------------------------------------------------------
create table if not exists public.admin_users (
  id uuid primary key default gen_random_uuid(),
  auth_user_id uuid references auth.users (id) on delete cascade,
  email text not null unique,
  full_name text not null default 'Administrador',
  role public.user_role not null default 'admin',
  is_active boolean not null default true,
  last_login_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- NEWS_CATEGORIES + NEWS — central de notícias
-- ------------------------------------------------------------
create table if not exists public.news_categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  color text default '#1565C0',
  icon text default 'newspaper_rounded',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.news (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references public.news_categories (id) on delete set null,
  title text not null,
  subtitle text default '',
  slug text not null unique,
  summary text default '',
  content text default '',
  image_url text default '',
  video_url text default '',
  author text default 'Equipe 45788',
  source text default '',
  tags text[] default '{}',
  is_featured boolean not null default false,
  status public.content_status not null default 'published',
  published_at timestamptz not null default now(),
  views_count bigint not null default 0,
  likes_count bigint not null default 0,
  comments_count bigint not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- PLAN_CATEGORIES + GOVERNMENT_PLAN — plano de governo / propostas
-- ------------------------------------------------------------
create table if not exists public.plan_categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  icon text default 'category_rounded',
  color text default '#1565C0',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.government_plan (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references public.plan_categories (id) on delete set null,
  title text not null,
  slug text not null unique,
  summary text default '',
  description text default '',
  objectives text[] default '{}',
  benefits text[] default '{}',
  impact text default '',
  status public.plan_status not null default 'planejado',
  progress int not null default 0 check (progress between 0 and 100),
  tone text not null default 'primary',
  pdf_url text default '',
  is_featured boolean not null default false,
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- CITIES — cidades da Bahia (mapa)
-- ------------------------------------------------------------
create table if not exists public.cities (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  state text not null default 'BA',
  region text default '',
  latitude double precision not null default 0,
  longitude double precision not null default 0,
  population bigint default 0,
  image_url text default '',
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- EVENTS — agenda oficial
-- ------------------------------------------------------------
create table if not exists public.events (
  id uuid primary key default gen_random_uuid(),
  city_id uuid references public.cities (id) on delete set null,
  title text not null,
  description text default '',
  location_name text default '',
  address text default '',
  latitude double precision,
  longitude double precision,
  starts_at timestamptz not null,
  ends_at timestamptz,
  event_type text not null default 'outro',
  status public.event_status not null default 'agendado',
  image_url text default '',
  rsvp_count bigint not null default 0,
  is_featured boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- GALLERY — fotos, vídeos, stories e álbuns
-- ------------------------------------------------------------
create table if not exists public.gallery (
  id uuid primary key default gen_random_uuid(),
  title text default '',
  description text default '',
  image_url text default '',
  video_url text default '',
  category text default 'geral',
  album text default '',
  is_video boolean not null default false,
  is_story boolean not null default false,
  likes_count bigint not null default 0,
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- VIDEOS — lives, entrevistas, reels (YouTube + storage)
-- ------------------------------------------------------------
create table if not exists public.videos (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text default '',
  youtube_id text default '',
  video_url text default '',
  thumbnail_url text default '',
  video_type text not null default 'outro',
  category text default 'geral',
  duration_seconds int default 0,
  views_count bigint not null default 0,
  is_featured boolean not null default false,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- VOLUNTEERS — cadastro de voluntários da campanha
-- ------------------------------------------------------------
create table if not exists public.volunteers (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  email text default '',
  phone text default '',
  whatsapp text default '',
  city text default '',
  neighborhood text default '',
  availability text[] default '{}',
  areas text[] default '{}',
  message text default '',
  status public.volunteer_status not null default 'pendente',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- MESSAGES — fale com Rogério (formulário + chat gabinete digital)
-- ------------------------------------------------------------
create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  device_id text default '',
  conversation_id text default '',
  sender_name text default '',
  sender_email text default '',
  subject text default '',
  category text default '',
  message text not null,
  attachments text[] default '{}',
  channel public.channel_type not null default 'form',
  parent_id uuid references public.messages (id) on delete cascade,
  is_admin_reply boolean not null default false,
  status public.message_status not null default 'novo',
  is_read boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- REPORTS — demandas dos moradores (com GPS e foto)
-- ------------------------------------------------------------
create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  device_id text default '',
  full_name text default '',
  city text default '',
  category text not null default 'outro',
  description text not null,
  image_url text default '',
  latitude double precision,
  longitude double precision,
  status public.report_status not null default 'pendente',
  admin_note text default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- DOWNLOADS — materiais oficiais da campanha (storage)
-- ------------------------------------------------------------
create table if not exists public.downloads (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text default '',
  file_url text not null,
  file_type public.download_type not null default 'pdf',
  file_size bigint default 0,
  icon text default 'download_rounded',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- SOCIAL_LINKS — redes sociais oficiais
-- ------------------------------------------------------------
create table if not exists public.social_links (
  id uuid primary key default gen_random_uuid(),
  platform public.social_platform not null,
  url text not null,
  username text default '',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- SETTINGS — configurações institucionais (textos oficiais, campanha, contato)
-- ------------------------------------------------------------
create table if not exists public.settings (
  id uuid primary key default gen_random_uuid(),
  key text not null unique,
  value jsonb not null default '{}'::jsonb,
  description text default '',
  updated_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- NOTIFICATIONS — push / in-app segmentadas por cidade
-- ------------------------------------------------------------
create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users (id) on delete cascade,
  title text not null,
  body text default '',
  data jsonb default '{}'::jsonb,
  channel public.notification_channel not null default 'in_app',
  city text default '',
  is_read boolean not null default false,
  is_active boolean not null default true,
  sent_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- LIKES / FAVORITES / COMMENTS — engajamento
-- ------------------------------------------------------------
create table if not exists public.likes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  target_type public.target_type not null,
  target_id uuid not null,
  created_at timestamptz not null default now(),
  unique (user_id, target_type, target_id)
);

create table if not exists public.favorites (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  target_type public.target_type not null,
  target_id uuid not null,
  created_at timestamptz not null default now(),
  unique (user_id, target_type, target_id)
);

create table if not exists public.comments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users (id) on delete cascade,
  full_name text default '',
  target_type public.target_type not null,
  target_id uuid not null,
  content text not null,
  parent_id uuid references public.comments (id) on delete cascade,
  is_approved boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- BANNER_HOME — hero da página inicial
-- ------------------------------------------------------------
create table if not exists public.banner_home (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  subtitle text default '',
  badge text default '',
  image_url text default '',
  cta_label text default '',
  cta_url text default '',
  is_active boolean not null default true,
  sort_order int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- CAMPAIGN_NUMBERS — indicadores do painel de transparência
-- ------------------------------------------------------------
create table if not exists public.campaign_numbers (
  id uuid primary key default gen_random_uuid(),
  label text not null,
  value text not null,
  trend text default '',
  is_positive boolean not null default true,
  tone text not null default 'primary',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- FAQ / TEAM / TESTIMONIALS — conteúdo institucional
-- ------------------------------------------------------------
create table if not exists public.faq (
  id uuid primary key default gen_random_uuid(),
  question text not null,
  answer text not null,
  category text default 'geral',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.team (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  role text not null default '',
  photo_url text default '',
  bio text default '',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.testimonials (
  id uuid primary key default gen_random_uuid(),
  author_name text not null,
  city text default '',
  role text default '',
  content text not null,
  photo_url text default '',
  rating int default 5,
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- ADMIN_AUDIT_LOG — auditoria das ações do admin
-- ------------------------------------------------------------
create table if not exists public.admin_audit_log (
  id uuid primary key default gen_random_uuid(),
  admin_id uuid references auth.users (id) on delete set null,
  admin_email text default '',
  action text not null,
  entity text not null,
  entity_id uuid,
  details jsonb default '{}'::jsonb,
  created_at timestamptz not null default now()
);
-- ============================================================
-- 02_rls.sql
-- Row Level Security: visitante lê / admin escreve / editor publica / moderador aprova
-- ============================================================

-- ------------------------------------------------------------
-- Funções auxiliares de papel (security definer)
-- ------------------------------------------------------------
create or replace function public.current_role()
returns public.user_role
language sql stable security definer set search_path = public
as $$
  select coalesce((select role from public.profiles where id = auth.uid()), 'user'::public.user_role);
$$;

create or replace function public.is_admin()
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from public.profiles p
    join public.admin_users a on a.email = p.email
    where p.id = auth.uid() and p.role = 'admin'::public.user_role and p.is_active and a.is_active
  );
$$;

create or replace function public.is_editor()
returns boolean
language sql stable security definer set search_path = public
as $$
  select public.current_role() in ('admin'::public.user_role, 'editor'::public.user_role);
$$;

create or replace function public.is_moderator()
returns boolean
language sql stable security definer set search_path = public
as $$
  select public.current_role() in ('admin'::public.user_role, 'moderator'::public.user_role);
$$;

create or replace function public.can_write_content()
returns boolean
language sql stable security definer set search_path = public
as $$
  select public.current_role() in ('admin'::public.user_role, 'editor'::public.user_role, 'moderator'::public.user_role);
$$;

-- Ativa RLS em todas as tabelas
alter table public.profiles enable row level security;
alter table public.admin_users enable row level security;
alter table public.news_categories enable row level security;
alter table public.news enable row level security;
alter table public.plan_categories enable row level security;
alter table public.government_plan enable row level security;
alter table public.cities enable row level security;
alter table public.events enable row level security;
alter table public.gallery enable row level security;
alter table public.videos enable row level security;
alter table public.volunteers enable row level security;
alter table public.messages enable row level security;
alter table public.reports enable row level security;
alter table public.downloads enable row level security;
alter table public.social_links enable row level security;
alter table public.settings enable row level security;
alter table public.notifications enable row level security;
alter table public.likes enable row level security;
alter table public.favorites enable row level security;
alter table public.comments enable row level security;
alter table public.banner_home enable row level security;
alter table public.campaign_numbers enable row level security;
alter table public.faq enable row level security;
alter table public.team enable row level security;
alter table public.testimonials enable row level security;
alter table public.admin_audit_log enable row level security;

-- ------------------------------------------------------------
-- PROFILES
-- ------------------------------------------------------------
drop policy if exists "profiles_select_own" on public.profiles;
create policy "profiles_select_own" on public.profiles
  for select using (auth.uid() = id or public.is_admin());

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id) with check (auth.uid() = id);

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own" on public.profiles
  for insert with check (auth.uid() = id);

-- ------------------------------------------------------------
-- ADMIN_USERS — somente admin
-- ------------------------------------------------------------
drop policy if exists "admin_users_select" on public.admin_users;
create policy "admin_users_select" on public.admin_users
  for select using (public.is_admin());

drop policy if exists "admin_users_all" on public.admin_users;
create policy "admin_users_all" on public.admin_users
  for all using (public.is_admin()) with check (public.is_admin());

-- ------------------------------------------------------------
-- CONTEÚDO PÚBLICO (publicado) — visitante lê
-- ------------------------------------------------------------
drop policy if exists "news_select" on public.news;
create policy "news_select" on public.news
  for select using (status = 'published'::public.content_status or public.can_write_content());

drop policy if exists "news_write" on public.news;
create policy "news_write" on public.news
  for insert with check (public.can_write_content());

drop policy if exists "news_update" on public.news;
create policy "news_update" on public.news
  for update using (public.can_write_content()) with check (public.can_write_content());

drop policy if exists "news_delete" on public.news;
create policy "news_delete" on public.news
  for delete using (public.is_admin());

drop policy if exists "news_categories_select" on public.news_categories;
create policy "news_categories_select" on public.news_categories
  for select using (true);

drop policy if exists "news_categories_write" on public.news_categories;
create policy "news_categories_write" on public.news_categories
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "plan_select" on public.government_plan;
create policy "plan_select" on public.government_plan
  for select using (is_active or public.can_write_content());

drop policy if exists "plan_write" on public.government_plan;
create policy "plan_write" on public.government_plan
  for insert with check (public.can_write_content());

drop policy if exists "plan_update" on public.government_plan;
create policy "plan_update" on public.government_plan
  for update using (public.can_write_content()) with check (public.can_write_content());

drop policy if exists "plan_delete" on public.government_plan;
create policy "plan_delete" on public.government_plan
  for delete using (public.is_admin());

drop policy if exists "plan_categories_select" on public.plan_categories;
create policy "plan_categories_select" on public.plan_categories
  for select using (true);

drop policy if exists "plan_categories_write" on public.plan_categories;
create policy "plan_categories_write" on public.plan_categories
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "events_select" on public.events;
create policy "events_select" on public.events
  for select using (status <> 'cancelado'::public.event_status or public.can_write_content());

drop policy if exists "events_write" on public.events;
create policy "events_write" on public.events
  for insert with check (public.can_write_content());

drop policy if exists "events_update" on public.events;
create policy "events_update" on public.events
  for update using (public.can_write_content()) with check (public.can_write_content());

drop policy if exists "events_delete" on public.events;
create policy "events_delete" on public.events
  for delete using (public.is_admin());

drop policy if exists "cities_select" on public.cities;
create policy "cities_select" on public.cities
  for select using (true);

drop policy if exists "cities_write" on public.cities;
create policy "cities_write" on public.cities
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "gallery_select" on public.gallery;
create policy "gallery_select" on public.gallery
  for select using (is_active or public.can_write_content());

drop policy if exists "gallery_write" on public.gallery;
create policy "gallery_write" on public.gallery
  for insert with check (public.can_write_content());

drop policy if exists "gallery_update" on public.gallery;
create policy "gallery_update" on public.gallery
  for update using (public.can_write_content()) with check (public.can_write_content());

drop policy if exists "gallery_delete" on public.gallery;
create policy "gallery_delete" on public.gallery
  for delete using (public.is_admin());

drop policy if exists "videos_select" on public.videos;
create policy "videos_select" on public.videos
  for select using (is_active or public.can_write_content());

drop policy if exists "videos_write" on public.videos;
create policy "videos_write" on public.videos
  for insert with check (public.can_write_content());

drop policy if exists "videos_update" on public.videos;
create policy "videos_update" on public.videos
  for update using (public.can_write_content()) with check (public.can_write_content());

drop policy if exists "videos_delete" on public.videos;
create policy "videos_delete" on public.videos
  for delete using (public.is_admin());

drop policy if exists "downloads_select" on public.downloads;
create policy "downloads_select" on public.downloads
  for select using (true);

drop policy if exists "downloads_write" on public.downloads;
create policy "downloads_write" on public.downloads
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "social_links_select" on public.social_links;
create policy "social_links_select" on public.social_links
  for select using (true);

drop policy if exists "social_links_write" on public.social_links;
create policy "social_links_write" on public.social_links
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "settings_select" on public.settings;
create policy "settings_select" on public.settings
  for select using (true);

drop policy if exists "settings_write" on public.settings;
create policy "settings_write" on public.settings
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "banner_home_select" on public.banner_home;
create policy "banner_home_select" on public.banner_home
  for select using (true);

drop policy if exists "banner_home_write" on public.banner_home;
create policy "banner_home_write" on public.banner_home
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "campaign_numbers_select" on public.campaign_numbers;
create policy "campaign_numbers_select" on public.campaign_numbers
  for select using (true);

drop policy if exists "campaign_numbers_write" on public.campaign_numbers;
create policy "campaign_numbers_write" on public.campaign_numbers
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "faq_select" on public.faq;
create policy "faq_select" on public.faq
  for select using (true);

drop policy if exists "faq_write" on public.faq;
create policy "faq_write" on public.faq
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "team_select" on public.team;
create policy "team_select" on public.team
  for select using (true);

drop policy if exists "team_write" on public.team;
create policy "team_write" on public.team
  for all using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "testimonials_select" on public.testimonials;
create policy "testimonials_select" on public.testimonials
  for select using (true);

drop policy if exists "testimonials_write" on public.testimonials;
create policy "testimonials_write" on public.testimonials
  for all using (public.is_moderator()) with check (public.is_moderator());

-- ------------------------------------------------------------
-- PARTICIPAÇÃO (envio público) — visitante envia
-- ------------------------------------------------------------
drop policy if exists "volunteers_insert_public" on public.volunteers;
create policy "volunteers_insert_public" on public.volunteers
  for insert with check (true);

drop policy if exists "volunteers_select_admin" on public.volunteers;
create policy "volunteers_select_admin" on public.volunteers
  for select using (public.is_moderator());

drop policy if exists "volunteers_update_admin" on public.volunteers;
create policy "volunteers_update_admin" on public.volunteers
  for update using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "volunteers_delete_admin" on public.volunteers;
create policy "volunteers_delete_admin" on public.volunteers
  for delete using (public.is_admin());

drop policy if exists "messages_insert_public" on public.messages;
create policy "messages_insert_public" on public.messages
  for insert with check (true);

drop policy if exists "messages_select_admin" on public.messages;
create policy "messages_select_admin" on public.messages
  for select using (public.is_moderator());

drop policy if exists "messages_update_admin" on public.messages;
create policy "messages_update_admin" on public.messages
  for update using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "messages_delete_admin" on public.messages;
create policy "messages_delete_admin" on public.messages
  for delete using (public.is_admin());

drop policy if exists "reports_insert_public" on public.reports;
create policy "reports_insert_public" on public.reports
  for insert with check (true);

drop policy if exists "reports_select_approved" on public.reports;
create policy "reports_select_approved" on public.reports
  for select using (status = 'aprovado'::public.report_status or public.is_moderator());

drop policy if exists "reports_update_admin" on public.reports;
create policy "reports_update_admin" on public.reports
  for update using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "reports_delete_admin" on public.reports;
create policy "reports_delete_admin" on public.reports
  for delete using (public.is_admin());

-- ------------------------------------------------------------
-- NOTIFICAÇÕES — dono ou admin
-- ------------------------------------------------------------
drop policy if exists "notifications_select" on public.notifications;
create policy "notifications_select" on public.notifications
  for select using (user_id = auth.uid() or user_id is null or public.is_moderator());

drop policy if exists "notifications_write" on public.notifications;
create policy "notifications_write" on public.notifications
  for insert with check (public.is_moderator());

drop policy if exists "notifications_update" on public.notifications;
create policy "notifications_update" on public.notifications
  for update using (user_id = auth.uid() or public.is_moderator()) with check (user_id = auth.uid() or public.is_moderator());

drop policy if exists "notifications_delete" on public.notifications;
create policy "notifications_delete" on public.notifications
  for delete using (public.is_admin());

-- ------------------------------------------------------------
-- ENGAGEMENT — likes / favorites / comments (autenticado escreve, todos leem)
-- ------------------------------------------------------------
drop policy if exists "likes_select" on public.likes;
create policy "likes_select" on public.likes
  for select using (true);

drop policy if exists "likes_insert" on public.likes;
create policy "likes_insert" on public.likes
  for insert with check (auth.uid() = user_id);

drop policy if exists "likes_delete" on public.likes;
create policy "likes_delete" on public.likes
  for delete using (auth.uid() = user_id or public.is_admin());

drop policy if exists "favorites_select" on public.favorites;
create policy "favorites_select" on public.favorites
  for select using (true);

drop policy if exists "favorites_insert" on public.favorites;
create policy "favorites_insert" on public.favorites
  for insert with check (auth.uid() = user_id);

drop policy if exists "favorites_delete" on public.favorites;
create policy "favorites_delete" on public.favorites
  for delete using (auth.uid() = user_id or public.is_admin());

drop policy if exists "comments_select" on public.comments;
create policy "comments_select" on public.comments
  for select using (is_approved or public.is_moderator());

drop policy if exists "comments_insert" on public.comments;
create policy "comments_insert" on public.comments
  for insert with check (auth.uid() = user_id);

drop policy if exists "comments_update" on public.comments;
create policy "comments_update" on public.comments
  for update using (auth.uid() = user_id or public.is_moderator()) with check (auth.uid() = user_id or public.is_moderator());

drop policy if exists "comments_delete" on public.comments;
create policy "comments_delete" on public.comments
  for delete using (auth.uid() = user_id or public.is_admin());

-- ------------------------------------------------------------
-- AUDITORIA — somente admin lê/escreve
-- ------------------------------------------------------------
drop policy if exists "audit_select" on public.admin_audit_log;
create policy "audit_select" on public.admin_audit_log
  for select using (public.is_admin());

drop policy if exists "audit_insert" on public.admin_audit_log;
create policy "audit_insert" on public.admin_audit_log
  for insert with check (public.is_admin());
-- ============================================================
-- 03_indexes_views.sql
-- Índices, views analíticas e busca global
-- ============================================================

-- ------------------------------------------------------------
-- ÍNDICES
-- ------------------------------------------------------------
create index if not exists idx_news_category on public.news (category_id);
create index if not exists idx_news_status on public.news (status);
create index if not exists idx_news_published on public.news (published_at desc);
create index if not exists idx_news_featured on public.news (is_featured) where is_featured;
create index if not exists idx_news_title_trgm on public.news using gin (title gin_trgm_ops);
create index if not exists idx_plan_category on public.government_plan (category_id);
create index if not exists idx_plan_status on public.government_plan (status);
create index if not exists idx_events_start on public.events (starts_at desc);
create index if not exists idx_events_city on public.events (city_id);
create index if not exists idx_events_status on public.events (status);
create index if not exists idx_cities_name on public.cities (name);
create index if not exists idx_gallery_active on public.gallery (is_active);
create index if not exists idx_videos_active on public.videos (is_active);
create index if not exists idx_reports_status on public.reports (status);
create index if not exists idx_reports_city on public.reports (city);
create index if not exists idx_messages_channel on public.messages (channel);
create index if not exists idx_messages_status on public.messages (status);
create index if not exists idx_messages_conversation on public.messages (conversation_id);
create index if not exists idx_notifications_user on public.notifications (user_id);
create index if not exists idx_likes_target on public.likes (target_type, target_id);
create index if not exists idx_favorites_target on public.favorites (target_type, target_id);
create index if not exists idx_comments_target on public.comments (target_type, target_id);
create index if not exists idx_comments_user on public.comments (user_id);

-- ------------------------------------------------------------
-- VIEWS
-- ------------------------------------------------------------

-- Notícias com categoria
create or replace view public.v_news as
select
  n.*,
  nc.name as category_name,
  nc.color as category_color,
  nc.icon as category_icon
from public.news n
left join public.news_categories nc on nc.id = n.category_id;

-- Propostas do plano com categoria
create or replace view public.v_plan as
select
  p.*,
  pc.name as category_name,
  pc.icon as category_icon,
  pc.color as category_color
from public.government_plan p
left join public.plan_categories pc on pc.id = p.category_id;

-- Eventos com cidade
create or replace view public.v_events as
select
  e.*,
  c.name as city_name,
  c.region as city_region,
  c.latitude as city_latitude,
  c.longitude as city_longitude
from public.events e
left join public.cities c on c.id = e.city_id;

-- Demandas aprovadas (exibidas no mapa público)
create or replace view public.v_reports_approved as
select id, city, category, description, image_url, latitude, longitude, status, created_at
from public.reports
where status = 'aprovado'::public.report_status;

-- Contadores do dashboard do admin
create or replace view public.v_dashboard_counts as
select
  (select count(*) from public.news) as news_count,
  (select count(*) from public.government_plan) as plan_count,
  (select count(*) from public.events) as events_count,
  (select count(*) from public.cities) as cities_count,
  (select count(*) from public.videos) as videos_count,
  (select count(*) from public.gallery) as gallery_count,
  (select count(*) from public.volunteers where status = 'pendente'::public.volunteer_status) as volunteers_pending,
  (select count(*) from public.messages where status = 'novo'::public.message_status) as messages_new,
  (select count(*) from public.reports where status = 'pendente'::public.report_status) as reports_pending,
  (select count(*) from public.likes) as likes_count,
  (select count(*) from public.comments) as comments_count,
  (select count(*) from public.profiles) as profiles_count,
  (select count(*) from public.admin_audit_log) as audit_count;

-- Comentários com autor
create or replace view public.v_comments as
select
  c.*,
  p.full_name as author_name,
  p.avatar_url as author_avatar
from public.comments c
left join public.profiles p on p.id = c.user_id;

-- ------------------------------------------------------------
-- BUSCA GLOBAL — notícias, propostas, eventos, cidades, vídeos
-- ------------------------------------------------------------
create or replace function public.global_search(term text)
returns table (
  result_type text,
  id uuid,
  title text,
  subtitle text,
  category text,
  image_url text,
  slug text,
  url_path text
)
language plpgsql stable security definer set search_path = public
as $$
begin
  return query
  select 'noticia'::text, n.id, n.title, n.summary, nc.name, n.image_url, n.slug, '/noticias/' || n.slug
  from public.news n left join public.news_categories nc on nc.id = n.category_id
  where n.status = 'published'::public.content_status
    and (n.title ilike '%' || term || '%' or n.summary ilike '%' || term || '%' or n.content ilike '%' || term || '%' or n.tags::text ilike '%' || term || '%')
  union all
  select 'proposta'::text, p.id, p.title, p.summary, pc.name, null::text, p.slug, '/plano/' || p.slug
  from public.government_plan p left join public.plan_categories pc on pc.id = p.category_id
  where p.is_active and (p.title ilike '%' || term || '%' or p.summary ilike '%' || term || '%' or p.description ilike '%' || term || '%')
  union all
  select 'evento'::text, e.id, e.title, e.description, c.name, e.image_url, null::text, '/agenda'
  from public.events e left join public.cities c on c.id = e.city_id
  where e.status <> 'cancelado'::public.event_status and (e.title ilike '%' || term || '%' or e.description ilike '%' || term || '%' or e.location_name ilike '%' || term || '%')
  union all
  select 'cidade'::text, c.id, c.name, c.region, 'Bahia', c.image_url, c.slug, '/mapa'
  from public.cities c
  where c.name ilike '%' || term || '%' or c.region ilike '%' || term || '%'
  union all
  select 'video'::text, v.id, v.title, v.description, v.category, v.thumbnail_url, null::text, '/videos'
  from public.videos v
  where v.is_active and (v.title ilike '%' || term || '%' or v.description ilike '%' || term || '%')
  order by 4
  limit 30;
end;
$$;
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
-- ============================================================
-- 05_buckets.sql
-- Storage: buckets + políticas de acesso
-- ============================================================

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values
  ('candidate', 'candidate', true, 52428800, null),
  ('news', 'news', true, 52428800, null),
  ('gallery', 'gallery', true, 52428800, null),
  ('videos', 'videos', true, 209715200, null),
  ('downloads', 'downloads', true, 209715200, null),
  ('avatars', 'avatars', true, 5242880, array['image/png','image/jpeg','image/webp']::text[]),
  ('reports', 'reports', true, 20971520, array['image/png','image/jpeg','image/webp']::text[]),
  ('banners', 'banners', true, 52428800, null)
on conflict (id) do nothing;

-- ------------------------------------------------------------
-- POLÍTICAS DE STORAGE
-- Leitura pública (buckets já são public). Escrita por papel.
-- ------------------------------------------------------------

-- Gerenciamento de mídias institucionais (admin/editor/moderador)
do $$
declare b text;
begin
  foreach b in array array['candidate','news','gallery','videos','downloads','banners'] loop
    execute format('drop policy if exists "media_write_%s" on storage.objects;', b);
    execute format('create policy "media_write_%s" on storage.objects for insert with check (bucket_id = ''%s'' and public.is_moderator());', b, b);
    execute format('drop policy if exists "media_update_%s" on storage.objects;', b);
    execute format('create policy "media_update_%s" on storage.objects for update using (bucket_id = ''%s'' and public.is_moderator());', b, b);
    execute format('drop policy if exists "media_delete_%s" on storage.objects;', b);
    execute format('create policy "media_delete_%s" on storage.objects for delete using (bucket_id = ''%s'' and (public.is_admin() or public.is_moderator()));', b, b);
  end loop;
end $$;

-- Avatares: usuário autenticado escreve apenas no próprio caminho
drop policy if exists "avatars_insert_own" on storage.objects;
create policy "avatars_insert_own" on storage.objects
  for insert with check (bucket_id = 'avatars' and auth.role() = 'authenticated' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "avatars_update_own" on storage.objects;
create policy "avatars_update_own" on storage.objects
  for update using (bucket_id = 'avatars' and auth.role() = 'authenticated' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "avatars_delete_own" on storage.objects;
create policy "avatars_delete_own" on storage.objects
  for delete using (bucket_id = 'avatars' and auth.role() = 'authenticated' and (storage.foldername(name))[1] = auth.uid()::text);

-- Demandas: visitante envia foto do problema (aprovação admin depois)
drop policy if exists "reports_insert_public" on storage.objects;
create policy "reports_insert_public" on storage.objects
  for insert with check (bucket_id = 'reports');

drop policy if exists "reports_delete_admin" on storage.objects;
create policy "reports_delete_admin" on storage.objects
  for delete using (bucket_id = 'reports' and public.is_moderator());