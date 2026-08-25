import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Cliente Supabase inicializado no main.dart.
final supabaseProvider = Provider<SupabaseClient>((ref) => Supabase.instance.client);

/// ID anônimo do dispositivo (usado para chat e demandas sem login).
final deviceIdProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'device_id';
  final stored = prefs.getString(key);
  if (stored != null && stored.isNotEmpty) return stored;
  final rand = Random.secure();
  final id = List.generate(
    32,
    (_) => '0123456789abcdef'[rand.nextInt(16)],
  ).join();
  await prefs.setString(key, id);
  return id;
});

/// Preferências locais.
final prefsProvider = FutureProvider<SharedPreferences>(
  (ref) => SharedPreferences.getInstance(),
);

/// Modo de tema persistido (padrão: sistema).
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final stored = ref.watch(prefsProvider).valueOrNull?.getString('theme_mode');
  return switch (stored) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
});