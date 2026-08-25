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