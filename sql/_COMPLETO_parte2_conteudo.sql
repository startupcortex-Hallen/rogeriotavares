// ============================================================
// PARTE 2 — CONTEÚDO (admin + categorias + 40 notícias com imagem + plano +
// 25 cidades COM IMAGEM + 17 eventos COM IMAGEM + galeria + vídeos + tudo)
// COLE DEPOIS DA PARTE 1
// ============================================================

-- LIMPEZA (idempotência: permite rodar o script mais de uma vez)
truncate table public.news_categories, public.plan_categories, public.news, public.government_plan, public.cities, public.events, public.gallery, public.videos, public.downloads, public.banner_home, public.campaign_numbers, public.settings restart identity cascade;

-- ------------------------------------------------------------
-- ADMIN padrão (troque a senha no painel depois do primeiro acesso)
-- ------------------------------------------------------------
select public.seed_admin_user('admin@rogeriotavares.com.br', '45788Admin', 'Administrador Geral');

-- ------------------------------------------------------------
-- CATEGORIAS DE NOTÍCIAS
-- ------------------------------------------------------------
insert into public.news_categories (name, slug, color, icon, sort_order) values
  ('Saúde', 'saude', '#1565C0', 'medical_services_rounded', 1),
  ('Educação', 'educacao', '#0D47A1', 'school_rounded', 2),
  ('Eventos', 'eventos', '#455A64', 'event_rounded', 3),
  ('Vídeos', 'videos', '#457B9D', 'play_circle_rounded', 4),
  ('Imprensa', 'imprensa', '#606C38', 'campaign_rounded', 5),
  ('Comunicados', 'comunicados', '#BC6C25', 'announcement_rounded', 6),
  ('Projetos', 'projetos', '#FFD600', 'construction_rounded', 7),
  ('Cultura', 'cultura', '#6B4423', 'theater_comedy_rounded', 8),
  ('Esporte', 'esporte', '#457B9D', 'sports_soccer_rounded', 9),
  ('Transparência', 'transparencia', '#606C38', 'visibility_rounded', 10);

-- ------------------------------------------------------------
-- CATEGORIAS DO PLANO DE GOVERNO
-- ------------------------------------------------------------
insert into public.plan_categories (name, slug, icon, color, sort_order) values
  ('Educação', 'educacao', 'school_rounded', '#1565C0', 1),
  ('Saúde', 'saude', 'medical_services_rounded', '#0D47A1', 2),
  ('Segurança', 'seguranca', 'gavel_rounded', '#455A64', 3),
  ('Infraestrutura', 'infraestrutura', 'construction_rounded', '#457B9D', 4),
  ('Agricultura', 'agricultura', 'agriculture_rounded', '#606C38', 5),
  ('Esporte', 'esporte', 'sports_soccer_rounded', '#BC6C25', 6),
  ('Cultura', 'cultura', 'theater_comedy_rounded', '#6B4423', 7),
  ('Tecnologia', 'tecnologia', 'smartphone_rounded', '#1565C0', 8),
  ('Emprego', 'emprego', 'work_rounded', '#0D47A1', 9),
  ('Mulheres', 'mulheres', 'female_rounded', '#AE2012', 10),
  ('Juventude', 'juventude', 'groups_rounded', '#FFD600', 11),
  ('Interior', 'interior', 'landscape_rounded', '#606C38', 12),
  ('Oeste da Bahia', 'oeste-da-bahia', 'terrain_rounded', '#BC6C25', 13),
  ('Economia', 'economia', 'trending_up_rounded', '#457B9D', 14);

-- ------------------------------------------------------------
-- PLANO DE GOVERNO — propostas oficiais
-- ------------------------------------------------------------
insert into public.government_plan (
  category_id, title, slug, summary, description, objectives, benefits, impact,
  status, progress, tone, is_featured, sort_order
) values
(
  (select id from public.plan_categories where slug = 'educacao'),
  'Expansão da Rede de Ensino Técnico',
  'expansao-rede-ensino-tecnico',
  'Ampliar a oferta de ensino técnico e profissionalizante em todas as regiões do estado, com polos regionais.',
  'Proposta de expansão da rede estadual de ensino técnico, levando cursos profissionalizantes para perto da casa do estudante.',
  array['Criar polos de ensino técnico nas regiões', 'Integrar a rede com o mercado de trabalho', 'Ampliar vagas em cursos profissionalizantes'],
  array['Jovens capacitados para o primeiro emprego', 'Renda gerada dentro das próprias regiões', 'Menos deslocamento para estudar'],
  'Transformação da educação profissional e geração de renda local.',
  'em_andamento', 45, 'primary', true, 1
),
(
  (select id from public.plan_categories where slug = 'infraestrutura'),
  'Universalização do Saneamento Básico',
  'universalizacao-saneamento-basico',
  'Levar água tratada e coleta de esgoto para todos os municípios baianos.',
  'Compromisso de universalizar o saneamento básico, priorizando as cidades do interior e as regiões mais carentes de infraestrutura.',
  array['Ampliar rede de água tratada', 'Expandir coleta e tratamento de esgoto', 'Captar recursos e parcerias'],
  array['Mais saúde para a população', 'Valorização dos imóveis', 'Proteção dos rios e mananciais'],
  'Qualidade de vida e dignidade para cada família baiana.',
  'planejado', 12, 'secondary', false, 2
),
(
  (select id from public.plan_categories where slug = 'tecnologia'),
  'Digitalização dos Serviços Públicos',
  'digitalizacao-servicos-publicos',
  'Serviços públicos digitais, rápidos e acessíveis para todos os cidadãos.',
  'Proposta de modernização digital do atendimento público, tornando os serviços mais rápidos, transparentes e acessíveis.',
  array['Unificar serviços digitais do estado', 'Ampliar acesso pela internet e celular', 'Reduzir filas e burocracia'],
  array['Atendimento célere', 'Transparência total', 'Menos deslocamento'],
  'Um estado moderno, conectado e a serviço do cidadão.',
  'concluido', 100, 'info', false, 3
),
(
  (select id from public.plan_categories where slug = 'saude'),
  'Fortalecimento do SUS no Interior',
  'fortalecimento-sus-interior',
  'Leitos regionais, médicos mais perto e atendimento humanizado no interior da Bahia.',
  'Proposta de ampliação da rede pública de saúde, com novos leitos regionais e estrutura para as cidades do interior.',
  array['Ampliar leitos regionais', 'Garantir médicos no interior', 'Modernizar unidades de saúde'],
  array['Atendimento mais rápido', 'Menos viagens para tratamento', 'Humanização do cuidado'],
  'Saúde digna e perto de casa para o povo baiano.',
  'em_andamento', 78, 'success', false, 4
),
(
  (select id from public.plan_categories where slug = 'tecnologia'),
  'Plano de Modernização do Ensino Técnico',
  'modernizacao-ensino-tecnico',
  'Rogério Tavares propõe a criação de polos tecnológicos regionais para capacitar jovens e gerar renda local.',
  'Plano de modernização do ensino técnico com polos tecnológicos regionais, conectando educação, inovação e emprego.',
  array['Criar polos tecnológicos regionais', 'Modernizar laboratórios e oficinas', 'Parcerias com empresas e universidades'],
  array['Capacitação para o futuro', 'Renda local', 'Inovação nas regiões'],
  'Jovens preparados para o mercado e regiões mais desenvolvidas.',
  'em_andamento', 65, 'primary', true, 5
),
(
  (select id from public.plan_categories where slug = 'infraestrutura'),
  'Expansão da Ferrovia Norte-Sul',
  'expansao-ferrovia-norte-sul',
  'Ampliar a malha ferroviária baiana para escoar a produção e baratear o transporte.',
  'Proposta de expansão da malha ferroviária do estado, integrando regiões produtoras aos principais portos.',
  array['Ampliar os trilhos no estado', 'Integrar regiões produtoras', 'Reduzir custo logístico'],
  array['Escoamento mais barato', 'Mais emprego', 'Menos caminhões nas estradas'],
  'Logística moderna e desenvolvimento para o interior.',
  'em_andamento', 65, 'primary', false, 6
);

-- ============================================================
-- NOTÍCIAS — 4 POR CATEGORIA (40 TOTAL) — TODAS COM IMAGEM
-- ============================================================

