import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';
import 'admin_crud.dart';
import 'admin_utils.dart';

/// CRUD de conteúdo principal (notícias, plano, agenda, cidades, galeria, vídeos).
class AdminNewsList extends ConsumerWidget {
  const AdminNewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<DropdownEntry>> categories() async {
      final rows = await ref.read(newsRepositoryProvider).fetchCategories();
      return [for (final c in rows) DropdownEntry(c.id ?? '', c.name ?? '')];
    }

    return AdminCrudPage(
      title: 'Notícias',
      subtitle: 'Central de notícias — o seed já traz 4 por categoria.',
      table: 'news',
      bucket: 'news',
      titleKey: 'title',
      subtitleKey: 'author',
      statusKey: 'status',
      statusOptions: const ['published', 'draft', 'archived'],
      fields: [
        const FieldSpec('title', 'Título', required: true),
        const FieldSpec('subtitle', 'Subtítulo'),
        const FieldSpec('slug', 'URL (slug)', required: true),
        const FieldSpec('summary', 'Resumo', type: FieldType.textarea, maxLines: 3),
        const FieldSpec('content', 'Conteúdo (markdown)', type: FieldType.textarea, maxLines: 8),
        FieldSpec('category_id', 'Categoria', type: FieldType.select, optionLoader: categories),
        const FieldSpec('author', 'Autor'),
        const FieldSpec('image_url', 'Imagem de capa', type: FieldType.image, bucket: 'news'),
        const FieldSpec('video_url', 'URL do vídeo (YouTube)'),
        const FieldSpec('tags', 'Tags (separadas por vírgula)', type: FieldType.textarea, maxLines: 2),
        const FieldSpec('is_featured', 'Destaque na Home', type: FieldType.boolField),
        const FieldSpec('status', 'Status', type: FieldType.status, options: ['published', 'draft', 'archived']),
        const FieldSpec('published_at', 'Data de publicação', type: FieldType.datetime),
      ],
    );
  }
}

class AdminPlanList extends ConsumerWidget {
  const AdminPlanList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<DropdownEntry>> categories() async {
      final rows = await ref.read(planRepositoryProvider).fetchCategories();
      return [for (final c in rows) DropdownEntry(c.id ?? '', c.name ?? '')];
    }

    return AdminCrudPage(
      title: 'Plano de Governo',
      subtitle: 'Propostas, metas e projetos da campanha.',
      table: 'government_plan',
      bucket: 'candidate',
      titleKey: 'title',
      subtitleKey: 'category_id',
      statusKey: 'status',
      statusOptions: const ['planejado', 'em_andamento', 'concluido'],
      rowActions: {
        'move_up': (c, r, row) => _movePlan(c, r, row, -1),
        'move_down': (c, r, row) => _movePlan(c, r, row, 1),
      },
      fields: [
        const FieldSpec('title', 'Título', required: true),
        const FieldSpec('slug', 'URL (slug)', required: true),
        const FieldSpec('summary', 'Resumo', type: FieldType.textarea, maxLines: 3),
        const FieldSpec('description', 'Descrição', type: FieldType.textarea, maxLines: 6),
        FieldSpec('category_id', 'Categoria', type: FieldType.select, optionLoader: categories),
        const FieldSpec('progress', 'Progresso (0-100)', type: FieldType.number),
        const FieldSpec('status', 'Status', type: FieldType.status, options: ['planejado', 'em_andamento', 'concluido']),
        const FieldSpec('tone', 'Cor do card', type: FieldType.select, options: ['primary', 'secondary', 'info', 'success', 'accent', 'warning']),
        const FieldSpec('impact', 'Impacto esperado', type: FieldType.textarea, maxLines: 2),
        const FieldSpec('is_featured', 'Destaque', type: FieldType.boolField),
        const FieldSpec('sort_order', 'Ordem', type: FieldType.number),
      ],
    );
  }
}

class AdminEventsList extends ConsumerWidget {
  const AdminEventsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<DropdownEntry>> cities() async {
      final rows = await ref.read(agendaRepositoryProvider).fetchAllCitiesAdmin();
      return [for (final c in rows) DropdownEntry(c.id ?? '', c.name)];
    }

