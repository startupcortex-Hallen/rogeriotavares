import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

/// Agenda (eventos) + cidades (mapa).
class AgendaRepository {
  AgendaRepository(this._client);

  final SupabaseClient _client;

  static const _selectEvents = '*, cities(name, region, latitude, longitude, id)';

  Map<String, dynamic> _mapEvent(dynamic row) {
    final m = Map<String, dynamic>.from(row as Map);
    final city = m['cities'];
    if (city is Map) {
      m.remove('cities');
      m['cityName'] = city['name'];
      m['cityRegion'] = city['region'];
      m['cityLatitude'] = city['latitude'];
      m['cityLongitude'] = city['longitude'];
      m['cityId'] = city['id'];
    } else if (city == null) {
      m.remove('cities');
    }
    return m;
  }

  Future<List<EventItem>> fetchEvents({
    String? cityId,
    DateTime? fromDate,
    DateTime? toDate,
    int from = 0,
    int to = 49,
  }) async {
    var q = _client
        .from('events')
        .select(_selectEvents)
        .neq('status', 'cancelado');
    if (cityId != null && cityId.isNotEmpty) {
      q = q.eq('city_id', cityId);
    }
    if (fromDate != null) {
      q = q.gte('starts_at', fromDate.toUtc().toIso8601String());
    }
    if (toDate != null) {
      q = q.lte('starts_at', toDate.toUtc().toIso8601String());
    }
    final rows = await q.order('starts_at', ascending: true).range(from, to);
    return rows.map((r) => EventItem.fromJson(_mapEvent(r))).toList();
  }

  Future<List<EventItem>> fetchAllAdmin() async {
    final rows = await _client
        .from('events')
        .select(_selectEvents)
        .order('starts_at', ascending: false);
    return rows.map((r) => EventItem.fromJson(_mapEvent(r))).toList();
  }

  Future<void> saveEvent(EventItem e) async {
    final json = e.toJson();
    json.remove('cityName');
    json.remove('cityRegion');
    json.remove('cityLatitude');
    json.remove('cityLongitude');
    if (e.id == null) {
      await _client.from('events').insert(json);
    } else {
      await _client.from('events').update(json).eq('id', e.id!);
    }
  }

  Future<void> deleteEvent(String id) async =>
      _client.from('events').delete().eq('id', id);

  Future<void> confirmRsvp(String id) async {
    await _client.rpc('confirm_rsvp', params: {'p_event_id': id});
  }

  Future<List<City>> fetchCities({String? search}) async {
    var q = _client.from('cities').select().eq('is_active', true);
    if (search != null && search.isNotEmpty) {
      q = q.ilike('name', '%$search%');
    }
    final rows = await q.order('name');
    return rows.map(City.fromJson).toList();
  }

  Future<List<City>> fetchAllCitiesAdmin() async {
    final rows = await _client.from('cities').select().order('name');
    return rows.map(City.fromJson).toList();
  }

  Future<void> saveCity(City c) async {
    if (c.id == null) {
      await _client.from('cities').insert(c.toJson());
    } else {
      await _client.from('cities').update(c.toJson()).eq('id', c.id!);
    }
  }

  Future<void> deleteCity(String id) async =>
      _client.from('cities').delete().eq('id', id);
}

/// Galeria + vídeos.
class MediaRepository {
  MediaRepository(this._client);

  final SupabaseClient _client;

  Future<List<GalleryItem>> fetchGallery({String? category, int from = 0, int to = 99}) async {
    var q = _client
        .from('gallery')
        .select()
        .eq('is_active', true);
    if (category != null && category.isNotEmpty && category != 'todas') {
      q = q.eq('category', category);
    }
    final rows = await q.order('sort_order').range(from, to);
    return rows.map(GalleryItem.fromJson).toList();
  }

  Future<void> saveGalleryItem(GalleryItem g) async {
    if (g.id == null) {
      await _client.from('gallery').insert(g.toJson());
    } else {
      await _client.from('gallery').update(g.toJson()).eq('id', g.id!);
    }
  }

  Future<void> deleteGalleryItem(String id) async =>
      _client.from('gallery').delete().eq('id', id);

  Future<List<VideoItem>> fetchVideos({String? category, int from = 0, int to = 99}) async {
    var q = _client.from('videos').select().eq('is_active', true);
    if (category != null && category.isNotEmpty && category != 'todas') {
      q = q.eq('category', category);
    }
    final rows = await q.order('created_at', ascending: false).range(from, to);
    return rows.map(VideoItem.fromJson).toList();
  }

  Future<void> incrementVideoViews(String id) async {
    await _client.rpc('increment_views', params: {'p_entity': 'video', 'p_id': id});
  }

  Future<void> saveVideo(VideoItem v) async {
    if (v.id == null) {
      await _client.from('videos').insert(v.toJson());
    } else {
      await _client.from('videos').update(v.toJson()).eq('id', v.id!);
    }
  }

  Future<void> deleteVideo(String id) async =>
      _client.from('videos').delete().eq('id', id);
}