-- SAÚDE
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'saude'),
  'Rogério Tavares propõe ampliação de leitos regionais',
  'Proposta reforça o compromisso com a saúde no interior do estado.',
  'rogerio-propoe-ampliacao-de-leitos-regionais',
  'Novo anúncio da campanha destaca a ampliação da rede hospitalar regional para atender melhor a população.',
  '## Ampliação de leitos regionais\n\nRogério Tavares apresentou nesta semana a proposta de ampliação de leitos regionais para fortalecer o atendimento de saúde em todo o estado.\n\nEntre os compromissos anunciados estão a modernização das unidades existentes, a contratação de profissionais e a ampliação do atendimento de média e alta complexidade nas regiões do interior.\n\n> Saúde digna e perto de casa para o povo baiano.',
  'https://dimg.dreamflow.cloud/v1/image/Modern+hospital+interior',
  '2026-08-12 09:00:00+00', array['saúde','leitos','interior']
),
(
  (select id from public.news_categories where slug = 'saude'),
  'Roda de conversa sobre saúde mental reúne profissionais',
  'Especialistas debatem acolhimento e estrutura para a saúde mental no estado.',
  'roda-de-conversa-sobre-saude-mental',
  'Profissionais de saúde participaram de roda de conversa sobre acolhimento e ampliação dos serviços de saúde mental.',
  '## Saúde mental em pauta\n\nUma roda de conversa promovida pela campanha reuniu psicólogos, médicos e assistentes sociais para debater o fortalecimento da rede de saúde mental.\n\nEntre os temas estavam o acolhimento humanizado, a ampliação dos CAPS regionais e a valorização dos profissionais da área.\n\n> Cuidar da mente também é cuidar do povo.',
  'https://dimg.dreamflow.cloud/v1/image/Health+workers+in+a+round+table+meeting',
  '2026-08-04 15:00:00+00', array['saúde','saúde mental']
),
(
  (select id from public.news_categories where slug = 'saude'),
  'Caravana da saúde visita unidades do interior',
  'Equipe percorre hospitais e postos para ouvir trabalhadores e pacientes.',
  'caravana-da-saude-visita-unidades-do-interior',
  'A caravana 45788 visitou unidades de saúde do interior para conhecer de perto as necessidades de cada região.',
  '## Caravana da saúde no interior\n\nA caravana 45788 percorreu hospitais e unidades básicas de saúde do interior para ouvir trabalhadores, pacientes e gestores locais.\n\nOs encontros servem para construir propostas alinhadas à realidade de cada município, desde a falta de especialistas até a necessidade de novos equipamentos.\n\n> Quem vive a realidade conhece a solução.',
  'https://dimg.dreamflow.cloud/v1/image/Nurse+talking+to+patients+in+a+small+clinic',
  '2026-07-28 10:00:00+00', array['saúde','caravana']
),
(
  (select id from public.news_categories where slug = 'saude'),
  'Proposta prevê modernização das UPAs do estado',
  'Unidades de pronto atendimento entram na pauta de infraestrutura da saúde.',
  'proposta-preve-modernizacao-das-upas',
  'Investimento em estrutura, equipamentos e acolhimento é a aposta para reduzir filas nas UPAs.',
  '## UPAs modernizadas\n\nA proposta de modernização das Unidades de Pronto Atendimento prevê investimentos em estrutura, equipamentos e organização do fluxo de pacientes.\n\nO objetivo é reduzir o tempo de espera e garantir atendimento mais rápido e humanizado, especialmente nos grandes centros urbanos.\n\n> Atendimento rápido e digno para quem mais precisa.',
  'https://dimg.dreamflow.cloud/v1/image/Emergency+room+modern+equipment',
  '2026-07-15 08:30:00+00', array['saúde','UPAs']
);

-- EDUCAÇÃO
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'educacao'),
  'Encontro com professores debate valorização da categoria',
  'Diálogo aberto com educadores em encontro promovido pela campanha.',
  'encontro-com-professores-debate-valorizacao-da-categoria',
  'Rogério Tavares reuniu professores para debater valorização, formação e condições de trabalho.',
  '## Valorização dos professores\n\nEm um encontro aberto com educadores, Rogério Tavares ouviu demandas da categoria e reforçou propostas de valorização profissional.\n\nOs temas debatidos incluíram piso salarial, formação continuada e condições de trabalho dignas nas escolas públicas do estado.',
  'https://dimg.dreamflow.cloud/v1/image/Candidate+talking+to+teachers+in+a+classroom',
  '2026-08-05 14:30:00+00', array['educação','professores']
),
(
  (select id from public.news_categories where slug = 'educacao'),
  'Rogério Tavares visita escola modelo em Feira de Santana',
  'Candidato conhece projeto que integra tecnologia e ensino profissionalizante.',
  'rogerio-visita-escola-modelo-em-feira-de-santana',
  'A visita marcou o lançamento do debate sobre integração entre escolas técnicas e o mercado de trabalho.',
  '## Escola modelo\n\nRogério Tavares visitou uma escola modelo em Feira de Santana que integra tecnologia e ensino profissionalizante.\n\nA visita reforçou a proposta de levar o mesmo modelo para todas as regiões do estado, conectando a sala de aula às oportunidades de trabalho locais.\n\n> Educação que transforma o futuro da juventude.',
  'https://dimg.dreamflow.cloud/v1/image/Candidate+visiting+a+school+with+students+in+labs',
  '2026-07-30 09:00:00+00', array['educação','visita','Feira de Santana']
),
(
  (select id from public.news_categories where slug = 'educacao'),
  'Proposta cria bolsas de estudo técnico para jovens',
  'Iniciativa prevê apoio financeiro para estudantes do ensino técnico do interior.',
  'proposta-cria-bolsas-de-estudo-tecnico',
  'Com o apoio a estudantes, a proposta pretende reduzir a evasão no ensino técnico e ampliar a qualificação.',
  '## Bolsas de estudo técnico\n\nA proposta prevê a criação de bolsas de estudo técnico para apoiar jovens do interior e reduzir a evasão escolar.\n\nO auxílio deve cobrir transporte, material e alimentação, permitindo que o estudante termine a formação e entre no mercado de trabalho qualificado.\n\n> Jovem estudando é o estado avançando.',
  'https://dimg.dreamflow.cloud/v1/image/Young+students+studying+together+in+a+technical+school',
  '2026-07-18 11:00:00+00', array['educação','bolsas']
),
(
  (select id from public.news_categories where slug = 'educacao'),
  'Educação infantil é tema de plenária em Vitória da Conquista',
  'Creches e pré-escolas no centro do debate sobre os primeiros anos da criança.',
  'educacao-infantil-tema-de-plenaria-em-vitoria-da-conquista',
  'Plenária reuniu mães, educadores e lideranças para debater creches e pré-escolas em tempo integral.',
  '## Plenária sobre educação infantil\n\nEm Vitória da Conquista, a campanha realizou plenária sobre educação infantil reunindo mães, educadores e lideranças da região.\n\nOs principais pedidos foram a ampliação de vagas em creches, a valorização dos profissionais e o fortalecimento da educação em tempo integral.\n\n> Os primeiros anos decidem a vida inteira.',
  'https://dimg.dreamflow.cloud/v1/image/Kids+in+a+kindergarten+classroom+with+a+teacher',
  '2026-07-08 16:00:00+00', array['educação','educação infantil','plenária']
);

