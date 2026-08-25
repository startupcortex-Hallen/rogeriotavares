import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/env.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// Chave global do Scaffold do shell — usada pelas páginas para abrir o drawer.
final GlobalKey<ScaffoldState> appScaffoldKey = GlobalKey<ScaffoldState>();

/// Itens do menu principal.
class MenuEntry {
  const MenuEntry(this.icon, this.label, {this.path, this.branchIndex});

  final IconData icon;
  final String label;
  final String? path;
  final int? branchIndex;
}

const kMainMenu = <MenuEntry>[
  MenuEntry(Icons.home_rounded, 'Home', branchIndex: 0),
  MenuEntry(Icons.person_outline_rounded, 'Quem é Rogério', path: '/biografia'),
  MenuEntry(Icons.description_outlined, 'Plano de Governo', branchIndex: 1),
  MenuEntry(Icons.newspaper_rounded, 'Notícias', branchIndex: 3),
  MenuEntry(Icons.event_rounded, 'Agenda', branchIndex: 2),
  MenuEntry(Icons.play_circle_outline_rounded, 'Vídeos', path: '/videos'),
  MenuEntry(Icons.map_outlined, 'Mapa da Bahia', path: '/mapa'),
  MenuEntry(Icons.volunteer_activism_outlined, 'Participe', path: '/participe'),
  MenuEntry(Icons.contact_page_outlined, 'Contato', path: '/contato'),
];

const kMoreMenu = <MenuEntry>[
  MenuEntry(Icons.chat_bubble_outline_rounded, 'Gabinete Digital', path: '/chat'),
  MenuEntry(Icons.campaign_outlined, 'Fale com Rogério', path: '/fale'),
  MenuEntry(Icons.download_outlined, 'Materiais Oficiais', path: '/downloads'),
  MenuEntry(Icons.share_outlined, 'Redes Sociais', path: '/redes'),
  MenuEntry(Icons.location_city_outlined, 'Demandas', path: '/demanda'),
];

/// Drawer institucional (logo + número + redes + tema).
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key, this.navigationShell, this.fixed = false});

  final StatefulNavigationShell? navigationShell;
  final bool fixed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final socials = ref.watch(socialLinksProvider).valueOrNull ?? [];
    final themeMode = ref.watch(themeModeProvider);
    final portrait = ref.watch(portraitUrlImmediateProvider);
    final profile = ref.watch(myProfileProvider).valueOrNull;
    final isTeam = profile != null &&
        (profile.role == 'admin' ||
            profile.role == 'moderator' ||
            profile.role == 'editor');

    void navigate(MenuEntry entry) {
      if (entry.branchIndex != null && navigationShell != null) {
        navigationShell!.goBranch(entry.branchIndex!, initialLocation: entry.branchIndex == 0);
      } else if (entry.path != null) {
        context.go(entry.path!);
      }
    }

    return Drawer(
      backgroundColor: p.surface,
      width: fixed ? 300 : null,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          children: [
            // Logo institucional
            Container(
              padding: const EdgeInsets.all(RtSpace.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [p.primary, p.primary.withValues(alpha: 0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  RtAvatar(name: Env.candidateName, imageUrl: portrait, size: 72),
                  const SizedBox(height: RtSpace.md),
                  Text(Env.candidateName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: p.onPrimary, fontWeight: FontWeight.w800)),
                  Text(Env.candidateRole,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.onPrimary.withValues(alpha: 0.9))),
                  const SizedBox(height: RtSpace.sm),
                  NumberBadge(color: p.accent, textColor: p.onSurface),
                  const SizedBox(height: RtSpace.sm),
                  Text('ELEIÇÕES ${Env.electionYear}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: p.onPrimary.withValues(alpha: 0.95), letterSpacing: 2)),
                ],
              ),
            ),
            const Divider(height: 1),
            // Menu
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: RtSpace.sm),
                children: [
                  for (final entry in kMainMenu)
                    _DrawerItem(
                      entry: entry,
                      active: _isActive(entry),
                      onTap: () => navigate(entry),
                    ),
                  if (isTeam) ...[
                    const Divider(height: RtSpace.lg),
                    _DrawerItem(
                      entry: const MenuEntry(
                        Icons.admin_panel_settings_rounded,
                        'Painel Admin',
                        path: '/admin',
                      ),
                      active: false,
                      onTap: () => context.go('/admin'),
                    ),
                  ],
                  const Divider(height: RtSpace.lg),
                  Text('MAIS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: p.hint, letterSpacing: 1.2),
                      ),
                  for (final entry in kMoreMenu)
                    _DrawerItem(entry: entry, active: false, onTap: () => navigate(entry)),
                ],
              ),
            ),
            // Redes + tema
            Container(
              padding: const EdgeInsets.all(RtSpace.md),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: p.divider))),
              child: Column(
                children: [
                  if (socials.isNotEmpty)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final s in socials.take(6))
                          IconButton(
                            tooltip: s.platform,
                            onPressed: () => ShareService.launch(s.url),
                            icon: Icon(ShareService.socialIcon(s.platform), color: p.secondaryText),
                          ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tema',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: p.secondaryText)),
                      IconButton(
                        onPressed: () {
                          final next = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                          ref.read(themeModeProvider.notifier).state = next;
                          ref.read(prefsProvider).valueOrNull?.setString('theme_mode', next.name);
                        },
                        icon: Icon(
                          themeMode == ThemeMode.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          color: p.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isActive(MenuEntry entry) {
    final shell = navigationShell;
    if (shell == null) return false;
    if (entry.branchIndex != null && shell.currentIndex == entry.branchIndex) return true;
    return false;
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.entry, required this.active, required this.onTap});

  final MenuEntry entry;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: 1),
      child: Material(
        color: active ? p.primary.withValues(alpha: 0.10) : Colors.transparent,
        borderRadius: BorderRadius.circular(RtRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(RtRadius.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm + 4),
            child: Row(
              children: [
                Icon(entry.icon, size: 22, color: active ? p.primary : p.secondaryText),
                const SizedBox(width: RtSpace.md),
                Text(entry.label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: active ? p.primary : p.onSurfaceVariant,
                          fontWeight: active ? FontWeight.w800 : FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shell responsivo do app.
/// Mobile: bottom navigation | Tablet: drawer | Desktop: menu lateral fixo.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 620;
    final isDesktop = width >= 1024;

    if (isMobile) {
      return Scaffold(
        key: appScaffoldKey,
        drawer: AppDrawer(navigationShell: navigationShell),
        body: navigationShell,
        bottomNavigationBar: _BottomNav(navigationShell: navigationShell),
      );
    }

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            SizedBox(width: 300, child: AppDrawer(navigationShell: navigationShell, fixed: true)),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      drawer: AppDrawer(navigationShell: navigationShell),
      body: navigationShell,
    );
  }
}

/// Bottom navigation mobile (Home, Plano, Agenda, Notícias, Perfil).
class _BottomNav extends ConsumerWidget {
  const _BottomNav({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.description_outlined), selectedIcon: Icon(Icons.description_rounded), label: 'Plano'),
        NavigationDestination(icon: Icon(Icons.event_outlined), selectedIcon: Icon(Icons.event_rounded), label: 'Agenda'),
        NavigationDestination(icon: Icon(Icons.newspaper_outlined), selectedIcon: Icon(Icons.newspaper_rounded), label: 'Notícias'),
        NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Perfil'),
      ],
    );
  }
}

/// Barra de topo para páginas internas (fora do shell).