    return AdminCrudPage(
      title: 'Agenda Oficial',
      subtitle: 'Compromissos públicos da campanha.',
      table: 'events',
      bucket: 'candidate',
      titleKey: 'title',
      subtitleKey: 'location_name',
      statusKey: 'status',
      statusOptions: const ['agendado', 'acontecendo', 'concluido', 'cancelado'],
      fields: [
        const FieldSpec('title', 'Título', required: true),
        const FieldSpec('description', 'Descrição', type: FieldType.textarea, maxLines: 4),
        FieldSpec('city_id', 'Cidade', type: FieldType.select, optionLoader: cities),
        const FieldSpec('location_name', 'Local'),
        const FieldSpec('address', 'Endereço'),
        const FieldSpec('starts_at', 'Início', type: FieldType.datetime, required: true),
        const FieldSpec('event_type', 'Tipo', type: FieldType.select, options: ['reuniao', 'caminhada', 'live', 'caravana', 'plenaria', 'debate', 'visita', 'programa', 'outro']),
        const FieldSpec('status', 'Status', type: FieldType.status, options: ['agendado', 'acontecendo', 'concluido', 'cancelado']),
        const FieldSpec('image_url', 'Imagem', type: FieldType.image, bucket: 'candidate'),
        const FieldSpec('is_featured', 'Destaque', type: FieldType.boolField),
      ],
      extraActions: SizedBox(
        height: 36,
        child: FilledButton.tonalIcon(
          onPressed: () {
            // Acesso rápido ao mapa público
          },
          icon: const Icon(Icons.map_outlined, size: 18),
          label: const Text('Mapa'),
        ),
      ),
    );
  }
}

class AdminCitiesList extends ConsumerWidget {
  const AdminCitiesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Cidades da Bahia',
      subtitle: 'Municípios exibidos no Mapa oficial.',
      table: 'cities',
      searchField: 'name',
      bucket: 'candidate',
      titleKey: 'name',
      subtitleKey: 'region',
      fields: const [
        FieldSpec('name', 'Nome', required: true),
        FieldSpec('slug', 'URL (slug)', required: true),
        FieldSpec('state', 'UF'),
        FieldSpec('region', 'Região'),
        FieldSpec('latitude', 'Latitude', type: FieldType.number, required: true),
        FieldSpec('longitude', 'Longitude', type: FieldType.number, required: true),
        FieldSpec('population', 'População', type: FieldType.number),
        FieldSpec('image_url', 'Imagem', type: FieldType.image, bucket: 'candidate'),
        FieldSpec('is_active', 'Ativa', type: FieldType.boolField),
      ],
    );
  }
}

class AdminGalleryList extends ConsumerWidget {
  const AdminGalleryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Galeria',
      subtitle: 'Fotos, vídeos, stories e álbuns.',
      table: 'gallery',
      bucket: 'gallery',
      titleKey: 'title',
      subtitleKey: 'category',
      fields: const [
        FieldSpec('title', 'Título'),
        FieldSpec('description', 'Descrição', type: FieldType.textarea, maxLines: 3),
        FieldSpec('category', 'Categoria', type: FieldType.select, options: ['geral', 'eventos', 'retratos', 'educacao', 'saude', 'caminhadas', 'caravanas', 'imprensa', 'esporte', 'cultura']),
        FieldSpec('album', 'Álbum'),
        FieldSpec('image_url', 'Imagem', type: FieldType.image, bucket: 'gallery'),
        FieldSpec('is_video', 'É vídeo?', type: FieldType.boolField),
        FieldSpec('is_story', 'É story?', type: FieldType.boolField),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativa', type: FieldType.boolField),
      ],
    );
  }
}

class AdminVideosList extends ConsumerWidget {
  const AdminVideosList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Vídeos',
      subtitle: 'Lives, entrevistas, reels e transmissões.',
      table: 'videos',
      bucket: 'videos',
      titleKey: 'title',
      subtitleKey: 'category',
      fields: const [
        FieldSpec('title', 'Título', required: true),
        FieldSpec('description', 'Descrição', type: FieldType.textarea, maxLines: 3),
        FieldSpec('youtube_id', 'ID do YouTube'),
        FieldSpec('thumbnail_url', 'Miniatura', type: FieldType.image, bucket: 'videos'),
        FieldSpec('video_type', 'Tipo', type: FieldType.select, options: ['live', 'entrevista', 'reel', 'programa', 'outro']),
        FieldSpec('category', 'Categoria', type: FieldType.select, options: ['geral', 'Saúde', 'Educação', 'Imprensa', 'Caravanas', 'Lives', 'Redes']),
        FieldSpec('duration_seconds', 'Duração (s)', type: FieldType.number),
        FieldSpec('is_featured', 'Destaque', type: FieldType.boolField),
        FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
      ],
    );
  }
}

