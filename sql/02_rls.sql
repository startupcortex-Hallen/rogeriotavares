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