import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Volta para a tela anterior; se não houver histórico (páginas abertas
/// por `go`), volta para a Home — nunca mais "botão que não funciona".
void goBack(BuildContext context, {String fallback = '/'}) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(fallback);
  }
}

/// Ícone de voltar reutilizável (estilo discreto).
Widget backButton(BuildContext context, {VoidCallback? onPressed}) {
  return IconButton(
    onPressed: onPressed ?? () => goBack(context),
    icon: const Icon(Icons.arrow_back_rounded),
    tooltip: 'Voltar',
  );
}