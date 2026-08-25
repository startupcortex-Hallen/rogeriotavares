import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formats.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';

/// AGENDA OFICIAL — réplica fiel do frame 4 (calendário + eventos + FAB).
class AgendaPage extends ConsumerStatefulWidget {
  const AgendaPage({super.key});

  @override
  ConsumerState<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends ConsumerState<AgendaPage> {
  DateTime _visibleMonth = DateTime.now();
  DateTime? _selectedDate;

  /// Retorna para o mês atual (usado pelo cabeçalho).
  void goToCurrentMonth() {
    setState(() {
      _visibleMonth = DateTime.now();
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final agenda = settings['agenda'] ?? const {};
    final disclaimer = (agenda['disclaimer'] as String?) ??
        'Horários sujeitos a alteração conforme logística de deslocamento da equipe 45788.';

    final monthKey = '${_visibleMonth.year}-${_visibleMonth.month}';
    final eventsAsync = ref.watch(_eventsForMonthProvider(monthKey));
    final events = eventsAsync.valueOrNull ?? [];

    // Chips: dias distintos com eventos
    final eventDates = events
        .map<DateTime>((e) {
          final d = e.startsAt;
          return DateTime(d.year, d.month, d.day);
        })
        .toSet()
        .toList()
      ..sort();

    final selected = _selectedDate ??
        (eventDates.isNotEmpty
            ? eventDates.firstWhere(
                (d) => !d.isBefore(DateTime(_visibleMonth.year, _visibleMonth.month, 1)),
                orElse: () => eventDates.first)
            : DateTime.now());

    final dayEvents = events.where((e) {
      final d = e.startsAt;
      return d.year == selected.year &&
          d.month == selected.month &&
          d.day == selected.day;
    }).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/participe'),
        backgroundColor: p.primary,
        foregroundColor: p.onPrimary,
        icon: const Icon(Icons.volunteer_activism_rounded),
        label: const Text('Apoiar Campanha'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(_eventsForMonthProvider(monthKey).future),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _AgendaHeader()),
            SliverToBoxAdapter(
              child: Container(
                color: p.secondaryBackground,
                padding: const EdgeInsets.fromLTRB(RtSpace.lg, 0, RtSpace.lg, RtSpace.sm),
                child: Column(
                  spacing: RtSpace.sm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Fmt.monthYear(_visibleMonth),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          spacing: RtSpace.sm,
                          children: [
                            IconButton(
                              tooltip: 'Mês anterior',
                              onPressed: () => setState(() {
                                _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1, 1);
                                _selectedDate = null;
                              }),
                              icon: const Icon(Icons.chevron_left_rounded, size: 20),
                            ),
                            IconButton(
                              tooltip: 'Próximo mês',
                              onPressed: () => setState(() {
                                _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 1);
                                _selectedDate = null;
                              }),
                              icon: const Icon(Icons.chevron_right_rounded, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(bottom: RtSpace.sm),
                      child: Row(
                        spacing: RtSpace.md,
                        children: [
                          if (eventDates.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(RtSpace.sm),
                              child: Text('Nenhum evento neste mês',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: p.secondaryText)),
                            )
                          else
                            for (final d in eventDates)
                              DateChip45788(
                                date: d,
                                selected: d.isAtSameMomentAs(selected),
                                onTap: () => setState(() => _selectedDate = d),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(RtSpace.lg),
                child: _CaravanaCard(events: events),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(RtSpace.lg, 0, RtSpace.lg, RtSpace.lg),
              sliver: SliverList.list(
                children: [
                  Text('Agenda de Campanha — ${Fmt.date(selected)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: RtSpace.md),
                  if (eventsAsync.isLoading)
                    const Column(
                      spacing: RtSpace.md,
                      children: [SkeletonBox(height: 90), SkeletonBox(height: 90)],
                    )
                  else if (dayEvents.isEmpty)
                    const EmptyState(
                      title: 'Nenhum compromisso',
                      subtitle: 'Selecione outro dia para ver a agenda.',
                      icon: Icons.event_busy_rounded,
                    )
                  else
                    for (final e in dayEvents)
                      Padding(
                        padding: const EdgeInsets.only(bottom: RtSpace.md),
                        child: AgendaItem(
                          event: e,
                          onTap: () => _showEventSheet(context, ref, e),
                        ),
                      ),
                  Container(
                    margin: const EdgeInsets.only(top: RtSpace.sm),
                    padding: const EdgeInsets.all(RtSpace.lg),
                    decoration: BoxDecoration(
                      color: p.secondaryBackground.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(RtRadius.lg),
                    ),
                    child: Column(
                      spacing: RtSpace.sm,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline_rounded, size: 20, color: p.secondaryText),
                        Text(
                          disclaimer,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: p.secondaryText),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom sheet com detalhes do evento (RSVP, calendário, compartilhar).
  void _showEventSheet(BuildContext context, WidgetRef ref, EventItem event) {
    final p = rt(context);
    final lat = event.latitude ?? event.cityLatitude;
    final lng = event.longitude ?? event.cityLongitude;
    showModalBottomSheet(
      context: context,
      backgroundColor: p.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
      ),
      builder: (context) => SafeArea(
        top: false,
        child: Padding(
        padding: EdgeInsets.only(
          left: RtSpace.lg,
          right: RtSpace.lg,
          top: RtSpace.lg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + RtSpace.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: RtSpace.md,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: p.outline,
                  borderRadius: BorderRadius.circular(RtRadius.full),
                ),
              ),
            ),
            if (event.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(RtRadius.lg),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: RtImage(
                    url: event.imageUrl,
                    placeholderIcon: Icons.event_rounded,
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: Text(event.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),
                const NumberBadge(),
              ],
            ),
            _InfoRow(
              icon: Icons.calendar_month_rounded,
              text: '${Fmt.date(event.startsAt)} • ${Fmt.timeRange(event.startsAt, event.endsAt)}',
            ),
            _InfoRow(
              icon: Icons.location_on_rounded,
              text: [event.cityName, event.locationName]
                  .where((e) => e != null && e.isNotEmpty)
                  .join(' — '),
            ),
            _InfoRow(icon: Icons.label_outline_rounded, text: event.typeLabel),
            if (lat != null && lng != null)
              FilledButton.tonalIcon(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/mapa?lat=$lat&lng=$lng');
                },
                icon: const Icon(Icons.map_outlined),
                label: const Text('Ver no Mapa da Bahia'),
              ),
            if (event.description.isNotEmpty)
              Text(event.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
            const SizedBox(height: RtSpace.sm),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  await ref.read(agendaRepositoryProvider).confirmRsvp(event.id!);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Presença confirmada!')),
                    );
                  }
                },
                icon: const Icon(Icons.how_to_reg_rounded),
                label: const Text('Confirmar presença'),
              ),
            ),
            Row(
              spacing: RtSpace.sm,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => ShareService.launch(_googleCalendarUrl(event)),
                    icon: const Icon(Icons.event_available_rounded),
                    label: const Text('Adicionar ao calendário'),
                  ),
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => ShareService.share(event.title, '/agenda'),
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Compartilhar'),
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }

  String _googleCalendarUrl(EventItem event) {
    final start = event.startsAt
        .toUtc()
        .toIso8601String()
        .replaceAll(RegExp(r'[-:]'), '')
        .split('.')
        .first;
    final end = (event.endsAt ?? event.startsAt.add(const Duration(hours: 1)))
        .toUtc()
        .toIso8601String()
        .replaceAll(RegExp(r'[-:]'), '')
        .split('.')
        .first;
    final base = 'https://calendar.google.com/calendar/render?action=TEMPLATE';
    return '$base&text=${Uri.encodeComponent(event.title)}'
        '&dates=$start/$end'
        '&details=${Uri.encodeComponent(event.description)}'
        '&location=${Uri.encodeComponent(event.locationName)}';
  }
}

final _eventsForMonthProvider =
    FutureProvider.family<List<EventItem>, String>((ref, monthKey) async {
  final parts = monthKey.split('-');
  final year = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final first = DateTime(year, month, 1);
  final last = DateTime(year, month + 1, 0);
  return ref.read(agendaRepositoryProvider).fetchEvents(
        fromDate: first,
        toDate: last,
      );
});

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: p.primary),
        const SizedBox(width: RtSpace.sm),
        Expanded(
          child: Text(text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
        ),
      ],
    );
  }
}

/// Cabeçalho "Rogério Tavares 45788" + botão calendário (design frame 4).
class _AgendaHeader extends ConsumerWidget {
  const _AgendaHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final state = context.findAncestorStateOfType<_AgendaPageState>();
    final canGoBack = state != null;
    return Container(
      color: p.secondaryBackground,
      padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.xl, RtSpace.lg, RtSpace.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: RtSpace.xs,
            children: [
              Text('Deputado Estadual',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: p.secondaryText)),
              Text('Rogério Tavares 45788',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: p.primaryText)),
            ],
          ),
          IconButton(
            onPressed: canGoBack
                ? () {
                    state.goToCurrentMonth();
                  }
                : null,
            style: IconButton.styleFrom(
              backgroundColor: p.surface,
              elevation: 2,
            ),
            icon: const Icon(Icons.calendar_month_rounded),
          ),
        ],
      ),
    );
  }
}

/// Card destacado "Caravana 45788" (design frame 4) — próximo evento em destaque.
class _CaravanaCard extends ConsumerWidget {
  const _CaravanaCard({required this.events});

  final List<EventItem> events;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final event = events
        .where((e) => e.isFeatured || e.eventType == 'caravana')
        .firstOrNull ??
        events.firstOrNull;

    if (event == null) return const SkeletonBox(height: 96);

    return Container(
      padding: const EdgeInsets.all(RtSpace.md),
      decoration: BoxDecoration(
        color: p.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(RtRadius.lg),
        border: Border.all(color: p.primary.withValues(alpha: 0.20)),
      ),
      child: Row(
        spacing: RtSpace.md,
        children: [
          Icon(Icons.campaign_rounded, color: p.tone('primary')),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${event.title} • ${event.cityName ?? ''}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: p.primary,
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 2),
                Text(
                  event.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}