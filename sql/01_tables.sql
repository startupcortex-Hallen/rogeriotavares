-- ============================================================
-- 01_tables.sql
-- Banco de dados completo do App Oficial Rogério Tavares 45788
-- Todas as tabelas possuem: id uuid PK, created_at, updated_at
-- ============================================================

-- ------------------------------------------------------------
-- ENUMS
-- ------------------------------------------------------------
create type public.user_role as enum ('admin','editor','moderator','volunteer','user');
create type public.content_status as enum ('draft','published','archived');
create type public.plan_status as enum ('planejado','em_andamento','concluido');
create type public.event_status as enum ('agendado','acontecendo','concluido','cancelado');
create type public.report_status as enum ('pendente','aprovado','recusado','em_andamento','concluido');
create type public.volunteer_status as enum ('pendente','aprovado','ativo','inativo');
create type public.message_status as enum ('novo','em_atendimento','respondido','arquivado');
create type public.channel_type as enum ('form','chat');
create type public.target_type as enum ('news','proposal','event','gallery','video');
create type public.download_type as enum ('pdf','imagem','video','logo','banner','santinho','adesivo','outro');
create type public.social_platform as enum ('instagram','facebook','tiktok','youtube','whatsapp','telegram','x','email','site');
create type public.notification_channel as enum ('in_app','push','web');
create type public.media_type as enum ('foto','video','story','album');

-- ------------------------------------------------------------
-- PROFILES — usuários & papéis (admin, editor, moderador, voluntário)
-- ------------------------------------------------------------
create table public.profiles (
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
create table public.admin_users (
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
create table public.news_categories (
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

create table public.news (
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
create table public.plan_categories (
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

create table public.government_plan (
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
create table public.cities (
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
create table public.events (
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
create table public.gallery (
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
create table public.videos (
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
create table public.volunteers (
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
create table public.messages (
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
create table public.reports (
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
create table public.downloads (
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
create table public.social_links (
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
create table public.settings (
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
create table public.notifications (
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
create table public.likes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  target_type public.target_type not null,
  target_id uuid not null,
  created_at timestamptz not null default now(),
  unique (user_id, target_type, target_id)
);

create table public.favorites (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  target_type public.target_type not null,
  target_id uuid not null,
  created_at timestamptz not null default now(),
  unique (user_id, target_type, target_id)
);

create table public.comments (
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
create table public.banner_home (
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
create table public.campaign_numbers (
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
create table public.faq (
  id uuid primary key default gen_random_uuid(),
  question text not null,
  answer text not null,
  category text default 'geral',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.team (
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

create table public.testimonials (
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
create table public.admin_audit_log (
  id uuid primary key default gen_random_uuid(),
  admin_id uuid references auth.users (id) on delete set null,
  admin_email text default '',
  action text not null,
  entity text not null,
  entity_id uuid,
  details jsonb default '{}'::jsonb,
  created_at timestamptz not null default now()
);