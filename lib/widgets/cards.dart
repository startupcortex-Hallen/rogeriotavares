import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formats.dart';
import 'rt_widgets.dart';

/// Card de notícia (design da Home / Notícias).
class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.item, this.onTap, this.compact = false});

  final NewsItem item;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final category = item.categoryName ?? 'NOTÍCIAS';

    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // 16:9 fixo — imagem profissional 1280×720 ou 800×450 não corta rosto.
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: RtImage(url: item.imageUrl, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(top: RtSpace.sm, left: RtSpace.sm,
                    child: RtBadge(label: category, color: p.primary.withValues(alpha: 0.92), textColor: p.onPrimary)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(RtSpace.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      maxLines: compact ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: RtSpace.xs),
                  Text(Fmt.date(item.publishedAt) + (item.author.isNotEmpty ? ' • ${item.author}' : ''),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.hint)),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

/// Item do feed de notícias com imagem lateral (design Notícias).
class NewsFeedItem extends StatelessWidget {
  const NewsFeedItem({
    super.key,
    required this.item,
    required this.onTap,
    this.isVideo = false,
  });

  final NewsItem item;
  final VoidCallback onTap;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final category = item.categoryName ?? (isVideo ? 'VÍDEO' : 'NOTÍCIA');
    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      clipBehavior: Clip.antiAlias,
      borderOnForeground: false,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: p.outline),
          ),
          padding: const EdgeInsets.all(RtSpace.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(RtRadius.md),
                    child: RtImage(url: item.imageUrl, width: 96, height: 96,
                        fit: BoxFit.cover, placeholderIcon: Icons.newspaper_rounded),
                  ),
                  if (isVideo || item.isVideo)
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: p.primary.withValues(alpha: 0.75),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.play_arrow_rounded,
                              color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(category,
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: p.primary, fontWeight: FontWeight.bold)),
                        ),
                        Text(Fmt.ago(item.publishedAt ?? DateTime.now()),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
                      ],
                    ),
                    const SizedBox(height: RtSpace.xs),
                    Text(item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: p.onSurfaceVariant, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

/// Card de proposta do Plano de Governo (design frame 2).
class ProposalCard extends StatelessWidget {
  const ProposalCard({
    super.key,
    required this.plan,
    required this.onTap,
    this.onShare,
  });

  final GovernmentPlan plan;
  final VoidCallback onTap;
  final VoidCallback? onShare;

  double _progress() => (plan.progress / 100).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final tone = p.tone(plan.tone);
    final progress = _progress();

    return Material(
      color: p.surfaceVariant,
      borderRadius: BorderRadius.circular(RtRadius.xl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.xl),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.xl),
            border: Border.all(color: p.outline),
          ),
          padding: const EdgeInsets.all(RtSpace.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: tone.withValues(alpha: 0.30),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.insights_rounded, color: tone),
                  ),
                  const SizedBox(width: RtSpace.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((plan.categoryName ?? 'PROPOSTA').toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: tone, fontWeight: FontWeight.w800, letterSpacing: 0.6)),
                        const SizedBox(height: 2),
                        Text(plan.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: p.primaryText, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  if (onShare != null)
                    InkWell(
                      onTap: onShare,
                      borderRadius: BorderRadius.circular(RtRadius.sm),
                      child: Padding(
                        padding: const EdgeInsets.all(RtSpace.xs),
                        child: Icon(Icons.share_outlined, size: 20, color: p.secondaryText),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: RtSpace.md),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(RtRadius.full),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: tone.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation(tone),
                      ),
                    ),
                  ),
                  const SizedBox(width: RtSpace.md),
                  Text('${plan.progress}%',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: tone)),
                  const SizedBox(width: RtSpace.md),
                  RtBadge(
                    label: plan.statusLabel,
                    color: tone.withValues(alpha: 0.15),
                    textColor: tone,
                  ),
                ],
              ),
              if (plan.summary.isNotEmpty) ...[
                const SizedBox(height: RtSpace.sm),
                Text(plan.summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05);
  }
}

/// Chip de data do calendário da Agenda (design frame 4).
class DateChip45788 extends StatelessWidget {
  const DateChip45788({
    super.key,
    required this.date,
    required this.selected,
    required this.onTap,
  });

