import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formats.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';

/// DETALHE DA NOTÍCIA — imagem, conteúdo, vídeo, compartilhar e relacionadas.
class NewsDetailPage extends ConsumerStatefulWidget {
  const NewsDetailPage({super.key, required this.slug});

  final String slug;

  @override
  ConsumerState<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends ConsumerState<NewsDetailPage> {
  YoutubePlayerController? _youtube;
  bool _viewsSent = false;

  @override
  void dispose() {
    _youtube?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final itemAsync = ref.watch(_newsBySlugProvider(widget.slug));
    final item = itemAsync.valueOrNull;

    if (itemAsync.isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(RtSpace.lg),
          child: Column(
            spacing: RtSpace.md,
            children: [
              SkeletonBox(height: 220, radius: RtRadius.xl),
              SkeletonBox(height: 40),
              SkeletonBox(height: 200),
            ],
          ),
        ),
      );
    }

    if (item == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const EmptyState(
          title: 'Notícia não encontrada',
          icon: Icons.search_off_rounded,
        ),
      );
    }

    _initVideoIfNeeded(item);
    if (!_viewsSent) {
      _viewsSent = true;
      ref.read(newsRepositoryProvider).incrementViews(item.id!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Central de Notícias'),
        actions: [
          IconButton(
            onPressed: () => ShareService.share(item.title, '/noticias/${item.slug}'),
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagem
                SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: RtImage(url: item.imageUrl),
                ),
                Padding(
                  padding: const EdgeInsets.all(RtSpace.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: RtSpace.md,
                    children: [
                      Row(
                        spacing: RtSpace.sm,
                        children: [
                          RtBadge(
                            label: (item.categoryName ?? 'NOTÍCIAS').toUpperCase(),
                            color: p.primary.withValues(alpha: 0.10),
                            textColor: p.primary,
                          ),
                          Text(
                            Fmt.date(item.publishedAt),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint),
                          ),
                        ],
                      ),
                      Text(
                        item.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ).animate().fadeIn(duration: 350.ms),
                      if (item.subtitle.isNotEmpty)
                        Text(
                          item.subtitle,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: p.secondaryText),
                        ),
                      if (item.author.isNotEmpty)
                        Row(
                          children: [
                            const RtAvatar(name: 'Equipe', size: 28),
                            const SizedBox(width: RtSpace.sm),
                            Flexible(
                              child: Text(
                                item.author,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: p.secondaryText),
                              ),
                            ),
                          ],
                        ),
                      // Vídeo (youtube embed)
                      if (item.isVideo && item.videoUrl.isNotEmpty) _buildVideo(item),
                      // Corpo da notícia — estilo artigo (título grande + texto menor dividido)
                      _ArticleBody(item: item),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: RtButton(
                              label: 'Compartilhar notícia',
                              icon: Icons.share_rounded,
                              variant: 'outline',
                              onPressed: () => ShareService.share(item.title, '/noticias/${item.slug}'),
                            ),
                          ),
                        ],
                      ),
                      _RelatedNews(currentId: item.id),
                      _CommentsSection(item: item),
                      const SizedBox(height: RtSpace.xl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _initVideoIfNeeded(NewsItem item) {
    if (!item.isVideo || item.videoUrl.isEmpty) return;
    final ytId = _extractYoutubeId(item.videoUrl);
    if (ytId == null) return;
    _youtube ??= YoutubePlayerController.fromVideoId(
      videoId: ytId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        showControls: true,
      ),
    );
  }

  String? _extractYoutubeId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.host.contains('youtu.be')) return uri.pathSegments.firstOrNull;
    return uri.queryParameters['v'];
  }

  Widget _buildVideo(NewsItem item) {
    final ytId = _extractYoutubeId(item.videoUrl);
    if (ytId == null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: RtImage(url: item.imageUrl),
      );
    }
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: YoutubePlayer(
          controller: _youtube!,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}

final _newsBySlugProvider = FutureProvider.family<NewsItem?, String>((ref, slug) {
  return ref.watch(newsRepositoryProvider).fetchNewsBySlug(slug);
});

