import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_city_field.dart';
import '../widgets/rt_widgets.dart';

/// PARTICIPE DA CAMPANHA — cadastro de voluntários.
class VolunteerPage extends ConsumerStatefulWidget {
  const VolunteerPage({super.key});

  @override
  ConsumerState<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends ConsumerState<VolunteerPage> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _whatsapp = TextEditingController();
  final _city = TextEditingController();
  final _neighborhood = TextEditingController();
  final _message = TextEditingController();
  final List<String> _availability = [];
  final List<String> _areas = [];
  bool _sending = false;

  static const _availabilityOptions = ['Manhã', 'Tarde', 'Noite', 'Fim de semana'];
  static const _areasOptions = [
    'Mobilização',
    'Redes Sociais',
    'Caravanas',
    'Material de Campanha',
    'Eventos',
    'Financeiro/Leis',
    'Tecnologia',
  ];

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _whatsapp.dispose();
    _city.dispose();
    _neighborhood.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_name.text.trim().isEmpty || _city.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha nome e cidade para se cadastrar.')),
      );
      return;
    }
    setState(() => _sending = true);
    await ref.read(participationRepositoryProvider).sendVolunteer(
          VolunteerRequest(
            fullName: _name.text.trim(),
            phone: _phone.text.trim(),
            whatsapp: _whatsapp.text.trim().isEmpty ? _phone.text.trim() : _whatsapp.text.trim(),
            city: _city.text.trim(),
            neighborhood: _neighborhood.text.trim(),
            availability: _availability,
            areas: _areas,
            message: _message.text.trim(),
          ),
        );
    setState(() => _sending = false);
    if (!mounted) return;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.volunteer_activism_rounded, color: Color(0xFF1565C0), size: 52),
        title: const Text('Bem-vindo(a) ao time 45788!'),
        content: const Text(
            'Seu cadastro de voluntário foi enviado. Nossa equipe de mobilização entrará em contato em breve.'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Juntos com o 45788'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final cta = settings['cta'] ?? const {};

    return Scaffold(
      appBar: AppBar(title: const Text('Participe da Campanha')),
      body: ListView(
        padding: const EdgeInsets.all(RtSpace.lg),
        children: [
          // CTA institucional (design frame 5)
          Container(
            margin: const EdgeInsets.only(bottom: RtSpace.lg),
            padding: const EdgeInsets.all(RtSpace.lg),
            decoration: BoxDecoration(
              color: p.secondaryBackground,
              borderRadius: BorderRadius.circular(RtRadius.xl),
              border: Border.all(color: p.outline),
            ),
            child: Column(
              spacing: RtSpace.sm,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.volunteer_activism_rounded, size: 40, color: Color(0xFF1565C0)),
                Text((cta['voluntario_title'] as String?) ?? 'Faça parte da mudança',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                Text(
                  (cta['voluntario_text'] as String?) ??
                      'Junte-se ao time do Rogério Tavares. Cadastre-se para ser um voluntário ou receber atualizações da campanha.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText),
                ),
                const SizedBox(height: RtSpace.sm),
                NumberBadge(color: p.accent, textColor: p.onSurface),
              ],
            ),
          ),
          Text('Cadastro de Voluntário',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: RtSpace.md),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Nome completo', hintText: 'Seu nome'),
          ),
          const SizedBox(height: RtSpace.md),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Telefone', hintText: '(00) 00000-0000'),
          ),
          const SizedBox(height: RtSpace.md),
          TextField(
            controller: _whatsapp,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'WhatsApp (opcional)', hintText: '(00) 00000-0000'),
          ),
          const SizedBox(height: RtSpace.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RtCityField(controller: _city),
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: TextField(
                  controller: _neighborhood,
                  decoration: const InputDecoration(labelText: 'Bairro'),
                ),
              ),
            ],
          ),
          const SizedBox(height: RtSpace.md),
          Text('Disponibilidade', style: Theme.of(context).textTheme.labelLarge),
          Wrap(
            spacing: RtSpace.sm,
            runSpacing: RtSpace.sm,
            children: [
              for (final a in _availabilityOptions)
                CategoryPill(
                  label: a,
                  active: _availability.contains(a),
                  onTap: () => setState(() {
                    _availability.contains(a) ? _availability.remove(a) : _availability.add(a);
                  }),
                ),
            ],
          ),
          const SizedBox(height: RtSpace.md),
          Text('Áreas de atuação', style: Theme.of(context).textTheme.labelLarge),
          Wrap(
            spacing: RtSpace.sm,
            runSpacing: RtSpace.sm,
            children: [
              for (final a in _areasOptions)
                CategoryPill(
                  label: a,
                  active: _areas.contains(a),
                  onTap: () => setState(() {
                    _areas.contains(a) ? _areas.remove(a) : _areas.add(a);
                  }),
                ),
            ],
          ),
          const SizedBox(height: RtSpace.md),
          TextField(
            controller: _message,
            maxLines: 4,
            decoration:
                const InputDecoration(labelText: 'Por que quer ajudar? (opcional)', hintText: 'Conte um pouco sobre você...'),
          ),
          const SizedBox(height: RtSpace.md),
          RtButton(
            label: (cta['voluntario_button'] as String?) ?? 'Quero ser Voluntário ${Env.campaignNumber}',
            size: 'large',
            fullWidth: true,
            icon: Icons.volunteer_activism_rounded,
            loading: _sending,
            onPressed: _submit,
          ),
          const SizedBox(height: RtSpace.lg),
        ],
      ),
    );
  }
}