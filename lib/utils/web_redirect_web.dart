import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// Lê (e apaga) o caminho salvo pela `web/404.html` do GitHub Pages.
///
/// No GitHub Pages, atualizar uma rota como `/noticias` responde 404.
/// O `404.html` guarda o caminho em `sessionStorage` e redireciona para a raiz
/// do app; aqui o caminho é convertido para uma rota do app (removendo o
/// prefixo do deploy, ex.: `/rogeriotavares/noticias` → `/noticias`) e o
/// GoRouter navega direto para ela.
String? pendingRedirectPath() {
  try {
    final storage = globalContext['localStorage'] as JSObject?;
    if (storage == null) return null;

    final stored = storage.callMethod<JSAny?>('getItem'.toJS, 'redirect_path'.toJS);
    if (stored == null) return null;

    storage.callMethod<JSAny?>('removeItem'.toJS, 'redirect_path'.toJS);

    final path = (stored.dartify() as String?) ?? '';
    if (path.isEmpty || path == '/') return null;

    // Remove o prefixo do deploy (base href) — funciona no endereço padrão
    // github.io/rogeriotavares e no domínio próprio na raiz.
    final document = globalContext['document'] as JSObject?;
    if (document != null) {
      final base = document.getProperty<JSAny?>('baseURI'.toJS);
      if (base != null) {
        final basePath =
            Uri.tryParse((base.dartify() as String?) ?? '')?.path ?? '';
        if (basePath.isNotEmpty && basePath != '/' && path.startsWith(basePath)) {
          return path.substring(basePath.length - 1);
        }
      }
    }
    return path;
  } catch (_) {
    return null;
  }
}