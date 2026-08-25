import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/go_back.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';

/// BIOGRAFIA — foto, timeline animada, trajetória, família, valores e projetos.
class BiographyPage extends ConsumerWidget {
  const BiographyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final portrait = ref.watch(portraitUrlImmediateProvider);
    final itemsAsync = ref.watch(biographyItemsProvider);
    final items = itemsAsync.valueOrNull ?? [];
    final teamAsync = ref.watch(teamProvider);
    final plans = ref.watch(plansProvider).valueOrNull ?? [];

    // Separa por tipo (história/trajetória → timeline; demais → cards)
    final milestones = items
        .where((i) =>
            i.itemType == 'historia' || i.itemType == 'trajetoria')
        .toList();
    final familyItems = items.where((i) => i.itemType == 'familia').toList();
    final valueItems = items.where((i) => i.itemType == 'valores').toList();
    final expItems = items.where((i) => i.itemType == 'experiencia').toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                SizedBox(
                  height: 360,
                  width: double.infinity,
                  child: RtImage(url: portrait),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          p.primary.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                  ),
                ),
                // Botão voltar fixo no topo (GoRouter, confiável)
                Positioned(
                  top: MediaQuery.paddingOf(context).top + RtSpace.sm,
                  left: RtSpace.sm,
                  child: Material(
                    color: Colors.black38,
                    shape: const CircleBorder(),
                    child: IconButton(
                      onPressed: () => goBack(context),
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      tooltip: 'Voltar',
                    ),
                  ),
                ),
                Positioned(
                  left: RtSpace.lg,
                  right: RtSpace.lg,
                  bottom: RtSpace.lg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RtBadge(label: 'QUEM É ROGÉRIO'),
                      const SizedBox(height: RtSpace.xs),
                      Text(Env.candidateName,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w800)),
                      Text('${Env.candidateRole} • ${Env.candidateState}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.95))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(RtSpace.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: RtSpace.lg,
                children: [
                  // Resumo
                  Text(
                    'Rogério Tavares é candidato a Deputado Estadual da Bahia nas eleições de ${Env.electionYear}, '
                        'com o número ${Env.campaignNumber}. Sua caminhada é marcada pelo trabalho sério, '
                        'a escuta das comunidades e o compromisso com a transformação do estado.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.secondaryText),
                  ).animate().fadeIn(duration: 400.ms),
                  // Timeline (história e trajetória — dinâmica, editável no painel)
                  _TimelineSection(
                    title: 'História e Trajetória',
                    items: milestones,
                    fallbackTitle: 'Nossa caminhada começa agora',
                    fallbackText:
                        'A equipe da campanha está montando esta linha do tempo. Em breve, a história completa de '
                            'Rogério Tavares estará disponível aqui — cada conquista, cada cidade visitada e cada projeto.',
                  ),
                  // Família
                  if (familyItems.isNotEmpty)
                    for (final item in familyItems)
                      _SectionCard(
                        icon: Icons.family_restroom_rounded,
                        title: 'Família',
                        subtitle: item.text,
                      ),
                  // Valores
                  if (valueItems.isNotEmpty)
                    for (final item in valueItems)
                      _SectionCard(
                        icon: Icons.verified_rounded,
                        title: 'Valores',
                        subtitle: item.text,
                      ),
                  // Experiência
                  if (expItems.isNotEmpty)
                    for (final item in expItems)
                      _SectionCard(
                        icon: Icons.work_history_rounded,
                        title: 'Experiência',
                        subtitle: item.text,
                      ),
                  // Projetos / propostas
                  if (plans.isNotEmpty) ...[
                    Text('Projetos e Propostas',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    for (final plan in plans.take(3))
                      ProposalCard(
                        plan: plan as GovernmentPlan,
                        onTap: () => context.go('/plano/${plan.slug}'),
                      ),
                  ],
                  // Equipe
                  if (teamAsync.valueOrNull.isNotNullOrEmpty) ...[
                    Text('Equipe',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    for (final member in teamAsync.valueOrNull!)
                      ListTile(
                        leading: RtAvatar(
                          name: (member as TeamMember).fullName,
                          imageUrl: member.photoUrl.isEmpty ? null : member.photoUrl,
                          size: 44,
                        ),
                        title: Text(member.fullName,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        subtitle: Text(member.role, style: Theme.of(context).textTheme.bodySmall),
                      ),
                  ],
                  const SizedBox(height: RtSpace.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension _NotNullOrEmptyList on List<dynamic>? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

/// Linha do tempo animada (dinâmica — itens da biografia editáveis).
class _TimelineSection extends StatelessWidget {
  const _TimelineSection({
    required this.title,
    required this.items,
    required this.fallbackTitle,
    required this.fallbackText,
  });

  final String title;
  final List<BiographyItem> items;
  final String fallbackTitle;
  final String fallbackText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: RtSpace.md,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        if (items.isEmpty)
          _Milestone(
            year: 'Em breve',
            title: fallbackTitle,
            text: fallbackText,
            last: true,
          )
        else
          for (var i = 0; i < items.length; i++)
            _Milestone(
              year: items[i].year,
              title: items[i].title,
              text: items[i].text,
              last: i == items.length - 1,
            ),
      ],
    );
  }
}

class _Milestone extends StatelessWidget {
  const _Milestone({
    required this.year,
    required this.title,
    required this.text,
    required this.last,
  });

  final String year;
  final String title;
  final String text;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: p.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: p.surface, width: 3),
                  boxShadow: [BoxShadow(color: p.primary.withValues(alpha: 0.4), blurRadius: 6)],
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(width: 2, color: p.outline),
                ),
            ],
          ),
          const SizedBox(width: RtSpace.md),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: RtSpace.lg),
              padding: const EdgeInsets.all(RtSpace.md),
              decoration: BoxDecoration(
                color: p.surface,
                borderRadius: BorderRadius.circular(RtRadius.lg),
                border: Border.all(color: p.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (year.isNotEmpty)
                    Text(year,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: p.primary, fontWeight: FontWeight.w900)),
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  if (text.isNotEmpty)
                    Text(text,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms).slideX(begin: 0.03);
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: p.primary.withValues(alpha: 0.10), shape: BoxShape.circle),
            child: Icon(icon, color: p.primary),
          ),
          const SizedBox(width: RtSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}