-- EVENTOS
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'eventos'),
  'Caminhada em prol da educação reúne milhares',
  'A população tomou as ruas pela educação nas cidades visitadas pela campanha.',
  'caminhada-em-prol-da-educacao-reune-milhares',
  'Milhares de pessoas participaram da caminhada 45788 em defesa da educação pública.',
  '## Caminhada pela educação\n\nA caminhada 45788 em prol da educação reuniu milhares de pessoas, em uma grande demonstração de apoio às propostas de Rogério Tavares para o ensino público.\n\nO ato contou com a participação de estudantes, professores, pais e lideranças comunitárias.',
  'https://dimg.dreamflow.cloud/v1/image/Political+rally+with+flags',
  '2026-08-02 10:00:00+00', array['educação','caminhada','evento']
),
(
  (select id from public.news_categories where slug = 'eventos'),
  'Comitê 45788 abre inscrições para caravanas',
  'Voluntários e apoiadores podem se cadastrar para participar das caravanas do interior.',
  'comite-45788-abre-inscricoes-para-caravanas',
  'As caravanas da campanha percorrerão as regiões do estado com agenda de visitas e plenárias.',
  '## Inscrições abertas para caravanas\n\nO comitê 45788 abriu inscrições para voluntários e apoiadores que desejam participar das caravanas pelo interior da Bahia.\n\nAs caravanas incluem visitas a municípios, plenárias temáticas e encontros com lideranças comunitárias.\n\n> Participe você também dessa caminhada.',
  'https://dimg.dreamflow.cloud/v1/image/Volunteers+registering+at+a+campaign+office',
  '2026-07-25 09:30:00+00', array['eventos','caravanas','voluntários']
),
(
  (select id from public.news_categories where slug = 'eventos'),
  'Caravana 45788 chega ao Oeste da Bahia',
  'Barreiras e região recebem agenda com visitas e plenárias temáticas.',
  'caravana-45788-chega-ao-oeste-da-bahia',
  'A caravana percorreu o Oeste com encontros sobre agricultura, educação e infraestrutura.',
  '## Caravana no Oeste da Bahia\n\nA caravana 45788 chegou ao Oeste da Bahia com agenda intensa em Barreiras e municípios vizinhos.\n\nAgricultura familiar, irrigação, educação e estradas dominaram os encontros com lideranças e trabalhadores da região.\n\n> O Oeste da Bahia merece atenção e desenvolvimento.',
  'https://dimg.dreamflow.cloud/v1/image/Caravan+trucks+in+a+country+road+with+people',
  '2026-07-12 08:00:00+00', array['eventos','caravana','Oeste']
),
(
  (select id from public.news_categories where slug = 'eventos'),
  'Ato pelo emprego lota praça em Juazeiro',
  'Trabalhadores e empreendedores participam de ato sobre geração de renda.',
  'ato-pelo-emprego-lota-praca-em-juazeiro',
  'O ato reuniu centenas de pessoas em defesa de políticas públicas de emprego e renda.',
  '## Ato pelo emprego\n\nUm ato pelo emprego lotou a praça central de Juazeiro, com a presença de trabalhadores, comerciantes e pequenos empreendedores.\n\nNo encontro, foram discutidas propostas de apoio ao pequeno negócio, crédito para o agricultor e qualificação profissional.\n\n> Emprego e renda são prioridade do 45788.',
  'https://dimg.dreamflow.cloud/v1/image/Crowd+holding+signs+in+a+town+square',
  '2026-06-28 17:00:00+00', array['eventos','emprego','Juazeiro']
);

-- VÍDEOS
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, video_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'videos'),
  'Conheça as metas de Rogério Tavares para a saúde',
  'Vídeo oficial apresenta as metas e compromissos da campanha para a área da saúde.',
  'conheca-as-metas-de-rogerio-para-a-saude',
  'No vídeo oficial, Rogério Tavares apresenta suas metas para fortalecer o SUS nas regiões do estado.',
  '## Metas para a saúde\n\nNo mais novo vídeo oficial da campanha, Rogério Tavares apresenta as metas para a saúde do estado, com foco no fortalecimento do SUS no interior e na ampliação de leitos regionais.',
  'https://dimg.dreamflow.cloud/v1/image/Candidate+speaking+to+camera',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  '2026-07-30 16:00:00+00', array['vídeo','saúde','metas']
),
(
  (select id from public.news_categories where slug = 'videos'),
  'Vídeo: Rogério Tavares nas ruas de Barreiras',
  'Bastidores da caravana mostram o contato direto com a população.',
  'video-rogerio-nas-ruas-de-barreiras',
  'Imagens da caravana mostram o candidato caminhando, conversando e ouvindo a população.',
  '## Bastidores em Barreiras\n\nAs imagens mostram Rogério Tavares percorrendo ruas de Barreiras ao lado de lideranças locais, ouvindo as demandas de cada bairro.\n\nSaiba como foi a passagem da caravana 45788 pelo Oeste da Bahia.\n\n> A campanha na rua, perto do povo.',
  'https://dimg.dreamflow.cloud/v1/image/Candidate+walking+in+a+country+town+street',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  '2026-07-20 18:30:00+00', array['vídeo','caravana','Barreiras']
),
(
  (select id from public.news_categories where slug = 'videos'),
  'Reels da campanha: bastidores da equipe 45788',
  'Uma série de vídeos curtos mostra o dia a dia da mobilização.',
  'reels-da-campanha-bastidores-da-equipe-45788',
  'Produção de reels para as redes mostra a energia da campanha nas ruas.',
  '## Reels de campanha\n\nUma série de vídeos curtos nas redes sociais mostra a energia da mobilização 45788: panfletagem, visitas, plenárias e os bastidores da equipe.\n\nAssista e compartilhe com a sua rede de amigos.\n\n> Cada compartilhamento é um passo a mais.',
  'https://dimg.dreamflow.cloud/v1/image/Young+team+filming+a+phone+video+campaign',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  '2026-07-10 19:00:00+00', array['vídeo','reels']
),
(
  (select id from public.news_categories where slug = 'videos'),
  'Live: Pergunte ao Rogério — replay completo',
  'Transmissão oficial respondeu perguntas da população sobre o plano de governo.',
  'live-pergunte-ao-rogerio-replay',
  'Na live, o candidato respondeu perguntas sobre saúde, educação, emprego e infraestrutura.',
  '## Replay da live oficial\n\nNa live Pergunte ao Rogério, a população participou ativamente com perguntas sobre saúde, educação, emprego e infraestrutura.\n\nConfira o replay completo da transmissão oficial da campanha.\n\n> Participação popular construindo as propostas.',
  'https://dimg.dreamflow.cloud/v1/image/Live+stream+studio+with+laptop+camera',
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  '2026-06-20 20:30:00+00', array['vídeo','live']
);

-- IMPRENSA
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'imprensa'),
  'Entrevista exclusiva: O futuro do nosso estado',
  'Rogério Tavares fala sobre o futuro do estado em entrevista exclusiva à imprensa.',
  'entrevista-exclusiva-o-futuro-do-nosso-estado',
  'Na entrevista, o candidato detalha seu plano de governo, propostas e a visão para o futuro do estado.',
  '## Entrevista exclusiva\n\nEm entrevista exclusiva, Rogério Tavares detalhou o plano de governo, as prioridades da campanha e sua visão para o futuro do estado.\n\nO candidato reafirmou o compromisso com a renovação, o trabalho sério e a proximidade com a população.',
  'https://dimg.dreamflow.cloud/v1/image/Candidate+in+a+TV+studio',
  '2026-07-25 11:00:00+00', array['imprensa','entrevista']
),
(
  (select id from public.news_categories where slug = 'imprensa'),
  'Imprensa regional destaca propostas de infraestrutura',
  'Veículos do interior repercutem compromissos com estradas e saneamento.',
  'imprensa-regional-destaca-propostas-de-infraestrutura',
  'A cobertura regional reuniu os principais compromissos da campanha com a infraestrutura do estado.',
  '## Infraestrutura na imprensa regional\n\nJornais e portais do interior repercutiram as propostas de infraestrutura da campanha 45788.\n\nEstradas vicinais, saneamento básico e ferrovias foram os temas mais destacados pela cobertura regional.',
  'https://dimg.dreamflow.cloud/v1/image/Newspapers+and+press+conference+table',
  '2026-07-15 10:00:00+00', array['imprensa','infraestrutura']
),
(
  (select id from public.news_categories where slug = 'imprensa'),
  'Rogério Tavares concede coletiva em Feira de Santana',
  'Candidato respondeu perguntas de jornalistas sobre o plano de governo.',
  'rogerio-concede-coletiva-em-feira-de-santana',
  'Na coletiva, o candidato detalhou investimentos em educação e saúde para o Portal do Sertão.',
  '## Coletiva de imprensa\n\nEm Feira de Santana, Rogério Tavares concedeu coletiva à imprensa regional e detalhou propostas de investimentos em educação e saúde.\n\nO candidato também falou sobre o papel do Legislativo na fiscalização e na destinação de emendas para os municípios.\n\n> Diálogo aberto com a imprensa e a população.',
  'https://dimg.dreamflow.cloud/v1/image/Press+conference+with+many+journalists+and+microphones',
  '2026-06-30 14:00:00+00', array['imprensa','coletiva']
),
(
  (select id from public.news_categories where slug = 'imprensa'),
  'Opinião: renovação e trabalho sério na Assembleia',
  'Articulista destaca a importância da renovação no Legislativo estadual.',
  'opiniao-renovacao-e-trabalho-serio-na-assembleia',
  'Artigo de opinião publicado em veículo regional sobre o papel do novo deputado estadual.',
  '## Renovação no Legislativo\n\nArtigo de opinião publicado em veículo regional destaca a importância da renovação da Assembleia Legislativa.\n\nO texto aponta a proximidade com a população e a transparência como pilares do mandato que o 45788 pretende construir.\n\n> A política feita com seriedade transforma vidas.',
  'https://dimg.dreamflow.cloud/v1/image/Person+writing+an+opinion+article+at+a+desk',
  '2026-06-15 08:00:00+00', array['imprensa','opinião']
);

