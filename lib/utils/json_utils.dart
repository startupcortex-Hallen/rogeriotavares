/// Utilitários de conversão de dados vindos do Supabase.
library;

import 'dart:convert';

String? str(dynamic v) => v?.toString();

int intVal(dynamic v) =>
    v is int ? v : int.tryParse(v?.toString() ?? '') ?? 0;

double dblVal(dynamic v) =>
    v is double ? v : double.tryParse(v?.toString() ?? '') ?? 0;

bool boolVal(dynamic v) => v == true || v == 1 || v == 'true' || v == 't';

DateTime? dateVal(dynamic v) =>
    v == null ? null : DateTime.tryParse(v.toString())?.toLocal();

List<String> listStr(dynamic v) {
  if (v is List) return v.map((e) => e.toString()).toList();
  if (v is String) {
    final t = v.trim();
    if (t.isEmpty) return [];
    return t.substring(1, t.length - 1).split(',').map((e) => e.trim()).toList();
  }
  return [];
}

Map<String, dynamic> mapVal(dynamic v) {
  if (v is Map) return Map<String, dynamic>.from(v);
  if (v is String && v.isNotEmpty) {
    try {
      return Map<String, dynamic>.from(jsonDecode(v) as Map);
    } catch (_) {}
  }
  return {};
}