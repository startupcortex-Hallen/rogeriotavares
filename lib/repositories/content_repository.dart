import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

/// Central de notícias + categorias.
class NewsRepository {
  NewsRepository(this._client);

  final SupabaseClient _client;

  static const _select =
      '*, news_categories(name, color, icon, id)';

  Map<String, dynamic> _map(dynamic row) {
    final m = Map<String, dynamic>.from(row as Map);
    final cat = m['news_categories'];
    if (cat is Map) {
      m.remove('news_categories');
      m['categoryName'] = cat['name'];
      m['categoryColor'] = cat['color'];
      m['categoryIcon'] = cat['icon'];
      m['categoryId'] = cat['id'];
    } else if (cat == null) {
      m.remove('news_categories');
    }
    return m;
  }

  Future<List<NewsItem>> fetchNews({
    String? categoryId,
    String? search,
    bool featuredOnly = false,
    int? limit,
    int from = 0,
    int to = 49,
  }) async {
    var q = _client
        .from('news')
        .select(_select)
        .eq('status', 'published');
    if (categoryId != null && categoryId.isNotEmpty) {
      q = q.eq('category_id', categoryId);
    }
    if (search != null && search.isNotEmpty) {
      q = q.ilike('title', '%$search%');
    }
    if (featuredOnly) {
      q = q.eq('is_featured', true);
    }
    final rows = await q.order('published_at', ascending: false).range(from, to);
    return rows.map((r) => NewsItem.fromJson(_map(r))).toList();
  }

  Future<NewsItem?> fetchNewsBySlug(String slug) async {
    final rows = await _client
        .from('news')
        .select(_select)
        .eq('slug', slug)
        .eq('status', 'published')
        .limit(1);
    if (rows.isEmpty) return null;
    return NewsItem.fromJson(_map(rows.first));
  }

  Future<void> incrementViews(String id) async {
    await _client.rpc('increment_views', params: {'p_entity': 'news', 'p_id': id});
  }

  Future<List<NewsItem>> fetchAllAdmin({String? search}) async {
    var q = _client.from('news').select(_select);
    if (search != null && search.isNotEmpty) {
      q = q.ilike('title', '%$search%');
    }
    final rows = await q.order('created_at', ascending: false);
    return rows.map((r) => NewsItem.fromJson(_map(r))).toList();
  }

  Future<void> save(NewsItem item) async {
    final json = item.toJson();
    json.remove('categoryName');
    json.remove('categoryColor');
    json.remove('categoryIcon');
    json.remove('createdAt');
    json.remove('updatedAt');
    if (item.id == null) {
      await _client.from('news').insert(json);
    } else {
      await _client.from('news').update(json).eq('id', item.id!);
    }
  }

  Future<void> delete(String id) async =>
      _client.from('news').delete().eq('id', id);

  Future<List<NewsCategory>> fetchCategories() async {
    final rows = await _client
        .from('news_categories')
        .select()
        .eq('is_active', true)
        .order('sort_order');
    return rows.map(NewsCategory.fromJson).toList();
  }

  Future<void> saveCategory(NewsCategory c) async {
    if (c.id == null) {
      await _client.from('news_categories').insert(c.toJson());
    } else {
      await _client.from('news_categories').update(c.toJson()).eq('id', c.id!);
    }
  }

  Future<void> deleteCategory(String id) async =>
      _client.from('news_categories').delete().eq('id', id);
}

/// Plano de governo + categorias.
class PlanRepository {
  PlanRepository(this._client);

  final SupabaseClient _client;

  static const _select = '*, plan_categories(name, icon, color, id)';

  Map<String, dynamic> _map(dynamic row) {
    final m = Map<String, dynamic>.from(row as Map);
    final cat = m['plan_categories'];
    if (cat is Map) {
      m.remove('plan_categories');
      m['categoryName'] = cat['name'];
      m['categoryIcon'] = cat['icon'];
      m['categoryColor'] = cat['color'];
      m['categoryId'] = cat['id'];
    } else if (cat == null) {
      m.remove('plan_categories');
    }
    return m;
  }

  Future<List<GovernmentPlan>> fetchPlans({
    String? categoryId,
    String? search,
    int from = 0,
    int to = 49,
  }) async {
    var q = _client
        .from('government_plan')
        .select(_select)
        .eq('is_active', true);
    if (categoryId != null && categoryId.isNotEmpty) {
      q = q.eq('category_id', categoryId);
    }
    if (search != null && search.isNotEmpty) {
      q = q.ilike('title', '%$search%');
    }
    final rows = await q.order('sort_order').range(from, to);
    return rows.map((r) => GovernmentPlan.fromJson(_map(r))).toList();
  }

  Future<GovernmentPlan?> fetchBySlug(String slug) async {
    final rows = await _client
        .from('government_plan')
        .select(_select)
        .eq('slug', slug)
        .eq('is_active', true)
        .limit(1);
    if (rows.isEmpty) return null;
    return GovernmentPlan.fromJson(_map(rows.first));
  }

  Future<List<GovernmentPlan>> fetchAllAdmin() async {
    final rows =
        await _client.from('government_plan').select(_select).order('sort_order');
    return rows.map((r) => GovernmentPlan.fromJson(_map(r))).toList();
  }

  Future<void> save(GovernmentPlan plan) async {
    final json = plan.toJson();
    json.remove('categoryName');
    json.remove('categoryIcon');
    json.remove('categoryColor');
    if (plan.id == null) {
      await _client.from('government_plan').insert(json);
    } else {
      await _client.from('government_plan').update(json).eq('id', plan.id!);
    }
  }

  Future<void> delete(String id) async =>
      _client.from('government_plan').delete().eq('id', id);

  Future<List<PlanCategory>> fetchCategories() async {
    final rows = await _client
        .from('plan_categories')
        .select()
        .eq('is_active', true)
        .order('sort_order');
    return rows.map(PlanCategory.fromJson).toList();
  }

  Future<void> saveCategory(PlanCategory c) async {
    if (c.id == null) {
      await _client.from('plan_categories').insert(c.toJson());
    } else {
      await _client.from('plan_categories').update(c.toJson()).eq('id', c.id!);
    }
  }

  Future<void> deleteCategory(String id) async =>
      _client.from('plan_categories').delete().eq('id', id);
}