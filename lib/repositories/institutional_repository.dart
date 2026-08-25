import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';
import '../utils/json_utils.dart';

/// Configurações institucionais (textos oficiais vindos do banco).
class InstitutionalRepository {
  InstitutionalRepository(this._client);

  final SupabaseClient _client;

  Future<Map<String, Map<String, dynamic>>> fetchSettings() async {
    final rows = await _client.from('settings').select('key, value');
    final map = <String, Map<String, dynamic>>{};
    for (final row in rows) {
      map[row['key'] as String] = mapVal(row['value']);
    }
    return map;
  }

Future<void> upsertSetting(String key, Map<String, dynamic> value) async {
  await _client
      .from('settings')
      .upsert({'key': key, 'value': value}, onConflict: 'key');
}

  Future<List<BannerHome>> fetchBanners() async {
    final rows = await _client
        .from('banner_home')
        .select()
        .eq('is_active', true)
        .order('sort_order');
    return rows.map(BannerHome.fromJson).toList();
  }

  Future<void> saveBanner(BannerHome b) async {
    if (b.id == null) {
      await _client.from('banner_home').insert(b.toJson());
    } else {
      await _client.from('banner_home').update(b.toJson()).eq('id', b.id!);
    }
  }

  Future<void> deleteBanner(String id) async =>
      _client.from('banner_home').delete().eq('id', id);

  Future<List<CampaignNumber>> fetchNumbers() async {
    final rows = await _client
        .from('campaign_numbers')
        .select()
        .eq('is_active', true)
        .order('sort_order');
    return rows.map(CampaignNumber.fromJson).toList();
  }

  Future<void> saveNumber(CampaignNumber n) async {
    if (n.id == null) {
      await _client.from('campaign_numbers').insert(n.toJson());
    } else {
      await _client.from('campaign_numbers').update(n.toJson()).eq('id', n.id!);
    }
  }

  Future<void> deleteNumber(String id) async =>
      _client.from('campaign_numbers').delete().eq('id', id);

  Future<List<SocialLink>> fetchSocialLinks() async {
    final rows = await _client
        .from('social_links')
        .select()
        .eq('is_active', true)
        .order('sort_order');
    return rows.map(SocialLink.fromJson).toList();
  }

  Future<void> saveSocialLink(SocialLink s) async {
    if (s.id == null) {
      await _client.from('social_links').insert(s.toJson());
    } else {
      await _client.from('social_links').update(s.toJson()).eq('id', s.id!);
    }
  }

  Future<void> deleteSocialLink(String id) async =>
      _client.from('social_links').delete().eq('id', id);

  Future<List<DownloadItem>> fetchDownloads() async {
    final rows = await _client
        .from('downloads')
        .select()
        .eq('is_active', true)
        .order('sort_order');
    return rows.map(DownloadItem.fromJson).toList();
  }

  Future<void> saveDownload(DownloadItem d) async {
    if (d.id == null) {
      await _client.from('downloads').insert(d.toJson());
    } else {
      await _client.from('downloads').update(d.toJson()).eq('id', d.id!);
    }
  }

  Future<void> deleteDownload(String id) async =>
      _client.from('downloads').delete().eq('id', id);

  Future<List<TeamMember>> fetchTeam() async {
    final rows = await _client.from('team').select().order('sort_order');
    return rows.map(TeamMember.fromJson).toList();
  }

  Future<void> saveTeamMember(TeamMember t) async {
    if (t.id == null) {
      await _client.from('team').insert(t.toJson());
    } else {
      await _client.from('team').update(t.toJson()).eq('id', t.id!);
    }
  }

  Future<void> deleteTeamMember(String id) async =>
      _client.from('team').delete().eq('id', id);

  Future<List<Testimonial>> fetchTestimonials() async {
    final rows = await _client.from('testimonials').select().order('sort_order');
    return rows.map(Testimonial.fromJson).toList();
  }

  Future<void> saveTestimonial(Testimonial t) async {
    if (t.id == null) {
      await _client.from('testimonials').insert(t.toJson());
    } else {
      await _client.from('testimonials').update(t.toJson()).eq('id', t.id!);
    }
  }

  Future<void> deleteTestimonial(String id) async =>
      _client.from('testimonials').delete().eq('id', id);

  Future<List<FaqItem>> fetchFaq() async {
    final rows = await _client.from('faq').select().order('sort_order');
    return rows.map(FaqItem.fromJson).toList();
  }

  Future<void> saveFaq(FaqItem f) async {
    if (f.id == null) {
      await _client.from('faq').insert(f.toJson());
    } else {
      await _client.from('faq').update(f.toJson()).eq('id', f.id!);
    }
  }

  Future<void> deleteFaq(String id) async =>
      _client.from('faq').delete().eq('id', id);

  Future<List<SearchResult>> globalSearch(String term) async {
    final rows = await _client.rpc('global_search', params: {'term': term});
    return rows.map(SearchResult.fromJson).toList();
  }

  // ---------------- Biografia (dinâmica e editável) ----------------

  Future<List<BiographyItem>> fetchBiographyItems() async {
    final rows = await _client
        .from('biography_items')
        .select()
        .eq('is_active', true)
        .order('sort_order');
    return rows.map(BiographyItem.fromJson).toList();
  }

  Future<List<BiographyItem>> fetchAllBiographyItems() async {
    final rows = await _client
        .from('biography_items')
        .select()
        .order('sort_order');
    return rows.map(BiographyItem.fromJson).toList();
  }

  Future<void> saveBiographyItem(BiographyItem item) async {
    if (item.id == null) {
      await _client.from('biography_items').insert(item.toJson());
    } else {
      var json = item.toJson();
      json.remove('created_at');
      await _client.from('biography_items').update(json).eq('id', item.id!);
    }
  }

  Future<void> deleteBiographyItem(String id) async =>
      _client.from('biography_items').delete().eq('id', id);
}