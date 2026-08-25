import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';
import '../widgets/rt_city_field.dart';

/// ENVIAR DEMANDA â€” morador envia com foto, GPS e categoria.
class ReportPage extends ConsumerStatefulWidget {
  const ReportPage({super.key});

  @override
  ConsumerState<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends ConsumerState<ReportPage> {
  final _description = TextEditingController();
  final _city = TextEditingController();
  XFile? _photo;
  Position? _position;
  String _category = 'infraestrutura';
  bool _sending = false;
  bool _locating = false;

  static const _categories = {
    'infraestrutura': (Icons.construction_rounded, 'Infraestrutura'),
    'saude': (Icons.medical_services_rounded, 'SaÃºde'),
    'educacao': (Icons.school_rounded, 'EducaÃ§Ã£o'),
    'seguranca': (Icons.gavel_rounded, 'SeguranÃ§a'),
    'agua_saneamento': (Icons.water_drop_rounded, 'Ãgua e Saneamento'),
    'iluminacao': (Icons.light_mode_rounded, 'IluminaÃ§Ã£o'),
    'estrada': (Icons.route_rounded, 'Estradas'),
    'outro': (Icons.category_rounded, 'Outro'),
  };

  @override
  void dispose() {
    _description.dispose();
    _city.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo != null) setState(() => _photo = photo);
  }

  Future<void> _locate() async {
    setState(() => _locating = true);
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      setState(() => _position = pos);
    } catch (_) {}
    setState(() => _locating = false);
  }

  Future<void> _submit() async {
    final description = _description.text.trim();
    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Descreva a demanda para enviar.')),
      );
      return;
    }
    setState(() => _sending = true);

    final deviceId = await ref.read(deviceIdProvider.future);
    String? imageUrl;
    if (_photo != null) {
      try {
        final bytes = await _photo!.readAsBytes();
        final path = '$deviceId/${DateTime.now().millisecondsSinceEpoch}.jpg';
        await ref.read(supabaseProvider).storage.from('reports').uploadBinary(
              path,
              bytes,
              
            );
        imageUrl = Env.storageUrl('reports', path);
      } catch (_) {}
    }

    await ref.read(participationRepositoryProvider).sendReport(
          ReportItem(
            deviceId: deviceId,
            city: _city.text.trim(),
            category: _category,
            description: description,
            imageUrl: imageUrl ?? '',
            latitude: _position?.latitude,
            longitude: _position?.longitude,
          ),
        );
    setState(() => _sending = false);
    if (!mounted) return;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.add_location_alt_rounded, color: Color(0xFF606C38), size: 48),
        title: const Text('Demanda enviada!'),
        content: const Text(
            'Sua demanda foi registrada. ApÃ³s aprovaÃ§Ã£o da equipe, ela aparecerÃ¡ no Mapa da Bahia.'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ver mapa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Demanda'),
        actions: [
          TextButton.icon(
            onPressed: () => context.go('/mapa'),
            icon: const Icon(Icons.map_outlined),
            label: const Text('Mapa'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(RtSpace.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(RtSpace.md),
            decoration: BoxDecoration(
              color: p.info.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(RtRadius.lg),
              border: Border.all(color: p.info.withValues(alpha: 0.30)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, color: p.info),
                const SizedBox(width: RtSpace.md),
                Expanded(
                  child: Text(
                    'Encontrou um problema na sua regiÃ£o? Envie com foto e localizaÃ§Ã£o. A equipe analisa e publica no mapa.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.info),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: RtSpace.md),
          Text('Categoria', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: RtSpace.sm),
          Wrap(
            spacing: RtSpace.sm,
            runSpacing: RtSpace.sm,
            children: [
              for (final entry in _categories.entries)
                ChoiceChip(
                  selected: _category == entry.key,
                  onSelected: (_) => setState(() => _category = entry.key),
                  avatar: Icon(entry.value.$1, size: 16),
                  label: Text(entry.value.$2),
                ),
            ],
          ),
          const SizedBox(height: RtSpace.md),
          RtCityField(controller: _city),
          const SizedBox(height: RtSpace.md),
          TextField(
            controller: _description,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'DescriÃ§Ã£o da demanda',
              hintText: 'Descreva o problema da sua regiÃ£o...',
            ),
          ),
          const SizedBox(height: RtSpace.md),
          // Foto
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _pickPhoto,
                  borderRadius: BorderRadius.circular(RtSpace.lg),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(RtSpace.lg),
                      border: Border.all(color: p.divider),
                      color: p.background.withValues(alpha: 0.5),
                    ),
                    child: _photo == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: RtSpace.xs,
                            children: [
                              Icon(Icons.add_a_photo_rounded, size: 32, color: p.secondaryText),
                              Text('Tirar foto do problema',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.secondaryText)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(RtSpace.lg - 4),
                            child: Image.file(
                              File(_photo!.path),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.image_outlined),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: InkWell(
                  onTap: _locate,
                  borderRadius: BorderRadius.circular(RtSpace.lg),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(RtSpace.lg),
                      border: Border.all(color: p.divider),
                      color: p.background.withValues(alpha: 0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: RtSpace.xs,
                      children: [
                        if (_locating)
                          const CircularProgressIndicator(strokeWidth: 3)
                        else
                          Icon(
                            _position != null ? Icons.my_location_rounded : Icons.location_searching_rounded,
                            size: 32,
                            color: _position != null ? p.success : p.secondaryText,
                          ),
                        Text(
                          _position != null
                              ? 'GPS: ${_position!.latitude.toStringAsFixed(4)}, ${_position!.longitude.toStringAsFixed(4)}'
                              : 'Coletar minha localizaÃ§Ã£o',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: _position != null ? p.success : p.secondaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: RtSpace.lg),
          RtButton(
            label: 'Enviar demanda',
            size: 'large',
            fullWidth: true,
            icon: Icons.send_rounded,
            loading: _sending,
            onPressed: _submit,
          ),
          const SizedBox(height: RtSpace.sm),
          Text(
            'Demandas aprovadas aparecem publicamente no Mapa da Bahia.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.hint),
          ),
          const SizedBox(height: RtSpace.lg),
        ],
      ),
    );
  }
}