-- COMUNICADOS
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'comunicados'),
  'Rogério Tavares assume compromisso com a renovação do estado',
  'Comunicado oficial sobre o compromisso com a renovação da Assembleia Legislativa.',
  'rogerio-assume-compromisso-com-a-renovacao-do-estado',
  'Comunicado oficial da campanha sobre o compromisso de renovação e trabalho sério para a Assembleia Legislativa.',
  '## Compromisso com a renovação\n\nRogério Tavares assume publicamente o compromisso com a renovação do estado.\n\nCom o número 45788, a campanha levará ao Legislativo o trabalho sério que a população baiana espera, marcado pela transparência e pela escuta das comunidades.',
  'https://dimg.dreamflow.cloud/v1/image/Rog%C3%A9rio+Tavares+giving+a+speech+to+a+crowd',
  '2026-08-18 08:00:00+00', array['comunicado','renovação']
),
(
  (select id from public.news_categories where slug = 'comunicados'),
  'Comunicado: agenda oficial da semana',
  'Confira os compromissos públicos da campanha para esta semana.',
  'comunicado-agenda-oficial-da-semana',
  'A agenda oficial reúne plenárias, visitas técnicas e encontros com a população.',
  '## Agenda da semana\n\nA campanha 45788 divulga a agenda oficial da semana, com plenárias, visitas técnicas e encontros com a população.\n\nOs compromissos são abertos ao público e podem ser acompanhados na aba Agenda do aplicativo oficial.\n\n> Transparência começa pela agenda.',
  'https://dimg.dreamflow.cloud/v1/image/Calendar+with+highlights+on+a+desk',
  '2026-08-10 07:30:00+00', array['comunicado','agenda']
),
(
  (select id from public.news_categories where slug = 'comunicados'),
  'Nota oficial: participação confirmada em debate regional',
  'Candidato confirmou presença em debate promovido por associação de municípios.',
  'nota-oficial-participacao-confirmada-em-debate-regional',
  'A campanha confirmou a participação de Rogério Tavares no próximo debate regional de propostas.',
  '## Participação confirmada\n\nA campanha confirma a participação de Rogério Tavares no debate regional de propostas promovido pela associação de municípios.\n\nO evento será aberto ao público e transmitido ao vivo pelas redes oficiais.\n\n> Propostas em debate, construídas com você.',
  'https://dimg.dreamflow.cloud/v1/image/Formal+notice+document+with+pen',
  '2026-08-01 12:00:00+00', array['comunicado','debate']
),
(
  (select id from public.news_categories where slug = 'comunicados'),
  'Comunicado: atualização dos canais de participação',
  'Novos canais aproximam a população das decisões da campanha.',
  'comunicado-atualizacao-dos-canais-de-participacao',
  'Gabine digital, WhatsApp e aplicativo: conheça os canais oficiais de participação.',
  '## Canais de participação\n\nA campanha atualiza os canais oficiais de participação: Gabinete Digital, WhatsApp, formulário de demandas e o aplicativo oficial.\n\nTodas as mensagens são recebidas pela equipe e os temas debatidos entram na construção das propostas.\n\n> Sua voz constrói nossas propostas.',
  'https://dimg.dreamflow.cloud/v1/image/People+using+smartphones+and+chat+interface',
  '2026-07-22 09:00:00+00', array['comunicado','participação']
);

-- PROJETOS
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'projetos'),
  'Plano de Modernização do Ensino Técnico',
  'Polos tecnológicos regionais vão capacitar jovens e gerar renda local.',
  'plano-de-modernizacao-do-ensino-tecnico',
  'Rogério Tavares propõe a criação de polos tecnológicos regionais para capacitar jovens e gerar renda local.',
  '## Polos tecnológicos regionais\n\nO plano de modernização do ensino técnico prevê a criação de polos tecnológicos regionais, conectando educação, inovação e emprego.\n\nOs polos devem oferecer laboratórios modernos, cursos alinhados às vocações locais e parcerias com empresas e universidades.\n\n> Capacitação para o futuro, renda para as regiões.',
  'https://dimg.dreamflow.cloud/v1/image/Technology+pole+with+modern+labs+and+students',
  '2026-08-08 10:00:00+00', array['projetos','educação','tecnologia']
),
(
  (select id from public.news_categories where slug = 'projetos'),
  'Projeto Água para Todos avança no Sertão Produtivo',
  'Iniciativa prevê cisternas e sistemas de abastecimento para comunidades rurais.',
  'projeto-agua-para-todos-avanca-no-sertao-produtivo',
  'O projeto combate os efeitos da seca com água de qualidade perto de casa.',
  '## Água para Todos\n\nO projeto Água para Todos avança pelo Sertão Produtivo com a instalação de cisternas e sistemas simplificados de abastecimento.\n\nA proposta garante água de qualidade para consumo humano, dessedentação animal e pequenas produções.\n\n> Água é vida e dignidade no campo.',
  'https://dimg.dreamflow.cloud/v1/image/Water+tank+system+in+a+small+farm+community',
  '2026-07-19 09:00:00+00', array['projetos','água','sertão']
),
(
  (select id from public.news_categories where slug = 'projetos'),
  'Projeto Estrada Viva: recuperação de vicinais',
  'Manutenção de estradas vicinais facilita o escoamento e o acesso à escola.',
  'projeto-estrada-viva-recuperacao-de-vicinais',
  'O projeto prevê um programa permanente de manutenção das estradas vicinais do interior.',
  '## Estradas Vivas\n\nO projeto Estrada Viva prevê um programa permanente de manutenção das estradas vicinais, garantindo o escoamento da produção e o acesso a escolas e postos de saúde.\n\nA proposta inclui parcerias com prefeituras e consórcios municipais para agilizar as obras.\n\n> Estrada boa é desenvolvimento e segurança.',
  'https://dimg.dreamflow.cloud/v1/image/Rural+road+being+restored+with+machinery',
  '2026-07-05 08:00:00+00', array['projetos','estradas','interior']
),
(
  (select id from public.news_categories where slug = 'projetos'),
  'Projeto Luz no Campo chega ao Extremo Sul',
  'Energia solar para unidades rurais amplia produção e reduz custos.',
  'projeto-luz-no-campo-chega-ao-extremo-sul',
  'O projeto leva energia solar a unidades rurais do Extremo Sul da Bahia.',
  '## Luz no Campo\n\nO projeto Luz no Campo leva sistemas de energia solar a unidades rurais do Extremo Sul, reduzindo custos e ampliando a produção.\n\nA iniciativa beneficia agricultores familiares, escolas do campo e associações comunitárias.\n\n> Energia limpa gerando renda no campo.',
  'https://dimg.dreamflow.cloud/v1/image/Solar+panels+in+a+family+farm+in+the+countryside',
  '2026-06-22 14:00:00+00', array['projetos','energia','Extremo Sul']
);

