// Conditional import: em Web usa a implementação real (sessionStorage),
// nas demais plataformas a stub retorna null e nada é alterado.
export 'web_redirect_stub.dart'
    if (dart.library.js_interop) 'web_redirect_web.dart';