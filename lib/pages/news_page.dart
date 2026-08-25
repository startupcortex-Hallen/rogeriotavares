import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';

/// CENTRAL DE NOTÍCIAS — réplica fiel do frame 3 (destaque + feed infinito).
class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  String _filter = 'Tudo';
  static const _categories = ['Tudo', 'Vídeos', 'Fotos', 'Projetos'];
  final _scroll = ScrollController();
  final List<NewsItem> _loaded = [];
  int _page = 0;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore) return;
    setState(() => _loadingMore = true);
    final repo = ref.read(newsRepositoryProvider);
    try {
      final next = _page + 1;
      final items = await repo.fetchNews(from: next * 10, to: next * 10 + 9);
      if (items.isNotEmpty) {
        _page = next;
        setState(() => _loaded.addAll(items));
      }
    } catch (_) {}
    setState(() => _loadingMore = false);
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final campaign = settings['campaign'] ?? const {};
    final campaignName = (campaign['name'] as String?) ?? 'CAMPANHA ${Env.electionYear}';
    final featuredAsync = ref.watch(featuredNewsProvider);

    final newsAsync = ref.watch(newsProvider);
    final news = newsAsync.valueOrNull ?? [];

    final feed = _filter == 'Tudo'
        ? news
        : news.where((n) {
            final item = n as NewsItem;
            final cat = (item.categoryName ?? '').toUpperCase();
            return switch (_filter) {
              'Vídeos' => item.isVideo,
              'Projetos' => cat == 'PROJETOS',
              'Fotos' => cat == 'EVENTOS' || cat == 'CULTURA',
              _ => true,
            };
          }).toList();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(newsProvider);
          ref.invalidate(featuredNewsProvider);
          _loaded.clear();
          _page = 0;
        },
        child: CustomScrollView(
          controller: _scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _NewsHeader(campaignName)),
            SliverToBoxAdapter(child: _SectorNav()),
            // Destaque da campanha
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(RtSpace.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: RtSpace.md,
                  children: [
                    Text('Destaque da Campanha',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: p.onSurfaceVariant, fontWeight: FontWeight.bold)),
                    _FeaturedCard(item: featuredAsync.valueOrNull as NewsItem?),
                  ],
                ),
              ),
            ),
            // Pills de categoria
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
                  children: [
                    for (final c in _categories)
                      Padding(
                        padding: const EdgeInsets.only(right: RtSpace.sm),
                        child: CategoryPill(
                          label: c,
                          active: _filter == c,
                          onTap: () => setState(() => _filter = c),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Feed
            SliverPadding(
              padding: const EdgeInsets.all(RtSpace.lg),
              sliver: SliverList.list(
                children: [
                  if (newsAsync.isLoading)
                    const Column(
                      spacing: RtSpace.md,
                      children: [SkeletonBox(height: 110), SkeletonBox(height: 110)],
                    )
                  else if (newsAsync.hasError && feed.isEmpty)
                    ErrorRetry(
                      onRetry: () => ref.invalidate(newsProvider),
                      message: 'Falha ao carregar as notícias. Verifique sua conexão.',
                    )
                  else if (feed.isEmpty)
                    const EmptyState(
                      title: 'Nenhuma notícia',
                      subtitle: 'Em breve novos conteúdos da campanha.',
                      icon: Icons.newspaper_outlined,
                    )
                  else
                    ...[
                      for (final item in feed)
                        Padding(
                          padding: const EdgeInsets.only(bottom: RtSpace.md),
                          child: NewsFeedItem(
                            item: item as NewsItem,
                            isVideo: item.isVideo,
                            onTap: () => context.go('/noticias/${item.slug}'),
                          ),
                        ),
                      for (final extra in _loaded)
                        Padding(
                          padding: const EdgeInsets.only(bottom: RtSpace.md),
                          child: NewsFeedItem(
                            item: extra,
                            isVideo: extra.isVideo,
                            onTap: () => context.go('/noticias/${extra.slug}'),
                          ),
                        ),
                      if (_loadingMore)
                        const Padding(
                          padding: EdgeInsets.all(RtSpace.sm),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      // Card PROPOSTA 45788 (design frame 3)
                      const _ProposalHighlightCard(),
                      const SizedBox(height: RtSpace.lg),
                      // CTA Juntos com o 45788
                      const _JuntosCta(),
                    ],
                ],
              ),
            ),
            SliverToBoxAdapter(child: Container(height: 80)),
          ],
        ),
      ),
    );
  }
}

/// Cabeçalho "CAMPANHA 2026 / Rogério Tavares" + badge 45788.
class _NewsHeader extends StatelessWidget {
  const _NewsHeader(this.campaignName);

