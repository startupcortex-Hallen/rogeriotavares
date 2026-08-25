import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/app_providers.dart';

/// Executa uma ação administrativa com tratamento de erro completo:
/// mensagem real no rodapé e, em caso de 401/403 (sessão inválida),
/// oferece sair e entrar novamente.
Future<bool> runAdminAction(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function() action, {
  String success = '',
}) async {
  try {
    await action();
    if (success.isNotEmpty && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success)));
    }
    return true;
  } catch (e) {
    if (!context.mounted) return false;
    if (_isSessionProblem(e)) {
      await _showSessionDialog(context, ref);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
    return false;
  }
}

bool _isSessionProblem(Object e) {
  if (e is StorageException) {
    return e.statusCode == 401 || e.statusCode == 403;
  }
  if (e is AuthException) return true;
  if (e is PostgrestException) {
    return (e.code ?? '').contains('401') || (e.code ?? '').contains('403');
  }
  final msg = e.toString().toLowerCase();
  return msg.contains('401') ||
      msg.contains('403') ||
      msg.contains('access denied') ||
      msg.contains('row-level security') ||
      msg.contains('token has expired');
}

Future<void> _showSessionDialog(BuildContext context, WidgetRef ref) async {
  final reenter = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.lock_clock_rounded, color: Color(0xFFAE2012)),
      title: const Text('Sessão expirada'),
      content: const Text(
          'Seu acesso expirou. Entre novamente para continuar editando o painel.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Agora não'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Entrar novamente'),
        ),
      ],
    ),
  );
  if (reenter == true && context.mounted) {
    await ref.read(supabaseProvider).auth.signOut();
    if (context.mounted) context.go('/admin/login');
  }
}

/// Garante sessão fresca ao abrir o painel (renova token expirado).
/// Se o refresh falhar, faz logout automático.
Future<void> ensureFreshSession(BuildContext context, WidgetRef ref) async {
  final client = ref.read(supabaseProvider);
  if (client.auth.currentUser == null) return;
  try {
    final res = await client.auth.refreshSession();
    if (res.session == null || context.mounted == false) {
      await client.auth.signOut();
      if (context.mounted) context.go('/admin/login');
    }
  } catch (_) {
    await client.auth.signOut();
    if (context.mounted) context.go('/admin/login');
  }
}