-- CULTURA
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'cultura'),
  '45788 apoia festivais culturais do interior',
  'Iniciativa fortalece festas populares e economia criativa das cidades.',
  '45788-apoia-festivais-culturais-do-interior',
  'A campanha defende calendário permanente de apoio aos festivais do interior.',
  '## Festivais do interior\n\nA campanha 45788 defende um calendário permanente de apoio aos festivais culturais do interior.\n\nAs festas populares movimentam a economia local, geram emprego temporário e valorizam a identidade de cada região.\n\n> Cultura é identidade e economia do nosso povo.',
  'https://dimg.dreamflow.cloud/v1/image/Music+festival+stage+with+people+in+a+small+town',
  '2026-08-06 18:00:00+00', array['cultura','festivais']
),
(
  (select id from public.news_categories where slug = 'cultura'),
  'Circuito cultural debate fortalecimento do artesanato baiano',
  'Artesãos e cooperativas participam de encontro sobre geração de renda pela cultura.',
  'circuito-cultural-debate-artesanato-baiano',
  'O encontro discutiu o apoio a cooperativas, feiras e a comercialização do artesanato.',
  '## Artesanato baiano\n\nUm circuito cultural promovido pela campanha reuniu artesãos e cooperativas para debater o fortalecimento do artesanato baiano.\n\nForam discutidas linhas de crédito, participação em feiras nacionais e a formalização das cooperativas.\n\n> O artesanato carrega a história da Bahia.',
  'https://dimg.dreamflow.cloud/v1/image/Handicraft+market+with+local+artisans',
  '2026-07-23 10:00:00+00', array['cultura','artesanato']
),
(
  (select id from public.news_categories where slug = 'cultura'),
  'Rogério Tavares visita centro cultural em Ilhéus',
  'Candidato conhece projetos de música, teatro e cinema para jovens da região.',
  'rogerio-visita-centro-cultural-em-ilheus',
  'A visita reforçou o compromisso com pontos de cultura na Região Sul do estado.',
  '## Visita a centro cultural\n\nRogério Tavares visitou um centro cultural em Ilhéus que oferece oficinas de música, teatro e cinema para jovens.\n\nA visita reforçou a proposta de ampliar os pontos de cultura na Região Sul e apoiar as iniciativas comunitárias.\n\n> Cultura para os jovens é futuro para todos.',
  'https://dimg.dreamflow.cloud/v1/image/Cultural+center+with+music+and+theater+workshop',
  '2026-07-03 15:00:00+00', array['cultura','Ilhéus']
),
(
  (select id from public.news_categories where slug = 'cultura'),
  'Proposta cria o calendário oficial de festas populares',
  'Festas de largo, juninas e lavagens ganham apoio permanente do estado.',
  'proposta-cria-calendario-oficial-de-festas-populares',
  'O calendário oficial organiza apoio técnico e financeiro às festas populares.',
  '## Calendário das festas populares\n\nA proposta cria o calendário oficial das festas populares da Bahia, organizando apoio técnico e financeiro para as festas de largo, juninas, lavagens e procissões.\n\nA iniciativa valoriza a fé, a cultura e a economia das cidades.\n\n> Respeito à cultura de cada comunidade.',
  'https://dimg.dreamflow.cloud/v1/image/Street+party+with+colorful+decorations+and+people+dancing',
  '2026-06-18 20:00:00+00', array['cultura','festas populares']
);

-- ESPORTE
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'esporte'),
  'Proposta amplia escolinhas de esporte nas escolas',
  'Projeto prevê aulas e materiais esportivos em todas as escolas estaduais.',
  'proposta-amplia-escolinhas-de-esporte-nas-escolas',
  'O esporte como ferramenta de saúde, educação e inclusão para os jovens.',
  '## Esporte nas escolas\n\nA proposta amplia as escolinhas de esporte dentro das escolas estaduais, garantindo professores, materiais e espaços adequados.\n\nO esporte é tratado como ferramenta de saúde, educação e inclusão social para crianças e adolescentes.\n\n> Esporte é educação de corpo e mente.',
  'https://dimg.dreamflow.cloud/v1/image/Children+playing+soccer+in+a+school+yard',
  '2026-08-03 09:00:00+00', array['esporte','escolas']
),
(
  (select id from public.news_categories where slug = 'esporte'),
  'Torcida organizada 45788 acompanha maratona',
  'Equipe de voluntários levou apoio e água para os atletas no percurso.',
  'torcida-organizada-45788-acompanha-maratona',
  'A ação uniu esporte e campanha na avenida principal da cidade.',
  '## Torcida na maratona\n\nA torcida organizada 45788 marcou presença na maratona local, distribuindo água e apoio aos atletas durante todo o percurso.\n\nA ação reforçou a importância do esporte como política pública de saúde e inclusão.\n\n> Esporte, saúde e comunidade de mãos dadas.',
  'https://dimg.dreamflow.cloud/v1/image/Runners+in+a+marathon+with+crowd+cheering',
  '2026-07-27 07:00:00+00', array['esporte','maratona']
),
(
  (select id from public.news_categories where slug = 'esporte'),
  'Rogério Tavares participa de partida beneficente',
  'Jogo reuniu atletas, artistas e lideranças em prol de instituição social.',
  'rogerio-participa-de-partida-beneficente',
  'A partida arrecadou doações para instituições que atendem crianças e jovens.',
  '## Partida beneficente\n\nRogério Tavares participou de uma partida beneficente que reuniu atletas, artistas e lideranças em apoio a instituições sociais.\n\nA renda e as doações do evento foram destinadas a projetos que atendem crianças e adolescentes.\n\n> Esporte unindo a comunidade por uma causa.',
  'https://dimg.dreamflow.cloud/v1/image/Friendly+soccer+match+with+players+on+the+field',
  '2026-07-09 16:00:00+00', array['esporte','beneficente']
),
(
  (select id from public.news_categories where slug = 'esporte'),
  'Esporte e juventude: centros de treinamento no interior',
  'Proposta prevê espaços de treino e acompanhamento esportivo nas regiões.',
  'esporte-e-juventude-centros-de-treinamento-no-interior',
  'Centros de treinamento aproximam talentos do interior das competições estaduais.',
  '## Centros de treinamento\n\nA proposta prevê centros de treinamento no interior com estrutura para diversas modalidades e acompanhamento técnico.\n\nOs espaços devem aproximar os talentos locais das competições estaduais e nacionais.\n\n> Descobrir talentos em todas as regiões da Bahia.',
  'https://dimg.dreamflow.cloud/v1/image/Sports+training+center+with+young+athletes',
  '2026-06-25 11:00:00+00', array['esporte','juventude']
);

-- TRANSPARÊNCIA
insert into public.news (category_id, title, subtitle, slug, summary, content, image_url, published_at, tags) values
(
  (select id from public.news_categories where slug = 'transparencia'),
  'Prestação de contas: veja a aplicação dos recursos',
  'Painel de transparência da campanha apresenta números atualizados.',
  'prestacao-de-contas-veja-a-aplicacao-dos-recursos',
  'A campanha ampliou o painel de dados com a aplicação de recursos de forma clara e acessível.',
  '## Prestação de contas\n\nA campanha 45788 ampliou o painel de transparência com dados atualizados sobre a aplicação dos recursos.\n\nArrecadação, despesas e informações detalhadas podem ser consultadas na seção Transparência e Dados do aplicativo oficial.\n\n> Transparência é compromisso do primeiro ao último dia.',
  'https://dimg.dreamflow.cloud/v1/image/Financial+chart+and+documents+on+a+desk',
  '2026-08-11 10:00:00+00', array['transparência','prestação de contas']
),
(
  (select id from public.news_categories where slug = 'transparencia'),
  'Painel de transparência ganha novos indicadores',
  'Novos números mostram evolução da arrecadação e dos apoiadores.',
  'painel-de-transparencia-ganha-novos-indicadores',
  'O painel de indicadores da campanha foi atualizado com novos dados de participação.',
  '## Novos indicadores\n\nO painel de transparência foi atualizado com novos indicadores, incluindo o número de apoiadores ativos e as cidades visitadas.\n\nOs dados são de acesso público e podem ser acompanhados pela seção Transparência do aplicativo.\n\n> Acompanhe cada número da nossa caminhada.',
  'https://dimg.dreamflow.cloud/v1/image/Dashboard+with+charts+on+a+laptop+screen',
  '2026-08-02 14:30:00+00', array['transparência','indicadores']
),
(
  (select id from public.news_categories where slug = 'transparencia'),
  'Demandas da população já aparecem no Mapa da Bahia',
  'Aprovadas pela equipe, as demandas são publicadas no mapa oficial da campanha.',
  'demandas-da-populacao-ja-aparecem-no-mapa-da-bahia',
  'O Mapa da Bahia agora exibe demandas aprovadas enviadas pela população.',
  '## Demandas no mapa\n\nO Mapa da Bahia do aplicativo oficial passou a exibir as demandas aprovadas enviadas pela população.\n\nCada ponto no mapa representa um problema registrado e em acompanhamento pela equipe da campanha.\n\n> Envie sua demanda e acompanhe pelo mapa.',
  'https://dimg.dreamflow.cloud/v1/image/Digital+map+with+location+pins+on+a+screen',
  '2026-07-21 09:00:00+00', array['transparência','mapa','demandas']
),
(
  (select id from public.news_categories where slug = 'transparencia'),
  'Relatório de participação popular é divulgado',
  'Documento reúne os principais temas enviados pelos canais oficiais.',
  'relatorio-de-participacao-popular-e-divulgado',
  'O relatório mostra os temas mais demandados pela população nos canais oficiais.',
  '## Relatório de participação\n\nA campanha divulgou o relatório de participação popular com os principais temas enviados pelos canais oficiais.\n\nSaúde, educação e infraestrutura lideram as demandas e ajudam a orientar a construção das propostas.\n\n> As propostas nascem da escuta da população.',
  'https://dimg.dreamflow.cloud/v1/image/Report+document+with+charts+and+graphs',
  '2026-07-11 13:00:00+00', array['transparência','relatório']
);

