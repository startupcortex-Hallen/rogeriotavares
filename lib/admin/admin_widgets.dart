import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/env.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// Título de seção do painel.
class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key, required this.title, this.subtitle, this.actions});

  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: RtSpace.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800)),
                if (subtitle != null)
                  Text(subtitle!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
              ],
            ),
          ),
          ...?actions,
        ],
      ),
    );
  }
}

/// Card de estatística do dashboard.
class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.icon, required this.label, required this.value, this.color = const Color(0xFF1565C0), this.onTap});

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

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
          padding: const EdgeInsets.all(RtSpace.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: p.outline),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    Text(label,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.secondaryText)),
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

/// Diálogo de confirmação.
Future<bool> confirmAction(BuildContext context, String title, String message) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirmar'),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Campo de upload de imagem com preview (envia para o bucket).
class UploadImageField extends ConsumerStatefulWidget {
  const UploadImageField({
    super.key,
    required this.label,
    required this.bucket,
    this.initialUrl,
    this.onChanged,
    this.height = 140,
  });

  final String label;
  final String bucket;
  final String? initialUrl;
  final ValueChanged<String?>? onChanged;
  final double height;

  @override
  ConsumerState<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends ConsumerState<UploadImageField> {
  String? _url;
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final url = _url ?? widget.initialUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: RtSpace.sm),
        InkWell(
          onTap: _upload,
          borderRadius: BorderRadius.circular(RtRadius.lg),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RtRadius.lg),
              border: Border.all(color: p.outline, width: url?.isNotEmpty == true ? 2 : 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: _uploading
                ? const Center(child: CircularProgressIndicator())
                : url != null && url.isNotEmpty
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          RtImage(url: url),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _url = null;
                                  widget.onChanged?.call(null);
                                });
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black54,
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.close_rounded, size: 18),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: IconButton(
                              onPressed: _upload,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black54,
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.cached_rounded, size: 18),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: RtSpace.xs,
                        children: [
                          Icon(Icons.add_a_photo_rounded, size: 32, color: p.secondaryText),
                          Text('Enviar imagem',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: p.secondaryText)),
                        ],
                      ),
          ),
        ),
      ],
    );
  }

  Future<void> _upload() async {
    final client = ref.read(supabaseProvider);
    final user = client.auth.currentUser;
    if (user == null || !context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sessão não conectada. Saia e entre novamente no painel para enviar imagens.'),
        ),
      );
      return;
    }
    final file = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1600);
    if (file == null) return;
    setState(() => _uploading = true);
    try {
      final bytes = await file.readAsBytes();
      final path = '${user.id}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await client.storage.from(widget.bucket).uploadBinary(path, bytes);
      final url = Env.storageUrl(widget.bucket, path);
      setState(() => _url = url);
      widget.onChanged?.call(url);
    } on StorageException catch (e) {
      if (context.mounted) {
        final code = e.statusCode ?? '?';
        final noSession = client.auth.currentUser == null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Upload falhou (HTTP $code): ${e.message}\n'
              '${noSession || code == 403 || code == 401 ? 'Sessão não conectada? Saia e entre novamente no painel.' : 'Verifique o bucket e a permissão.'}',
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível enviar a imagem.\n$e')),
        );
      }
    }
    setState(() => _uploading = false);
  }
}

/// Chips de seleção múltipla/única.
class ChipEditField extends StatelessWidget {
  const ChipEditField({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.multiple = true,
  });

  final String label;
  final List<String> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;
  final bool multiple;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: RtSpace.xs),
        Wrap(
          spacing: RtSpace.xs,
          runSpacing: RtSpace.xs,
          children: [
            for (final option in options)
              ChoiceChip(
                label: Text(option),
                selected: selected.contains(option),
                onSelected: (value) {
                  if (multiple) {
                    onChanged(value
                        ? [...selected, option]
                        : selected.where((e) => e != option).toList());
                  } else {
                    onChanged([option]);
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}

/// Registro de mudanças com data.
class AuditTile extends StatelessWidget {
  const AuditTile({super.key, required this.entry});

  final Map<String, dynamic> entry;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return ListTile(
      leading: Icon(Icons.history_rounded, color: p.primary),
      title: Text('${entry['action']} • ${entry['entity']}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
      subtitle: Text(
        '${entry['admin_email'] ?? 'sistema'} — ${_mkDate(entry['created_at'])}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  String _mkDate(dynamic v) {
    final d = DateTime.tryParse(v?.toString() ?? '');
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} ${d.hour}:${d.minute.toString().padLeft(2, '0')}';
  }
}

/// Botão "+ Novo".
class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add_rounded, size: 20),
      label: const Text('Novo'),
    );
  }
}