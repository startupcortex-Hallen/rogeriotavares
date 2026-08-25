import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';

/// TRANSPARÊNCIA E DADOS — réplica fiel do frame 5 (indicadores + donut).
class TransparencyPage extends ConsumerWidget {
  const TransparencyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final numbersAsync = ref.watch(campaignNumbersProvider);
    final numbers = numbersAsync.valueOrNull ?? [];
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final transparency = settings['transparency'] ?? const {};
    final cta = settings['cta'] ?? const {};

    final description = (transparency['title'] as String?) ??
        'Transparência total na campanha: acompanhe aqui a aplicação dos recursos e o andamento das propostas para o nosso estado.';

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(campaignNumbersProvider.future),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: p.secondaryBackground,
                padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.xl, RtSpace.lg, RtSpace.md),
                child: Column(
                  spacing: RtSpace.sm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: RtSpace.xs,
                          children: [
                            Text('Deputado Estadual',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: p.primary, fontWeight: FontWeight.bold)),
                            Text('Rogério Tavares',
                                style: Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                        const RtAvatar(name: 'Rogério Tavares', size: 48),
                      ],
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(RtSpace.lg),
              sliver: SliverList.list(
                children: [
                  Text('Painel da Campanha ${(settings['campaign']?['election_year'] ?? 2026)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: RtSpace.md),
                  if (numbersAsync.isLoading)
                    const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (numbers.isEmpty)
                    const EmptyState(title: 'Indicadores em breve', icon: Icons.insights_outlined)
                  else
                    ...[
                      Row(
                        spacing: RtSpace.md,
                        children: [
                          if (numbers.length > 0)
                            IndicatorCard(
                              label: (numbers[0] as CampaignNumber).label,
                              value: (numbers[0] as CampaignNumber).value,
                              trend: (numbers[0] as CampaignNumber).trend,
                              positive: (numbers[0] as CampaignNumber).isPositive,
                              tone: (numbers[0] as CampaignNumber).tone,
                            ),
                          if (numbers.length > 1)
                            IndicatorCard(
                              label: (numbers[1] as CampaignNumber).label,
                              value: (numbers[1] as CampaignNumber).value,
                              trend: (numbers[1] as CampaignNumber).trend,
                              positive: (numbers[1] as CampaignNumber).isPositive,
                              tone: (numbers[1] as CampaignNumber).tone,
                            ),
                        ],
                      ),
                      const SizedBox(height: RtSpace.md),
                      Row(
                        spacing: RtSpace.md,
                        children: [
                          if (numbers.length > 2)
                            IndicatorCard(
                              label: (numbers[2] as CampaignNumber).label,
                              value: (numbers[2] as CampaignNumber).value,
                              trend: (numbers[2] as CampaignNumber).trend,
                              positive: (numbers[2] as CampaignNumber).isPositive,
                              tone: (numbers[2] as CampaignNumber).tone,
                            ),
                          if (numbers.length > 3)
                            IndicatorCard(
                              label: (numbers[3] as CampaignNumber).label,
                              value: (numbers[3] as CampaignNumber).value,
                              trend: (numbers[3] as CampaignNumber).trend,
                              positive: (numbers[3] as CampaignNumber).isPositive,
                              tone: (numbers[3] as CampaignNumber).tone,
                            ),
                        ],
                      ),
                    ],
                  const SizedBox(height: RtSpace.lg),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: RtSpace.sm),
                    padding: const EdgeInsets.all(RtSpace.lg),
                    decoration: BoxDecoration(
                      color: p.surface,
                      borderRadius: BorderRadius.circular(RtRadius.xl),
                      border: Border.all(color: p.outline),
                      boxShadow: [RtShadow.sm()],
                    ),
                    child: Column(
                      spacing: RtSpace.lg,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Alocação de Recursos',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: p.primaryText)),
                            Icon(Icons.donut_large_rounded, color: p.secondaryText),
                          ],
                        ),
                        _ResourceDonut(transparency: transparency),
                        Divider(color: p.divider, thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RtButton(
                              label: (transparency['tse_button'] as String?) ?? 'Ver Prestação de Contas (TSE)',
                              variant: 'ghost',
                              icon: Icons.open_in_new_rounded,
                              onPressed: () => ShareService.launch(
                                  'https://www.tse.jus.br/'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 100.ms),
                  const SizedBox(height: RtSpace.lg),
                  Text('Compromissos e Transparência',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: RtSpace.md),
                  TransparencyItem(
                    icon: Icons.description_rounded,
                    title: 'Plano de Governo',
                    subtitle: 'Propostas detalhadas para o estado',
                    onTap: () => context.go('/plano'),
                  ),
                  const SizedBox(height: RtSpace.sm),
                  TransparencyItem(
                    icon: Icons.event_available_rounded,
                    title: 'Agenda do Candidato',
                    subtitle: 'Encontros, debates e caminhadas',
                    onTap: () => context.go('/agenda'),
                  ),
                  const SizedBox(height: RtSpace.sm),
                  TransparencyItem(
                    icon: Icons.account_balance_wallet_rounded,
                    title: 'Origem das Doações',
                    subtitle: 'Lista de doadores e valores recebidos',
                    onTap: () => ShareService.launch('https://www.tse.jus.br/'),
                  ),
                  const SizedBox(height: RtSpace.sm),
                  TransparencyItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'Fale com Rogério 45788',
                    subtitle: 'Canal direto para sugestões e dúvidas',
                    onTap: () => context.go('/fale'),
                  ),
                  const SizedBox(height: RtSpace.lg),
                  Container(
                    margin: const EdgeInsets.only(top: RtSpace.md),
                    padding: const EdgeInsets.all(RtSpace.lg),
                    decoration: BoxDecoration(
                      color: p.secondaryBackground,
                      borderRadius: BorderRadius.circular(RtRadius.xl),
                      border: Border.all(color: p.outline),
                    ),
                    child: Column(
                      spacing: RtSpace.md,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.volunteer_activism_rounded, size: 36, color: Color(0xFF1565C0)),
                        Text('Faça parte da mudança',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: p.primaryText)),
                        Text(
                          (cta['voluntario_text'] as String?) ??
                              'Junte-se ao time do Rogério Tavares. Cadastre-se para ser um voluntário ou receber atualizações da campanha.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText),
                        ),
                        const SizedBox(height: RtSpace.xs),
                        RtButton(
                          label: (cta['voluntario_button'] as String?) ?? 'Quero ser Voluntário 45788',
                          size: 'large',
                          fullWidth: true,
                          icon: Icons.volunteer_activism_rounded,
                          onPressed: () => context.go('/participe'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: RtSpace.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Donut "50,20,15,15" do design (dados via settings).
class _ResourceDonut extends StatelessWidget {
  const _ResourceDonut({required this.transparency});

  final Map<String, dynamic> transparency;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    final rawValues = (transparency['pie'] as String?) ?? '50,20,15,15';
    final rawLabels = (transparency['pie_labels'] as String?) ?? 'Mídia/Social,Eventos,Logística,Equipe';
    final rawColors = (transparency['pie_colors'] as String?) ?? 'primary,success,accent,info';

    final values = rawValues
        .split(',')
        .map((e) => double.tryParse(e.trim()) ?? 0)
        .toList();
    final labels = rawLabels.split(',').map((e) => e.trim()).toList();
    final tones = rawColors.split(',').map((e) => e.trim()).toList();
    final colors = tones.map(p.tone).toList();

    final total = values.fold<double>(0, (a, b) => a + b);
    final sections = [
      for (var i = 0; i < values.length; i++)
        PieChartSectionData(
          value: total <= 0 ? 1 : values[i],
          color: colors[i % colors.length],
          radius: 26,
          showTitle: false,
        ),
    ];

    return Row(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: total <= 0
              ? const Center(child: CircularProgressIndicator(strokeWidth: 3))
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sections: sections,
                        sectionsSpace: 2,
                        centerSpaceRadius: 46,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(total <= 0 ? '0%' : '${total.round()}%',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w900)),
                        Text('recursos',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
                      ],
                    ),
                  ],
                ),
        ),
        const SizedBox(width: RtSpace.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < labels.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: colors[i % colors.length],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: RtSpace.sm),
                      Expanded(
                        child: Text(labels[i],
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: p.secondaryText)),
                      ),
                      Text('${values[i].toStringAsFixed(0)}%',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: p.primaryText)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}