class AdminDownloadsList extends ConsumerWidget {
  const AdminDownloadsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Envia um PDF diretamente para o bucket downloads e mostra a URL.
    Future<void> uploadPdf() async {
      final scaffold = ScaffoldMessenger.of(context);
      final path = 'materiais/${DateTime.now().millisecondsSinceEpoch}.pdf';
      scaffold.showSnackBar(SnackBar(
        content: Text(
            'Para PDF: envie via Supabase Storage (bucket "downloads") e cole a URL do arquivo no campo "Arquivo". Ex.: $path'),
        duration: const Duration(seconds: 6),
      ));
    }

    return AdminCrudPage(
      title: 'Materiais Oficiais',
      subtitle: 'Plano de Governo PDF, santinhos, logos e banners.',
      table: 'downloads',
      bucket: 'downloads',
      titleKey: 'title',
      subtitleKey: 'file_type',
      fields: const [
        FieldSpec('title', 'Título', required: true),
        FieldSpec('description', 'Descrição', type: FieldType.textarea, maxLines: 2),
        FieldSpec('file_url', 'Arquivo (URL do storage)', required: true),
        FieldSpec('file_type', 'Tipo', type: FieldType.select, options: ['pdf', 'imagem', 'video', 'logo', 'banner', 'santinho', 'adesivo', 'outro']),
        FieldSpec('file_size', 'Tamanho (bytes)', type: FieldType.number),
        FieldSpec('icon', 'Ícone (Material)'),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
      ],
      extraActions: FilledButton.tonalIcon(
        onPressed: uploadPdf,
        icon: const Icon(Icons.info_outline_rounded, size: 18),
        label: const Text('Como enviar PDF'),
      ),
    );
  }
}

class AdminSocialList extends ConsumerWidget {
  const AdminSocialList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Redes Sociais',
      subtitle: 'Canais oficiais da campanha.',
      table: 'social_links',
      searchField: 'platform',
      titleKey: 'platform',
      subtitleKey: 'username',
      fields: const [
        FieldSpec('platform', 'Plataforma', type: FieldType.select, options: ['instagram', 'facebook', 'tiktok', 'youtube', 'whatsapp', 'telegram', 'x', 'email', 'site'], required: true),
        FieldSpec('url', 'Link', required: true),
        FieldSpec('username', 'Usuário'),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
      ],
    );
  }
}

class AdminFaqList extends ConsumerWidget {
  const AdminFaqList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'FAQ',
      subtitle: 'Perguntas frequentes do app.',
      table: 'faq',
      searchField: 'question',
      titleKey: 'question',
      subtitleKey: 'category',
      fields: const [
        FieldSpec('question', 'Pergunta', required: true),
        FieldSpec('answer', 'Resposta', type: FieldType.textarea, maxLines: 4, required: true),
        FieldSpec('category', 'Categoria'),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativa', type: FieldType.boolField),
      ],
    );
  }
}

class AdminTeamList extends ConsumerWidget {
  const AdminTeamList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Equipe',
      subtitle: 'Membros da equipe de campanha.',
      table: 'team',
      searchField: 'full_name',
      bucket: 'candidate',
      titleKey: 'full_name',
      subtitleKey: 'role',
      fields: const [
        FieldSpec('full_name', 'Nome', required: true),
        FieldSpec('role', 'Função'),
        FieldSpec('photo_url', 'Foto', type: FieldType.image, bucket: 'candidate'),
        FieldSpec('bio', 'Biografia', type: FieldType.textarea, maxLines: 3),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
      ],
    );
  }
}

