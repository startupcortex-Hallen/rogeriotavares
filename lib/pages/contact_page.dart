import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/go_back.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';

/// FALE COM ROGÉRIO — réplica fiel do frame 6 (canais + formulário).
class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final List<String> _selectedAreas = ['Saúde'];
  final List<XFile> _photos = [];
  bool _sending = false;

  static const _areas = ['Saúde', 'Educação', 'Emprego', 'Segurança', 'Habitação'];

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final files = await ImagePicker().pickMultiImage(limit: 3);
    if (files.isNotEmpty) setState(() => _photos.addAll(files));
  }

  Future<void> _send() async {
    final title = _titleController.text.trim();
    final message = _messageController.text.trim();
    if (title.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o título e a mensagem para enviar.')),
      );
      return;
    }
    setState(() => _sending = true);

    final deviceId = await ref.read(deviceIdProvider.future);
    final attachments = <String>[];
    for (final photo in _photos) {
      try {
        final path = 'reports/$deviceId/${DateTime.now().millisecondsSinceEpoch}-${photo.name}';
        final bytes = await photo.readAsBytes();
        await ref.read(supabaseProvider).storage.from('reports').uploadBinary(
              path,
              bytes,
              
            );
        attachments.add(Env.storageUrl('reports', path));
      } catch (_) {}
    }

    await ref.read(participationRepositoryProvider).sendMessage(
          MessageItem(
            deviceId: deviceId,
            subject: title,
            message: message,
            category: _selectedAreas.isEmpty ? 'geral' : _selectedAreas.first,
            channel: 'form',
            attachments: attachments,
          ),
        );

    setState(() => _sending = false);
    if (!mounted) return;

    _titleController.clear();
    _messageController.clear();
    setState(() => _photos.clear());
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle_rounded, color: Color(0xFF606C38), size: 48),
        title: const Text('Sugestão enviada!'),
        content: const Text(
            'Obrigado por contribuir com a construção das nossas propostas. Sua mensagem chegou à equipe 45788.'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final campaign = settings['campaign'] ?? const {};
    final contact = settings['contact'] ?? const {};
    final securityNotice = (contact['security_notice'] as String?) ??
        'Campanha Rogério Tavares. CNPJ: 00.000.000/0001-00. Seus dados estão seguros conosco.';
    final whatsup = (contact['whatsapp'] as String?) ?? '';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _ContactHeader(campaignName: (campaign['name'] as String?) ?? 'ELEIÇÕES ${Env.electionYear}')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(RtSpace.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: RtSpace.md,
                children: [
                  Text('Canais de Participação',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: p.primaryText)),
                  ContactMethodCard(
                    icon: Icons.record_voice_over_rounded,
                    title: 'Gabinete Digital',
                    description: 'Envie solicitações e acompanhe nossas propostas',
                    tone: 'primary',
                    onTap: () => context.go('/chat'),
                  ),
                  ContactMethodCard(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'WhatsApp Direto',
                    description: 'Fale com nossa equipe de mobilização agora',
                    tone: 'success',
                    onTap: whatsup.isEmpty
                        ? () => ShareService.launch('https://wa.me/')
                        : () => ShareService.launch(whatsup),
                  ),
                  ContactMethodCard(
                    icon: Icons.volunteer_activism_rounded,
                    title: 'Seja Voluntário',
                    description: 'Cadastre-se para ajudar na nossa campanha',
                    tone: 'warning',
                    onTap: () => context.go('/participe'),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: RtSpace.lg),
              padding: const EdgeInsets.all(RtSpace.lg),
              decoration: BoxDecoration(
                color: p.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(top: BorderSide(color: p.outline)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: RtSpace.md,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: RtSpace.xs,
                    children: [
                      Text('Construção de Propostas',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: p.primaryText)),
                      Text('Qual sua principal demanda para o nosso estado?',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
                    ],
                  ),
                  Text('Selecione a área prioritária',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: p.primaryText)),
                  Wrap(
                    spacing: RtSpace.sm,
                    runSpacing: RtSpace.sm,
                    children: [
                      for (final area in _areas)
                        CategoryPill(
                          label: area,
                          active: _selectedAreas.contains(area),
                          onTap: () => setState(() {
                            _selectedAreas.contains(area)
                                ? _selectedAreas.remove(area)
                                : _selectedAreas.add(area);
                          }),
                        ),
                    ],
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Título da Sugestão',
                      hintText: 'Ex: Reforma da UBS local',
                    ),
                  ),
                  TextField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Sua Mensagem',
                      hintText: 'Descreva sua ideia para o mandato de Rogério Tavares...',
                    ),
                  ),
                  Text('Anexar fotos da sua região (opcional)',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: p.primaryText)),
                  InkWell(
                    onTap: _pickPhoto,
                    borderRadius: BorderRadius.circular(RtSpace.lg),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(RtSpace.lg),
                        border: Border.all(color: p.divider),
                        color: p.background.withValues(alpha: 0.5),
                      ),
                      child: Center(
                        child: _photos.isEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                spacing: RtSpace.xs,
                                children: [
                                  Icon(Icons.add_a_photo_rounded, size: 32, color: p.secondaryText),
                                  Text('Clique para enviar arquivos',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: p.secondaryText)),
                                ],
                              )
                            : ListView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(RtSpace.sm),
                                children: [
                                  for (final photo in _photos)
                                    Padding(
                                      padding: const EdgeInsets.only(right: RtSpace.sm),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(RtSpace.sm),
                                        child: Image.file(
                                          File(photo.path),
                                          width: 76,
                                          height: 76,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => const Icon(Icons.image_outlined),
                                        ),
                                      ),
                                    ),
                                  IconButton(
                                    onPressed: _pickPhoto,
                                    icon: Icon(Icons.add_rounded, color: p.primary),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  RtButton(
                    label: 'Enviar para Rogério 45788',
                    size: 'large',
                    fullWidth: true,
                    icon: Icons.send_rounded,
                    loading: _sending,
                    onPressed: _send,
                  ),
                  const SizedBox(height: RtSpace.sm),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: p.secondaryBackground,
              padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg, vertical: RtSpace.xl),
              child: SafeArea(
                top: false,
                child: Column(
                  spacing: RtSpace.sm,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.verified_user_rounded, color: Color(0xFF606C38), size: 24),
                    Text(
                      securityNotice,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Cabeçalho "ELEIÇÕES 2026 / avatar RT / 45788" (design frame 6).
class _ContactHeader extends ConsumerWidget {
  const _ContactHeader({required this.campaignName});

  final String campaignName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final portrait = ref.watch(portraitUrlImmediateProvider);
    return Container(
      color: p.secondaryBackground,
      padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.xl, RtSpace.lg, RtSpace.md),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.divider))),
      child: Column(
        spacing: RtSpace.md,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => goBack(context),
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: p.primaryText),
              ),
              Text(campaignName,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: p.primary, fontWeight: FontWeight.bold, letterSpacing: 1)),
              IconButton(
                onPressed: () => ShareService.share('Fale com o Rogério — 45788', '/fale'),
                icon: Icon(Icons.share_rounded, size: 20, color: p.secondaryText),
              ),
            ],
          ),
          Row(
            spacing: RtSpace.lg,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RtAvatar(name: 'Rogério Tavares', imageUrl: portrait, size: 64),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: RtSpace.xs,
                  children: [
                    Text('Rogério Tavares',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: p.primaryText, fontWeight: FontWeight.bold)),
                    Text('Deputado Estadual',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm),
                decoration: BoxDecoration(
                  color: p.accent,
                  borderRadius: BorderRadius.circular(RtRadius.md),
                  boxShadow: [RtShadow.sm()],
                ),
                child: Text('45788',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: p.onSurface, fontWeight: FontWeight.w900)),
              ),
            ],
          ),
          Text('Fale com o Rogério',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: p.primaryText, fontWeight: FontWeight.bold)),
          Text(
            'Sua voz constrói nossas propostas. Escolha um canal abaixo para participar da nossa caminhada.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.secondaryText),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 350.ms);
  }
}