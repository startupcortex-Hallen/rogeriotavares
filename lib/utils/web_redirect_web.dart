import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// Lê (e apaga) o caminho salvo pela `web/404.html` do GitHub Pages.
///
/// No GitHub Pages, atualizar uma rota como `/noticias` responde 404.
/// O `404.html` guarda o caminho em `sessionStorage` e recarrega a raiz;
/// o app então navega direto para o caminho salvo, simulando a rota original.
String? pendingRedirectPath() {
  try {
    final storage = globalContext['localStorage'] as JSObject?;
    if (storage == null) return null;

    final stored = storage.callMethod<JSAny?>('getItem'.toJS, 'redirect_path'.toJS);
    if (stored == null) return null;

    storage.callMethod<JSAny?>('removeItem'.toJS, 'redirect_path'.toJS);

    final path = (stored.dartify() as String?) ?? '';
    if (path.isEmpty || path == '/') return null;
    return path;
  } catch (_) {
    return null;
  }
}