/// Corpo da notícia em estilo de artigo: título grande já renderizado acima,
/// texto do corpo MENOR (15px), peso normal, dividido em parágrafos espaçados.
/// Se não houver conteúdo, usa o resumo (summary) como texto.
class _ArticleBody extends StatelessWidget {
  const _ArticleBody({required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final body = item.content.isNotEmpty ? item.content : item.summary;

    // Estilo do corpo: NORMAL (sem negrito), tamanho 15, entrelinha 1.7.
    const bodyStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      height: 1.7,
      letterSpacing: 0.1,
      inherit: false,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Resumo em destaque (intertítulo do artigo)
        if (item.summary.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: RtSpace.sm),
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm),
            decoration: BoxDecoration(
              color: p.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(RtRadius.md),
              border: Border(left: BorderSide(color: p.primary, width: 3)),
            ),
            child: Text(
              item.summary,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: p.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                    height: 1.55,
                  ),
            ),
          ),
        if (body.isNotEmpty) ...[
          const SizedBox(height: RtSpace.md),
          // Texto do corpo em fonte menor, dividido e espaçado (artigo)
          MarkdownBody(
            data: body,
            styleSheet: MarkdownStyleSheet(
              p: bodyStyle.copyWith(
                color: p.primaryText,
                fontSize: 15,
                fontWeight: FontWeight.normal,
                height: 1.7,
              ),
              h2: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: 'Playfair Display',
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
              h3: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              blockSpacing: 16,
              // Destaques (negrito) apenas onde o autor marcou com ** **
              strong: bodyStyle.copyWith(
                color: p.primaryText,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.7,
              ),
              blockquoteDecoration: BoxDecoration(
                color: p.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(RtRadius.sm),
                border: Border(left: BorderSide(color: p.primary, width: 3)),
              ),
              blockquotePadding: const EdgeInsets.all(RtSpace.md),
              blockquote: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                height: 1.55,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                inherit: false,
                color: p.secondaryText,
              ),
            ),
          ),
        ] else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: RtSpace.md),
            child: Text('Sem texto publicado ainda.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.hint)),
          ),
      ],
    );
  }
}

class _RelatedNews extends ConsumerWidget {
  const _RelatedNews({required this.currentId});

  final String? currentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsProvider).valueOrNull ?? [];
    final related = news
        .whereType<NewsItem>()
        .where((e) => e.id != currentId)
        .take(2)
        .toList();
    if (related.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: RtSpace.md,
      children: [
        const SizedBox(height: RtSpace.sm),
        Text('Relacionadas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
        for (final item in related)
          NewsCard(
            item: item,
            compact: true,
            onTap: () => context.pushReplacement('/noticias/${item.slug}'),
          ),
      ],
    );
  }
}

/// Comentários da notícia.
class _CommentsSection extends ConsumerStatefulWidget {
  const _CommentsSection({required this.item});

  final NewsItem item;

  @override
  ConsumerState<_CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends ConsumerState<_CommentsSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final commentsAsync = ref.watch(_commentsProvider(widget.item.id ?? ''));
    final comments = commentsAsync.valueOrNull ?? [];
    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(myProfileProvider).valueOrNull;
    final canComment = user != null && profile?.role == 'admin';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: RtSpace.md,
      children: [
        Text('Comentários (${comments.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
        if (user == null)
          Container(
            padding: const EdgeInsets.all(RtSpace.md),
            decoration: BoxDecoration(
              color: p.surfaceVariant,
              borderRadius: BorderRadius.circular(RtRadius.lg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text('Entre com uma conta para acompanhar os comentários.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                ),
                TextButton(
                  onPressed: () => context.go('/perfil'),
                  child: const Text('Entrar'),
                ),
              ],
            ),
          )
        else if (!canComment)
          Container(
            padding: const EdgeInsets.all(RtSpace.md),
            decoration: BoxDecoration(
              color: p.surfaceVariant,
              borderRadius: BorderRadius.circular(RtRadius.lg),
            ),
            child: Row(
              children: [
                Icon(Icons.admin_panel_settings_outlined, size: 20, color: p.secondaryText),
                const SizedBox(width: RtSpace.sm),
                Expanded(
                  child: Text('Apenas a administração pode comentar nesta área.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                ),
              ],
            ),
          )
        else
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Escreva seu comentário...'),
                ),
              ),
              const SizedBox(width: RtSpace.sm),
              IconButton(
                onPressed: _send,
                style: IconButton.styleFrom(
                  backgroundColor: p.primary,
                  foregroundColor: p.onPrimary,
                  shape: const CircleBorder(),
                ),
                icon: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        for (final c in comments)
          _CommentTile(comment: c),
        if (comments.isEmpty && !commentsAsync.isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: RtSpace.sm),
            child: Text('Seja o primeiro a comentar.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.hint)),
          ),
      ],
    );
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    await ref.read(engagementRepositoryProvider).addComment(
          targetType: 'news',
          targetId: widget.item.id!,
          content: text,
        );
    _controller.clear();
    ref.invalidate(_commentsProvider(widget.item.id ?? ''));
    setState(() {});
  }
}

final _commentsProvider =
    FutureProvider.family<List<CommentItem>, String>((ref, id) {
  return ref.watch(engagementRepositoryProvider).fetchComments('news', id);
});

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final CommentItem comment;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Container(
      padding: const EdgeInsets.all(RtSpace.md),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        border: Border.all(color: p.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RtAvatar(
            name: comment.authorName ?? comment.fullName,
            imageUrl: comment.authorAvatar,
            size: 36,
          ),
          const SizedBox(width: RtSpace.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text((comment.authorName != null && comment.authorName!.isNotEmpty)
                        ? comment.authorName!
                        : (comment.fullName.isNotEmpty ? comment.fullName : 'Anônimo'),
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                    Text(Fmt.ago(comment.createdAt ?? DateTime.now()),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(comment.content,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}