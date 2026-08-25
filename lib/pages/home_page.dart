import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../routes/app_shell.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/cards.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/rt_widgets.dart';

/// HOME — réplica fiel do frame 1 + seções institucionais.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => Future.wait([
            ref.refresh(settingsProvider.future),
            ref.refresh(newsProvider.future),
            ref.refresh(plansProvider.future),
            ref.refresh(upcomingEventsProvider.future),
            ref.refresh(videosProvider.future),
            ref.refresh(galleryProvider.future),
          ]),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: _Header()),
              const SliverToBoxAdapter(child: _CarouselSection()),
              const SliverToBoxAdapter(child: _HeroSection()),
              const SliverToBoxAdapter(child: _NewsSection()),
              const SliverToBoxAdapter(child: _CtaSection()),
              const SliverToBoxAdapter(child: _WhoIsRogerio()),
              const SliverToBoxAdapter(child: _PlanPreview()),
              const SliverToBoxAdapter(child: _AgendaPreview()),
              const SliverToBoxAdapter(child: _VideosPreview()),
              const SliverToBoxAdapter(child: _GalleryPreview()),
              const SliverToBoxAdapter(child: _RegionsSection()),
              const SliverToBoxAdapter(child: _RedesSection()),
              const SliverToBoxAdapter(child: _FooterSection()),
              SliverToBoxAdapter(
                child: Container(height: 40, color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Topo institucional (nomes atualizados + hamburger funcional).
class _Header extends ConsumerWidget {
  const _Header();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    return Container(
      color: p.secondaryBackground,
      padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.xl, RtSpace.lg, RtSpace.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: p.primary.withValues(alpha: 0.08),
            shape: const CircleBorder(),
            child: IconButton(
              onPressed: () => appScaffoldKey.currentState?.openDrawer(),
              icon: Icon(Icons.menu_rounded, color: p.primary),
              tooltip: 'Menu',
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: RtSpace.xs,
              children: [
                Text('Deputado Estadual',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: p.secondaryText)),
                Text('Rogério Tavares',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: p.primaryText,
                          fontWeight: FontWeight.w700,
                        )),
              ],
            ),
          ),
          const NumberBadge(),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

/// Carrossel de imagens (design "só imagens") + chips de navegação.
class _CarouselSection extends ConsumerWidget {
  const _CarouselSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.sm, RtSpace.lg, 0),
      child: const HeroCarousel(height: 300),
    );
  }
}

/// Frame 1 — chips de ação primária com pouca opacidade.
class _HeroSection extends ConsumerWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.sm, RtSpace.lg, RtSpace.xs),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: RtSpace.sm),
        child: Row(
          spacing: RtSpace.md,
          children: [
            ActionChip45788(
              icon: Icons.description_rounded,
              label: 'Propostas',
              onTap: () => context.go('/plano'),
            ),
            ActionChip45788(
              icon: Icons.event_rounded,
              label: 'Agenda',
              onTap: () => context.go('/agenda'),
            ),
            ActionChip45788(
              icon: Icons.campaign_rounded,
              label: 'Comunicados',
              onTap: () => context.go('/noticias'),
            ),
            ActionChip45788(
              icon: Icons.podcasts,
              label: 'Voz do Povo',
              onTap: () => context.go('/fale'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }
}

/// Frame 1 — "Últimas da Campanha" com news cards.
class _NewsSection extends ConsumerWidget {
  const _NewsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);
    final news = newsAsync.valueOrNull ?? [];

    return Container(
      padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.xs, RtSpace.lg, RtSpace.lg),
      child: Column(
        spacing: RtSpace.lg,
        children: [
          SectionHeader(
            title: 'Últimas da Campanha',
            onAction: () => context.go('/noticias'),
          ),
          if (newsAsync.isLoading)
            const Column(
              spacing: RtSpace.lg,
              children: [SkeletonBox(height: 220), SkeletonBox(height: 220)],
            )
          else if (newsAsync.hasError && news.isEmpty)
            ErrorRetry(
              onRetry: () => ref.invalidate(newsProvider),
              message: 'Falha ao carregar as notícias. Verifique sua conexão.',
            )
          else if (news.isEmpty)
            const EmptyState(
              title: 'Em breve',
              subtitle: 'As notícias da campanha aparecem aqui.',
              icon: Icons.newspaper_outlined,
            )
          else
            for (final item in news.take(2))
              NewsCard(
                item: item as NewsItem,
                onTap: () => context.go('/noticias/${item.slug}'),
              ),
        ],
      ),
    );
  }
}