-- DESTAQUE DA HOME (featured)
update public.news set is_featured = true
where slug = 'rogerio-assume-compromisso-com-a-renovacao-do-estado';

-- ------------------------------------------------------------
-- CIDADES DA BAHIA — 25 MUNICÍPIOS — TODAS COM IMAGEM
-- ------------------------------------------------------------
insert into public.cities (name, slug, state, region, latitude, longitude, image_url) values
  ('Salvador', 'salvador', 'BA', 'Metropolitana de Salvador', -12.9777, -38.5016, 'https://dimg.dreamflow.cloud/v1/image/Salvador+Bahia+skyline'),
  ('Feira de Santana', 'feira-de-santana', 'BA', 'Portal do Sertão', -12.2664, -38.9665, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Feira+de+Santana+Bahia'),
  ('Vitória da Conquista', 'vitoria-da-conquista', 'BA', 'Sudoeste', -14.8531, -40.8725, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Vitoria+da+Conquista+Bahia'),
  ('Barreiras', 'barreiras', 'BA', 'Oeste da Bahia', -12.1528, -44.9900, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Barreiras+Bahia+oeste'),
  ('Ilhéus', 'ilheus', 'BA', 'Região Sul', -14.7932, -39.0392, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Ilheus+Bahia+beach'),
  ('Itabuna', 'itabuna', 'BA', 'Região Sul', -14.7874, -39.2788, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Itabuna+Bahia'),
  ('Jequié', 'jequie', 'BA', 'Vale do Jequiriçá', -13.8575, -40.0837, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Jequie+Bahia'),
  ('Alagoinhas', 'alagoinhas', 'BA', 'Agreste', -12.1335, -38.4206, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Alagoinhas+Bahia'),
  ('Lauro de Freitas', 'lauro-de-freitas', 'BA', 'Metropolitana de Salvador', -12.8944, -38.3270, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Lauro+de+Freitas+Bahia'),
  ('Camaçari', 'camacari', 'BA', 'Metropolitana de Salvador', -12.6998, -38.3231, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Camacari+Bahia+industrial'),
  ('Simões Filho', 'simoes-filho', 'BA', 'Metropolitana de Salvador', -12.7847, -38.4037, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Simoes+Filho+Bahia'),
  ('Juazeiro', 'juazeiro', 'BA', 'Vale do São Francisco', -9.4162, -40.5033, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Juazeiro+Bahia+river'),
  ('Paulo Afonso', 'paulo-afonso', 'BA', 'Vale do São Francisco', -9.4061, -38.2217, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Paulo+Afonso+Bahia+dam'),
  ('Eunápolis', 'eunapolis', 'BA', 'Extremo Sul', -16.3715, -39.5821, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Eunapolis+Bahia'),
  ('Porto Seguro', 'porto-seguro', 'BA', 'Extremo Sul', -16.4499, -39.0646, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Porto+Seguro+Bahia+beach'),
  ('Teixeira de Freitas', 'teixeira-de-freitas', 'BA', 'Extremo Sul', -17.5395, -39.7407, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Teixeira+de+Freitas+Bahia'),
  ('Guanambi', 'guanambi', 'BA', 'Sertão Produtivo', -14.2239, -42.7804, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Guanambi+Bahia'),
  ('Brumado', 'brumado', 'BA', 'Sertão Produtivo', -14.2041, -41.6655, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Brumado+Bahia'),
  ('Jacobina', 'jacobina', 'BA', 'Chapada Norte', -11.1813, -40.5132, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Jacobina+Bahia+mountains'),
  ('Irecê', 'irece', 'BA', 'Centro Norte', -11.3033, -41.8558, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Irece+Bahia'),
  ('Santo Antônio de Jesus', 'santo-antonio-de-jesus', 'BA', 'Recôncavo', -12.9680, -39.2610, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Santo+Antonio+de+Jesus+Bahia'),
  ('Bom Jesus da Lapa', 'bom-jesus-da-lapa', 'BA', 'Vale do São Francisco', -13.2549, -43.4181, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Bom+Jesus+da+Lapa+Bahia'),
  ('Valença', 'valenca', 'BA', 'Baixo Sul', -13.3710, -39.0730, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Valenca+Bahia'),
  ('Cruz das Almas', 'cruz-das-almas', 'BA', 'Recôncavo', -12.6701, -39.1016, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Cruz+das+Almas+Bahia'),
  ('Serrinha', 'serrinha', 'BA', 'Sisaleira', -11.6642, -39.0075, 'https://dimg.dreamflow.cloud/v1/image/Aerial+view+of+Serrinha+Bahia');

-- ============================================================
-- AGENDA OFICIAL — 17 EVENTOS — TODOS COM IMAGEM
-- ============================================================
insert into public.events (
  city_id, title, description, location_name, address, latitude, longitude,
  starts_at, ends_at, event_type, status, is_featured, image_url
) values
(
  (select id from public.cities where slug = 'salvador'),
  'Visita técnica a unidade de saúde',
  'Visita a unidade de saúde da capital para ouvir pacientes e profissionais.',
  'Unidade de Saúde', 'Salvador - BA', -12.9777, -38.5016,
  '2026-09-05 09:00:00-03', '2026-09-05 11:00:00-03', 'visita', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Hospital+corridor+with+doctors+and+nurses'
),
(
  (select id from public.cities where slug = 'vitoria-da-conquista'),
  'Plenária: Saúde e o Futuro do Interior',
  'Plenária temática para debater leitos regionais, médicos e estrutura hospitalar.',
  'Centro de Eventos', 'Vitória da Conquista - BA', -14.8531, -40.8725,
  '2026-09-12 16:00:00-03', '2026-09-12 18:00:00-03', 'plenaria', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Community+meeting+in+a+hall+with+people+seated'
),
(
  (select id from public.cities where slug = 'feira-de-santana'),
  'Caminhada 45788',
  'Caminhada da campanha pelas ruas centrais da cidade.',
  'Praça da Matriz', 'Feira de Santana - BA', -12.2664, -38.9665,
  '2026-09-19 09:00:00-03', '2026-09-19 12:00:00-03', 'caminhada', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Political+rally+with+flags'
),
(
  (select id from public.cities where slug = 'barreiras'),
  'Caravana do Oeste: agenda em Barreiras',
  'Encontro com lideranças e apresentação do plano de infraestrutura para o Oeste.',
  'Centro de Barreiras', 'Barreiras - BA', -12.1528, -44.9900,
  '2026-10-02 09:00:00-03', '2026-10-02 12:00:00-03', 'caravana', 'agendado', true,
  'https://dimg.dreamflow.cloud/v1/image/Caravan+trucks+in+a+country+road+with+people'
),
(
  (select id from public.cities where slug = 'salvador'),
  'Live: Pergunte ao Rogério',
  'Live de perguntas e respostas com o candidato, transmitida pelas redes sociais.',
  'Redes Sociais', 'Redes Sociais Oficiais', -12.9777, -38.5016,
  '2026-10-09 19:00:00-03', '2026-10-09 20:00:00-03', 'live', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Live+stream+studio+with+laptop+camera'
),
(
  (select id from public.cities where slug = 'salvador'),
  'Café com Comerciantes',
  'Encontro com comerciantes para ouvir demandas e apresentar propostas de apoio ao comércio local.',
  'Mercado Central', 'Mercado Central, Salvador - BA', -12.9693, -38.5084,
  '2026-10-15 09:00:00-03', '2026-10-15 10:30:00-03', 'reuniao', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Business+meeting+with+coffee+in+a+hall'
),
(
  (select id from public.cities where slug = 'salvador'),
  'Caminhada 45788',
  'Caminhada da campanha pelas ruas da cidade, com a participação popular.',
  'Calçadão Principal', 'Calçadão Principal, Salvador - BA', -12.9718, -38.5111,
  '2026-10-15 11:30:00-03', '2026-10-15 13:30:00-03', 'caminhada', 'agendado', true,
  'https://dimg.dreamflow.cloud/v1/image/Political+rally+with+flags'
),
(
  (select id from public.cities where slug = 'salvador'),
  'Gravação de Programa Eleitoral',
  'Gravação do programa eleitoral com a participação da equipe e apoiadores.',
  'Estúdio Regional', 'Estúdio Regional, Salvador - BA', -12.9777, -38.5016,
  '2026-10-15 14:00:00-03', '2026-10-15 16:00:00-03', 'programa', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Recording+studio+with+camera+and+lights'
),
(
  (select id from public.cities where slug = 'salvador'),
  'Plenária: Educação e Futuro',
  'Plenária aberta para debater educação, formação técnica e o futuro dos jovens.',
  'Associação de Moradores', 'Associação de Moradores, Salvador - BA', -12.9800, -38.4950,
  '2026-10-15 16:30:00-03', '2026-10-15 18:00:00-03', 'plenaria', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Community+meeting+in+a+hall+with+people+seated'
),
(
  (select id from public.cities where slug = 'salvador'),
  'Live: Pergunte ao Rogério',
  'Live de perguntas e respostas com o candidato, transmitida pelas redes sociais.',
  'Redes Sociais', 'Redes Sociais Oficiais', -12.9777, -38.5016,
  '2026-10-15 19:00:00-03', '2026-10-15 20:00:00-03', 'live', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Live+stream+studio+with+laptop+camera'
),
(
  (select id from public.cities where slug = 'juazeiro'),
  'Plenária: Emprego e Renda',
  'Plenária sobre geração de emprego, apoio ao pequeno negócio e crédito rural.',
  'Câmara Municipal', 'Juazeiro - BA', -9.4162, -40.5033,
  '2026-10-18 16:00:00-03', '2026-10-18 18:00:00-03', 'plenaria', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Community+meeting+in+a+hall+with+people+seated'
),
(
  (select id from public.cities where slug = 'ilheus'),
  'Caminhada 45788',
  'Caminhada da campanha pelas ruas de Ilhéus.',
  'Avenida Central', 'Ilhéus - BA', -14.7932, -39.0392,
  '2026-10-22 09:00:00-03', '2026-10-22 11:30:00-03', 'caminhada', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Political+rally+with+flags'
),
(
  (select id from public.cities where slug = 'barreiras'),
  'Caravana 45788',
  'Encontro com lideranças e apresentação do plano de infraestrutura.',
  'Centro de Barreiras', 'Centro, Barreiras - BA', -12.1528, -44.9900,
  '2026-10-25 09:00:00-03', '2026-10-25 12:00:00-03', 'caravana', 'agendado', true,
  'https://dimg.dreamflow.cloud/v1/image/Caravan+trucks+in+a+country+road+with+people'
),
(
  (select id from public.cities where slug = 'teixeira-de-freitas'),
  'Debate regional de propostas',
  'Debate aberto com a comunidade sobre os planos para o Extremo Sul.',
  'Teatro Municipal', 'Teixeira de Freitas - BA', -17.5395, -39.7407,
  '2026-11-04 18:00:00-03', '2026-11-04 20:00:00-03', 'debate', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Debate+stage+with+microphone+and+audience'
),
(
  (select id from public.cities where slug = 'porto-seguro'),
  'Caravana 45788: Extremo Sul',
  'Agenda da caravana em Porto Seguro com visita a comunidades e plenária.',
  'Praça Central', 'Porto Seguro - BA', -16.4499, -39.0646,
  '2026-11-08 09:00:00-03', '2026-11-08 15:00:00-03', 'caravana', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Caravan+trucks+in+a+country+road+with+people'
),
(
  (select id from public.cities where slug = 'barreiras'),
  'Encontro com lideranças do Oeste',
  'Encontro com prefeitos, vereadores e lideranças do Oeste da Bahia.',
  'Centro de Convenções', 'Barreiras - BA', -12.1528, -44.9900,
  '2026-11-13 14:00:00-03', '2026-11-13 17:00:00-03', 'reuniao', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Business+meeting+with+coffee+in+a+hall'
),
(
  (select id from public.cities where slug = 'salvador'),
  'Live: Pergunte ao Rogério',
  'Live de perguntas e respostas com o candidato, transmitida pelas redes sociais.',
  'Redes Sociais', 'Redes Sociais Oficiais', -12.9777, -38.5016,
  '2026-11-20 19:00:00-03', '2026-11-20 20:00:00-03', 'live', 'agendado', false,
  'https://dimg.dreamflow.cloud/v1/image/Live+stream+studio+with+laptop+camera'
);

-- ------------------------------------------------------------
-- BANNER DA HOME — hero oficial (com imagem)
-- ------------------------------------------------------------
insert into public.banner_home (title, subtitle, badge, image_url, cta_label, sort_order) values
(
  'Rogério Tavares: Experiência e Compromisso com Você',
  'Candidato a Deputado Estadual da Bahia',
  'CONHEÇA ROGÉRIO TAVARES',
  'https://dimg.dreamflow.cloud/v1/image/Rog%C3%A9rio+Tavares+smiling+in+a+professional+campaign+portrait+with+Brazilian+flag+background',
  'Conheça Rogério Tavares', 1
);

-- ------------------------------------------------------------
-- NÚMEROS DA CAMPANHA — painel de transparência
-- ------------------------------------------------------------
insert into public.campaign_numbers (label, value, trend, is_positive, tone, sort_order) values
  ('Arrecadação Total', 'R$ 457k', '+12% esta semana', true, 'primary', 1),
  ('Apoiadores Ativos', '12.8k', '+840 novos', true, 'success', 2),
  ('Despesas Pagas', 'R$ 312k', 'Dentro do teto', true, 'info', 3),
  ('Cidades Visitadas', '42', '+5 planejadas', true, 'accent', 4);

-- ============================================================
-- GALERIA — fotos da campanha (todas com imagem)
-- ============================================================
insert into public.gallery (title, description, image_url, category, album, is_active, sort_order) values
  ('Rogério Tavares em evento de campanha', 'Discurso para a população em ato público.', 'https://dimg.dreamflow.cloud/v1/image/Rog%C3%A9rio+Tavares+giving+a+speech+to+a+crowd', 'eventos', 'Campanha', true, 1),
  ('Retrato oficial', 'Foto oficial da campanha 45788.', 'https://dimg.dreamflow.cloud/v1/image/Rog%C3%A9rio+Tavares+portrait', 'retratos', 'Campanha', true, 2),
  ('Encontro com professores', 'Diálogo com educadores em escola pública.', 'https://dimg.dreamflow.cloud/v1/image/Candidate+talking+to+teachers+in+a+classroom', 'educacao', 'Campanha', true, 3),
  ('Caminhada 45788', 'População nas ruas pela educação.', 'https://dimg.dreamflow.cloud/v1/image/Political+rally+with+flags', 'caminhadas', 'Campanha', true, 4),
  ('Hospital moderno', 'Visita técnica à unidade de saúde do interior.', 'https://dimg.dreamflow.cloud/v1/image/Modern+hospital+interior', 'saude', 'Visitas', true, 5),
  ('Roda de conversa com profissionais', 'Debate com trabalhadores da saúde.', 'https://dimg.dreamflow.cloud/v1/image/Health+workers+in+a+round+table+meeting', 'saude', 'Visitas', true, 6),
  ('Caravana no interior', 'Caravana 45788 percorrendo as estradas da Bahia.', 'https://dimg.dreamflow.cloud/v1/image/Caravan+trucks+in+a+country+road+with+people', 'caravanas', 'Caravanas', true, 7),
  ('Ato na praça', 'Ato pelo emprego em praça pública.', 'https://dimg.dreamflow.cloud/v1/image/Crowd+holding+signs+in+a+town+square', 'eventos', 'Campanha', true, 8),
  ('Entrevista na TV', 'Gravação de entrevista exclusiva.', 'https://dimg.dreamflow.cloud/v1/image/Candidate+in+a+TV+studio', 'imprensa', 'Campanha', true, 9),
  ('Coletiva de imprensa', 'Rogério Tavares responde a perguntas de jornalistas.', 'https://dimg.dreamflow.cloud/v1/image/Press+conference+with+many+journalists+and+microphones', 'imprensa', 'Campanha', true, 10),
  ('Escola modelo', 'Visita a escola com laboratórios e tecnologia.', 'https://dimg.dreamflow.cloud/v1/image/Candidate+visiting+a+school+with+students+in+labs', 'educacao', 'Visitas', true, 11),
  ('Esporte e juventude', 'Partida beneficente com atletas da região.', 'https://dimg.dreamflow.cloud/v1/image/Friendly+soccer+match+with+players+on+the+field', 'esporte', 'Campanha', true, 12),
  ('Cultura popular', 'Festival cultural com apoio da campanha.', 'https://dimg.dreamflow.cloud/v1/image/Music+festival+stage+with+people+in+a+small+town', 'cultura', 'Campanha', true, 13),
  ('Artesanato baiano', 'Encontro com artesãos e cooperativas.', 'https://dimg.dreamflow.cloud/v1/image/Handicraft+market+with+local+artisans', 'cultura', 'Campanha', true, 14);

-- ============================================================
-- VÍDEOS — com miniaturas
-- ============================================================
insert into public.videos (title, description, youtube_id, thumbnail_url, video_type, category, is_active) values
(
  'Conheça as metas de Rogério Tavares para a saúde',
  'Vídeo oficial com as metas de saúde da campanha 45788.',
  'dQw4w9WgXcQ',
  'https://dimg.dreamflow.cloud/v1/image/Candidate+speaking+to+camera',
  'programa', 'Saúde', true
),
(
  'Entrevista exclusiva: O futuro do nosso estado',
  'Rogério Tavares detalha o plano de governo em entrevista exclusiva.',
  'dQw4w9WgXcQ',
  'https://dimg.dreamflow.cloud/v1/image/Candidate+in+a+TV+studio',
  'entrevista', 'Imprensa', true
),
(
  'Caravana 45788: bastidores em Barreiras',
  'Bastidores da caravana pelo Oeste da Bahia.',
  'dQw4w9WgXcQ',
  'https://dimg.dreamflow.cloud/v1/image/Caravan+trucks+in+a+country+road+with+people',
  'programa', 'Caravanas', true
),
(
  'Live: Pergunte ao Rogério — replay',
  'Replay completo da live oficial de perguntas e respostas.',
  'dQw4w9WgXcQ',
  'https://dimg.dreamflow.cloud/v1/image/Live+stream+studio+with+laptop+camera',
  'live', 'Lives', true
),
(
  'Reels: a energia da mobilização 45788',
  'Vídeos curtos mostram o dia a dia da campanha nas ruas.',
  'dQw4w9WgXcQ',
  'https://dimg.dreamflow.cloud/v1/image/Young+team+filming+a+phone+video+campaign',
  'programa', 'Redes', true
);

-- ------------------------------------------------------------
-- DOWNLOADS — materiais oficiais (arquivos ficam prontos para upload no painel)
-- ------------------------------------------------------------
insert into public.downloads (title, description, file_url, file_type, icon, sort_order) values
  ('Plano de Governo 2026', 'Documento completo com as propostas de Rogério Tavares para a Bahia.', '', 'pdf', 'description_rounded', 1),
  ('Santinho 45788', 'Material de campanha para impressão e distribuição.', '', 'santinho', 'campaign_rounded', 2),
  ('Logo Oficial', 'Logotipo oficial em alta resolução.', '', 'logo', 'image_rounded', 3),
  ('Banner de Campanha', 'Banners prontos para redes sociais.', '', 'banner', 'photo_library_outlined', 4),
  ('Adesivos e marca d''água', 'Arquivos da identidade visual da campanha.', '', 'adesivo', 'sell_outlined', 5);

-- ------------------------------------------------------------
-- SETTINGS — textos e configurações institucionais oficiais
-- ------------------------------------------------------------
insert into public.settings (key, value, description) values
(
  'campaign',
  '{"name":"CAMPANHA 2026","election_year":2026,"number":"45788","candidate":"Rogério Tavares","role":"Candidato a Deputado Estadual","state":"Bahia","slogan":"Por um Estado mais Forte"}',
  'Identidade oficial da campanha'
),
(
  'site',
  '{"title":"Rogério Tavares 45788 — Deputado Estadual da Bahia","subtitle":"Site e aplicativo oficial da campanha","domain":"https://SEU-DOMINIO.com.br","description":"Site e aplicativo oficial da campanha de Rogério Tavares, candidato a Deputado Estadual da Bahia — 45788. Plano de governo, notícias, agenda, transparência e participação popular.","keywords":"Rogério Tavares, 45788, Deputado Estadual, Bahia, eleições 2026, plano de governo, notícias, agenda"}',
  'SEO e identidade do site'
),
(
  'hero',
  '{"badge":"CONHEÇA ROGÉRIO TAVARES","title":"Rogério Tavares: Experiência e Compromisso com Você","subtitle":"Candidato a Deputado Estadual da Bahia","image_url":"https://dimg.dreamflow.cloud/v1/image/Rog%C3%A9rio+Tavares+smiling+in+a+professional+campaign+portrait+with+Brazilian+flag+background","cta_label":"Conheça Rogério Tavares"}',
  'Seção hero da Home'
),
(
  'platform',
  '{"description":"Rogério Tavares acredita que a política é o caminho para transformar vidas. Com o número 45788, vamos levar renovação e trabalho sério para a nossa Assembleia Legislativa."}',
  'Mensagem da plataforma'
),
(
  'cta',
  '{"juntos_title":"Juntos com o 45788","juntos_text":"Acompanhe as propostas de Rogério Tavares e faça parte da mudança que o nosso estado precisa.","voluntario_title":"Faça parte da mudança","voluntario_text":"Junte-se ao time do Rogério Tavares. Cadastre-se para ser um voluntário ou receber atualizações da campanha.","voluntario_button":"Quero ser Voluntário 45788","fale_title":"Fale com Rogério","fale_text":"Envie sua sugestão para melhorarmos nossa região juntos.","fale_button":"Enviar Sugestão","download_plan_button":"Baixar Plano de Governo","apoiar_button":"Apoiar Campanha"}',
  'Call to actions de conversão'
),
(
  'contact',
  '{"whatsapp":"","email":"","phone":"","address":"","hours":"","cnpj":"00.000.000/0001-00","security_notice":"Campanha Rogério Tavares. CNPJ: 00.000.000/0001-00. Seus dados estão seguros conosco."}',
  'Informações de contato e rodapé'
),
(
  'agenda',
  '{"disclaimer":"Horários sujeitos a alteração conforme logística de deslocamento da equipe 45788.","month_label":"Agenda de Campanha"}',
  'Textos da Agenda Oficial'
),
(
  'transparency',
  '{"title":"Transparência total na campanha: acompanhe aqui a aplicação dos recursos e o andamento das propostas para o nosso estado.","resources_title":"Alocação de Recursos","pie":"50,20,15,15","pie_labels":"Mídia/Social,Eventos,Logística,Equipe","pie_colors":"primary,success,accent,info","tse_button":"Ver Prestação de Contas (TSE)"}',
  'Painel de Transparência e Dados'
),
(
  'chat',
  '{"title":"Gabinete digital","subtitle":"Canal Oficial de Transparência","welcome":"Olá! Como posso ajudar com informações sobre as novas propostas de infraestrutura?"}',
  'Chat Gabinete Digital'
),
(
  'biography',
  '{"sections":[]}',
  'Biografia: história, trajetória, família, projetos, valores (cadastre pelo painel)'
);