import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'admin_utils.dart';

/// Shell do painel administrativo — menu lateral + conteúdo.
class AdminShell extends ConsumerStatefulWidget {
  const AdminShell({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends ConsumerState<AdminShell> {
  @override
  void initState() {
    super.initState();
    // Renova o token de sessão ao abrir o painel (corrige 403 por sessão velha).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ensureFreshSession(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final profile = ref.watch(myProfileProvider).valueOrNull;
    final isAdmin = profile?.isAdmin == true;

    return Scaffold(
      backgroundColor: p.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 900;

          final content = Padding(
            padding: EdgeInsets.all(compact ? RtSpace.md : RtSpace.lg),
            child: widget.child,
          );
          if (compact) {
            return Column(
              children: [
                _AdminTopBar(isAdmin: isAdmin),
                Expanded(child: content),
                SafeArea(top: false, child: _AdminBottomBar()),
              ],
            );
          }
          return Row(
            children: [
              SizedBox(width: 260, child: _AdminTopBar(isAdmin: isAdmin, vertical: true)),
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }
}

class _AdminTopBar extends ConsumerWidget {
  const _AdminTopBar({required this.isAdmin, this.vertical = false});

  final bool isAdmin;
  final bool vertical;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final user = ref.watch(currentUserProvider);
    final session = user != null
        ? (user.email ?? 'sessão ativa')
        : '⚠️ Sessão expirada — saia e entre novamente';

    final logo = Row(
      spacing: RtSpace.sm,
      children: [
        Container(
          padding: const EdgeInsets.all(RtSpace.sm),
          decoration: BoxDecoration(
            color: p.primary,
            borderRadius: BorderRadius.circular(RtRadius.md),
          ),
          child: const Icon(Icons.admin_panel_settings_rounded, color: Colors.white),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Painel 45788',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
              Text(
                user != null ? 'Admin • $session' : session,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: user != null ? p.hint : p.error,
                      fontWeight: user != null ? FontWeight.w400 : FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Ver site',
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.open_in_new_rounded, size: 18),
        ),
        IconButton(
          tooltip: 'Sair',
          onPressed: () async {
            await ref.read(supabaseProvider).auth.signOut();
            if (context.mounted) context.go('/admin/login');
          },
          icon: const Icon(Icons.logout_rounded, size: 18),
        ),
      ],
    );

    if (!vertical) {
      return Container(
        padding: const EdgeInsets.all(RtSpace.md),
        decoration: BoxDecoration(
          color: p.surface,
          border: Border(bottom: BorderSide(color: p.divider)),
        ),
        child: logo,
      );
    }

    return Container(
      width: 260,
      padding: const EdgeInsets.all(RtSpace.md),
      decoration: BoxDecoration(
        color: p.surface,
        border: Border(right: BorderSide(color: p.divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          logo,
          const SizedBox(height: RtSpace.lg),
          Text('MENU',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint, letterSpacing: 1.5)),
          const SizedBox(height: RtSpace.sm),
          for (final item in _navItems(isAdmin))
            _AdminNavTile(
              item: item,
              onTap: () => context.go(item.path),
            ),
          const Spacer(),
          Text(
            'Rogério Tavares 45788',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint),
          ),
        ],
      ),
    );
  }
}

class _AdminBottomBar extends ConsumerWidget {
  const _AdminBottomBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final profile = ref.watch(myProfileProvider).valueOrNull;
    final isAdmin = profile?.isAdmin == true;
    final items = _navItems(isAdmin).take(5).toList();

    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        border: Border(top: BorderSide(color: p.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final item in items)
            IconButton(
              tooltip: item.label,
              onPressed: () => context.go(item.path),
              icon: Icon(item.icon, size: 20),
            ),
        ],
      ),
    );
  }
}

class _AdminNavTile extends StatelessWidget {
  const _AdminNavTile({required this.item, required this.onTap});

  final _NavItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final selected = GoRouterState.of(context).matchedLocation == item.path;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: selected ? p.primary.withValues(alpha: 0.10) : Colors.transparent,
        borderRadius: BorderRadius.circular(RtRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(RtRadius.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: 10),
            child: Row(
              children: [
                Icon(item.icon, size: 20, color: selected ? p.primary : p.secondaryText),
                const SizedBox(width: RtSpace.md),
                Expanded(
                  child: Text(item.label,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: selected ? p.primary : p.onSurfaceVariant,
                            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                          )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label, this.path);

  final IconData icon;
  final String label;
  final String path;
}

List<_NavItem> _navItems(bool isAdmin) => [
      const _NavItem(Icons.dashboard_rounded, 'Dashboard', '/admin'),
      const _NavItem(Icons.newspaper_rounded, 'Notícias', '/admin/noticias'),
      const _NavItem(Icons.description_rounded, 'Plano de Governo', '/admin/plano'),
      const _NavItem(Icons.event_rounded, 'Agenda', '/admin/agenda'),
      const _NavItem(Icons.location_city_rounded, 'Cidades', '/admin/cidades'),
      const _NavItem(Icons.photo_library_rounded, 'Galeria', '/admin/galeria'),
      const _NavItem(Icons.play_circle_rounded, 'Vídeos', '/admin/videos'),
      const _NavItem(Icons.volunteer_activism_rounded, 'Voluntários', '/admin/voluntarios'),
      const _NavItem(Icons.mail_rounded, 'Mensagens', '/admin/mensagens'),
      const _NavItem(Icons.comment_rounded, 'Comentários', '/admin/comentarios'),
      const _NavItem(Icons.warning_amber_rounded, 'Demandas', '/admin/demandas'),
      const _NavItem(Icons.download_rounded, 'Materiais', '/admin/downloads'),
      const _NavItem(Icons.share_rounded, 'Redes Sociais', '/admin/redes'),
      const _NavItem(Icons.person_rounded, 'Biografia (Quem é Rogério)', '/admin/biografia'),
      const _NavItem(Icons.group_rounded, 'Usuários & Papéis', '/admin/usuarios'),
      const _NavItem(Icons.category_rounded, 'Conteúdo & Config', '/admin/conteudo'),
      const _NavItem(Icons.notifications_rounded, 'Notificações', '/admin/notificacoes'),
      const _NavItem(Icons.settings_rounded, 'Configurações', '/admin/configuracoes'),
      const _NavItem(Icons.person_rounded, 'Minha Conta', '/admin/conta'),
    ];