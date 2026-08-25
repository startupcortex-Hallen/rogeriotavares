import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';
import 'admin_widgets.dart';

/// DASHBOARD — estatísticas ao vivo, pendências e últimas publicações.
class AdminHome extends ConsumerWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final countsAsync = ref.watch(_countsProvider);
    final counts = countsAsync.valueOrNull ?? const DashboardCounts();
    final recentNews = ref.watch(_recentNewsProvider).valueOrNull ?? [];
    final audit = ref.watch(_auditProvider).valueOrNull ?? [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AdminHeader(
            title: 'Dashboard da Campanha',
            subtitle: 'Tudo o que você publica aqui aparece no app na hora.',
          ),
          // KPI — contadores ao vivo
          if (countsAsync.isLoading)
            const SkeletonBox(height: 180)
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 1100
                    ? 4
                    : constraints.maxWidth >= 700
                        ? 3
                        : 2;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: columns,
                  mainAxisSpacing: RtSpace.md,
                  crossAxisSpacing: RtSpace.md,
                  childAspectRatio: 2.6,
                  children: [
                    StatCard(icon: Icons.newspaper_rounded, value: counts.newsCount.toString(), label: 'Notícias', color: const Color(0xFF1565C0), onTap: () => context.go('/admin/noticias')),
                    StatCard(icon: Icons.description_rounded, value: counts.planCount.toString(), label: 'Propostas', color: const Color(0xFF0D47A1), onTap: () => context.go('/admin/plano')),
                    StatCard(icon: Icons.event_rounded, value: counts.eventsCount.toString(), label: 'Eventos', color: const Color(0xFF455A64), onTap: () => context.go('/admin/agenda')),
                    StatCard(icon: Icons.location_city_rounded, value: counts.citiesCount.toString(), label: 'Cidades', color: const Color(0xFF457B9D), onTap: () => context.go('/admin/cidades')),
                    StatCard(icon: Icons.play_circle_rounded, value: counts.videosCount.toString(), label: 'Vídeos', color: const Color(0xFF606C38), onTap: () => context.go('/admin/videos')),
                    StatCard(icon: Icons.photo_library_rounded, value: counts.galleryCount.toString(), label: 'Mídias', color: const Color(0xFFFFD600), onTap: () => context.go('/admin/galeria')),
                    StatCard(icon: Icons.favorite_rounded, value: counts.likesCount.toString(), label: 'Curtidas', color: const Color(0xFFAE2012), onTap: () => context.go('/admin')),
                  ],
                );
              },
            ),
          const SizedBox(height: RtSpace.lg),

          // Configurações do app (acesso rápido no mobile, sem menu lateral)
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              final card = Card(
                child: ListTile(
                  leading: const Icon(Icons.settings_rounded, color: Color(0xFF1565C0)),
                  title: const Text('Configurações do app'),
                  subtitle: const Text('Contato do comitê, textos e avisos (settings).'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.go('/admin/configuracoes'),
                ),
              );
              if (wide) {
                return Row(
                  spacing: RtSpace.md,
                  children: [
                    Expanded(child: card),
                    Expanded(
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.category_rounded, color: Color(0xFF1565C0)),
                          title: const Text('Conteúdo & Config'),
                          subtitle: const Text('FAQ, equipe, banners, números e carrossel.'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => context.go('/admin/conteudo'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.person_rounded, color: Color(0xFF1565C0)),
                          title: const Text('Minha conta'),
                          subtitle: const Text('Perfil do administrador e segurança.'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => context.go('/admin/conta'),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                spacing: RtSpace.sm,
                children: [
                  card,
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.category_rounded, color: Color(0xFF1565C0)),
                      title: const Text('Conteúdo & Config'),
                      subtitle: const Text('FAQ, equipe, banners, números e carrossel.'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.go('/admin/conteudo'),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: RtSpace.lg),

          // Precisa de atenção — pendências clicáveis
          const Text('Precisa de atenção',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, fontFamily: 'Nunito',
                  letterSpacing: 0.3, color: Color(0xFF4A3228))),
          const SizedBox(height: RtSpace.sm),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              final pending = <Widget>[
                if (counts.volunteersPending > 0)
                  _AttentionTile(
                    icon: Icons.volunteer_activism_rounded,
                    label: 'Voluntários pendentes',
                    count: counts.volunteersPending,
                    color: const Color(0xFFBC6C25),
                    onTap: () => context.go('/admin/voluntarios'),
                  ),
                if (counts.messagesNew > 0)
                  _AttentionTile(
                    icon: Icons.mail_rounded,
                    label: 'Mensagens novas',
                    count: counts.messagesNew,
                    color: const Color(0xFFAE2012),
                    onTap: () => context.go('/admin/mensagens'),
                  ),
                if (counts.reportsPending > 0)
                  _AttentionTile(
                    icon: Icons.warning_amber_rounded,
                    label: 'Demandas pendentes',
                    count: counts.reportsPending,
                    color: const Color(0xFF457B9D),
                    onTap: () => context.go('/admin/demandas'),
                  ),
              ];
              if (pending.isEmpty) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.check_circle_rounded, color: p.success),
                    title: const Text('Tudo em dia!'),
                    subtitle: const Text('Nenhuma pendência de aprovação.'),
                  ),
                );
              }
              if (wide) {
                return Row(
                  spacing: RtSpace.md,
                  children: [
                    for (final w in pending) Expanded(child: w),
                  ],
                );
              }
              return Column(
                spacing: RtSpace.sm,
                children: pending,
              );
            },
          ),

          const SizedBox(height: RtSpace.lg),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;

              // Últimas publicações (notícias recentes)
              final newsCard = Card(
                child: Padding(
                  padding: const EdgeInsets.all(RtSpace.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Últimas publicações',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          const Spacer(),
                          TextButton(
                            onPressed: () => context.go('/admin/noticias'),
                            child: const Text('Ver todas'),
                          ),
                        ],
                      ),
                      const SizedBox(height: RtSpace.sm),
                      if (recentNews.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: RtSpace.md),
                          child: Text('Nenhuma notícia publicada ainda.'),
                        )
                      else
                        for (final n in recentNews.take(5))
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: _MiniThumb(url: n.imageUrl),
                            title: Text(n.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall),
                            subtitle: Text(
                                '${n.categoryName ?? 'Notícia'} • ${(n.publishedAt ?? DateTime(2026)).toString().substring(0, 10)}',
                                style: Theme.of(context).textTheme.labelSmall),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _StatusDot(status: n.status),
                                const SizedBox(width: RtSpace.xs),
                                const Icon(Icons.chevron_right_rounded, size: 18),
                              ],
                            ),
                            onTap: () => context.go('/admin/noticias'),
                          ),
                    ],
                  ),
                ),
              );

              // Atividade recente (auditoria)
              final activityCard = Card(
                child: Padding(
                  padding: const EdgeInsets.all(RtSpace.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Atividade recente',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: RtSpace.sm),
                      if (audit.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: RtSpace.md),
                          child: Text('Nenhuma atividade registrada ainda.'),
                        )
                      else
                        for (final entry in audit.take(8))
                          AuditTile(entry: entry),
                    ],
                  ),
                ),
              );

              if (wide) {
                return Row(
                  spacing: RtSpace.md,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: newsCard),
                    Expanded(flex: 2, child: activityCard),
                  ],
                );
              }
              return Column(
                children: [
                  newsCard,
                  const SizedBox(height: RtSpace.md),
                  activityCard,
                ],
              );
            },
          ),
          const SizedBox(height: RtSpace.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(RtSpace.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Distribuição de conteúdo',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: RtSpace.md),
                  SizedBox(height: 180, child: _OverviewPie(counts: counts)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _countsProvider = FutureProvider<DashboardCounts>((ref) {
  return ref.watch(engagementRepositoryProvider).fetchDashboardCounts();
});

final _recentNewsProvider = FutureProvider<List<NewsItem>>((ref) {
  return ref.watch(newsRepositoryProvider).fetchNews(limit: 5);
});

final _auditProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.watch(engagementRepositoryProvider).fetchAuditLog();
});

/// Card de pendência (precisa de atenção).
class _AttentionTile extends StatelessWidget {
  const _AttentionTile({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final int count;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Material(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(RtRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(RtSpace.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    Text('Clique para analisar',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(RtRadius.full),
                ),
                child: Text('$count',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Miniatura pequena da notícia.
class _MiniThumb extends StatelessWidget {
  const _MiniThumb({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(RtRadius.sm),
      child: SizedBox(width: 44, height: 44, child: RtImage(url: url)),
    );
  }
}

/// Indicador de status (verde publicado, âmbar rascunho, cinza arquivado).
class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'published' => const Color(0xFF606C38),
      'draft' => const Color(0xFFBC6C25),
      _ => const Color(0xFFA68D7B),
    };
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _OverviewPie extends StatelessWidget {
  const _OverviewPie({required this.counts});

  final DashboardCounts counts;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final sections = <(double, Color, String)>[
      (counts.newsCount.toDouble(), p.primary, 'Notícias'),
      (counts.planCount.toDouble(), p.success, 'Propostas'),
      (counts.eventsCount.toDouble(), p.accent, 'Eventos'),
      (counts.videosCount.toDouble(), p.info, 'Vídeos'),
      (counts.galleryCount.toDouble(), Colors.orangeAccent, 'Mídias'),
    ].where((s) => s.$1 > 0).toList();

    if (sections.isEmpty) {
      return const Center(child: Text('Sem dados ainda'));
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 30,
        sections: [
          for (final s in sections)
            PieChartSectionData(
              value: s.$1,
              color: s.$2,
              radius: 22,
              title: s.$1.toInt().toString(),
              titleStyle: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
        ],
      ),
    );
  }
}