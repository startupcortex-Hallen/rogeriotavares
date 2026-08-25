import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/go_back.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';

/// PLANO DE GOVERNO â€” rÃ©plica fiel do frame 2 (filtros + busca + status).
class PlanPage extends ConsumerStatefulWidget {
  const PlanPage({super.key});

  @override
  ConsumerState<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends ConsumerState<PlanPage> {
  String? _selectedCategory;
  final _searchController = TextEditingController();
  String _search = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final categories = ref.watch(planCategoriesProvider).valueOrNull ?? [];
    final plansAsync = ref.watch(plansProvider);
    final plans = plansAsync.valueOrNull ?? [];

    final filtered = plans.where((plan) {
      final pl = plan as GovernmentPlan;
      if (_selectedCategory != null && pl.categoryId != _selectedCategory) {
        return false;
      }
      if (_search.isNotEmpty && !pl.title.toLowerCase().contains(_search.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: p.background,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(plansProvider);
          ref.invalidate(planCategoriesProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: PlanHeader()),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg, vertical: RtSpace.md),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: p.divider)),
                ),
                child: Column(
                  spacing: RtSpace.md,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: RtSpace.sm,
                        children: [
                          _FilterChip(
                            label: 'Todas',
                            selected: _selectedCategory == null,
                            onTap: () => setState(() => _selectedCategory = null),
                          ),
for (final cat in categories)
                            _FilterChip(
                              label: (cat as PlanCategory).name ?? '',
                              selected: _selectedCategory == cat.id,
                              onTap: () => setState(() => _selectedCategory = cat.id),
                            ),
                        ],
                      ),
                    ),
                    TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _search = v.trim()),
                      decoration: InputDecoration(
                        hintText: 'Buscar compromisso de campanha...',
                        prefixIcon: const Icon(Icons.filter_list_rounded),
                        suffixIcon: _search.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close_rounded),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _search = '');
                                },
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(RtSpace.lg),
              sliver: SliverList.list(
                children: [
                  const _PlanStatusCard(),
                  const SizedBox(height: RtSpace.lg),
if (plansAsync.isLoading)
                    for (var i = 0; i < 3; i++) ...[
                      const SkeletonBox(height: 140),
                      const SizedBox(height: RtSpace.lg),
                    ]
                  else if (plansAsync.hasError && filtered.isEmpty)
                    ErrorRetry(
                      onRetry: () => ref.invalidate(plansProvider),
                      message: 'Falha ao carregar o Plano de Governo. Verifique sua conexão.',
                    )
                  else if (filtered.isEmpty)
                    const EmptyState(
                      title: 'Nenhuma proposta encontrada',
                      subtitle: 'Tente outra categoria ou termo de busca.',
                      icon: Icons.search_off_rounded,
                    )
                  else
                    ...filtered.map(
                      (plan) => Padding(
                        padding: const EdgeInsets.only(bottom: RtSpace.lg),
                        child: ProposalCard(
                          plan: plan as GovernmentPlan,
                          onTap: () => context.go('/plano/${plan.slug}'),
                          onShare: () =>
                              ShareService.share(plan.title, '/plano/${plan.slug}'),
                        ),
                      ),
                    ),
                  const _PlanCta(),
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

/// Cabeçalho do Plano (design "só imagens"): foto oficial em destaque
/// com botões de voltar e busca discretos sobrepostos — sem fundo azul.
class PlanHeader extends ConsumerWidget {
  const PlanHeader({super.key, this.onSearch, this.showBack = false});

  final VoidCallback? onSearch;
  final bool showBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portrait = ref.watch(portraitUrlImmediateProvider);
    return SizedBox(
      height: 240,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RtImage(url: portrait),
          // Vinheta sutil para contraste dos controles
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black26,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: RtSpace.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showBack)
                    Material(
                      color: Colors.black38,
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: () => goBack(context),
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                        tooltip: 'Voltar',
                      ),
                    )
                  else
                    const SizedBox(width: 52),
                  if (onSearch != null)
                    Material(
                      color: Colors.black38,
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: onSearch,
                        icon: const Icon(Icons.search_rounded, color: Colors.white),
                        tooltip: 'Buscar',
                      ),
                    )
                  else
                    const SizedBox(width: 52),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Material(
      color: selected ? p.primary : p.surface,
      borderRadius: BorderRadius.circular(RtRadius.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.sm),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.sm),
            border: Border.all(color: selected ? p.primary : p.outline),
          ),
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: selected ? p.onPrimary : p.secondaryText),
          ),
        ),
      ),
    );
  }
}

/// Card "Status do Plano" (design frame 2).
class _PlanStatusCard extends StatelessWidget {
  const _PlanStatusCard();

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Container(
      padding: const EdgeInsets.all(RtSpace.lg),
      decoration: BoxDecoration(
        color: p.surfaceVariant,
        borderRadius: BorderRadius.circular(RtRadius.xl),
        border: Border.all(color: p.outline),
      ),
      child: Row(
        spacing: RtSpace.md,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: p.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.insights_rounded, color: p.primary, size: 28),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status do Plano', style: Theme.of(context).textTheme.titleMedium),
                Text(
                  'Compromissos reais para o nosso estado',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// CTA "Fale com RogÃ©rio" (design frame 2).
class _PlanCta extends StatelessWidget {
  const _PlanCta();

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Container(
      padding: const EdgeInsets.all(RtSpace.lg),
      decoration: BoxDecoration(
        color: p.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(RtRadius.lg),
        border: Border.all(color: p.primary.withValues(alpha: 0.20)),
      ),
      child: Column(
        spacing: RtSpace.sm,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.rate_review_rounded, color: p.primary, size: 32),
          Text('Fale com RogÃ©rio',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: p.primary)),
          Text(
            'Envie sua sugestÃ£o para melhorarmos nossa regiÃ£o juntos.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.primary),
          ),
          const SizedBox(height: RtSpace.sm),
          RtButton(
            label: 'Enviar SugestÃ£o',
            fullWidth: true,
            icon: Icons.send_rounded,
            onPressed: () => context.go('/fale'),
          ),
        ],
      ),
    );
  }
}