class AdminTestimonialsList extends ConsumerWidget {
  const AdminTestimonialsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Depoimentos',
      subtitle: 'Depoimentos da população.',
      table: 'testimonials',
      searchField: 'author_name',
      bucket: 'candidate',
      titleKey: 'author_name',
      subtitleKey: 'city',
      fields: const [
        FieldSpec('author_name', 'Nome', required: true),
        FieldSpec('city', 'Cidade'),
        FieldSpec('role', 'Profissão'),
        FieldSpec('content', 'Depoimento', type: FieldType.textarea, maxLines: 3, required: true),
        FieldSpec('photo_url', 'Foto', type: FieldType.image, bucket: 'candidate'),
        FieldSpec('rating', 'Nota (1-5)', type: FieldType.number),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
      ],
    );
  }
}

class AdminBannerList extends ConsumerWidget {
  const AdminBannerList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Banner da Home',
      subtitle: 'Carrossel do topo da página inicial.',
      table: 'banner_home',
      bucket: 'banners',
      titleKey: 'title',
      subtitleKey: 'badge',
      rowActions: {
        'move_up': (c, r, row) => _moveBanner(c, r, row, -1),
        'move_down': (c, r, row) => _moveBanner(c, r, row, 1),
      },
      fields: const [
        FieldSpec('title', 'Título', required: true),
        FieldSpec('subtitle', 'Subtítulo'),
        FieldSpec('badge', 'Badge (ex: CONHEÇA ROGÉRIO)'),
        FieldSpec('image_url', 'Imagem do hero', type: FieldType.image, bucket: 'banners'),
        FieldSpec('cta_label', 'Texto do botão'),
        FieldSpec('cta_url', 'Link do botão'),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
      ],
    );
  }
}

/// Move um slide do carrossel na ordenação (sort_order).
Future<void> _moveBanner(
    BuildContext context, WidgetRef ref, Map<String, dynamic> row, int delta) {
  return runAdminAction(context, ref, () async {
    final current = ((row['sort_order'] ?? 0) as num?)?.toInt() ?? 0;
    await ref
        .read(supabaseProvider)
        .from('banner_home')
        .update({'sort_order': (current + delta).clamp(0, 999)})
        .eq('id', row['id']);
  }, success: delta < 0 ? 'Slide movido para cima.' : 'Slide movido para baixo.');
}

/// Move uma proposta na ordenação (sort_order).
Future<void> _movePlan(
    BuildContext context, WidgetRef ref, Map<String, dynamic> row, int delta) {
  return runAdminAction(context, ref, () async {
    final current = ((row['sort_order'] ?? 0) as num?)?.toInt() ?? 0;
    await ref
        .read(supabaseProvider)
        .from('government_plan')
        .update({'sort_order': (current + delta).clamp(0, 999)})
        .eq('id', row['id']);
  }, success: delta < 0 ? 'Proposta movida para cima.' : 'Proposta movida para baixo.');
}

class AdminNumbersList extends ConsumerWidget {
  const AdminNumbersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Números da Campanha',
      subtitle: 'Indicadores do painel de transparência.',
      table: 'campaign_numbers',
      searchField: 'label',
      titleKey: 'label',
      subtitleKey: 'value',
      fields: const [
        FieldSpec('label', 'Rótulo', required: true),
        FieldSpec('value', 'Valor', required: true),
        FieldSpec('trend', 'Tendência (ex: +12%)'),
        FieldSpec('is_positive', 'Tendência positiva?', type: FieldType.boolField),
        FieldSpec('tone', 'Cor', type: FieldType.select, options: ['primary', 'secondary', 'info', 'success', 'accent', 'warning']),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
      ],
    );
  }
}

/// BIOGRAFIA — história, trajetória, família, valores e experiência,
/// tudo editável pelo painel (o app atualiza em tempo real).
class AdminBiographyList extends ConsumerWidget {
  const AdminBiographyList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: 'Biografia',
      subtitle: 'História, trajetória, família, valores e experiência do candidato.',
      table: 'biography_items',
      searchField: 'title',
      titleKey: 'title',
      subtitleKey: 'item_type',
      fields: const [
        FieldSpec('item_type', 'Tipo', type: FieldType.select, options: ['historia', 'trajetoria', 'familia', 'valores', 'experiencia'], required: true),
        FieldSpec('year', 'Ano / Período'),
        FieldSpec('title', 'Título', required: true),
        FieldSpec('text', 'Texto', type: FieldType.textarea, maxLines: 5, required: true),
        FieldSpec('image_url', 'Imagem (opcional)', type: FieldType.image, bucket: 'candidate'),
        FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
      ],
    );
  }
}