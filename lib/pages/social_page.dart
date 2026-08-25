import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// REDES SOCIAIS — canais oficiais + compartilhar campanha.
class SocialPage extends ConsumerWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final linksAsync = ref.watch(socialLinksProvider);
    final links = linksAsync.valueOrNull ?? [];

    const shareText =
        'Rogério Tavares 45788 — Deputado Estadual da Bahia. Juntos com o 45788!';

    return Scaffold(
      appBar: AppBar(title: const Text('Redes Sociais')),
      body: ListView(
        padding: const EdgeInsets.all(RtSpace.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(RtSpace.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [p.primary, p.primary.withValues(alpha: 0.85)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(RtRadius.xl),
            ),
            child: Column(
              spacing: RtSpace.sm,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const RtAvatar(size: 80),
                Text('@rogeriotavares45788',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                Text('Siga e compartilhe a campanha 45788',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.9))),
                Text('ELEIÇÕES ${Env.electionYear}',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white.withValues(alpha: 0.95), letterSpacing: 2)),
              ],
            ),
          ).animate().fadeIn(duration: 350.ms),
          const SizedBox(height: RtSpace.lg),
          if (linksAsync.isLoading)
            const SkeletonBox(height: 200)
          else if (links.isEmpty)
            const EmptyState(
              title: 'Canais em breve',
              subtitle: 'As redes sociais oficiais aparecem aqui assim que cadastradas.',
              icon: Icons.alternate_email_outlined,
            )
          else
            Wrap(
              spacing: RtSpace.md,
              runSpacing: RtSpace.md,
              children: [
                for (final link in links.whereType<SocialLink>())
                  Material(
                    color: p.surface,
                    borderRadius: BorderRadius.circular(RtRadius.lg),
                    child: InkWell(
                      onTap: () => ShareService.launch(link.url),
                      borderRadius: BorderRadius.circular(RtRadius.lg),
                      child: Container(
                        width: (MediaQuery.sizeOf(context).width - RtSpace.lg * 2 - RtSpace.md) / 2,
                        padding: const EdgeInsets.all(RtSpace.md),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(RtSpace.lg),
                          border: Border.all(color: p.outline),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: ShareService.socialColor(link.platform).withValues(alpha: 0.12),
                              child: Icon(
                                ShareService.socialIcon(link.platform),
                                color: ShareService.socialColor(link.platform),
                              ),
                            ),
                            const SizedBox(height: RtSpace.sm),
                            Text(capitalize(link.platform),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                            Text(link.username.isEmpty ? 'Seguir' : '${link.username}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 100.ms),
              ],
            ),
          const SizedBox(height: RtSpace.lg),
          Text('Compartilhar Campanha',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: RtSpace.sm),
          Row(
            spacing: RtSpace.md,
            children: [
              _ShareButton(
                label: 'WhatsApp',
                icon: Icons.chat_rounded,
                color: ShareService.socialColor('whatsapp'),
                onTap: () => ShareService.launch(ShareService.whatsappUri(shareText).toString()),
              ),
              _ShareButton(
                label: 'Telegram',
                icon: Icons.send_rounded,
                color: ShareService.socialColor('telegram'),
                onTap: () => ShareService.launch(ShareService.telegramUri(shareText).toString()),
              ),
              _ShareButton(
                label: 'X',
                icon: Icons.alternate_email_rounded,
                color: Colors.black,
                onTap: () => ShareService.launch(ShareService.xUri(shareText).toString()),
              ),
            ],
          ),
          Row(
            spacing: RtSpace.md,
            children: [
              _ShareButton(
                label: 'Facebook',
                icon: Icons.facebook_rounded,
                color: ShareService.socialColor('facebook'),
                onTap: () => ShareService.launch(ShareService.facebookUri(shareText).toString()),
              ),
              _ShareButton(
                label: 'Instagram',
                icon: Icons.camera_alt_rounded,
                color: ShareService.socialColor('instagram'),
                onTap: () => ShareService.launch(ShareService.instagramUri(shareText).toString()),
              ),
              _ShareButton(
                label: 'Copiar link',
                icon: Icons.link_rounded,
                color: p.primary,
                onTap: () {
                  ShareService.launch(ShareService.currentUri('/').toString());
                },
              ),
            ],
          ),
          const SizedBox(height: RtSpace.lg),
        ],
      ),
    );
  }

  String capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final width = (MediaQuery.sizeOf(context).width - RtSpace.lg * 2 - RtSpace.md * 3) / 3;
    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: RtSpace.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: p.outline),
          ),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: RtSpace.xs),
              Text(label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.secondaryText)),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 150.ms);
  }
}