  final String campaignName;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Container(
      color: p.secondaryBackground,
      padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.lg, RtSpace.lg, RtSpace.md),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.divider))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: RtSpace.xs,
            children: [
              Text(campaignName,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: p.primary, fontWeight: FontWeight.bold, letterSpacing: 1)),
              Text('Rogério Tavares',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: p.onSurfaceVariant)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.xs),
            decoration: BoxDecoration(
              color: p.primary,
              borderRadius: BorderRadius.circular(RtRadius.sm),
            ),
            child: Text('45788',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: p.onPrimary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

/// Navegação por setores (design frame 3).
class _SectorNav extends StatelessWidget {
  const _SectorNav();

  static const _items = [
    (Icons.psychology_rounded, 'Propostas', '/plano'),
    (Icons.groups_rounded, 'Agenda', '/agenda'),
    (Icons.volunteer_activism_rounded, 'Social', '/participe'),
    (Icons.gavel_rounded, 'Leis', '/contato'),
    (Icons.record_voice_over_rounded, 'Voz', '/fale'),
  ];

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg, vertical: RtSpace.sm),
      child: Row(
        spacing: RtSpace.md,
        children: [
          for (final (icon, label, path) in _items)
            InkWell(
              onTap: () => context.go(path),
              borderRadius: BorderRadius.circular(RtRadius.md),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RtRadius.md),
                  border: Border.all(color: p.outline),
                  color: p.surface,
                ),
                child: Column(
                  children: [
                    Icon(icon, color: p.primary, size: 22),
                    const SizedBox(height: 2),
                    Text(label,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.secondaryText)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Card de destaque com gradiente (design frame 3).
class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({this.item});

  final NewsItem? item;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    if (item == null) {
      return const SkeletonBox(height: 260, radius: RtRadius.xl);
    }
    return Container(
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RtRadius.xl),
        boxShadow: [RtShadow.md()],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RtImage(url: item!.imageUrl),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  p.onSurfaceVariant.withValues(alpha: 0.9),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(RtSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: RtSpace.sm,
              children: [
                RtBadge(label: 'DEPUTADO ESTADUAL'),
                InkWell(
                  onTap: item == null
                      ? null
                      : () => context.go('/noticias/${item!.slug}'),
                  child: Text(
                    item!.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: p.onBackground, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

/// Card "PROPOSTA 45788" com curtir/compartilhar (design frame 3).
class _ProposalHighlightCard extends ConsumerWidget {
  const _ProposalHighlightCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final plans = ref.watch(plansProvider).valueOrNull ?? [];
    final featured = plans.whereType<GovernmentPlan>().where((e) => e.isFeatured).firstOrNull;

    if (featured == null) return const SizedBox.shrink();

    void like() {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entre com uma conta para curtir a proposta.')),
        );
        context.go('/perfil');
        return;
      }
      ref.read(engagementRepositoryProvider).toggleLike('proposal', featured.id!);
    }

    return Container(
      padding: const EdgeInsets.all(RtSpace.lg),
      decoration: BoxDecoration(
        color: p.secondaryBackground,
        borderRadius: BorderRadius.circular(RtRadius.xl),
        border: Border.all(color: p.primary.withValues(alpha: 0.30), width: 2),
      ),
      child: Column(
        spacing: RtSpace.md,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RtBadge(label: 'PROPOSTA 45788', color: p.secondary, textColor: p.onSecondary),
              Icon(Icons.auto_awesome_rounded, color: p.secondary),
            ],
          ),
          Text(featured.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: p.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  )),
          Text(featured.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
          Divider(color: p.primary.withValues(alpha: 0.10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Apoia esta ideia?',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: p.onSurfaceVariant)),
              Row(
                spacing: RtSpace.sm,
                children: [
                  IconButton(
                    onPressed: like,
                    style: IconButton.styleFrom(
                      side: BorderSide(color: p.error.withValues(alpha: 0.20)),
                      shape: const CircleBorder(),
                    ),
                    icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent),
                  ),
                  IconButton(
                    onPressed: () => ShareService.share(featured.title, '/plano/${featured.slug}'),
                    style: IconButton.styleFrom(
                      side: BorderSide(color: p.secondary.withValues(alpha: 0.20)),
                      shape: const CircleBorder(),
                    ),
                    icon: Icon(Icons.share_rounded, color: p.secondary),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}

/// CTA "Juntos com o 45788" (design frame 3).
class _JuntosCta extends ConsumerWidget {
  const _JuntosCta();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final cta = settings['cta'] ?? const {};

    return Container(
      margin: const EdgeInsets.only(bottom: RtSpace.md),
      padding: const EdgeInsets.all(RtSpace.xxl),
      decoration: BoxDecoration(
        color: p.primary,
        borderRadius: BorderRadius.circular(RtRadius.lg),
      ),
      child: Column(
        spacing: RtSpace.md,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.how_to_reg_rounded, size: 32, color: Colors.white),
          Text('Juntos com o 45788',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: p.onPrimary, fontWeight: FontWeight.w700)),
          Text(
            (cta['juntos_text'] as String?) ??
                'Acompanhe as propostas de Rogério Tavares e faça parte da mudança que o nosso estado precisa.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.onPrimary),
          ),
          RtButton(
            label: (cta['download_plan_button'] as String?) ?? 'Baixar Plano de Governo',
            variant: 'outline',
            fullWidth: true,
            onPressed: () => context.go('/downloads'),
          ),
        ],
      ),
    );
  }
}