import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/app_providers.dart';

/// Realtime: quando o admin publica/edita no painel, o app reflete na hora.
class RealtimeService {
  RealtimeChannel? _channel;

  /// Inicia as assinaturas de mudanças nas tabelas de conteúdo.
  void start(ProviderContainer container) {
    final client = container.read(supabaseProvider);
    if (_channel != null) return;

    final channel = client.channel('realtime-conteudo-45788');

    void listen(String table, void Function() invalidate) {
      channel.onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: table,
        callback: (_) => invalidate(),
      );
    }

    listen('news', () {
      container.invalidate(newsProvider);
      container.invalidate(featuredNewsProvider);
    });
    listen('government_plan', () => container.invalidate(plansProvider));
    listen('events', () => container.invalidate(upcomingEventsProvider));
    listen('cities', () => container.invalidate(citiesProvider));
    listen('gallery', () => container.invalidate(galleryProvider));
    listen('videos', () => container.invalidate(videosProvider));
    listen('downloads', () => container.invalidate(downloadsProvider));
    listen('social_links', () => container.invalidate(socialLinksProvider));
    listen('banner_home', () => container.invalidate(bannerProvider));
    listen('campaign_numbers', () {
      container.invalidate(campaignNumbersProvider);
      container.invalidate(transparencyNumbersProvider);
    });
    listen('settings', () {
      container.invalidate(settingsProvider);
      container.invalidate(portraitUrlProvider);
    });
    listen('biography_items', () {
      container.invalidate(biographyItemsProvider);
    });
    listen('plan_categories', () => container.invalidate(planCategoriesProvider));
    listen('news_categories', () => container.invalidate(newsCategoriesProvider));
    listen('faq', () => container.invalidate(faqProvider));
    listen('team', () => container.invalidate(teamProvider));
    listen('testimonials', () => container.invalidate(testimonialsProvider));

    channel.subscribe();
    _channel = channel;
  }

  /// Encerra as assinaturas (aplicativo fechando).
  void dispose() {
    _channel?.unsubscribe();
    _channel = null;
  }
}