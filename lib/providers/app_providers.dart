import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../repositories/agenda_repository.dart';
import '../repositories/content_repository.dart';
import '../repositories/engagement_repository.dart';
import '../repositories/institutional_repository.dart';
import '../repositories/participation_repository.dart';
import '../services/ibge_service.dart';
import '../services/supabase_service.dart';
import '../utils/formats.dart';

export '../services/supabase_service.dart';

final institutionalRepositoryProvider = Provider<InstitutionalRepository>(
  (ref) => InstitutionalRepository(ref.watch(supabaseProvider)),
);

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => NewsRepository(ref.watch(supabaseProvider)),
);

final planRepositoryProvider = Provider<PlanRepository>(
  (ref) => PlanRepository(ref.watch(supabaseProvider)),
);

final agendaRepositoryProvider = Provider<AgendaRepository>(
  (ref) => AgendaRepository(ref.watch(supabaseProvider)),
);

final mediaRepositoryProvider = Provider<MediaRepository>(
  (ref) => MediaRepository(ref.watch(supabaseProvider)),
);

final participationRepositoryProvider = Provider<ParticipationRepository>(
  (ref) => ParticipationRepository(ref.watch(supabaseProvider)),
);

final engagementRepositoryProvider = Provider<EngagementRepository>(
  (ref) => EngagementRepository(ref.watch(supabaseProvider)),
);

/// Configurações institucionais (textos oficiais do banco).
final settingsProvider = FutureProvider<Map<String, Map<String, dynamic>>>((ref) {
  return ref.watch(institutionalRepositoryProvider).fetchSettings();
});

final bannerProvider = FutureProvider<List<dynamic>>((ref) async {
  return ref.watch(institutionalRepositoryProvider).fetchBanners();
});

/// Busca global.
final globalSearchProvider =
    FutureProvider.family<List<dynamic>, String>((ref, term) async {
  if (term.trim().isEmpty) return const [];
  return ref.watch(institutionalRepositoryProvider).globalSearch(term);
});

/// Sessão do usuário autenticado.
final authStateProvider = StreamProvider<dynamic>((ref) {
  final client = ref.watch(supabaseProvider);
  return client.auth.onAuthStateChange.map((e) => e.session?.user);
});

final currentUserProvider = Provider((ref) {
  return ref.watch(authStateProvider).valueOrNull;
});

final myProfileProvider = FutureProvider<dynamic>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  return ref.watch(engagementRepositoryProvider).fetchMyProfile();
});

final newsProvider = FutureProvider<List<dynamic>>((ref) async {
  return ref.watch(newsRepositoryProvider).fetchNews(limit: 8);
});

final featuredNewsProvider = FutureProvider<dynamic>((ref) async {
  final items =
      await ref.watch(newsRepositoryProvider).fetchNews(featuredOnly: true, limit: 1);
  return items.isEmpty ? null : items.first;
});

final newsCategoriesProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(newsRepositoryProvider).fetchCategories();
});

final plansProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(planRepositoryProvider).fetchPlans();
});

final planCategoriesProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(planRepositoryProvider).fetchCategories();
});

final upcomingEventsProvider = FutureProvider<List<dynamic>>((ref) {
  return ref
      .watch(agendaRepositoryProvider)
      .fetchEvents(fromDate: DateTime.now().subtract(const Duration(days: 1)));
});

final citiesProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(agendaRepositoryProvider).fetchCities();
});

final galleryProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(mediaRepositoryProvider).fetchGallery();
});

final videosProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(mediaRepositoryProvider).fetchVideos();
});

final downloadsProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(institutionalRepositoryProvider).fetchDownloads();
});

final socialLinksProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(institutionalRepositoryProvider).fetchSocialLinks();
});

final campaignNumbersProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(institutionalRepositoryProvider).fetchNumbers();
});

final teamProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(institutionalRepositoryProvider).fetchTeam();
});

final testimonialsProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(institutionalRepositoryProvider).fetchTestimonials();
});

final faqProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(institutionalRepositoryProvider).fetchFaq();
});

final approvedReportsProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(participationRepositoryProvider).fetchApprovedReports();
});

/// 4 números da campanha (painel de transparência).
final transparencyNumbersProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(campaignNumbersProvider.future);
});

/// Seção de biografia (cadastrada pelo admin em settings.biography).
final biographyProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  return settings['biography'] ?? {};
});

/// Retrato oficial do candidato (cadastrado pelo admin em settings.hero).
/// Fallback: imagem padrão do design.
final portraitUrlProvider = FutureProvider<String>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  final hero = settings['hero'] ?? const {};
  final fromHero = (hero['portrait_url'] as String?)?.trim() ?? '';
  if (fromHero.isNotEmpty) return fromHero;
  final fromCampaign = (settings['campaign']?['portrait_url'] as String?)?.trim() ?? '';
  if (fromCampaign.isNotEmpty) return fromCampaign;
  return Env.defaultPortrait;
});

/// URL imediata do retrato (usada antes do Future completar).
final portraitUrlImmediateProvider = Provider<String>(
  (ref) => ref.watch(portraitUrlProvider).valueOrNull ?? Env.defaultPortrait,
);

/// Blocos da biografia (história, trajetória, família, valores, experiência).
final biographyItemsProvider = FutureProvider<List<BiographyItem>>((ref) {
  return ref.watch(institutionalRepositoryProvider).fetchBiographyItems();
});

/// IBGE — municípios oficiais da Bahia (417), com cache local.
final ibgeServiceProvider = Provider<IbgeService>((ref) => IbgeService());

final ibgeCitiesProvider = FutureProvider<List<String>>((ref) async {
  final cities = await ref.watch(ibgeServiceProvider).fetchBahiaMunicipalities();
  final names = [for (final c in cities) c.name].toSet().toList();
  names.sort((a, b) => Fmt.normPt(a).compareTo(Fmt.normPt(b)));
  return names;
});