/// Frame 1 — CTA "Por um Estado mais Forte".
class _CtaSection extends ConsumerWidget {
  const _CtaSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final platform = settings['platform'] ?? const {};
    final cta = settings['cta'] ?? const {};

    final description = (platform['description'] as String?) ??
        'Rogério Tavares acredita que a política é o caminho para transformar vidas. '
            'Com o número 45788, vamos levar renovação e trabalho sério para a nossa Assembleia Legislativa.';
    final button = (cta['download_plan_button'] as String?) ?? 'Baixar Plano de Governo';

    return Container(
      color: p.surface,
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg, vertical: RtSpace.xxl),
      margin: const EdgeInsets.only(bottom: RtSpace.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: RtSpace.md,
        children: [
          Icon(Icons.how_to_reg_rounded, size: 32, color: p.primary),
          Text('Por um Estado mais Forte',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium),
          Text(description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.secondaryText)),
          const SizedBox(height: RtSpace.md),
          RtButton(
            label: button,
            variant: 'outline',
            size: 'large',
            fullWidth: true,
            icon: Icons.download_rounded,
            onPressed: () => context.go('/downloads'),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 150.ms);
  }
}

/// Quem é Rogério — resumo + foto + link biografia.
class _WhoIsRogerio extends ConsumerWidget {
  const _WhoIsRogerio();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final portrait = ref.watch(portraitUrlImmediateProvider);
    final bioItems = ref.watch(biographyItemsProvider).valueOrNull ?? [];
    final historia = bioItems.where((e) => e.itemType == 'historia').firstOrNull ?? bioItems.firstOrNull;
    final bioText = (historia?.text.isNotEmpty ?? false)
        ? historia!.text
        : 'Experiência, trabalho sério e compromisso com a população. '
            'Com o número ${Env.campaignNumber}, vamos levar renovação para a Assembleia Legislativa.';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
      child: Container(
        padding: const EdgeInsets.all(RtSpace.lg),
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: BorderRadius.circular(RtRadius.xl),
          border: Border.all(color: p.outline),
          boxShadow: [RtShadow.sm()],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Quem é Rogério',
              actionLabel: 'Conhecer',
              onAction: () => context.go('/biografia'),
            ),
            const SizedBox(height: RtSpace.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RtAvatar(name: 'Rogério Tavares', imageUrl: portrait, size: 72),
                const SizedBox(width: RtSpace.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Env.candidateName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800)),
                      Text(Env.candidateRole,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                      const SizedBox(height: RtSpace.sm),
                      Text(
                        bioText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: RtSpace.md),
            RtButton(
              label: 'Conheça Rogério Tavares',
              variant: 'outline',
              fullWidth: true,
              onPressed: () => context.go('/biografia'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Plano de Governo — prévia das propostas em destaque.
class _PlanPreview extends ConsumerWidget {
  const _PlanPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansProvider);
    final plans = plansAsync.valueOrNull ?? [];
    return Padding(
      padding: const EdgeInsets.all(RtSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: RtSpace.md,
        children: [
          SectionHeader(title: 'Plano de Governo', onAction: () => context.go('/plano')),
          if (plansAsync.hasError && plans.isEmpty)
            ErrorRetry(
              onRetry: () => ref.invalidate(plansProvider),
              message: 'Falha ao carregar as propostas. Verifique sua conexão.',
            )
          else if (plans.isEmpty)
            const SkeletonBox(height: 120)
          else
            for (final plan in plans.take(3))
              ProposalCard(
                plan: plan as GovernmentPlan,
                onTap: () => context.go('/plano/${plan.slug}'),
                onShare: () => ShareService.share(plan.title, '/plano/${plan.slug}'),
              ),
          RtButton(
            label: 'Ver todas as propostas',
            variant: 'ghost',
            fullWidth: true,
            icon: Icons.arrow_forward_rounded,
            onPressed: () => context.go('/plano'),
          ),
        ],
      ),
    );
  }
}

/// Agenda — próximos compromissos.
class _AgendaPreview extends ConsumerWidget {
  const _AgendaPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(upcomingEventsProvider);
    final events = eventsAsync.valueOrNull ?? [];
    return Padding(
      padding: const EdgeInsets.all(RtSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: RtSpace.md,
        children: [
          SectionHeader(title: 'Agenda Oficial', onAction: () => context.go('/agenda')),
          if (eventsAsync.hasError && events.isEmpty)
            ErrorRetry(
              onRetry: () => ref.invalidate(upcomingEventsProvider),
              message: 'Falha ao carregar a agenda. Verifique sua conexão.',
            )
          else if (events.isEmpty)
            const SkeletonBox(height: 100)
          else
            for (final e in events.take(3))
              AgendaItem(
                event: e as EventItem,
                onTap: () => context.go('/agenda'),
              ),
        ],
      ),
    );
  }
}

/// Vídeos da campanha (prévia horizontal).
class _VideosPreview extends ConsumerWidget {
  const _VideosPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final videosAsync = ref.watch(videosProvider);
    final videos = videosAsync.valueOrNull
        ?.whereType<VideoItem>()
        .where((v) {
          final id = v.youtubeId.trim();
          return id.isNotEmpty &&
              id != 'dQw4w9WgXcQ' &&
              (v.videoUrl.isNotEmpty || id.isNotEmpty);
        })
        .toList() ??
        [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Vídeos', onAction: () => context.go('/videos')),
          const SizedBox(height: RtSpace.sm),
          if (videosAsync.hasError && videos.isEmpty)
            ErrorRetry(
              onRetry: () => ref.invalidate(videosProvider),
              message: 'Falha ao carregar os vídeos. Verifique sua conexão.',
            )
          else if (videos.isEmpty)
            const SkeletonBox(height: 140)
          else
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                separatorBuilder: (_, __) => const SizedBox(width: RtSpace.md),
                itemBuilder: (context, i) {
                  final v = videos[i];
                  return SizedBox(
                    width: 260,
                    child: Material(
                      color: p.surface,
                      borderRadius: BorderRadius.circular(RtRadius.lg),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => context.go('/videos'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  RtImage(
                                    url: v.thumbnailUrl.isNotEmpty
                                        ? v.thumbnailUrl
                                        : 'https://img.youtube.com/vi/${v.youtubeId}/hqdefault.jpg',
                                  ),
                                  Container(color: Colors.black26),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.play_arrow_rounded,
                                          color: Colors.white, size: 30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(RtSpace.sm),
                              child: Text(v.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

/// Fotos da campanha (prévia horizontal).
class _GalleryPreview extends ConsumerWidget {
  const _GalleryPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryAsync = ref.watch(galleryProvider);
    final gallery = galleryAsync.valueOrNull ?? [];

    return Padding(
      padding: const EdgeInsets.all(RtSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Fotos da Campanha', onAction: () => context.go('/galeria')),
          const SizedBox(height: RtSpace.sm),
          if (galleryAsync.hasError && gallery.isEmpty)
            ErrorRetry(
              onRetry: () => ref.invalidate(galleryProvider),
              message: 'Falha ao carregar as fotos. Verifique sua conexão.',
            )
          else if (gallery.isEmpty)
            const SkeletonBox(height: 120)
          else
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: gallery.length,
                separatorBuilder: (_, __) => const SizedBox(width: RtSpace.sm),
                itemBuilder: (context, i) {
                  final item = gallery[i] as GalleryItem;
                  return GestureDetector(
                    onTap: () => context.go('/galeria'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(RtRadius.lg),
                      child: SizedBox(
                        width: 180,
                        child: RtImage(url: item.imageUrl, placeholderIcon: Icons.photo_outlined),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

/// Regiões atendidas + atalho para o mapa.
class _RegionsSection extends ConsumerWidget {
  const _RegionsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cities = ref.watch(citiesProvider).valueOrNull ?? [];
    final regions = <String>{
      for (final c in cities.whereType<City>())
        if (c.region.isNotEmpty) c.region,
    }.toList()..sort();
    final names = <String>{
      for (final c in cities.whereType<City>())
        if (c.name.isNotEmpty) c.name,
    }.toList()..sort();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Regiões Atendidas', onAction: () => context.go('/mapa')),
          const SizedBox(height: RtSpace.sm),
          if (cities.isEmpty)
            const SkeletonBox(height: 90)
          else ...[
            SizedBox(
              height: 34,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final r in regions.take(6))
                    Padding(
                      padding: const EdgeInsets.only(right: RtSpace.sm),
                      child: CategoryPill(label: r, active: false, onTap: () {}),
                    ),
                ],
              ),
            ),
            const SizedBox(height: RtSpace.sm),
            SizedBox(
              height: 34,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final n in names.take(14))
                    Padding(
                      padding: const EdgeInsets.only(right: RtSpace.sm),
                      child: ActionChip45788(icon: Icons.place_outlined, label: n, onTap: () => context.go('/mapa')),
                    ),
                ],
              ),
            ),
            const SizedBox(height: RtSpace.sm),
            RtButton(
              label: 'Explorar no Mapa da Bahia',
              variant: 'outline',
              fullWidth: true,
              icon: Icons.map_outlined,
              onPressed: () => context.go('/mapa'),
            ),
          ],
        ],
      ),
    );
  }
}

/// Redes sociais oficiais.
class _RedesSection extends ConsumerWidget {
  const _RedesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final socials = ref.watch(socialLinksProvider).valueOrNull ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg, vertical: RtSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Siga a campanha',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: RtSpace.sm),
          if (socials.isEmpty)
            const SkeletonBox(height: 44)
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final s in socials.whereType<SocialLink>())
                  IconButton(
                    tooltip: s.platform,
                    onPressed: () => ShareService.launch(s.url),
                    icon: Icon(ShareService.socialIcon(s.platform), color: p.secondaryText),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

/// Rodapé institucional: canais rápidos + contato + legal.
class _FooterSection extends ConsumerWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final contact = settings['contact'] ?? const {};
    final whatsapp = (contact['whatsapp'] as String? ?? '').trim();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(RtSpace.lg),
      decoration: BoxDecoration(color: p.surfaceVariant.withValues(alpha: 0.4)),
      child: Column(
        spacing: RtSpace.md,
        children: [
          NumberBadge(),
          if (whatsapp.isNotEmpty)
            RtButton(
              label: 'Falar no WhatsApp',
              variant: 'outline',
              fullWidth: true,
              icon: Icons.chat_rounded,
              onPressed: () => ShareService.launch(ShareService.openWhatsApp(whatsapp)),
            ),
          Row(
            spacing: RtSpace.md,
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/contato'),
                  icon: const Icon(Icons.contact_page_outlined),
                  label: const Text('Contato'),
                ),
              ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/fale'),
                  icon: const Icon(Icons.campaign_outlined),
                  label: const Text('Fale conosco'),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          Text('Rogério Tavares ${Env.campaignNumber} • ${Env.candidateRole} • Eleições ${Env.electionYear}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
          Text('Propaganda eleitoral gratuita — Eleições ${Env.electionYear}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
        ],
      ),
    );
  }
}