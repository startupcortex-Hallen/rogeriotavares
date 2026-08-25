import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Município da Bahia (IBGE).
class IbgeCity {
  const IbgeCity({required this.id, required this.name});

  final int id;
  final String name;

  factory IbgeCity.fromJson(Map<String, dynamic> json) =>
      IbgeCity(id: json['id'] as int, name: json['nome'] as String);
}

/// API pública oficial do IBGE — municípios da Bahia (417).
/// Faz cache local (SharedPreferences) após a primeira consulta.
class IbgeService {
  static const _endpoint =
      'https://servicodados.ibge.gov.br/api/v1/localidades/estados/BA/municipios';
  static const _cacheKey = 'ibge_bahia_municipios';

  Future<List<IbgeCity>> fetchBahiaMunicipalities() async {
    final prefs = await SharedPreferences.getInstance();

    final cached = prefs.getString(_cacheKey);
    if (cached != null && cached.isNotEmpty) {
      final list = (jsonDecode(cached) as List)
          .map((e) => IbgeCity.fromJson(e as Map<String, dynamic>))
          .toList();
      if (list.isNotEmpty) return list;
    }

    final res = await http
        .get(Uri.parse(_endpoint))
        .timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) {
      throw Exception('IBGE indisponível (HTTP ${res.statusCode})');
    }
    final cities = (jsonDecode(res.body) as List)
        .map((e) => IbgeCity.fromJson(e as Map<String, dynamic>))
        .toList();
    await prefs.setString(
        _cacheKey, jsonEncode([for (final c in cities) {'id': c.id, 'nome': c.name}]));
    return cities;
  }
}