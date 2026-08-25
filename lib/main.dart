import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/env.dart';
import 'providers/app_providers.dart';
import 'routes/app_router.dart';
import 'services/realtime_service.dart';
import 'theme/app_theme.dart';
import 'utils/formats.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // Datas e moeda em pt-BR (obrigatório antes de qualquer DateFormat)
  await Fmt.init();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  runApp(const ProviderScope(child: RogerioApp()));
}

class RogerioApp extends ConsumerStatefulWidget {
  const RogerioApp({super.key});

  @override
  ConsumerState<RogerioApp> createState() => _RogerioAppState();
}

class _RogerioAppState extends ConsumerState<RogerioApp> with WidgetsBindingObserver {
  final _realtime = RealtimeService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Assina mudanças do Supabase: admin publica → app atualiza na hora.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final container = ProviderScope.containerOf(context);
      _realtime.start(container);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _realtime.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    // Garantia de conteúdo fresco ao voltar ao app: o realtime só emite
    // eventos para tabelas da publicação supabase_realtime no banco.
    // Sem ela, invalida-se aqui para refletir edições/exclusões do painel.
    final container = ProviderScope.containerOf(context);
    for (final provider in [
      bannerProvider,
      newsProvider,
      plansProvider,
      upcomingEventsProvider,
      galleryProvider,
      videosProvider,
      downloadsProvider,
      socialLinksProvider,
      biographyItemsProvider,
      campaignNumbersProvider,
      settingsProvider,
      portraitUrlProvider,
      planCategoriesProvider,
      teamProvider,
    ]) {
      container.invalidate(provider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Rogério Tavares 45788',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
        },
      ),
    );
  }
}