-- ============================================================
-- 13_biografia.sql — BIOGRAFIA DINÂMICA E EDITÁVEL (painel admin)
--
-- Cria a tabela biography_items, onde cada bloco da biografia
-- (história, trajetória, família, valores, experiência) vira um
-- registro editável pelo painel → o app atualiza em tempo real.
-- Idempotente.
-- ============================================================

create table if not exists public.biography_items (
  id uuid primary key default gen_random_uuid(),
  item_type text not null default 'historia', -- historia | trajetoria | familia | valores | experiencia
  year text default '',
  title text not null,
  text text default '',
  image_url text default '',
  sort_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.biography_items enable row level security;

drop policy if exists "biography_select" on public.biography_items;
create policy "biography_select" on public.biography_items
  for select using (true);

drop policy if exists "biography_write" on public.biography_items;
create policy "biography_write" on public.biography_items
  for insert with check (public.is_moderator());

drop policy if exists "biography_update" on public.biography_items;
create policy "biography_update" on public.biography_items
  for update using (public.is_moderator()) with check (public.is_moderator());

drop policy if exists "biography_delete" on public.biography_items;
create policy "biography_delete" on public.biography_items
  for delete using (public.is_admin());

-- Seed inicial com os fatos reais (reportagem do Mural do Oeste)
truncate table public.biography_items restart identity cascade;

insert into public.biography_items (item_type, year, title, text, sort_order) values
('historia', 'Infância', 'Trabalho no campo',
 'Rogério Tavares, filho de Maria Catarina da Silva e Jonas Tavares da Silva, cresceu em uma família grande — 14 irmãos, 70 sobrinhos e 200 primos. Aos 10 anos já trabalhava com o pai na fazenda do ex-prefeito de Barreiras, Baltazarino Araújo de Andrade, no plantio e no cuidado com o gado.', 1),
('historia', 'Juventude', 'Superação para aprender',
 'Aos 14 anos mudou-se para a cidade e, aos 15, superou grandes dificuldades para aprender a ler e escrever. Foi líder do Grêmio Estudantil do Colégio Costa Borges.', 2),
('historia', 'Comunidade', 'Fé e serviço no Ribeirão',
 'Na igreja católica do bairro Ribeirão, coordenou a Pastoral da Criança e foi fundador da creche Lar de Cristo. Presidiu a Associação de Moradores do Ribeirão.', 3),
('trajetoria', 'Serviço público', 'Da escola à gestão',
 'Começou como porteiro na escola da comunidade de Boa Sorte, foi secretário escolar na escola municipal Dona Maria de Castro e Silva e dedicou sua vida ao serviço público municipal.', 4),
('trajetoria', '2013–2016', 'Políticas públicas e UNICEF',
 'Foi coordenador de políticas públicas na Prefeitura de Barreiras, articulador do selo UNICEF e liderou o movimento dos concursados de 2004. Formou-se em Gestão Pública pela UNOPAR.', 5),
('trajetoria', '2026', 'Deputado estadual — 45788',
 'Candidato a Deputado Estadual da Bahia pelo PSDB, com candidatura deferida e o número 45788.', 6),
('familia', '', 'Filho de Maria Catarina e Jonas',
 'Cresceu em uma família grande: 14 irmãos, 70 sobrinhos e 200 primos.', 7),
('valores', '', 'Superação, fé e comunidade',
 'Coordenação da Pastoral da Criança, fundação da creche Lar de Cristo e a presidência da Associação de Moradores do Ribeirão marcam sua trajetória de serviço.', 8),
('experiencia', '', 'Servidor público e gestor',
 'Servidor público municipal, formado em Gestão Pública (UNOPAR), coordenador de políticas públicas (2013–2016), articulador do selo UNICEF e líder do movimento dos concursados de 2004.', 9);