-- ============================================================
-- 09_carrossel_banners.sql — BANNERS DO CARROSSEL (fotos reais)
-- As 6 fotos já estão no Storage (bucket reports — upload feito):
--   reports/carrossel-1.jpg ... carrossel-6.jpg
--   reports/retrato-oficial.jpg
-- Este script registra os 6 slides em banner_home (na ordem das
-- fotos) e aponta o retrato oficial para a foto enviada.
-- Idempotente.
-- ============================================================

-- Retrato oficial agora é a SUA foto (enviada para reports)
update public.settings set value = jsonb_set(
  value,
  '{portrait_url}',
  '"https://hpubrzclxyhlodtmigrv.supabase.co/storage/v1/object/public/reports/retrato-oficial.jpg"'
) where key = 'hero';

-- Banners do carrossel (slide 1 a 6 — na ordem das suas fotos)
insert into public.banner_home (title, subtitle, badge, image_url, cta_label, sort_order, is_active) values
('Rogério Tavares em Barreiras', 'Candidato a Deputado Estadual da Bahia', 'BARREIRAS', 'https://hpubrzclxyhlodtmigrv.supabase.co/storage/v1/object/public/reports/carrossel-1.jpg', '', 1, true),
('No contato com a população', 'Caminhadas, plenárias e visitas pelo estado', 'CONTATO COM O POVO', 'https://hpubrzclxyhlodtmigrv.supabase.co/storage/v1/object/public/reports/carrossel-2.jpg', '', 2, true),
('Caminhada 45788', 'Juntos por um estado mais forte', 'ELEIÇÕES 2026', 'https://hpubrzclxyhlodtmigrv.supabase.co/storage/v1/object/public/reports/carrossel-3.jpg', '', 3, true),
('Plenária com as comunidades', 'A voz do povo constrói nossas propostas', '45388', 'https://hpubrzclxyhlodtmigrv.supabase.co/storage/v1/object/public/reports/carrossel-4.jpg', '', 4, true),
('Compromisso com a educação', 'Polos técnicos e valorização dos professores', 'EDUCAÇÃO', 'https://hpubrzclxyhlodtmigrv.supabase.co/storage/v1/object/public/reports/carrossel-5.jpg', '', 5, true),
('Trabalho sério pelo estado', 'Experiência e compromisso com você', '45788', 'https://hpubrzclxyhlodtmigrv.supabase.co/storage/v1/object/public/reports/carrossel-6.jpg', '', 6, true)
on conflict (id) do nothing;

-- Remove banners antigos sem imagem (se houver) para não criarem slides vazios
delete from public.banner_home where (image_url is null or image_url = '') and title = 'Rogério Tavares: Experiência e Compromisso com Você';