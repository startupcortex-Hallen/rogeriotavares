import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/env.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../routes/app_shell.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// PERFIL — conta, favoritos, notificações, configurações e acesso admin.
class PerfilPage extends ConsumerWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final user = ref.watch(currentUserProvider);
    final profileAsync = ref.watch(myProfileProvider);
    final profile = profileAsync.valueOrNull;
    final socials = ref.watch(socialLinksProvider).valueOrNull ?? [];
    final themeMode = ref.watch(themeModeProvider);
    final portrait = ref.watch(portraitUrlImmediateProvider);
    final avatarUrl = (profile?.avatarUrl != null && profile!.avatarUrl.isNotEmpty)
        ? profile.avatarUrl
        : portrait;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Cabeçalho institucional
          Container(
            color: p.secondaryBackground,
            padding: const EdgeInsets.fromLTRB(RtSpace.lg, RtSpace.xl, RtSpace.lg, RtSpace.md),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: RtSpace.xs,
                    children: [
                      Text('Deputado Estadual',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: p.secondaryText)),
                      Text('Rogério Tavares',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),
                NumberBadge(),
              ],
            ),
          ),
          // Card de conta
          Padding(
            padding: const EdgeInsets.all(RtSpace.lg),
            child: Material(
              color: p.surface,
              borderRadius: BorderRadius.circular(RtRadius.xl),
              child: Container(
                padding: const EdgeInsets.all(RtSpace.lg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RtRadius.xl),
                  border: Border.all(color: p.outline),
                ),
                child: Row(
                  children: [
                    RtAvatar(
                      name: profile?.fullName ?? 'Visitante',
                      imageUrl: avatarUrl,
                      size: 64,
                    ),
                    const SizedBox(width: RtSpace.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user == null ? 'Visitante' : (profile?.fullName ?? user.email ?? 'Usuário'),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          Text(
                            user == null
                                ? 'Entre para curtir, comentar e salvar conteúdos'
                                : (profile?.role?.toUpperCase() ?? 'USUÁRIO'),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText),
                          ),
                        ],
                      ),
                    ),
                    if (user == null)
                      RtButton(
                        label: 'Entrar',
                        variant: 'outline',
                        onPressed: () => _showAuthSheet(context, ref),
                      )
                    else
                      IconButton(
                        onPressed: () => _showAuthSheet(context, ref),
                        icon: const Icon(Icons.logout_rounded),
                        tooltip: 'Sair / trocar conta',
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Menu principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: RtSpace.xs,
              children: [
                Text('Menu Principal',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: p.hint)),
                const SizedBox(height: RtSpace.xs),
                for (final entry in kMainMenu)
                  _ListTile(
                    icon: entry.icon,
                    label: entry.label,
                    path: entry.path ?? _branchPath(entry.branchIndex),
                  ),
              ],
            ),
          ),
          // Transparência (frame 5)
          Padding(
            padding: const EdgeInsets.all(RtSpace.lg),
            child: Material(
              color: p.surface,
              borderRadius: BorderRadius.circular(RtRadius.lg),
              child: InkWell(
                onTap: () => context.go('/transparencia'),
                borderRadius: BorderRadius.circular(RtRadius.lg),
                child: Container(
                  padding: const EdgeInsets.all(RtSpace.md),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(RtRadius.lg),
                    border: Border.all(color: p.outline),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.insights_rounded, color: Color(0xFF1565C0)),
                      const SizedBox(width: RtSpace.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Transparência e Dados',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                            Text('Acompanhe recursos, indicadores e compromissos da campanha 45788.',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Configurações
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: RtSpace.xs,
              children: [
                Text('Configurações',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: p.hint)),
                const SizedBox(height: RtSpace.xs),
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(
                        secondary: Icon(themeMode == ThemeMode.dark
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded),
                        title: const Text('Modo escuro'),
                        value: themeMode == ThemeMode.dark,
                        onChanged: (v) {
                          final next = v ? ThemeMode.dark : ThemeMode.light;
                          ref.read(themeModeProvider.notifier).state = next;
                          ref.read(prefsProvider).valueOrNull?.setString('theme_mode', next.name);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.palette_outlined),
                        title: const Text('Tema do sistema'),
                        subtitle: const Text('Seguir o tema do dispositivo'),
                        trailing: Switch(
                          value: themeMode == ThemeMode.system,
                          onChanged: (v) {
                            ref.read(themeModeProvider.notifier).state =
                                v ? ThemeMode.system : ThemeMode.light;
                            ref.read(prefsProvider).valueOrNull?.setString(
                                'theme_mode', (v ? ThemeMode.system : ThemeMode.light).name);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Notificações e favoritos
          Padding(
            padding: const EdgeInsets.all(RtSpace.lg),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: const Text('Notificações'),
                    subtitle: const Text('Avisos oficiais da campanha'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showNotifications(context, ref),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.favorite_outline_rounded),
                    title: const Text('Meus favoritos'),
                    subtitle: const Text('Conteúdos que você salvou'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showFavorites(context, ref),
                  ),
                ],
              ),
            ),
          ),
          // Acesso admin
          if (profile != null && (profile.role == 'admin' || profile.role == 'moderator' || profile.role == 'editor'))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
              child: Card(
                color: p.primary.withValues(alpha: 0.08),
                child: ListTile(
                  leading: const Icon(Icons.admin_panel_settings_rounded, color: Color(0xFF1565C0)),
                  title: const Text('Painel Administrativo'),
                  subtitle: const Text('Gerenciar conteúdo, uploads e aprovações'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.go('/admin'),
                ),
              ),
            ),
          // Redes
          if (socials.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(RtSpace.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final s in socials)
                    IconButton(
                      onPressed: () => ShareService.launch(s.url),
                      icon: Icon(ShareService.socialIcon(s.platform), color: p.secondaryText),
                    ),
                ],
              ),
            ),
          const SizedBox(height: RtSpace.xl),
          Center(
            child: Text(
              'Rogério Tavares ${Env.campaignNumber} • Eleições ${Env.electionYear}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint),
            ),
          ),
          const SizedBox(height: RtSpace.xl),
        ],
      ),
    );
  }
}

