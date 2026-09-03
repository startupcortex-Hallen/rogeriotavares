import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

/// Participação popular: voluntários, mensagens (form + chat) e demandas.
class ParticipationRepository {
  ParticipationRepository(this._client);

  final SupabaseClient _client;

  Future<void> sendVolunteer(VolunteerRequest v) async {
    await _client.from('volunteers').insert(v.toJson());
  }

  Future<List<VolunteerRequest>> fetchVolunteers({String? status}) async {
    var q = _client.from('volunteers').select();
    if (status != null && status.isNotEmpty) {
      q = q.eq('status', status);
    }
    final rows = await q.order('created_at', ascending: false);
    return rows.map(VolunteerRequest.fromJson).toList();
  }

  Future<void> updateVolunteerStatus(String id, String status) async {
    await _client.from('volunteers').update({'status': status}).eq('id', id);
  }

  Future<void> deleteVolunteer(String id) async =>
      _client.from('volunteers').delete().eq('id', id);

  // ---------------- MESSAGES ----------------

  Future<void> sendMessage(MessageItem m) async {
    await _client.from('messages').insert(m.toJson());
  }

  Future<List<MessageItem>> fetchMessages({String? channel}) async {
    var q = _client.from('messages').select();
    if (channel != null && channel.isNotEmpty) {
      q = q.eq('channel', channel);
    }
    final rows = await q.order('created_at', ascending: false);
    return rows.map(MessageItem.fromJson).toList();
  }

  Future<List<MessageItem>> fetchConversation(String conversationId) async {
    final rows = await _client
        .from('messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true);
    return rows.map(MessageItem.fromJson).toList();
  }

  Future<void> markMessageRead(String id) async {
    await _client.from('messages').update({'is_read': true}).eq('id', id);
  }

  Future<void> updateMessageStatus(String id, String status) async {
    await _client.from('messages').update({'status': status}).eq('id', id);
  }

  Future<void> deleteMessage(String id) async =>
      _client.from('messages').delete().eq('id', id);

  // ---------------- REPORTS (demandas) ----------------

  Future<void> sendReport(ReportItem r) async {
    await _client.from('reports').insert(r.toJson());
  }

  Future<List<ReportItem>> fetchReports({String? status}) async {
    var q = _client
        .from('reports')
        .select();
    if (status != null && status.isNotEmpty) {
      q = q.eq('status', status);
    }
    final rows = await q.order('created_at', ascending: false);
    return rows.map(ReportItem.fromJson).toList();
  }

  /// Demandas aprovadas — exibidas no mapa público.
  Future<List<ReportItem>> fetchApprovedReports() async {
    final rows = await _client
        .from('v_reports_approved')
        .select()
        .order('created_at', ascending: false);
    return rows.map(ReportItem.fromJson).toList();
  }

  Future<void> updateReportStatus(String id, String status, {String? adminNote}) async {
    await _client.from('reports').update({
      'status': status,
      if (adminNote != null) 'admin_note': adminNote,
    }).eq('id', id);
  }

  /// Grava uma nota interna/visível em uma demanda (sem mudar o status).
  Future<void> updateReportNote(String id, String note) async {
    await _client.from('reports').update({'admin_note': note}).eq('id', id);
  }

  Future<void> deleteReport(String id) async =>
      _client.from('reports').delete().eq('id', id);
}