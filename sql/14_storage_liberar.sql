-- ============================================================
-- 14_storage_liberar.sql — POLÍTICAS DE STORAGE LIBERAIS
--
-- Permite INSERT/UPDATE/DELETE para QUALQUER usuário autenticado
-- nos buckets do app (candidate, news, gallery, videos, downloads,
-- banners, avatars). O upload do painel é feito pelo admin logado:
-- garante que a foto SEMPRE suba (elimina o HTTP 403 do upload).
-- Idempotente.
-- ============================================================

do $$
declare b text;
begin
  foreach b in array array['candidate','news','gallery','videos','downloads','banners','avatars'] loop
    -- Remover políticas anteriores (nomes antigos)
    execute format('drop policy if exists "media_write_%s" on storage.objects;', b);
    execute format('drop policy if exists "media_update_%s" on storage.objects;', b);
    execute format('drop policy if exists "media_delete_%s" on storage.objects;', b);

    -- INSERT para qualquer autenticado
    execute format('drop policy if exists "rt_upload_%s" on storage.objects;', b);
    execute format($q$
      create policy "rt_upload_%s" on storage.objects
      for insert with check (
        bucket_id = '%s' and auth.role() = 'authenticated'
      )
    $q$, b, b);

    -- UPDATE para qualquer autenticado
    execute format('drop policy if exists "rt_update_%s" on storage.objects;', b);
    execute format($q$
      create policy "rt_update_%s" on storage.objects
      for update using (
        bucket_id = '%s' and auth.role() = 'authenticated'
      )
    $q$, b, b);

    -- DELETE para qualquer autenticado
    execute format('drop policy if exists "rt_delete_%s" on storage.objects;', b);
    execute format($q$
      create policy "rt_delete_%s" on storage.objects
      for delete using (
        bucket_id = '%s' and auth.role() = 'authenticated'
      )
    $q$, b, b);
  end loop;
end $$;

-- Demandas: continua liberado para anônimos (foto do problema)
drop policy if exists "reports_insert_public" on storage.objects;
create policy "reports_insert_public" on storage.objects
  for insert with check (bucket_id = 'reports');