/// Rota equivalente de um branch da navegação inferior.
String _branchPath(int? branchIndex) {
  switch (branchIndex) {
    case 0:
      return '/';
    case 1:
      return '/plano';
    case 2:
      return '/agenda';
    case 3:
      return '/noticias';
  }
  return '/';
}

/// Item de linha do menu principal (Perfil).
class _ListTile extends StatelessWidget {
  const _ListTile({required this.icon, required this.label, required this.path});

  final IconData icon;
  final String label;
  final String path;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Card(
      child: ListTile(
        leading: Icon(icon, color: p.primary),
        title: Text(label,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right_rounded, size: 20),
        onTap: () => context.go(path),
      ),
    );
  }
}

void _showAuthSheet(BuildContext context, WidgetRef ref) {
  final p = rt(context);
  final email = TextEditingController();
  final password = TextEditingController();
  var loading = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: p.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: EdgeInsets.only(
          left: RtSpace.lg,
          right: RtSpace.lg,
          top: RtSpace.lg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + RtSpace.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: RtSpace.md,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: p.outline,
                  borderRadius: BorderRadius.circular(RtRadius.full),
                ),
              ),
            ),
            const Row(
              children: [
                Icon(Icons.lock_outline_rounded, color: Color(0xFF1565C0)),
                SizedBox(width: RtSpace.sm),
                Text('Conta de participação'),
              ],
            ),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email', hintText: 'voce@email.com'),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            Row(
              spacing: RtSpace.sm,
              children: [
                Expanded(
                  child: RtButton(
                    label: 'Entrar',
                    loading: loading,
                    onPressed: () async {
                      setState(() => loading = true);
                      try {
                        await ref
                            .read(supabaseProvider)
                            .auth
                            .signInWithPassword(email: email.text.trim(), password: password.text);
                        if (context.mounted) Navigator.pop(context);
                      } catch (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Não foi possível entrar. Verifique email e senha.')),
                          );
                        }
                      }
                      setState(() => loading = false);
                    },
                  ),
                ),
                Expanded(
                  child: RtButton(
                    label: 'Criar conta',
                    variant: 'outline',
                    loading: loading,
                    onPressed: () async {
                      setState(() => loading = true);
                      try {
                        await ref
                            .read(supabaseProvider)
                            .auth
                            .signUp(email: email.text.trim(), password: password.text);
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Conta criada! Confirme seu email.')),
                          );
                        }
                      } catch (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Não foi possível criar a conta.')),
                          );
                        }
                      }
                      setState(() => loading = false);
                    },
                  ),
                ),
              ],
            ),
            if (ref.read(currentUserProvider) != null)
              Center(
                child: TextButton(
                  onPressed: () async {
                    await ref.read(supabaseProvider).auth.signOut();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text('Sair da conta'),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

void _showNotifications(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: rt(context).surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      builder: (context, controller) => _NotificationsSheet(controller: controller),
    ),
  );
}

void _showFavorites(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: rt(context).surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      builder: (context, controller) => _FavoritesSheet(controller: controller),
    ),
  );
}

