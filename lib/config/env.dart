/// Configuração central do aplicativo.
///
/// Ao comprar o domínio, troque [kSiteDomain] — o resto do app se ajusta
/// (SEO, canonical, sitemap, manifest, compartilhamento, JSON-LD).
library;

abstract final class Env {
  static const String supabaseUrl = 'https://hpubrzclxyhlodtmigrv.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhwdWJyemNseHlobG9kdG1pZ3J2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODczMzY1NDEsImV4cCI6MjEwMjkxMjU0MX0.oX5HKjmQpMAQpb4VjM_ZSbeAbNHovfYd6IyLyxAuEnc';

  /// Número oficial da campanha.
  static const String campaignNumber = '45788';

  /// Candidato.
  static const String candidateName = 'Rogério Tavares';

  /// Papel oficial.
  static const String candidateRole = 'Candidato a Deputado Estadual';

  /// Estado da campanha.
  static const String candidateState = 'Bahia';

  /// Ano eleitoral.
  static const int electionYear = 2026;

  /// DOMÍNIO DO SITE — usado nos links compartilhados (share).
  static const String kSiteDomain = 'https://www.rogeriotavares.com.br';

  /// Imagem oficial de retrato (design).
  static const String defaultPortrait =
      'https://dimg.dreamflow.cloud/v1/image/Rog%C3%A9rio+Tavares+portrait';

  /// URL pública de um arquivo do storage do Supabase.
  static String storageUrl(String bucket, String path) {
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '$supabaseUrl/storage/v1/object/public/$bucket/$cleanPath';
  }
}