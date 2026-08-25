-- ============================================================
-- 08_conteudo_real.sql — NOTÍCIAS REAIS + BIOGRAFIA OFICIAL
-- Fatos extraídos de reportagens públicas sobre Rogério Tavares:
--   • Mural do Oeste (biografia/2025)
--   • Plural (ficha eleitoral 2026)
--   • Opera Mundi (ficha oficial)
-- Redação própria com fonte citada — sem conteúdo inventado.
-- Idempotente (ON CONFLICT por slug/key).
-- ============================================================

-- ------------------------------------------------------------
-- NOTÍCIAS REAIS
-- ------------------------------------------------------------

insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, source, author, published_at, tags) values
(
  (select id from public.news_categories where slug='imprensa'),
  'Conheça a biografia de Rogério Tavares, liderança política do Oeste Baiano',
  'De Barreiras, história de superação marca a caminhada do candidato 45788.',
  'biografia-rogerio-tavares-lideranca-politica-do-oeste-baiano',
  'Barreirense, Rogério trabalhou desde criança, coordenou a Pastoral da Criança, fundou a creche Lar de Cristo e liderou a Associação de Moradores do Ribeirão.',
  '## Uma história de superação\n\nRogério Tavares, filho de Maria Catarina da Silva e Jonas Tavares da Silva, cresceu em uma família grande, com 14 irmãos, 70 sobrinhos e 200 primos. Desde cedo aprendeu a se sustentar: aos 10 anos, trabalhava com o pai na fazenda do ex-prefeito de Barreiras, Baltazarino Araújo de Andrade, ajudando no plantio e no cuidado com o gado.\n\nAos 14 anos mudou-se para a cidade e, aos 15, superou grandes dificuldades para aprender a ler e escrever.\n\n## Liderança comunitária\n\nFoi líder do Grêmio Estudantil do Colégio Costa Borges e atuou ativamente na igreja católica do bairro Ribeirão, coordenando a Pastoral da Criança e sendo fundador da creche Lar de Cristo.\n\nPresidiu a Associação de Moradores do Ribeirão e começou a trajetória no serviço público ainda adolescente, como porteiro na escola da comunidade de Boa Sorte — depois, secretário escolar na escola municipal Dona Maria de Castro e Silva.\n\n## Vida pública\n\nFoi coordenador de políticas públicas na Prefeitura de Barreiras entre 2013 e 2016, período em que também atuou como articulador do selo UNICEF e liderou o movimento dos concursados de 2004. Formado em Gestão Pública pela UNOPAR, é servidor público municipal.\n\n> *Fonte: Mural do Oeste — muraldooeste.com*',
  'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Barreiras+Bahia+oeste',
  'Mural do Oeste', 'Mural do Oeste', '2026-08-19 09:00:00+00', array['biografia','Barreiras','Oeste da Bahia','comunidade']
),
(
  (select id from public.news_categories where slug='imprensa'),
  'Candidatura de Rogério Tavares (PSDB) é deferida para deputado estadual — 45788',
  'Ficha oficial confirma disputa na Bahia com o número 45788 em 2026.',
  'candidatura-rogerio-tavares-psdb-deferida-deputado-estadual-45788',
  'Com o número 45788, Rogério Tavares (PSDB) tem candidatura a deputado estadual pela Bahia oficialmente deferida.',
  '## Candidatura DEFERIDA\n\nRogério Tavares da Silva, nome de urna **Rogério Tavares**, disputa em 2026 uma vaga de deputado estadual da Bahia pelo **PSDB**, com o número **45788**. A situação da candidatura é **DEFERIDA**.\\n\\nNa Bahia, 639 candidatos disputam as 63 vagas da Assembleia Legislativa em 2026.\n\nNatural de Barreiras (BA), nascido em 1979, o candidato declara profissão de servidor público municipal e escolaridade superior completa.\n\n> *Fontes: Plural — plural.jor.br; Opera Mundi — operamundi.uol.com.br*',
  'https://dimg.dreamflow.cloud/v1/image/Person+writing+an+opinion+article+at+a+desk',
  'Plural / Opera Mundi', 'Equipe 45788', '2026-08-16 11:00:00+00', array['eleições 2026','PSDB','candidatura']
),
(
  (select id from public.news_categories where slug='imprensa'),
  'Rogério Tavares nas urnas: a trajetória de 2016 a 2022',
  'Quatro disputas anteriores marcam a caminhada eleitoral do candidato 45788.',
  'rogerio-tavares-nas-urnas-trajetoria-2016-a-2022',
  'Vereador em 2016 e 2020 e deputado estadual em 2018 e 2022, Rogério construiu uma trajetória eleitoral contínua em Barreiras.',
  '## Histórico eleitoral\n\nA trajetória eleitoral de Rogério Tavares começa em 2016, quando disputou uma vaga na Câmara Municipal de Barreiras pelo PRB, ficando na suplência com 165 votos.\n\nEm 2018, disputou uma vaga de deputado estadual pelo PATRIOTA, ficando na suplência com 547 votos. Em 2020, disputou novamente a Câmara Municipal de Barreiras, com 188 votos.\n\nEm 2022, disputou mais uma vez o cargo de deputado estadual, ficando na suplência com 740 votos.\n\nAgora, em 2026, disputa pelo PSDB uma vaga na Assembleia Legislativa da Bahia com o número 45788.\n\n> *Fonte: Plural — plural.jor.br*',
  'https://dimg.dreamflow.cloud/v1/image/Sports+training+center+with+young+athletes',
  'Plural', 'Equipe 45788', '2026-08-14 10:00:00+00', array['eleições','trajetória','Barreiras']
),
(
  (select id from public.news_categories where slug='imprensa'),
  'Eleições 2026: quem é Rogério Tavares, candidato a deputado estadual pela Bahia',
  'Ficha oficial reúne os dados públicos do candidato 45788.',
  'eleicoes-2026-quem-e-rogerio-tavares-candidato-deputado-estadual-bahia',
  'Nome na urna, partido, número, situação e dados da candidatura: confira a ficha oficial.',
  '## Quem é Rogério Tavares\n\nDados públicos oficiais da candidatura de **Rogério Tavares** (2026):\n\n- **Nome completo:** Rogério Tavares da Silva\n- **Nome na urna:** Rogério Tavares\n- **Cargo:** Deputado Estadual\n- **Unidade eleitoral:** Bahia\n- **Número:** 45788\n- **Partido:** PSDB\n- **Situação:** DEFERIDO\n\n> *Fonte: Divulgação de Candidaturas (TSE) — em veículos como opera mundi e jornal extra.*',
  'https://dimg.dreamflow.cloud/v1/image/Formal+notice+document+with+pen',
  'TSE / Opera Mundi', 'Equipe 45788', '2026-08-12 14:00:00+00', array['eleições 2026','quem é','ficha oficial']
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, content = excluded.content,
  image_url = excluded.image_url, source = excluded.source, tags = excluded.tags;

-- ------------------------------------------------------------
-- BIOGRAFIA OFICIAL (timeline com fatos reais)
-- ------------------------------------------------------------
update public.settings set value = '{"summary":"Rogério Tavares é candidato a Deputado Estadual da Bahia nas eleições de 2026, com o número 45788. Barreirense, filho de Maria Catarina da Silva e Jonas Tavares da Silva, construiu sua história na liderança comunitária do bairro Ribeirão e no serviço público municipal — uma caminhada de superação que começou no trabalho na roça e na busca por aprender a ler aos 15 anos.","hero_image":"","sections":[{"type":"trajetoria","year":"Anos 80/90","title":"Infância e trabalho no campo","text":"Trabalhou desde os 10 anos com o pai na fazenda do ex-prefeito de Barreiras, Baltazarino Araújo de Andrade, no plantio e no cuidado com o gado. Aos 14 anos mudou-se para a cidade; aos 15, superou grandes dificuldades para aprender a ler e escrever."},{"type":"trajetoria","year":"Juventude","title":"Grêmio, fé e comunidade","text":"Foi líder do Grêmio Estudantil do Colégio Costa Borges, coordenou a Pastoral da Criança na igreja católica do bairro Ribeirão e fundou a creche Lar de Cristo."},{"type":"trajetoria","year":"Serviço público","title":"Da escola à gestão pública","text":"Começou como porteiro na escola da comunidade de Boa Sorte, foi secretário escolar na escola municipal Dona Maria de Castro e Silva e presidiu a Associação de Moradores do Ribeirão."},{"type":"trajetoria","year":"2013–2016","title":"Políticas públicas e UNICEF","text":"Foi coordenador de políticas públicas na Prefeitura de Barreiras, articulador do selo UNICEF e liderou o movimento dos concursados de 2004. Formou-se em Gestão Pública pela UNOPAR."},{"type":"trajetoria","year":"2026","title":"Deputado estadual — 45788","text":"Candidato a Deputado Estadual da Bahia pelo PSDB, com candidatura deferida e o número 45788."}],"family":"Filho de Maria Catarina da Silva e Jonas Tavares da Silva, cresceu em uma família grande — 14 irmãos, 70 sobrinhos e 200 primos.","values":"Superação, fé e comunidade: coordenação da Pastoral da Criança, fundação da creche Lar de Cristo e a presidência da Associação de Moradores do Ribeirão marcam sua trajetória de serviço.","experience":"Servidor público municipal formado em Gestão Pública (UNOPAR). Coordenador de políticas públicas na Prefeitura de Barreiras (2013–2016), articulador do selo UNICEF e líder do movimento dos concursados de 2004. Disputou eleições em 2016, 2018, 2020 e 2022."}' where key = 'biography';

-- ------------------------------------------------------------
-- RETRATO OFICIAL (preencha com o upload da sua foto no Storage)
-- Depois de enviar a foto em: Storage → candidate → perfil/retrato-oficial.jpg
-- esta URL pública passa a ser usada em todo o app automaticamente.
-- ------------------------------------------------------------
update public.settings set value = jsonb_set(
  value,
  '{portrait_url}',
  '"https://hpubrzclxyhlodtmigrv.supabase.co/storage/v1/object/public/candidate/perfil/retrato-oficial.jpg"'
) where key = 'hero';