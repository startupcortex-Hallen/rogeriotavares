import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// GALERIA — fotos, vídeos, stories e álbuns com fullscreen.
class GalleryPage extends ConsumerStatefulWidget {
  const GalleryPage({super.key});

  @override
  ConsumerState<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends ConsumerState<GalleryPage> {
  String _filter = 'Todas';

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(galleryProvider);
    final items = itemsAsync.valueOrNull ?? [];
    final categories = <String>{'Todas'};
    for (final it in items.whereType<GalleryItem>()) {
      if (it.category.isNotEmpty) categories.add(it.category);
    }

    final filtered = items.whereType<GalleryItem>().where((it) {
      if (_filter == 'Todas') return true;
      if (_filter == 'Vídeos') return it.isVideo;
      if (_filter == 'Stories') return it.isStory;
      return it.category == _filter;
    }).toList();

    final pills = <String>[
      ...categories,
      if (!categories.contains('Vídeos')) 'Vídeos',
      if (!categories.contains('Stories')) 'Stories',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria'),
        actions: [
          IconButton(
            onPressed: () => context.go('/videos'),
            icon: const Icon(Icons.play_circle_outline_rounded),
            tooltip: 'Vídeos',
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
                for (final c in pills)
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
              onRefresh: () async => ref.refresh(galleryProvider.future),
              child: itemsAsync.isLoading
                  ? GridView.builder(
                      padding: const EdgeInsets.all(RtSpace.lg),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: RtSpace.sm,
                        crossAxisSpacing: RtSpace.sm,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, i) => const SkeletonBox(radius: RtRadius.lg),
                    )
                  : itemsAsync.hasError && filtered.isEmpty
                      ? ErrorRetry(
                          onRetry: () => ref.invalidate(galleryProvider),
                          message: 'Falha ao carregar as fotos. Verifique sua conexão.',
                        )
                      : filtered.isEmpty
                      ? const EmptyState(
                          title: 'Nenhuma mídia',
                          subtitle: 'As fotos da campanha aparecem aqui.',
                          icon: Icons.photo_library_outlined,
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(RtSpace.lg),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: RtSpace.sm,
                            crossAxisSpacing: RtSpace.sm,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            return _GalleryTile(
                              item: item,
                              index: index,
                              items: filtered,
                            ).animate().fadeIn(
                                  duration: const Duration(milliseconds: 250),
                                  delay: Duration(milliseconds: (index % 6) * 40),
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

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({required this.item, required this.index, required this.items});

  final GalleryItem item;
  final int index;
  final List<GalleryItem> items;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openFullscreen(context, index, items),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RtSpace.lg),
        child: Stack(
          fit: StackFit.expand,
          children: [
            RtImage(url: item.imageUrl, placeholderIcon: Icons.photo_outlined),
            if (item.isVideo || item.videoUrl.isNotEmpty)
              Positioned.fill(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30),
                  ),
                ),
              ),
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(RtRadius.full),
                ),
                child: Text(
                  item.album.isNotEmpty ? item.album : item.category,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: IconButton(
                onPressed: () =>
                    ShareService.share(item.title.isEmpty ? 'Galeria 45788' : item.title, '/galeria'),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.share_rounded, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFullscreen(BuildContext context, int initialIndex, List<GalleryItem> galleryItems) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black,
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: PhotoViewGallery.builder(
              itemCount: galleryItems.length,
              pageController: PageController(initialPage: initialIndex),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              builder: (context, i) => PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(galleryItems[i].imageUrl),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 4,
                heroAttributes: PhotoViewHeroAttributes(tag: 'gallery_${galleryItems[i].id}'),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(RtSpace.sm),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}