  final DateTime date;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Material(
      color: selected ? p.primary : p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: selected ? p.primary : p.outline),
          ),
          child: Column(
            children: [
              Text(Fmt.weekday(date),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: selected ? p.onPrimary : p.secondaryText,
                        letterSpacing: 0.5)),
              const SizedBox(height: 2),
              Text('${date.day}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: selected ? p.onPrimary : p.primaryText,
                        fontWeight: FontWeight.w800,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}

/// Item da "Agenda de Campanha" (linha do tempo).
class AgendaItem extends StatelessWidget {
  const AgendaItem({
    super.key,
    required this.event,
    required this.onTap,
  });

  final EventItem event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final now = DateTime.now();
    final isNow = now.isAfter(event.startsAt) &&
        (event.endsAt == null || now.isBefore(event.endsAt!));
    final isPast = event.endsAt != null && now.isAfter(event.endsAt!);

    return Material(
      color: isNow ? p.primary.withValues(alpha: 0.08) : p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: isNow ? p.primary.withValues(alpha: 0.4) : p.divider),
          ),
          padding: const EdgeInsets.all(RtSpace.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: RtSpace.xs),
                decoration: BoxDecoration(
                  color: isNow ? p.primary : p.surfaceVariant,
                  borderRadius: BorderRadius.circular(RtRadius.sm),
                ),
                child: Text(Fmt.time(event.startsAt),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isNow ? p.onPrimary : p.secondaryText,
                        )),
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(event.title,
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: isPast ? p.hint : p.primaryText,
                                    decoration: isPast ? TextDecoration.lineThrough : null,
                                  )),
                        ),
                        if (isNow) ...[
                          const SizedBox(width: RtSpace.xs),
                          RtBadge(label: 'AGORA', textColor: p.onPrimary),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 14, color: p.hint),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(event.locationName.isNotEmpty ? event.locationName : (event.cityName ?? ''),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card de indicador (painel de transparência — design frame 5).
class IndicatorCard extends StatelessWidget {
  const IndicatorCard({
    super.key,
    required this.label,
    required this.value,
    this.trend,
    this.positive = true,
    this.tone = 'primary',
  });

  final String label;
  final String value;
  final String? trend;
  final bool positive;
  final String tone;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final c = p.tone(tone);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(RtSpace.md),
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: BorderRadius.circular(RtRadius.lg),
          border: Border.all(color: p.outline),
          boxShadow: [RtShadow.sm()],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: c, shape: BoxShape.circle),
                ),
                const SizedBox(width: RtSpace.sm),
                Expanded(
                  child: Text(label,
                      maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.secondaryText)),
                ),
              ],
            ),
            const SizedBox(height: RtSpace.sm),
            Text(value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: p.primaryText, fontWeight: FontWeight.w700, fontSize: 22)),
            if (trend != null && trend!.isNotEmpty) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(positive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                      size: 14, color: positive ? p.success : p.error),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(trend!,
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: positive ? p.success : p.error)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Bolha de chat (design frame 7).
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isSent,
  });

  final String message;
  final String time;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
        margin: const EdgeInsets.only(bottom: RtSpace.sm),
        padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm),
        decoration: BoxDecoration(
          color: isSent ? p.primary : p.surfaceVariant,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(RtRadius.lg),
            topRight: const Radius.circular(RtRadius.lg),
            bottomLeft: Radius.circular(isSent ? RtRadius.lg : RtRadius.xs),
            bottomRight: Radius.circular(isSent ? RtRadius.xs : RtRadius.lg),
          ),
        ),
        child: Column(
          crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSent ? p.onPrimary : p.primaryText)),
            const SizedBox(height: 2),
            Text(time,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isSent ? p.onPrimary.withValues(alpha: 0.8) : p.hint)),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}

/// Card de canal de participação (design frame 6).
class ContactMethodCard extends StatelessWidget {
  const ContactMethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.tone,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final String tone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final c = p.tone(tone);
    return Material(
      color: c.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(RtRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(RtSpace.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: p.outline),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: c.withValues(alpha: 0.20), shape: BoxShape.circle),
                child: Icon(icon, color: c),
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: p.hint),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

/// Item de "Compromissos e Transparência" (design frame 5).
class TransparencyItem extends StatelessWidget {
  const TransparencyItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(RtSpace.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: p.outline),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: p.primary.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: p.primary),
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: p.primaryText, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: p.hint),
            ],
          ),
        ),
      ),
    );
  }
}