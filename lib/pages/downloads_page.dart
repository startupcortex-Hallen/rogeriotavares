import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// DOWNLOADS — materiais oficiais (PDF, santinhos, logos, banners) via storage.
class DownloadsPage extends ConsumerWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final downloadsAsync = ref.watch(downloadsProvider);
    final downloads = downloadsAsync.valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Materiais Oficiais')),
      body: ListView(
        padding: const EdgeInsets.all(RtSpace.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(RtSpace.lg),
            decoration: BoxDecoration(
              color: p.primary,
              borderRadius: BorderRadius.circular(RtRadius.xl),
            ),
            child: Column(
              spacing: RtSpace.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.download_rounded, color: Colors.white, size: 32),
                    const SizedBox(width: RtSpace.md),
                    Expanded(
                      child: Text('Materiais Oficiais 45788',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                Text(
                  'Plano de Governo, santinhos, logos e banners oficiais da campanha. Baixe e compartilhe!',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white.withValues(alpha: 0.9)),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 350.ms),
          const SizedBox(height: RtSpace.md),
          if (downloadsAsync.isLoading)
            for (var i = 0; i < 4; i++)
              const Padding(padding: EdgeInsets.only(bottom: RtSpace.md), child: SkeletonBox(height: 84))
          else if (downloads.isEmpty)
            const EmptyState(
              title: 'Materiais em breve',
              subtitle: 'Os arquivos oficiais aparecem aqui.',
              icon: Icons.folder_open_outlined,
            )
          else
            for (final item in downloads.whereType<DownloadItem>())
              _DownloadTile(item: item),
          const SizedBox(height: RtSpace.lg),
          Container(
            padding: const EdgeInsets.all(RtSpace.md),
            decoration: BoxDecoration(
              color: p.secondaryBackground,
              borderRadius: BorderRadius.circular(RtRadius.lg),
              border: Border.all(color: p.outline),
            ),
            child: Row(
              children: [
                Icon(Icons.verified_user_rounded, color: p.success),
                const SizedBox(width: RtSpace.md),
                Expanded(
                  child: Text('Todos os arquivos são de uso autorizado pela campanha 45788.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                ),
              ],
            ),
          ),
          const SizedBox(height: RtSpace.lg),
        ],
      ),
    );
  }
}

class _DownloadTile extends StatelessWidget {
  const _DownloadTile({required this.item});

  final DownloadItem item;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final color = _typeColor(item.fileType);
    final hasFile = item.fileUrl.isNotEmpty;
    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      child: InkWell(
        onTap: hasFile ? () => _download(context) : null,
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
          margin: const EdgeInsets.only(bottom: RtSpace.md),
          padding: const EdgeInsets.all(RtSpace.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtSpace.lg),
            border: Border.all(color: p.outline),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: Icon(_typeIcon(item.fileType), color: color),
              ),
              const SizedBox(width: RtSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    if (item.description.isNotEmpty)
                      Text(item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                    const SizedBox(height: 2),
                    Text(_typeLabel(item.fileType),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
                  ],
                ),
              ),
              if (hasFile)
                IconButton(
                  onPressed: () => _download(context),
                  icon: const Icon(Icons.download_rounded, color: Color(0xFF1565C0)),
                )
              else
                RtBadge(label: 'Em breve', color: p.surfaceVariant, textColor: p.hint),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 250.ms);
  }

  Future<void> _download(BuildContext context) async {
    final url = item.fileUrl.startsWith('http')
        ? item.fileUrl
        : Env.storageUrl('downloads', item.fileUrl);
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  IconData _typeIcon(String type) => switch (type) {
        'pdf' => Icons.picture_as_pdf_rounded,
        'imagem' => Icons.image_rounded,
        'video' => Icons.video_library_rounded,
        'logo' => Icons.copyright_rounded,
        'banner' => Icons.photo_library_outlined,
        'santinho' => Icons.campaign_rounded,
        'adesivo' => Icons.sell_outlined,
        _ => Icons.insert_drive_file_rounded,
      };

  Color _typeColor(String type) => switch (type) {
        'pdf' => const Color(0xFFAE2012),
        'imagem' => const Color(0xFF457B9D),
        'video' => const Color(0xFF1565C0),
        'logo' => const Color(0xFF606C38),
        'banner' => const Color(0xFFFFD600),
        'santinho' => const Color(0xFF0D47A1),
        _ => const Color(0xFF455A64),
      };

  String _typeLabel(String type) => switch (type) {
        'pdf' => 'PDF Oficial',
        'imagem' => 'Imagem',
        'video' => 'Vídeo',
        'logo' => 'Logo',
        'banner' => 'Banner',
        'santinho' => 'Santinho',
        'adesivo' => 'Adesivos',
        _ => 'Arquivo',
      };
}