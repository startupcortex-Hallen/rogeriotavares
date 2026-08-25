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