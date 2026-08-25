import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/env.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// CONTATO — escritórios, telefones, emails, horários e mapa.
class ContactInfoPage extends ConsumerWidget {
  const ContactInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final contact = settings['contact'] ?? const {};

    final whatsapp = (contact['whatsapp'] as String?) ?? '';
    final email = (contact['email'] as String?) ?? '';
    final phone = (contact['phone'] as String?) ?? '';
    final address = (contact['address'] as String?) ?? '';
    final hours = (contact['hours'] as String?) ?? 'Seg–Sex, 08h às 18h';

    return Scaffold(
      appBar: AppBar(title: const Text('Contato')),
      body: ListView(
        padding: const EdgeInsets.all(RtSpace.lg),
        children: [
          Text('Escritório 45788',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: RtSpace.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(RtSpace.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: RtSpace.sm,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.place_rounded, color: Color(0xFF1565C0)),
                      const SizedBox(width: RtSpace.sm),
                      Expanded(
                        child: Text(address.isEmpty ? 'Salvador — Bahia' : address,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded, color: Color(0xFF1565C0)),
                      const SizedBox(width: RtSpace.sm),
                      Expanded(
                        child: Text(hours,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  ),
                  if (phone.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.phone_rounded, color: Color(0xFF1565C0)),
                        const SizedBox(width: RtSpace.sm),
                        Expanded(
                          child: InkWell(
                            onTap: () => ShareService.launch('tel:$phone'),
                            child: Text(phone,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: p.primary)),
                          ),
                        ),
                      ],
                    ),
                  if (email.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.email_rounded, color: Color(0xFF1565C0)),
                        const SizedBox(width: RtSpace.sm),
                        Expanded(
                          child: InkWell(
                            onTap: () => ShareService.launch('mailto:$email'),
                            child: Text(email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: p.primary)),
                          ),
                        ),
                      ],
                    ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.apartment_rounded, color: Color(0xFF1565C0)),
                      const SizedBox(width: RtSpace.sm),
                      Expanded(
                        child: Text('Comitê Central de Campanha',
                            style: Theme.of(context).textTheme.labelLarge),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: RtSpace.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(RtSpace.lg),
            child: SizedBox(
              height: 200,
              child: Image.network(
                'https://dimg.dreamflow.cloud/v1/image/Salvador+Bahia+city+map+style',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: p.surfaceVariant,
                  child: Center(
                    child: IconButton(
                      onPressed: () => ShareService.launch(
                          'https://www.google.com/maps?q=Salvador,+Bahia'),
                      icon: Icon(Icons.map_outlined, size: 48, color: p.primary),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: RtSpace.sm),
          RtButton(
            label: 'Abrir no Google Maps',
            variant: 'outline',
            fullWidth: true,
            icon: Icons.map_outlined,
            onPressed: () => ShareService.launch('https://www.google.com/maps?q=Salvador,+Bahia'),
          ),
          const SizedBox(height: RtSpace.lg),
          Text('Canais rápidos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: RtSpace.sm),
          Row(
            spacing: RtSpace.md,
            children: [
              Expanded(
                child: _QuickAction(
                  icon: Icons.chat_rounded,
                  label: 'WhatsApp',
                  color: ShareService.socialColor('whatsapp'),
                  onTap: () => ShareService.launch(ShareService.openWhatsApp(whatsapp)),
                ),
              ),
              Expanded(
                child: _QuickAction(
                  icon: Icons.campaign_outlined,
                  label: 'Fale com Rogério',
                  color: p.primary,
                  onTap: () => context.go('/fale'),
                ),
              ),
              Expanded(
                child: _QuickAction(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Gabinete Digital',
                  color: p.secondary,
                  onTap: () => context.go('/chat'),
                ),
              ),
            ],
          ),
          const SizedBox(height: RtSpace.lg),
          Center(
            child: Text('Rogério Tavares ${Env.campaignNumber} • ${Env.candidateRole}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
          ),
          const SizedBox(height: RtSpace.lg),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
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
    ).animate().fadeIn(delay: 100.ms);
  }
}