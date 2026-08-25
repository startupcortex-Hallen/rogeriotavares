import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

/// Engajamento: likes, favoritos, comentários, notificações, perfis e dashboard.
class EngagementRepository {
  EngagementRepository(this._client);

  final SupabaseClient _client;

  Future<void> toggleLike(String targetType, String targetId) async {
    await _client.rpc('toggle_like', params: {'p_target_type': targetType, 'p_target_id': targetId});
  }

  Future<void> toggleFavorite(String targetType, String targetId) async {
    await _client.rpc('toggle_favorite', params: {'p_target_type': targetType, 'p_target_id': targetId});
  }

  Future<Set<String>> myLikes(String targetType) async {
    final rows = await _client
        .from('likes')
        .select('target_id')
        .eq('user_id', _client.auth.currentUser?.id ?? '-')
        .eq('target_type', targetType);
    return rows.map((r) => r['target_id'].toString()).toSet();
  }

  Future<Set<String>> myFavorites(String targetType) async {
    final rows = await _client
        .from('favorites')
        .select('target_id')
        .eq('user_id', _client.auth.currentUser?.id ?? '-')
        .eq('target_type', targetType);
    return rows.map((r) => r['target_id'].toString()).toSet();
  }

  Future<void> addComment({
    required String targetType,
    required String targetId,
    required String content,
    String? fullName,
  }) async {
    await _client.from('comments').insert({
      'user_id': _client.auth.currentUser?.id,
      'full_name': fullName ?? _client.auth.currentUser?.email,
      'target_type': targetType,
      'target_id': targetId,
      'content': content,
    });
  }

  Future<List<CommentItem>> fetchComments(String targetType, String targetId) async {
    final rows = await _client
        .from('v_comments')
        .select()
        .eq('target_type', targetType)
        .eq('target_id', targetId)
        .eq('is_approved', true)
        .order('created_at', ascending: false);
    return rows.map(CommentItem.fromJson).toList();
  }

  Future<void> deleteComment(String id) async =>
      _client.from('comments').delete().eq('id', id);

  // ---- Notificações ----
  Future<List<NotificationItem>> fetchNotifications() async {
    var q = _client.from('notifications').select().eq('is_active', true);
    final uid = _client.auth.currentUser?.id;
    if (uid != null) {
      q = q.or('user_id.is.null,user_id.eq.$uid');
    } else {
      q = q.isFilter('user_id', null);
    }
    final rows = await q.order('sent_at', ascending: false).limit(50);
    return rows.map(NotificationItem.fromJson).toList();
  }

  Future<void> markNotificationRead(String id) async =>
      _client.from('notifications').update({'is_read': true}).eq('id', id);

  Future<void> sendNotification({
    String? userId,
    required String title,
    String body = '',
    String? city,
  }) async {
    await _client.from('notifications').insert({
      'user_id': userId,
      'title': title,
      'body': body,
      'city': city ?? '',
      'channel': 'in_app',
    });
  }

  Future<int> unreadNotifications() async {
    final rows = await _client
        .from('notifications')
        .select('id')
        .eq('is_read', false)
        .isFilter('user_id', null);
    return rows.length;
  }

  // ---- Perfis / admin ----
  Future<Profile?> fetchMyProfile() async {
    final uid = _client.auth.currentUser?.id;
    if (uid == null) return null;
    final rows = await _client.from('profiles').select().eq('id', uid).limit(1);
    if (rows.isEmpty) return null;
    return Profile.fromJson(rows.first);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final uid = _client.auth.currentUser?.id;
    if (uid == null) return;
    await _client.from('profiles').update(data).eq('id', uid);
  }

  Future<List<Profile>> fetchProfiles() async {
    final rows = await _client.from('profiles').select().order('created_at', ascending: false);
    return rows.map(Profile.fromJson).toList();
  }

  Future<Profile?> fetchProfileByEmail(String email) async {
    final rows = await _client.from('profiles').select().eq('email', email).limit(1);
    if (rows.isEmpty) return null;
    return Profile.fromJson(rows.first);
  }

  Future<DashboardCounts> fetchDashboardCounts() async {
    final rows = await _client.from('v_dashboard_counts').select().limit(1);
    if (rows.isEmpty) return const DashboardCounts();
    return DashboardCounts.fromJson(rows.first);
  }

  Future<List<Map<String, dynamic>>> fetchAuditLog() async {
    return _client
        .from('admin_audit_log')
        .select()
        .order('created_at', ascending: false)
        .limit(100);
  }

  Future<void> logAudit({
    required String action,
    required String entity,
    String? entityId,
    Map<String, dynamic>? details,
  }) async {
    try {
      await _client.from('admin_audit_log').insert({
        'admin_id': _client.auth.currentUser?.id,
        'admin_email': _client.auth.currentUser?.email,
        'action': action,
        'entity': entity,
        'entity_id': entityId,
        'details': details ?? {},
      });
    } catch (_) {}
  }
}