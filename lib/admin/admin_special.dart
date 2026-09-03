import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formats.dart';
import '../widgets/rt_widgets.dart';
import 'admin_content_crud.dart';
import 'admin_crud.dart';
import 'admin_utils.dart';
import 'admin_widgets.dart';

/// VOLUNTÁRIOS — aprovar/ativo/inativo.
class AdminVolunteersList extends ConsumerStatefulWidget {
  const AdminVolunteersList({super.key});

  @override
  ConsumerState<AdminVolunteersList> createState() => _AdminVolunteersListState();
}

class _AdminVolunteersListState extends ConsumerState<AdminVolunteersList> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    final itemsAsync = ref.watch(_volunteersProvider(_filter));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdminHeader(
          title: 'Voluntários',
          subtitle: 'Cadastros de apoiadores para aprovar e acompanhar.',
          actions: [
            DropdownButton<String>(
              value: _filter.isEmpty ? null : _filter,
              hint: const Text('Filtrar'),
              items: const [
                DropdownMenuItem(value: '', child: Text('Todos')),
                DropdownMenuItem(value: 'pendente', child: Text('Pendentes')),
                DropdownMenuItem(value: 'aprovado', child: Text('Aprovados')),
                DropdownMenuItem(value: 'ativo', child: Text('Ativos')),
                DropdownMenuItem(value: 'inativo', child: Text('Inativos')),
              ],
              onChanged: (v) => setState(() => _filter = v ?? ''),
            ),
          ],
        ),
        Expanded(
          child: itemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorRetry(onRetry: () => ref.invalidate(_volunteersProvider(_filter))),
            data: (items) => items.isEmpty
                ? const EmptyState(title: 'Nenhum voluntário', icon: Icons.volunteer_activism_outlined)
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: RtSpace.sm),
                    itemBuilder: (context, i) {
                      final v = items[i];
                      final color = v.status == 'pendente'
                          ? const Color(0xFFBC6C25)
                          : v.status == 'ativo'
                              ? const Color(0xFF606C38)
                              : const Color(0xFF455A64);
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(RtSpace.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(v.fullName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(fontWeight: FontWeight.w700)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(RtRadius.full),
                                    ),
                                    child: Text(v.status,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: color, fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                              Text(
                                '${v.city}${v.neighborhood.isNotEmpty ? ' • ${v.neighborhood}' : ''}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText),
                              ),
                              if (v.phone.isNotEmpty)
                                Text('Tel/Whats: ${v.phone}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                              if (v.availability.isNotEmpty)
                                Text('Disponibilidade: ${v.availability.join(', ')}',
                                    style: Theme.of(context).textTheme.bodySmall),
                              if (v.areas.isNotEmpty)
                                Text('Áreas: ${v.areas.join(', ')}',
                                    style: Theme.of(context).textTheme.bodySmall),
                              if (v.message.isNotEmpty)
                                Text('"${v.message}"',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: p.secondaryText, fontStyle: FontStyle.italic)),
                              const SizedBox(height: RtSpace.sm),
                              Wrap(
                                spacing: RtSpace.sm,
                                children: [
                                  FilledButton(
                                    onPressed: () => runAdminAction(context, ref, () async {
                                      await ref
                                          .read(participationRepositoryProvider)
                                          .updateVolunteerStatus(v.id!, 'ativo');
                                      ref.invalidate(_volunteersProvider(_filter));
                                    }, success: 'Voluntário aprovado.'),
                                    child: const Text('Aprovar'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () => runAdminAction(context, ref, () async {
                                      await ref
                                          .read(participationRepositoryProvider)
                                          .updateVolunteerStatus(v.id!, 'inativo');
                                      ref.invalidate(_volunteersProvider(_filter));
                                    }, success: 'Voluntário inativado.'),
                                    child: const Text('Inativar'),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final ok = await confirmAction(context, 'Excluir', 'Excluir este cadastro?');
                                      if (ok) {
                                        await runAdminAction(context, ref, () async {
                                          await ref
                                              .read(participationRepositoryProvider)
                                              .deleteVolunteer(v.id!);
                                          ref.invalidate(_volunteersProvider(_filter));
                                        }, success: 'Removido.');
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

final _volunteersProvider = FutureProvider.family<List<VolunteerRequest>, String>((ref, status) {
  return ref.watch(participationRepositoryProvider).fetchVolunteers(status: status.isEmpty ? null : status);
});

/// MENSAGENS — caixa de entrada (form) + responder no chat.
class AdminMessagesList extends ConsumerStatefulWidget {
  const AdminMessagesList({super.key});

  @override
  ConsumerState<AdminMessagesList> createState() => _AdminMessagesListState();
}

class _AdminMessagesListState extends ConsumerState<AdminMessagesList> {
  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    final messagesAsync = ref.watch(_messagesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AdminHeader(
          title: 'Mensagens',
          subtitle: 'Formulário "Fale com Rogério" e conversas do Gabinete Digital.',
        ),
        const SizedBox(height: RtSpace.sm),
        Expanded(
          child: messagesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorRetry(onRetry: () => ref.invalidate(_messagesProvider)),
            data: (messages) => messages.isEmpty
                ? const EmptyState(title: 'Nenhuma mensagem', icon: Icons.mail_outline_rounded)
                : ListView.separated(
                    itemCount: messages.length,
                    separatorBuilder: (_, __) => const SizedBox(height: RtSpace.sm),
                    itemBuilder: (context, i) {
                      final m = messages[i];
                      return Card(
                        color: m.isRead ? null : p.primary.withValues(alpha: 0.05),
                        child: ListTile(
                          leading: Icon(
                            m.channel == 'chat' ? Icons.chat_bubble_outline_rounded : Icons.mail_outline_rounded,
                            color: m.isRead ? p.hint : p.primary,
                          ),
                          title: Text(m.subject.isNotEmpty ? m.subject : (m.channel == 'chat' ? 'Chat' : 'Mensagem'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(m.message, maxLines: 2, overflow: TextOverflow.ellipsis),
                              Text(
                                '${m.senderName.isNotEmpty ? '${m.senderName} • ' : ''}${m.category.isNotEmpty ? '${m.category} • ' : ''}${Fmt.ago(m.createdAt ?? DateTime.now())}',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => _openChat(context, ref, m),
                                icon: const Icon(Icons.reply_rounded),
                                tooltip: 'Responder',
                              ),
                              IconButton(
                                onPressed: () async {
                                  final ok = await confirmAction(context, 'Excluir', 'Excluir mensagem?');
                                  if (ok) {
                                    await runAdminAction(context, ref, () async {
                                      await ref.read(participationRepositoryProvider).deleteMessage(m.id!);
                                      ref.invalidate(_messagesProvider);
                                    }, success: 'Mensagem removida.');
                                  }
                                },
                                icon: const Icon(Icons.delete_outline_rounded, size: 20, color: Color(0xFFAE2012)),
                              ),
                            ],
                          ),
                          onTap: () => _openChat(context, ref, m),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  void _openChat(BuildContext context, WidgetRef ref, MessageItem message) async {
    final p = rt(context);

    await runAdminAction(context, ref, () async {
      await ref.read(participationRepositoryProvider).markMessageRead(message.id!);
      ref.invalidate(_messagesProvider);
    });
    if (!context.mounted) return;

    final controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: rt(context).surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: RtSpace.lg,
          right: RtSpace.lg,
          top: RtSpace.lg,
          bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + RtSpace.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mensagem de ${message.senderName.isNotEmpty ? message.senderName : 'visitante'}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: RtSpace.sm),
            Text(message.message,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.secondaryText)),
            if (message.attachments.isNotEmpty) ...[
              const SizedBox(height: RtSpace.sm),
              Wrap(
                spacing: RtSpace.sm,
                children: [
                  for (final url in message.attachments)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(RtRadius.sm),
                      child: SizedBox(width: 90, height: 90, child: RtImage(url: url)),
                    ),
                ],
              ),
            ],
            const SizedBox(height: RtSpace.md),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: const InputDecoration(hintText: 'Escreva a resposta...'),
            ),
            const SizedBox(height: RtSpace.sm),
            RtButton(
              label: 'Responder ao visitante',
              icon: Icons.send_rounded,
              fullWidth: true,
              onPressed: () => runAdminAction(context, ref, () async {
                final text = controller.text.trim();
                if (text.isEmpty) return;
                await ref.read(participationRepositoryProvider).sendMessage(
                      MessageItem(
                        conversationId: message.conversationId,
                        subject: message.subject,
                        message: text,
                        channel: message.channel,
                        isAdminReply: true,
                        status: 'respondido',
                      ),
                    );
                await ref.read(participationRepositoryProvider).updateMessageStatus(message.id!, 'respondido');
                ref.invalidate(_messagesProvider);
                if (sheetContext.mounted) Navigator.pop(sheetContext);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Resposta enviada.')),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

final _messagesProvider = FutureProvider<List<MessageItem>>((ref) {
  return ref.watch(participationRepositoryProvider).fetchMessages();
});

/// DEMANDAS — aprovar/recusar; aprovadas aparecem no Mapa da Bahia.
class AdminReportsList extends ConsumerStatefulWidget {
  const AdminReportsList({super.key});

  @override
  ConsumerState<AdminReportsList> createState() => _AdminReportsListState();
}

class _AdminReportsListState extends ConsumerState<AdminReportsList> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    final itemsAsync = ref.watch(_reportsProvider(_filter));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdminHeader(
          title: 'Demandas da População',
          subtitle: 'Aprovadas aparecem no Mapa da Bahia.',
          actions: [
            DropdownButton<String>(
              value: _filter.isEmpty ? null : _filter,
              hint: const Text('Filtrar'),
              items: [
                const DropdownMenuItem(value: '', child: Text('Todas')),
                for (final s in ['pendente', 'aprovado', 'recusado', 'em_andamento', 'concluido'])
                  DropdownMenuItem(value: s, child: Text(s)),
              ],
              onChanged: (v) => setState(() => _filter = v ?? ''),
            ),
          ],
        ),
        Expanded(
          child: itemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorRetry(onRetry: () => ref.invalidate(_reportsProvider(''))),
            data: (items) => items.isEmpty
                ? const EmptyState(title: 'Nenhuma demanda', icon: Icons.warning_amber_outlined)
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: RtSpace.sm),
                    itemBuilder: (context, i) {
                      final r = items[i];
                      final color = r.status == 'aprovado'
                          ? const Color(0xFF606C38)
                          : r.status == 'recusado'
                              ? const Color(0xFFAE2012)
                              : r.status == 'pendente'
                                  ? const Color(0xFFBC6C25)
                                  : const Color(0xFF457B9D);
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(RtSpace.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(RtRadius.full),
                                    ),
                                    child: Text(r.statusLabel,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: color, fontWeight: FontWeight.w700)),
                                  ),
                                  const SizedBox(width: RtSpace.sm),
                                  Expanded(
                                    child: Text(r.category,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: p.secondaryText)),
                                  ),
                                  Text(Fmt.ago(r.createdAt ?? DateTime.now()),
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
                                ],
                              ),
                              const SizedBox(height: RtSpace.xs),
                              Text(r.description,
                                  style: Theme.of(context).textTheme.bodyMedium),
                              Text('${r.city.isEmpty ? 'Região não informada' : r.city}'
                                  '${r.latitude != null ? ' • GPS registrado' : ''}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: p.secondaryText)),
                              if (r.imageUrl.isNotEmpty) ...[
                                const SizedBox(height: RtSpace.sm),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(RtRadius.lg),
                                  child: SizedBox(
                                    height: 120,
                                    width: double.infinity,
                                    child: RtImage(url: r.imageUrl),
                                  ),
                                ),
                              ],
                              if (r.adminNote.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: RtSpace.xs),
                                  child: Text('Nota: ${r.adminNote}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: p.info, fontStyle: FontStyle.italic)),
                                ),
                              const SizedBox(height: RtSpace.sm),
                              Wrap(
                                spacing: RtSpace.sm,
                                runSpacing: RtSpace.sm,
                                children: [
                                  FilledButton.icon(
                                    onPressed: () => runAdminAction(context, ref, () async {
                                      await ref
                                          .read(participationRepositoryProvider)
                                          .updateReportStatus(r.id!, 'aprovado');
                                      ref.invalidate(_reportsProvider(_filter));
                                    }, success: 'Demanda aprovada — já aparece no mapa.'),
                                    icon: const Icon(Icons.check_rounded, size: 16),
                                    label: const Text('Aprovar'),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () => runAdminAction(context, ref, () async {
                                      await ref
                                          .read(participationRepositoryProvider)
                                          .updateReportStatus(r.id!, 'em_andamento');
                                      ref.invalidate(_reportsProvider(_filter));
                                    }, success: 'Demanda em andamento.'),
                                    icon: const Icon(Icons.hourglass_top_rounded, size: 16),
                                    label: const Text('Em andamento'),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () => runAdminAction(context, ref, () async {
                                      await ref
                                          .read(participationRepositoryProvider)
                                          .updateReportStatus(r.id!, 'recusado');
                                      ref.invalidate(_reportsProvider(_filter));
                                    }, success: 'Demanda recusada.'),
                                    icon: const Icon(Icons.close_rounded, size: 16),
                                    label: const Text('Recusar'),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () async {
                                      final controller =
                                          TextEditingController(text: r.adminNote);
                                      final note = await showDialog<String>(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text('Nota da demanda'),
                                          content: TextField(
                                            controller: controller,
                                            maxLines: 3,
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                              hintText: 'Ex.: equipe já acionou a gestão do município...',
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () => Navigator.pop(ctx),
                                                child: const Text('Cancelar')),
                                            FilledButton(
                                                onPressed: () =>
                                                    Navigator.pop(ctx, controller.text.trim()),
                                                child: const Text('Salvar')),
                                          ],
                                        ),
                                      );
                                      controller.dispose();
                                      if (note == null || !context.mounted) return;
                                      await runAdminAction(context, ref, () async {
                                        await ref
                                            .read(participationRepositoryProvider)
                                            .updateReportNote(r.id!, note);
                                        ref.invalidate(_reportsProvider(_filter));
                                      }, success: note.isEmpty ? 'Nota removida.' : 'Nota salva.');
                                    },
                                    icon: const Icon(Icons.note_add_rounded, size: 16),
                                    label: const Text('Nota'),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final ok = await confirmAction(context, 'Excluir', 'Excluir demanda?');
                                      if (ok) {
                                        await runAdminAction(context, ref, () async {
                                          await ref
                                              .read(participationRepositoryProvider)
                                              .deleteReport(r.id!);
                                          ref.invalidate(_reportsProvider(_filter));
                                        }, success: 'Demanda removida.');
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

final _reportsProvider = FutureProvider.family<List<ReportItem>, String>((ref, status) {
  return ref.watch(participationRepositoryProvider).fetchReports(status: status.isEmpty ? null : status);
});

/// CONTEÚDO & CONFIG — categorias, FAQ, equipe, depoimentos, banner, números, auditoria.
class AdminContentPage extends ConsumerWidget {
  const AdminContentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AdminHeader(
            title: 'Conteúdo & Configurações',
            subtitle: 'Categorias, institucionais e textos oficiais.',
          ),
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Categorias de Notícias'),
              Tab(text: 'Categorias do Plano'),
              Tab(text: 'FAQ'),
              Tab(text: 'Equipe'),
              Tab(text: 'Depoimentos'),
              Tab(text: 'Banner da Home'),
              Tab(text: 'Números & Auditoria'),
            ],
          ),
          const SizedBox(height: RtSpace.md),
          Expanded(
            child: TabBarView(
              children: [
                _CategoriesCrud(table: 'news_categories', options: _newsCatIcons),
                _CategoriesCrud(table: 'plan_categories', options: _planCatIcons),
                const AdminFaqList(),
                const AdminTeamList(),
                const AdminTestimonialsList(),
                const AdminBannerList(),
                const _NumbersAndAudit(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _newsCatIcons = [
  'medical_services_rounded', 'school_rounded', 'event_rounded', 'play_circle_rounded',
  'campaign_rounded', 'announcement_rounded', 'construction_rounded', 'theater_comedy_rounded',
  'sports_soccer_rounded', 'visibility_rounded', 'newspaper_rounded',
];

const _planCatIcons = [
  'school_rounded', 'medical_services_rounded', 'gavel_rounded', 'construction_rounded',
  'agriculture_rounded', 'sports_soccer_rounded', 'theater_comedy_rounded', 'smartphone_rounded',
  'work_rounded', 'female_rounded', 'groups_rounded', 'landscape_rounded', 'terrain_rounded',
  'trending_up_rounded', 'category_rounded',
];

class _CategoriesCrud extends ConsumerWidget {
  const _CategoriesCrud({required this.table, required this.options});

  final String table;
  final List<String> options;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminCrudPage(
      title: table == 'news_categories' ? 'Categorias de Notícias' : 'Categorias do Plano',
      subtitle: 'Adicione, edite ou remova categorias.',
      table: table,
      searchField: 'name',
      titleKey: 'name',
      subtitleKey: 'color',
      fields: [
        const FieldSpec('name', 'Nome', required: true),
        const FieldSpec('slug', 'URL (slug)', required: true),
        const FieldSpec('color', 'Cor (hex)', type: FieldType.text),
        FieldSpec('icon', 'Ícone', type: FieldType.select, options: options),
        const FieldSpec('sort_order', 'Ordem', type: FieldType.number),
        const FieldSpec('is_active', 'Ativa', type: FieldType.boolField),
      ],
    );
  }
}

/// Números da campanha + auditoria admin.
class _NumbersAndAudit extends ConsumerStatefulWidget {
  const _NumbersAndAudit();

  @override
  ConsumerState<_NumbersAndAudit> createState() => _NumbersAndAuditState();
}

class _NumbersAndAuditState extends ConsumerState<_NumbersAndAudit> {
  @override
  Widget build(BuildContext context) {

    final auditAsync = ref.watch(_auditProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: ClipRect(
            child: _ClipScope(
              child: AdminCrudPage(
                title: 'Números da Campanha',
                subtitle: 'Indicadores da transparência.',
                table: 'campaign_numbers',
                titleKey: 'label',
                subtitleKey: 'value',
                fields: const [
                  FieldSpec('label', 'Rótulo', required: true),
                  FieldSpec('value', 'Valor', required: true),
                  FieldSpec('trend', 'Tendência'),
                  FieldSpec('is_positive', 'Positivo', type: FieldType.boolField),
                  FieldSpec('tone', 'Cor', type: FieldType.select, options: ['primary', 'secondary', 'info', 'success', 'accent', 'warning']),
                  FieldSpec('sort_order', 'Ordem', type: FieldType.number),
                  FieldSpec('is_active', 'Ativo', type: FieldType.boolField),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        Expanded(
          flex: 2,
          child: auditAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => const EmptyState(title: 'Sem auditoria disponível', icon: Icons.history_rounded),
            data: (entries) => ListView(
              children: [
                Text('Auditoria de alterações',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.sm),
                for (final entry in entries.take(30))
                  AuditTile(entry: entry),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Evita erro de infinito dentro de grid/tab.
class _ClipScope extends StatelessWidget {
  const _ClipScope({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 320, child: child);
  }
}

final _auditProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.watch(engagementRepositoryProvider).fetchAuditLog();
});

/// NOTIFICAÇÕES — enviar avisos in-app (e push se a edge function estiver ativa).
class AdminNotificationsPage extends ConsumerStatefulWidget {
  const AdminNotificationsPage({super.key});

  @override
  ConsumerState<AdminNotificationsPage> createState() => _AdminNotificationsPageState();
}

class _AdminNotificationsPageState extends ConsumerState<AdminNotificationsPage> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _city = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    _city.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_title.text.trim().isEmpty) return;
    setState(() => _sending = true);
    final ok = await runAdminAction(context, ref, () async {
      await ref.read(engagementRepositoryProvider).sendNotification(
            title: _title.text.trim(),
            body: _body.text.trim(),
            city: _city.text.trim(),
          );
    }, success: 'Notificação enviada para todos.');
    setState(() => _sending = false);
    if (ok) {
      _title.clear();
      _body.clear();
      _city.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    final historyAsync = ref.watch(_notificationsHistoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AdminHeader(
          title: 'Notificações',
          subtitle: 'Avisos oficiais exibidos para todos (push web via edge function opcional).',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nova notificação',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(
                  controller: _title,
                  decoration: const InputDecoration(labelText: 'Título', hintText: 'Ex: Novo comunicado oficial'),
                ),
                const SizedBox(height: RtSpace.md),
                TextField(
                  controller: _body,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Texto'),
                ),
                const SizedBox(height: RtSpace.md),
                TextField(
                  controller: _city,
                  decoration: const InputDecoration(
                    labelText: 'Segmentar por cidade (opcional)',
                    hintText: 'Deixe vazio para todos',
                  ),
                ),
                const SizedBox(height: RtSpace.md),
                RtButton(
                  label: 'Enviar notificação',
                  icon: Icons.notifications_active_rounded,
                  loading: _sending,
                  onPressed: _send,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        Text('Histórico',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: RtSpace.sm),
        Expanded(
          child: historyAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => const EmptyState(title: 'Sem notificações'),
            data: (history) => ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) {
                final n = history[i];
                return ListTile(
                  leading: Icon(Icons.notifications_active_rounded, color: n.isRead ? p.hint : p.primary),
                  title: Text(n.title, style: Theme.of(context).textTheme.titleSmall),
                  subtitle: Text('${n.body} • ${Fmt.ago(n.sentAt ?? DateTime.now())}'),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

final _notificationsHistoryProvider = FutureProvider<List<NotificationItem>>((ref) {
  return ref.watch(engagementRepositoryProvider).fetchNotifications();
});

/// MINHA CONTA — perfil, troca de senha e dados do admin.
/// CONFIGURAÇÕES — contato do escritório, textos institucionais e avisos.
class AdminSettingsPage extends ConsumerStatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  ConsumerState<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends ConsumerState<AdminSettingsPage> {
  final _whatsapp = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _hours = TextEditingController();
  final _securityNotice = TextEditingController();
  final _siteName = TextEditingController();
  final _siteDescription = TextEditingController();
  final _agendaDisclaimer = TextEditingController();
  final _chatTitle = TextEditingController();
  final _chatSubtitle = TextEditingController();
  final _chatWelcome = TextEditingController();
  // Hero
  final _heroPortraitUrl = TextEditingController();
  final _heroSubtitle = TextEditingController();
  // Campaign
  final _campaignName = TextEditingController();
  final _campaignElectionYear = TextEditingController(text: '2026');
  final _campaignPortraitUrl = TextEditingController();
  // CTA
  final _ctaLabel = TextEditingController();
  final _ctaSubtitle = TextEditingController();
  final _ctaDownloadButton = TextEditingController();
  final _ctaColor = TextEditingController();
  // Transparency
  final _transparencyTitle = TextEditingController();
  final _transparencySubtitle = TextEditingController();
  final _transparencyDescription = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider).valueOrNull ?? const {};
    final contact = settings['contact'] ?? const {};
    final site = settings['site'] ?? const {};
    final platform = settings['platform'] ?? const {};
    final agenda = settings['agenda'] ?? const {};
    final chat = settings['chat'] ?? const {};
    final hero = settings['hero'] ?? const {};
    final campaign = settings['campaign'] ?? const {};
    final cta = settings['cta'] ?? const {};
    final transparency = settings['transparency'] ?? const {};

    _whatsapp.text = (contact['whatsapp'] as String?) ?? '';
    _email.text = (contact['email'] as String?) ?? '';
    _phone.text = (contact['phone'] as String?) ?? '';
    _address.text = (contact['address'] as String?) ?? '';
    _hours.text = (contact['hours'] as String?) ?? '';
    _securityNotice.text = (contact['security_notice'] as String?) ?? '';
    _siteName.text = (site['name'] as String?) ?? '';
    _siteDescription.text = (platform['description'] as String?) ?? '';
    _agendaDisclaimer.text = (agenda['disclaimer'] as String?) ?? '';
    _chatTitle.text = (chat['title'] as String?) ?? '';
    _chatSubtitle.text = (chat['subtitle'] as String?) ?? '';
    _chatWelcome.text = (chat['welcome'] as String?) ?? '';
    _heroPortraitUrl.text = (hero['portrait_url'] as String?) ?? '';
    _heroSubtitle.text = (hero['subtitle'] as String?) ?? '';
    _campaignName.text = (campaign['name'] as String?) ?? '';
    _campaignElectionYear.text = '${campaign['election_year'] ?? 2026}';
    _campaignPortraitUrl.text = (campaign['portrait_url'] as String?) ?? '';
    _ctaLabel.text = (cta['label'] as String?) ?? '';
    _ctaSubtitle.text = (cta['subtitle'] as String?) ?? '';
    _ctaDownloadButton.text = (cta['download_plan_button'] as String?) ?? '';
    _ctaColor.text = (cta['color'] as String?) ?? '';
    _transparencyTitle.text = (transparency['title'] as String?) ?? '';
    _transparencySubtitle.text = (transparency['subtitle'] as String?) ?? '';
    _transparencyDescription.text = (transparency['description'] as String?) ?? '';
  }

  @override
  void dispose() {
    _whatsapp.dispose();
    _email.dispose();
    _phone.dispose();
    _address.dispose();
    _hours.dispose();
    _securityNotice.dispose();
    _siteName.dispose();
    _siteDescription.dispose();
    _agendaDisclaimer.dispose();
    _chatTitle.dispose();
    _chatSubtitle.dispose();
    _chatWelcome.dispose();
    _heroPortraitUrl.dispose();
    _heroSubtitle.dispose();
    _campaignName.dispose();
    _campaignElectionYear.dispose();
    _campaignPortraitUrl.dispose();
    _ctaLabel.dispose();
    _ctaSubtitle.dispose();
    _ctaDownloadButton.dispose();
    _ctaColor.dispose();
    _transparencyTitle.dispose();
    _transparencySubtitle.dispose();
    _transparencyDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    return ListView(
      padding: const EdgeInsets.only(bottom: RtSpace.xl),
      children: [
        const AdminHeader(
          title: 'Configurações',
          subtitle: 'Contato do comitê, textos do app e avisos. Salvos em settings (banco).',
        ),
        // CONTATO
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contato do escritório',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _whatsapp, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'WhatsApp (com DDI)')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Telefone fixo')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _address, decoration: const InputDecoration(labelText: 'Endereço do comitê')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _hours, decoration: const InputDecoration(labelText: 'Horário de atendimento')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _securityNotice, maxLines: 2, decoration: const InputDecoration(labelText: 'Aviso de segurança / CNPJ')),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        // HERO
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Retrato do candidato (Hero)',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _heroPortraitUrl, decoration: const InputDecoration(labelText: 'URL do retrato (hero)', hintText: 'https://...')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _heroSubtitle, maxLines: 2, decoration: const InputDecoration(labelText: 'Subtítulo do hero')),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        // CAMPANHA
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Campanha',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _campaignName, decoration: const InputDecoration(labelText: 'Nome da campanha', hintText: 'ELEIÇÕES 2026')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _campaignElectionYear, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Ano da eleição')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _campaignPortraitUrl, decoration: const InputDecoration(labelText: 'URL retrato (fallback do hero)', hintText: 'https://...')),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        // CTA
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chamada para ação (CTA)',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _ctaLabel, decoration: const InputDecoration(labelText: 'Rótulo do botão')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _ctaSubtitle, maxLines: 2, decoration: const InputDecoration(labelText: 'Subtítulo / frase de apoio')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _ctaDownloadButton, decoration: const InputDecoration(labelText: 'Texto do botão "Baixar Plano"')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _ctaColor, decoration: const InputDecoration(labelText: 'Cor do CTA (hex)', hintText: '#1B6B3D')),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        // TRANSPARÊNCIA
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Transparência',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _transparencyTitle, decoration: const InputDecoration(labelText: 'Título da página de transparência')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _transparencySubtitle, decoration: const InputDecoration(labelText: 'Subtítulo')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _transparencyDescription, maxLines: 3, decoration: const InputDecoration(labelText: 'Descrição')),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        // AGENDA
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Agenda',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _agendaDisclaimer, maxLines: 3, decoration: const InputDecoration(labelText: 'Aviso da agenda (disclaimer)')),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        // CHAT
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chat / Gabinete Digital',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _chatTitle, decoration: const InputDecoration(labelText: 'Título do chat')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _chatSubtitle, decoration: const InputDecoration(labelText: 'Subtítulo')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _chatWelcome, maxLines: 2, decoration: const InputDecoration(labelText: 'Mensagem de boas-vindas')),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        // SITE
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Site / App',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _siteName, decoration: const InputDecoration(labelText: 'Nome do site/aplicativo')),
                const SizedBox(height: RtSpace.md),
                TextField(controller: _siteDescription, maxLines: 3, decoration: const InputDecoration(labelText: 'Descrição da campanha (Home)')),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.lg),
        RtButton(
          label: 'Salvar configurações',
          icon: Icons.save_rounded,
          loading: _saving,
          onPressed: () => runAdminAction(context, ref, () async {
            setState(() => _saving = true);
            try {
              final repo = ref.read(institutionalRepositoryProvider);
              final current = ref.read(settingsProvider).valueOrNull ?? const {};

              final contact = {...current['contact'] ?? const {}, ...{
                'whatsapp': _whatsapp.text.trim(),
                'email': _email.text.trim(),
                'phone': _phone.text.trim(),
                'address': _address.text.trim(),
                'hours': _hours.text.trim(),
                'security_notice': _securityNotice.text.trim(),
              }};
              await repo.upsertSetting('contact', contact);

              final site = {...current['site'] ?? const {}, 'name': _siteName.text.trim()};
              await repo.upsertSetting('site', site);

              final platform = {...current['platform'] ?? const {}, 'description': _siteDescription.text.trim()};
              await repo.upsertSetting('platform', platform);

              final agenda = {...current['agenda'] ?? const {}, 'disclaimer': _agendaDisclaimer.text.trim()};
              await repo.upsertSetting('agenda', agenda);

              final hero = {...current['hero'] ?? const {}, ...{
                'portrait_url': _heroPortraitUrl.text.trim(),
                'subtitle': _heroSubtitle.text.trim(),
              }};
              await repo.upsertSetting('hero', hero);

              final campaign = {...current['campaign'] ?? const {}, ...{
                'name': _campaignName.text.trim(),
                'election_year': int.tryParse(_campaignElectionYear.text.trim()) ?? 2026,
                'portrait_url': _campaignPortraitUrl.text.trim(),
              }};
              await repo.upsertSetting('campaign', campaign);

              final cta = {...current['cta'] ?? const {}, ...{
                'label': _ctaLabel.text.trim(),
                'subtitle': _ctaSubtitle.text.trim(),
                'download_plan_button': _ctaDownloadButton.text.trim(),
                'color': _ctaColor.text.trim(),
              }};
              await repo.upsertSetting('cta', cta);

              final transparency = {...current['transparency'] ?? const {}, ...{
                'title': _transparencyTitle.text.trim(),
                'subtitle': _transparencySubtitle.text.trim(),
                'description': _transparencyDescription.text.trim(),
              }};
              await repo.upsertSetting('transparency', transparency);

              final chat = {...current['chat'] ?? const {}, ...{
                'title': _chatTitle.text.trim(),
                'subtitle': _chatSubtitle.text.trim(),
                'welcome': _chatWelcome.text.trim(),
              }};
              await repo.upsertSetting('chat', chat);

              ref.invalidate(settingsProvider);
            } finally {
              setState(() => _saving = false);
            }
          }, success: 'Configurações salvas.'),
        ),
        const SizedBox(height: RtSpace.sm),
        Text(
          'Dica: o WhatsApp precisa do DDI para o link abrir corretamente (ex.: +5571999998888).',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.hint),
        ),
      ],
    );
  }
}

class AdminAccountPage extends ConsumerStatefulWidget {
  const AdminAccountPage({super.key});

  @override
  ConsumerState<AdminAccountPage> createState() => _AdminAccountPageState();
}

class _AdminAccountPageState extends ConsumerState<AdminAccountPage> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _city = TextEditingController();
  final _newPassword = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(myProfileProvider).valueOrNull;
    _name.text = profile?.fullName ?? '';
    _phone.text = profile?.phone ?? '';
    _city.text = profile?.city ?? '';
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _city.dispose();
    _newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(myProfileProvider).valueOrNull;

    return ListView(
      children: [
        const AdminHeader(title: 'Minha Conta', subtitle: 'Perfil do administrador e segurança.'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RtAvatar(name: profile?.fullName ?? 'Admin', size: 56),
                    const SizedBox(width: RtSpace.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile?.fullName ?? 'Administrador',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w800)),
                          Text(user?.email ?? '',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                          Text('Papel: ${(profile?.role ?? 'user').toUpperCase()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: p.primary, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: RtSpace.md),
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Nome completo'),
                ),
                const SizedBox(height: RtSpace.md),
                TextField(
                  controller: _phone,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                const SizedBox(height: RtSpace.md),
                TextField(
                  controller: _city,
                  decoration: const InputDecoration(labelText: 'Cidade'),
                ),
                const SizedBox(height: RtSpace.md),
                RtButton(
                  label: 'Salvar perfil',
                  icon: Icons.save_rounded,
                  loading: _saving,
                  onPressed: () => runAdminAction(context, ref, () async {
                    setState(() => _saving = true);
                    try {
                      await ref.read(engagementRepositoryProvider).updateProfile({
                        'full_name': _name.text.trim(),
                        'phone': _phone.text.trim(),
                        'city': _city.text.trim(),
                      });
                    } finally {
                      setState(() => _saving = false);
                    }
                  }, success: 'Perfil atualizado.'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(RtSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Segurança',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: RtSpace.md),
                TextField(
                  controller: _newPassword,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Nova senha'),
                ),
                const SizedBox(height: RtSpace.md),
                RtButton(
                  label: 'Trocar senha',
                  variant: 'outline',
                  icon: Icons.lock_reset_rounded,
                  onPressed: () => runAdminAction(context, ref, () async {
                    final pass = _newPassword.text.trim();
                    if (pass.length < 6) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('A senha deve ter ao menos 6 caracteres.')),
                        );
                      }
                      return;
                    }
                    await ref.read(supabaseProvider).auth.updateUser(UserAttributes(password: pass));
                    _newPassword.clear();
                  }, success: 'Senha atualizada com sucesso.'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: RtSpace.md),
        Card(
          color: p.secondaryBackground,
          child: ListTile(
            leading: const Icon(Icons.info_outline_rounded, color: Color(0xFF0D47A1)),
            title: const Text('Sobre o painel'),
            subtitle: const Text(
                'Todo o conteúdo aqui gerenciado é publicado automaticamente no app oficial, no site e no mapa.'),
            trailing: const Icon(Icons.verified_rounded, color: Color(0xFF606C38)),
          ),
        ),
        const SizedBox(height: RtSpace.md),
      ],
    );
  }
}