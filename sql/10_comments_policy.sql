-- ============================================================
-- 10_comments_policy.sql — COMENTÁRIOS SOMENTE ADMIN
-- Criação de comentários restrita ao papel admin (is_admin).
-- Leitura continua pública para todos.
-- Idempotente.
-- ============================================================

drop policy if exists "comments_insert" on public.comments;
create policy "comments_insert" on public.comments
  for insert with check (auth.uid() = user_id and public.is_admin());