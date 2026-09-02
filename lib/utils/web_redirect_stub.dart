/// Lê (e apaga) o caminho salvo pela `web/404.html` do GitHub Pages.
///
/// No GitHub Pages, atualizar uma rota como `/noticias` responde 404.
/// O `404.html` guarda o caminho em `sessionStorage` e recarrega a raiz;
/// o app então navega direto para o caminho salvo, simulando a rota original.
String? pendingRedirectPath() => null;