import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formats.dart';
import '../widgets/rt_widgets.dart';
import 'admin_utils.dart';
import 'admin_widgets.dart';

const _targetLabels = {
  'news': 'Notícia',
  'proposal': 'Proposta',
  'event': 'Evento',
  'gallery': 'Galeria',
  'video': 'Vídeo',
};

/// MODERAÇÃO DE COMENTÁRIOS — aprovar, ocultar e excluir.
/// O site só exibe comentários com is_approved = true.
class AdminCommentsList extends ConsumerStatefulWidget {
  const AdminCommentsList({super.key});

  @override
  ConsumerState<AdminCommentsList> createState() => _AdminCommentsListState();
}

class _AdminCommentsListState extends ConsumerState<AdminCommentsList> {
  String _filter = 'pendentes';

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final rowsAsync = ref.watch(_commentsProvider(_filter));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdminHeader(
          title: 'Comentários',
          subtitle: 'Novos comentários entram pendentes e só aparecem no site após aprovação.',
          actions: [
            DropdownButton<String>(
              value: _filter,
              items: const [
                DropdownMenuItem(value: 'pendentes', child: Text('Pendentes')),
                DropdownMenuItem(value: 'aprovados', child: Text('Aprovados')),
                DropdownMenuItem(value: 'todas', child: Text('Todos')),
              ],
              onChanged: (v) => setState(() => _filter = v ?? 'pendentes'),
            ),
          ],
        ),
        Expanded(
          child: rowsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorRetry(
              onRetry: () => ref.invalidate(_commentsProvider(_filter)),
              message: 'Erro ao carregar: $e',
            ),
            data: (rows) => rows.isEmpty
                ? const EmptyState(title: 'Nenhum comentário', icon: Icons.comment_outlined)
                : ListView.separated(
                    itemCount: rows.length,
                    separatorBuilder: (_, __) => const SizedBox(height: RtSpace.sm),
                    itemBuilder: (context, i) {
                      final c = rows[i];
                      final approved = c['is_approved'] == true;
                      final color = approved
                          ? const Color(0xFF606C38)
                          : const Color(0xFFBC6C25);
                      final targetType = (c['target_type'] ?? '').toString();
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(RtSpace.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RtAvatar(name: (c['author_name'] ?? c['full_name'] ?? '?').toString(),
                                      size: 32),
                                  const SizedBox(width: RtSpace.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (c['author_name'] ?? c['full_name'] ?? 'Visitante').toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          '${_targetLabels[targetType] ?? targetType} '
                                          '${c['target_id']?.toString().substring(0, 8) ?? ''} • '
                                          '${Fmt.ago(DateTime.tryParse(c['created_at']?.toString() ?? '') ?? DateTime.now())}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(color: p.hint),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: RtSpace.sm, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(RtRadius.full),
                                    ),
                                    child: Text(
                                      approved ? 'Aprovado' : 'Pendente',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: color, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: RtSpace.sm),
                              Text(c['content']?.toString() ?? ''),
                              const SizedBox(height: RtSpace.sm),
                              Wrap(
                                spacing: RtSpace.sm,
                                children: [
                                  if (!approved)
                                    FilledButton.icon(
                                      onPressed: () => runAdminAction(context, ref, () async {
                                        await ref
                                            .read(engagementRepositoryProvider)
                                            .setCommentApproved(c['id'].toString(), true);
                                        ref.invalidate(_commentsProvider(_filter));
                                      }, success: 'Comentário aprovado.'),
                                      icon: const Icon(Icons.check_rounded, size: 16),
                                      label: const Text('Aprovar'),
                                    )
                                  else
                                    OutlinedButton.icon(
                                      onPressed: () => runAdminAction(context, ref, () async {
                                        await ref
                                            .read(engagementRepositoryProvider)
                                            .setCommentApproved(c['id'].toString(), false);
                                        ref.invalidate(_commentsProvider(_filter));
                                      }, success: 'Comentário ocultado.'),
                                      icon: const Icon(Icons.visibility_off_rounded, size: 16),
                                      label: const Text('Ocultar'),
                                    ),
                                  IconButton(
                                    onPressed: () async {
                                      final ok = await confirmAction(context, 'Excluir comentário',
                                          'Esta ação é permanente. Deseja continuar?');
                                      if (ok) {
                                        await runAdminAction(context, ref, () async {
                                          await ref
                                              .read(engagementRepositoryProvider)
                                              .deleteComment(c['id'].toString());
                                          ref.invalidate(_commentsProvider(_filter));
                                        }, success: 'Comentário excluído.');
                                      }
                                    },
                                    icon: const Icon(Icons.delete_outline_rounded,
                                        color: Color(0xFFAE2012), size: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

final _commentsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, filter) {
  return ref.watch(engagementRepositoryProvider).fetchCommentsAdmin(
        pendingOnly: filter == 'pendentes',
      );
});

/// USUÁRIOS E PAPÉIS — criar membros da equipe e definir permissões.
class AdminUsersPage extends ConsumerStatefulWidget {
  const AdminUsersPage({super.key});

  @override
  ConsumerState<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends ConsumerState<AdminUsersPage> {
  static const _roles = ['admin', 'editor', 'moderator', 'volunteer', 'user'];

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final usersAsync = ref.watch(_usersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdminHeader(
          title: 'Usuários e Papéis',
          subtitle: 'Administradores, editores e moderadores controlam o que aparece no site.',
          actions: [
            AddButton(onPressed: _openCreateDialog),
          ],
        ),
        Expanded(
          child: usersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorRetry(
              onRetry: () => ref.invalidate(_usersProvider),
              message: 'Erro ao carregar: $e',
            ),
            data: (users) => users.isEmpty
                ? const EmptyState(title: 'Nenhum usuário', icon: Icons.person_off_outlined)
                : ListView.separated(
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const SizedBox(height: RtSpace.sm),
                    itemBuilder: (context, i) => _buildUserCard(context, p, users[i]),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserCard(BuildContext context, RtPalette p, Profile u) {
    final roleColor = switch (u.role) {
      'admin' => const Color(0xFFAE2012),
      'editor' => const Color(0xFF1565C0),
      'moderator' => const Color(0xFF457B9D),
      'volunteer' => const Color(0xFFBC6C25),
      _ => const Color(0xFF455A64),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(RtSpace.md),
        child: Row(
          children: [
            RtAvatar(name: u.fullName, size: 44),
            const SizedBox(width: RtSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(u.fullName.isEmpty ? 'Sem nome' : u.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  Text(u.email,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.hint)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: 2),
                    decoration: BoxDecoration(
                      color: roleColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(RtRadius.full),
                    ),
                    child: Text(u.role.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: roleColor, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
            DropdownButton<String>(
              value: u.role,
              underline: const SizedBox.shrink(),
              items: [
                for (final r in _roles) DropdownMenuItem(value: r, child: Text(r)),
              ],
              onChanged: (v) {
                if (v == null || v == u.role) return;
                runAdminAction(context, ref, () async {
                  await ref
                      .read(engagementRepositoryProvider)
                      .adminUpdateProfile(u.id!, role: v);
                  ref.invalidate(_usersProvider);
                }, success: 'Papel atualizado.');
              },
            ),
            Switch(
              value: u.isActive,
              onChanged: (v) => runAdminAction(context, ref, () async {
                await ref
                    .read(engagementRepositoryProvider)
                    .adminUpdateProfile(u.id!, isActive: v);
                ref.invalidate(_usersProvider);
              }, success: v ? 'Usuário ativado.' : 'Usuário inativado.'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openCreateDialog() async {
    final name = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    String role = 'editor';

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Novo membro da equipe'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Nome completo'),
              ),
              const SizedBox(height: RtSpace.sm),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email (login)'),
              ),
              const SizedBox(height: RtSpace.sm),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha inicial'),
              ),
              const SizedBox(height: RtSpace.sm),
              DropdownButtonFormField<String>(
                initialValue: role,
                items: [
                  for (final r in _roles) DropdownMenuItem(value: r, child: Text(r)),
                ],
                onChanged: (v) => role = v ?? 'editor',
                decoration: const InputDecoration(labelText: 'Papel'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Criar'),
          ),
        ],
      ),
    );

    if (email.text.trim().isEmpty || password.text.trim().length < 6) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Informe email e uma senha com ao menos 6 caracteres.')));
      }
      name.dispose();
      email.dispose();
      password.dispose();
      return;
    }

    await runAdminAction(context, ref, () async {
      await ref.read(engagementRepositoryProvider).createStaffUser(
            email: email.text.trim(),
            password: password.text.trim(),
            fullName: name.text.trim(),
            role: role,
          );
      ref.invalidate(_usersProvider);
    }, success: 'Usuário criado — já pode acessar o painel.');
    name.dispose();
    email.dispose();
    password.dispose();
  }
}

final _usersProvider = FutureProvider<List<Profile>>((ref) {
  return ref.watch(engagementRepositoryProvider).fetchProfiles();
});