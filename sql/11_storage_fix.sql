-- ============================================================
-- 11_storage_fix.sql — POLICIES DE STORAGE BLINDADAS
-- O upload falhou no painel (403 RLS). As policies atuais usam
-- is_moderator() (admin/moderator) e EXCLUEM o papel editor.
-- Esta versão usa can_write_content() = admin | editor | moderador
-- e exige sessão autenticada (auth.role() = 'authenticated').
-- Idempotente — pode colar e recolar.
-- ============================================================

do $$
declare b text;
begin
  foreach b in array array['candidate','news','gallery','videos','downloads','banners'] loop
    execute format('drop policy if exists "media_write_%s" on storage.objects;', b);
    execute format($q$
      create policy "media_write_%s" on storage.objects
      for insert with check (
        bucket_id = '%s'
        and auth.role() = 'authenticated'
        and public.can_write_content()
      )
    $q$, b, b);

    execute format('drop policy if exists "media_update_%s" on storage.objects;', b);
    execute format($q$
      create policy "media_update_%s" on storage.objects
      for update using (
        bucket_id = '%s'
        and auth.role() = 'authenticated'
        and public.can_write_content()
      )
    $q$, b, b);

    execute format('drop policy if exists "media_delete_%s" on storage.objects;', b);
    execute format($q$
      create policy "media_delete_%s" on storage.objects
      for delete using (
        bucket_id = '%s'
        and auth.role() = 'authenticated'
        and public.can_write_content()
      )
    $q$, b, b);
  end loop;
end $$;

-- Avatares: usuário autenticado no próprio caminho (inalterado, reforçado)
drop policy if exists "avatars_insert_own" on storage.objects;
create policy "avatars_insert_own" on storage.objects
  for insert with check (
    bucket_id = 'avatars'
    and auth.role() = 'authenticated'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "avatars_update_own" on storage.objects;
create policy "avatars_update_own" on storage.objects
  for update using (
    bucket_id = 'avatars'
    and auth.role() = 'authenticated'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "avatars_delete_own" on storage.objects;
create policy "avatars_delete_own" on storage.objects
  for delete using (
    bucket_id = 'avatars'
    and auth.role() = 'authenticated'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

-- Demandas: visitante envia foto (inalterado)
drop policy if exists "reports_insert_public" on storage.objects;
create policy "reports_insert_public" on storage.objects
  for insert with check (bucket_id = 'reports');

drop policy if exists "reports_delete_admin" on storage.objects;
create policy "reports_delete_admin" on storage.objects
  for delete using (bucket_id = 'reports' and public.is_moderator());