import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_theme.dart';
import 'rt_widgets.dart';

/// Carrossel de imagens estilo streaming: auto-play, dots e swipe.
/// Sem textos nem overlay — apenas as imagens (design "só imagens").
class HeroCarousel extends ConsumerStatefulWidget {
  const HeroCarousel({
    super.key,
    this.height = 300,
    this.autoPlaySeconds = 4,
  });

  final double height;
  final int autoPlaySeconds;

  @override
  ConsumerState<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends ConsumerState<HeroCarousel> {
  final _controller = PageController(viewportFraction: 0.94);
  Timer? _timer;
  int _current = 0;
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider).valueOrNull ?? [];

    // Prioriza imagens reais (storage) e ignora banners sem imagem.
    final slides =
        banners.whereType<BannerHome>().where((b) => b.imageUrl.isNotEmpty).toList();
    final total = slides.length;
    if (total != _total) {
      _total = total;
      _restartTimer(total);
    }

    if (total == 0) {
      return SizedBox(
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(RtRadius.xl),
          child: RtImage(
            url:
                'https://dimg.dreamflow.cloud/v1/image/Rog%C3%A9rio+Tavares+smiling+in+a+professional+campaign+portrait+with+Brazilian+flag+background',
          ),
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          // Pausa o auto-play enquanto o usuário interage (estilo streaming)
          Listener(
            onPointerDown: (_) => _timer?.cancel(),
            onPointerUp: (_) => _restartTimer(total),
            onPointerCancel: (_) => _restartTimer(total),
            child: PageView.builder(
              controller: _controller,
              itemCount: total,
              onPageChanged: (i) {
                setState(() => _current = i);
                _restartTimer(total);
              },
              itemBuilder: (context, index) {
                final slide = slides[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(RtRadius.xl),
                    child: RtImage(url: slide.imageUrl),
                  ),
                );
              },
            ),
          ),
          // Dots indicadores
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < total; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _current ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _current
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ),
          // Contador "1 / 6" discreto
          Positioned(
            top: 12,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_current + 1} / $total',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _restartTimer(int total) {
    _timer?.cancel();
    if (total <= 1) return;
    _timer = Timer.periodic(Duration(seconds: widget.autoPlaySeconds), (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_current + 1) % total;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}