/// Folha de notificações in-app.
class _NotificationsSheet extends ConsumerWidget {
  const _NotificationsSheet({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = rt(context);
    final notifAsync = ref.watch(_notificationsProvider);
    final notifs = notifAsync.valueOrNull ?? [];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(RtSpace.lg),
          child: Text('Notificações',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        ),
        Expanded(
          child: notifAsync.isLoading
              ? const Center(child: CircularProgressIndicator())
              : notifs.isEmpty
                  ? const EmptyState(title: 'Nenhuma notificação', icon: Icons.notifications_off_outlined)
                  : ListView.builder(
                      controller: controller,
                      padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
                      itemCount: notifs.length,
                      itemBuilder: (context, i) {
                        final n = notifs[i];
                        return Card(
                          child: ListTile(
                            leading: n.isRead
                                ? Icon(Icons.notifications_none_rounded, color: p.hint)
                                : Icon(Icons.notifications_active_rounded, color: p.primary),
                            title: Text(n.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                            subtitle: n.body.isEmpty ? null : Text(n.body),
                            onTap: () async {
                              if (!n.isRead) {
                                await ref.read(engagementRepositoryProvider).markNotificationRead(n.id!);
                                ref.invalidate(_notificationsProvider);
                              }
                            },
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

final _notificationsProvider = FutureProvider<List<NotificationItem>>((ref) {
  return ref.watch(engagementRepositoryProvider).fetchNotifications();
});

/// Favoritos do usuário.
class _FavoritesSheet extends ConsumerWidget {
  const _FavoritesSheet({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final favoritesAsync = ref.watch(_myFavoritesProvider);
    final favoriteIds = favoritesAsync.valueOrNull ?? <String>{};
    final plans = ref.watch(plansProvider).valueOrNull ?? [];
    final news = ref.watch(newsProvider).valueOrNull ?? [];

    final favPlans = plans
        .whereType<GovernmentPlan>()
        .where((e) => favoriteIds.contains(e.id))
        .toList();
    final favNews = news
        .whereType<NewsItem>()
        .where((e) => favoriteIds.contains(e.id))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(RtSpace.lg),
          child: Text('Meus favoritos',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        ),
        Expanded(
          child: user == null
              ? const EmptyState(
                  title: 'Entre com uma conta',
                  subtitle: 'Salve notícias, propostas e eventos para ler depois.',
                  icon: Icons.favorite_border_rounded,
                )
              : favoritesAsync.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : favPlans.isEmpty && favNews.isEmpty
                      ? const EmptyState(title: 'Nenhum favorito ainda', icon: Icons.favorite_border_rounded)
                      : ListView(
                          controller: controller,
                          padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
                          children: [
                            for (final plan in favPlans)
                              ListTile(
                                leading: const Icon(Icons.description_outlined, color: Color(0xFF1565C0)),
                                title: Text(plan.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                                subtitle: const Text('Proposta'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent),
                                  onPressed: () async {
                                    await ref
                                        .read(engagementRepositoryProvider)
                                        .toggleFavorite('proposal', plan.id!);
                                    ref.invalidate(_myFavoritesProvider);
                                  },
                                ),
                                onTap: () => context.go('/plano/${plan.slug}'),
                              ),
                            for (final item in favNews)
                              ListTile(
                                leading: const Icon(Icons.newspaper_rounded, color: Color(0xFF0D47A1)),
                                title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                                subtitle: const Text('Notícia'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent),
                                  onPressed: () async {
                                    await ref
                                        .read(engagementRepositoryProvider)
                                        .toggleFavorite('news', item.id!);
                                    ref.invalidate(_myFavoritesProvider);
                                  },
                                ),
                                onTap: () => context.go('/noticias/${item.slug}'),
                              ),
                          ],
                        ),
        ),
      ],
    );
  }
}

final _myFavoritesProvider = FutureProvider<Set<String>>((ref) async {
  final repo = ref.watch(engagementRepositoryProvider);
  final likes = await repo.myFavorites('news');
  final planFavs = await repo.myFavorites('proposal');
  return {...likes, ...planFavs};
});