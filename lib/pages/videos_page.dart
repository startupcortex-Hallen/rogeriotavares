import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// ID placeholder usado pelo seed (Rick Astley) — tratado como vazio.
const _placeholderYoutubeIds = {'dQw4w9WgXcQ', 'phNkkD8pXs4'};

bool _hasValidYoutubeId(VideoItem v) {
  final id = v.youtubeId.trim();
  return id.isNotEmpty && !_placeholderYoutubeIds.contains(id);
}

/// VÍDEOS — lives, entrevistas e reels (YouTube embed + storage).
class VideosPage extends ConsumerStatefulWidget {
  const VideosPage({super.key});

  @override
  ConsumerState<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends ConsumerState<VideosPage> {
  String _filter = 'Todas';

  @override
  Widget build(BuildContext context) {

    final videosAsync = ref.watch(videosProvider);
    final videos = videosAsync.valueOrNull ?? [];

    final categories = <String>{'Todas'};
    for (final v in videos.whereType<VideoItem>()) {
      if (v.category.isNotEmpty) categories.add(v.category);
    }

    final filtered = videos.whereType<VideoItem>().where((v) {
      if (!_hasValidYoutubeId(v) && v.videoUrl.isEmpty) return false;
      if (_filter == 'Todas') return true;
      return v.category == _filter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vídeos'),
        actions: [
          IconButton(
            onPressed: () => ShareService.share('Vídeos — Rogério Tavares 45788', '/videos'),
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg, vertical: RtSpace.sm),
              children: [
                for (final c in categories)
                  Padding(
                    padding: const EdgeInsets.only(right: RtSpace.sm),
                    child: CategoryPill(
                      label: c,
                      active: _filter == c,
                      onTap: () => setState(() => _filter = c),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => ref.refresh(videosProvider.future),
              child: videosAsync.isLoading
                  ? ListView.builder(
                      padding: const EdgeInsets.all(RtSpace.lg),
                      itemCount: 4,
                      itemBuilder: (context, i) =>
                          const Padding(padding: EdgeInsets.only(bottom: RtSpace.md), child: SkeletonBox(height: 180)),
                    )
                  : videosAsync.hasError && filtered.isEmpty
                      ? ErrorRetry(
                          onRetry: () => ref.invalidate(videosProvider),
                          message: 'Falha ao carregar os vídeos. Verifique sua conexão.',
                        )
                      : filtered.isEmpty
                          ? const EmptyState(
                          title: 'Nenhum vídeo',
                          subtitle: 'Em breve novos vídeos da campanha.',
                          icon: Icons.videocam_off_outlined,
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(RtSpace.lg),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => const SizedBox(height: RtSpace.md),
                          itemBuilder: (context, index) {
                            final v = filtered[index];
                            return _VideoTile(video: v).animate().fadeIn(
                                  duration: const Duration(milliseconds: 250),
                                  delay: Duration(milliseconds: (index % 5) * 50),
                                );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoTile extends StatelessWidget {
  const _VideoTile({required this.video});

  final VideoItem video;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openPlayer(context),
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  RtImage(url: video.thumbnailUrl.isNotEmpty
                      ? video.thumbnailUrl
                      : 'https://img.youtube.com/vi/${video.youtubeId}/hqdefault.jpg'),
                  Container(color: Colors.black26),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40),
                    ),
                  ),
                  Positioned(
                    right: RtSpace.sm,
                    bottom: RtSpace.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(RtRadius.sm),
                      ),
                      child: Text(
                        video.durationSeconds > 0
                            ? _fmtDuration(video.durationSeconds)
                            : video.videoType.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    left: RtSpace.sm,
                    top: RtSpace.sm,
                    child: RtBadge(
                      label: video.category.toUpperCase(),
                      color: p.primary,
                      textColor: p.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(RtSpace.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(video.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        if (video.description.isNotEmpty)
                          Text(video.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => ShareService.share(video.title, '/videos'),
                    icon: Icon(Icons.share_rounded, color: p.secondaryText, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmtDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _openPlayer(BuildContext context) {
    final p = rt(context);

    final hasYouTube = video.youtubeId.isNotEmpty;
    final controller = hasYouTube
        ? YoutubePlayerController.fromVideoId(
            videoId: video.youtubeId,
            autoPlay: true,
            params: const YoutubePlayerParams(showFullscreenButton: true),
          )
        : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: p.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(RtSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: RtSpace.md),
            Text(video.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: RtSpace.md),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(RtSpace.lg),
                child: hasYouTube && controller != null
                    ? YoutubePlayer(controller: controller, aspectRatio: 16 / 9)
                    : video.videoUrl.isNotEmpty
                        ? Stack(
                            children: [
                              RtImage(url: video.videoUrl),
                              const Center(
                                child: CircularProgressIndicator(color: Colors.white),
                              ),
                            ],
                          )
                        : RtImage(url: video.thumbnailUrl),
              ),
            ),
            const SizedBox(height: RtSpace.md),
            if (video.description.isNotEmpty)
              Text(video.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
          ],
        ),
      ),
    );
  }
}