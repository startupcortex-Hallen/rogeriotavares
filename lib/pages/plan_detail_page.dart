import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';
import 'plan_page.dart';

/// DETALHE DA PROPOSTA â€” hero, indicadores, objetivos, benefÃ­cios, impacto.
class PlanDetailPage extends ConsumerWidget {
  const PlanDetailPage({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final plansAsync = ref.watch(plansProvider);
    final plans = plansAsync.valueOrNull ?? [];

    final plan = plans
        .whereType<GovernmentPlan>()
        .where((e) => e.slug == slug)
        .firstOrNull;

    if (plan == null) {
      if (plansAsync.isLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      return Scaffold(
        body: PlanHeader(showBack: true),
        bottomNavigationBar: const SizedBox.shrink(),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: PlanHeader(showBack: true)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(RtSpace.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: RtSpace.md,
                children: [
                  // Tutulo + categoria
                  RtBadge(
                    label: (plan.categoryName ?? 'PROPOSTA').toUpperCase(),
                    color: p.primary.withValues(alpha: 0.10),
                    textColor: p.primary,
                    icon: Icons.description_rounded,
                  ),
                  Text(
                    plan.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (plan.summary.isNotEmpty)
                    Text(
                      plan.summary,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.secondaryText),
                    ),
                  // Barra de progresso + status
                  Container(
                    padding: const EdgeInsets.all(RtSpace.md),
                    decoration: BoxDecoration(
                      color: p.surface,
                      borderRadius: BorderRadius.circular(RtRadius.lg),
                      border: Border.all(color: p.outline),
                    ),
                    child: Column(
                      spacing: RtSpace.sm,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Andamento da proposta',
                                style: Theme.of(context).textTheme.labelLarge),
                            RtBadge(label: plan.statusLabel,
                                color: p.tone(plan.tone).withValues(alpha: 0.15),
                                textColor: p.tone(plan.tone)),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(RtRadius.full),
                          child: LinearProgressIndicator(
                            value: (plan.progress / 100).clamp(0.0, 1.0),
                            minHeight: 10,
                            backgroundColor: p.tone(plan.tone).withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation(p.tone(plan.tone)),
                          ),
                        ),
                        Text('${plan.progress}% concluÃ­do',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: p.secondaryText)),
                      ],
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                  // DescriÃ§Ã£o
                  if (plan.description.isNotEmpty) ...[
                    _SectionTitle('DescriÃ§Ã£o'),
                    MarkdownBody(
                      data: plan.description,
                      styleSheet: MarkdownStyleSheet(
                        p: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.primaryText),
                        h2: Theme.of(context).textTheme.headlineSmall,
                        blockquoteDecoration: BoxDecoration(
                          color: p.primary.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(RtRadius.sm),
                        ),
                      ),
                    ),
                  ],
                  // Objetivos
                  if (plan.objectives.isNotEmpty) ...[
                    _SectionTitle('Objetivos'),
                    for (final o in plan.objectives)
                      _BulletPoint(icon: Icons.check_circle_rounded, color: p.success, text: o),
                  ],
                  // BenefÃ­cios
                  if (plan.benefits.isNotEmpty) ...[
                    _SectionTitle('BenefÃ­cios'),
                    for (final b in plan.benefits)
                      _BulletPoint(icon: Icons.volunteer_activism_rounded, color: p.primary, text: b),
                  ],
                  // Impacto
                  if (plan.impact.isNotEmpty) ...[
                    _SectionTitle('Impacto'),
                    Container(
                      padding: const EdgeInsets.all(RtSpace.md),
                      decoration: BoxDecoration(
                        color: p.primary.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(RtRadius.lg),
                        border: Border.all(color: p.primary.withValues(alpha: 0.20)),
                      ),
                      child: Text(plan.impact,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: p.primary,
                                fontWeight: FontWeight.w700,
                              )),
                    ),
                  ],
                  // AÃ§Ãµes
                  Row(
                    spacing: RtSpace.sm,
                    children: [
                      Expanded(
                        child: RtButton(
                          label: 'Compartilhar',
                          icon: Icons.share_rounded,
                          variant: 'outline',
                          onPressed: () => ShareService.share(plan.title, '/plano/${plan.slug}'),
                        ),
                      ),
                      Expanded(
                        child: RtButton(
                          label: 'Baixar PDF',
                          icon: Icons.picture_as_pdf_rounded,
                          onPressed: () => _openPdfDialog(context),
                        ),
                      ),
                    ],
                  ),
                  // Relacionadas
                  _RelatedPlans(currentId: plan.id, currentSlug: plan.slug),
                  const SizedBox(height: RtSpace.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openPdfDialog(BuildContext context) {
    final p = rt(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: p.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(RtSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: RtSpace.md,
          children: [
            Icon(Icons.picture_as_pdf_rounded, size: 48, color: p.primary),
            Text('Plano de Governo',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const Text('Em breve vocÃª poderÃ¡ baixar o PDF completo do Plano de Governo 2026.'),
            Row(
              children: [
                Expanded(
                  child: RtButton(
                    label: 'Fechar',
                    variant: 'outline',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800));
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint({required this.icon, required this.color, required this.text});

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: RtSpace.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: RtSpace.sm),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _RelatedPlans extends ConsumerWidget {
  const _RelatedPlans({required this.currentId, required this.currentSlug});

  final String? currentId;
  final String currentSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(plansProvider).valueOrNull ?? [];
    final related = plans
        .whereType<GovernmentPlan>()
        .where((e) => e.id != currentId && e.slug != currentSlug)
        .take(2)
        .toList();
    if (related.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: RtSpace.md,
      children: [
        const SizedBox(height: RtSpace.sm),
        _SectionTitle('Propostas relacionadas'),
        for (final plan in related)
          ProposalCard(
            plan: plan,
            onTap: () => context.pushReplacement('/plano/${plan.slug}'),
          ),
      ],
    );
  }
}



