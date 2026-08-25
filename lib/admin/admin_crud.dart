import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';
import 'admin_utils.dart';
import 'admin_widgets.dart';

/// Tipos de campos do formulário genérico.
enum FieldType {
  text,
  textarea,
  number,
  select,
  chips,
  datetime,
  image,
  boolField,
  status,
}

/// Item de opção dinâmica (categorias, cidades, etc).
class DropdownEntry {
  const DropdownEntry(this.value, this.label);

  final String value;
  final String label;
}

/// Especificação de campo do CRUD.
class FieldSpec {
  const FieldSpec(
    this.key,
    this.label, {
    this.type = FieldType.text,
    this.options = const [],
    this.required = false,
    this.bucket,
    this.maxLines = 1,
    this.optionLoader,
  });

  final String key;
  final String label;
  final FieldType type;
  final List<String> options;
  final bool required;
  final String? bucket;
  final int maxLines;

  /// Carrega opções dinâmicas (para selects vinculados a tabelas).
  final Future<List<DropdownEntry>> Function()? optionLoader;
}

/// Remove do Storage um arquivo que deixou de ser usado.
/// Usa RPC com privilégio de admin (não depende das políticas de DELETE,
/// que alguns ambientes não criam corretamente). Fallback: delete direto.
Future<void> removeStoredImage(WidgetRef ref, String? url, [String? newUrl]) async {
  if (url == null || url.isEmpty || url == newUrl) return;
  const marker = '/storage/v1/object/public/';
  final idx = url.indexOf(marker);
  if (idx < 0) return;
  final rest = url.substring(idx + marker.length);
  final slash = rest.indexOf('/');
  if (slash <= 0) return;
  final bucket = rest.substring(0, slash);
  final path = rest.substring(slash + 1);

  final client = ref.read(supabaseProvider);
  try {
    // 1) Tenta o RPC administrativo (criado no sql/12_storage_delete_rpc.sql)
    await client.rpc(
      'admin_delete_storage_object',
      params: {'p_bucket': bucket, 'p_path': path},
    );
  } catch (_) {
    // 2) Fallback: delete direto pelas policies
    try {
      await client.storage.from(bucket).remove([path]);
    } catch (_) {}
  }
}

/// Página CRUD genérica do painel (lista + formulário + exclusão + status).
class AdminCrudPage extends ConsumerStatefulWidget {
  const AdminCrudPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.table,
    required this.fields,
    required this.titleKey,
    this.searchField = 'title',
    this.subtitleKey,
    this.statusKey,
    this.statusOptions = const [],
    this.bucket,
    this.extraActions,
    this.rowActions,
  });

  final String title;
  final String subtitle;
  final String table;
  final List<FieldSpec> fields;
  final String titleKey;

  /// Coluna usada na busca (title, name, label, full_name, question...).
  final String searchField;
  final String? subtitleKey;
  final String? statusKey;
  final List<String> statusOptions;
  final String? bucket;
  final Widget? extraActions;

  /// Ações extras por card (ex.: reordenar) — recebem o registro da linha.
  final Map<String, void Function(BuildContext context, WidgetRef ref, Map<String, dynamic> row)>? rowActions;

  @override
  ConsumerState<AdminCrudPage> createState() => _AdminCrudPageState();
}

class _AdminCrudPageState extends ConsumerState<AdminCrudPage> {
  String _search = '';
  String _status = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Chave EXATA observada pela tela — usada nas invalidações.
  String get _currentKey =>
      '${widget.table}|$_search|$_status|${widget.searchField}';

  Future<void> _refresh() async {
    ref.invalidate(_rowsProvider(_currentKey));
  }

  @override
  Widget build(BuildContext context) {
    final searchKey = '${widget.table}|$_search|$_status|${widget.searchField}';
    final rowsAsync = ref.watch(_rowsProvider(searchKey));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AdminHeader(
          title: widget.title,
          subtitle: widget.subtitle,
          actions: [
            IconButton(
              onPressed: _refresh,
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Recarregar',
            ),
            if (widget.extraActions != null) ...[
              const SizedBox(width: RtSpace.sm),
              widget.extraActions!,
            ],
            const SizedBox(width: RtSpace.sm),
            AddButton(onPressed: () => _openForm(null)),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _search = v.trim()),
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _search.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close_rounded),
                          tooltip: 'Limpar busca',
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _search = '');
                          },
                        ),
                ),
              ),
            ),
            if (widget.statusKey != null && widget.statusOptions.isNotEmpty) ...[
              const SizedBox(width: RtSpace.sm),
              SizedBox(
                width: 180,
                child: DropdownButtonFormField<String>(
                  initialValue: _status.isEmpty ? null : _status,
                  hint: const Text('Status'),
                  items: [
                    const DropdownMenuItem(value: '', child: Text('Todos')),
                    for (final s in widget.statusOptions)
                      DropdownMenuItem(value: s, child: Text(s)),
                  ],
                  onChanged: (v) => setState(() => _status = v ?? ''),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: RtSpace.md),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: rowsAsync.isLoading
                ? const Center(child: CircularProgressIndicator())
                : rowsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (e, _) => ErrorRetry(onRetry: _refresh, message: 'Erro ao carregar: $e'),
                    data: (rows) => rows.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              SizedBox(height: 80),
                              EmptyState(title: 'Nenhum registro', icon: Icons.inbox_outlined),
                            ],
                          )
                        : ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: rows.length,
                            separatorBuilder: (_, _) => const SizedBox(height: RtSpace.sm),
                            itemBuilder: (context, i) => _buildTile(context, rows[i]),
                          ),
                  ),
          ),
        ),
      ],
    );
  }

  /// Card profissional com moldura, miniatura, chips e menu de ações.
  Widget _buildTile(BuildContext context, Map<String, dynamic> row) {
    final p = rt(context);
    final title = (row[widget.titleKey] ?? '').toString();
    final subtitle = widget.subtitleKey != null
        ? (row[widget.subtitleKey!] ?? '').toString()
        : '';
    final status = widget.statusKey != null ? (row[widget.statusKey!] ?? '').toString() : '';
    final createdAt = row['created_at']?.toString().substring(0, 10) ?? '';
    final hasImage = widget.fields.any((f) => f.type == FieldType.image);

    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(RtRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openForm(row),
        borderRadius: BorderRadius.circular(RtRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(RtSpace.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.lg),
            border: Border.all(color: p.outline),
          ),
          child: Row(
            children: [
              if (hasImage) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(RtRadius.sm),
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: RtImage(
                      url: (row[widget.fields
                                  .firstWhere((f) => f.type == FieldType.image)
                                  .key] ??
                              '')
                          .toString(),
                      placeholderIcon: Icons.image_outlined,
                      errorIcon: Icons.image_outlined,
                    ),
                  ),
                ),
                const SizedBox(width: RtSpace.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            )),
                    if (subtitle.isNotEmpty && subtitle != title)
                      Text(subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.secondaryText)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: RtSpace.sm,
                      runSpacing: RtSpace.xs,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (status.isNotEmpty)
                          _StatusChip(status: status, options: widget.statusOptions),
                        if (createdAt.isNotEmpty)
                          Text(createdAt,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint)),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                tooltip: 'Ações',
                onSelected: (v) {
                  if (v == 'edit') {
                    _openForm(row);
                  } else if (v == 'delete') {
                    _delete(row);
                  } else if (v.startsWith('row:')) {
                    final action = widget.rowActions?[v.substring(4)];
                    if (action != null) action(context, ref, row);
                    ref.invalidate(_rowsProvider(_currentKey));
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit_rounded),
                      title: Text('Editar'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete_outline_rounded, color: Color(0xFFAE2012)),
                      title: Text('Excluir', style: TextStyle(color: Color(0xFFAE2012))),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  if (widget.rowActions != null && widget.rowActions!.isNotEmpty) ...[
                    const PopupMenuDivider(),
                    for (final e in widget.rowActions!.entries)
                      PopupMenuItem(
                        value: 'row:${e.key}',
                        child: ListTile(
                          leading: Icon(e.key.contains('up') ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded),
                          title: Text(e.key.contains('up') ? 'Mover para cima' : 'Mover para baixo'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _delete(Map<String, dynamic> row) async {
    final ok = await confirmAction(context, 'Excluir registro', 'Esta ação é permanente. Deseja continuar?');
    if (!ok) return;
    await runAdminAction(context, ref, () async {
      await ref.read(supabaseProvider).from(widget.table).delete().eq('id', row['id']);
      ref.invalidate(_rowsProvider(_currentKey));
    }, success: 'Registro excluído.');
  }

  /// Abre o formulário em TELA CHEIA (scroll confortável para campos longos).
  Future<void> _openForm(Map<String, dynamic>? row) async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _CrudFormPage(
          fields: widget.fields,
          initial: row ?? {},
          bucket: widget.bucket,
          formTitle: row == null ? 'Criar' : 'Editar',
        ),
      ),
    );
    if (result == null || !mounted) return;

    final saved = await runAdminAction(context, ref, () async {
      final supabase = ref.read(supabaseProvider);
      if (row == null) {
        await supabase.from(widget.table).insert(result);
      } else {
        // Foto trocada → remove o arquivo antigo do Storage
        final imageField = widget.fields
            .where((f) => f.type == FieldType.image)
            .firstOrNull;
        if (imageField != null) {
          await removeStoredImage(
            ref,
            row[imageField.key]?.toString(),
            result[imageField.key]?.toString(),
          );
        }
        await supabase.from(widget.table).update(result).eq('id', row['id']);
      }
      ref.invalidate(_rowsProvider(_currentKey));
    }, success: row == null ? 'Criado com sucesso.' : 'Salvo com sucesso.');
    if (saved && mounted) {
      ref.invalidate(_rowsProvider(_currentKey));
    }
  }
}

final _rowsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, key) async {
  final parts = key.split('|');
  final table = parts[0];
  final search = parts.length > 1 ? parts[1] : '';
  final status = parts.length > 2 ? parts[2] : '';
  final searchField = parts.length > 3 ? parts[3] : 'title';

  var q = ref.read(supabaseProvider).from(table).select();
  if (search.isNotEmpty) {
    q = q.ilike(searchField, '%$search%');
  }
  final rows = await q.order('created_at', ascending: false);
  if (status.isNotEmpty) {
    return rows.where((r) => (r['status'] ?? '').toString() == status).toList();
  }
  return rows.map((r) => Map<String, dynamic>.from(r)).toList();
});

/// Página de formulário em tela cheia.
class _CrudFormPage extends StatefulWidget {
  const _CrudFormPage({
    required this.fields,
    required this.initial,
    this.bucket,
    required this.formTitle,
  });

  final List<FieldSpec> fields;
  final Map<String, dynamic> initial;
  final String? bucket;
  final String formTitle;

  @override
  State<_CrudFormPage> createState() => _CrudFormPageState();
}

class _CrudFormPageState extends State<_CrudFormPage> {
  /// Signal de "Salvar" — o botão fixo incrementa, o formulário escuta.
  final ValueNotifier<int> _submitSignal = ValueNotifier(0);

  /// Impede envio duplicado enquanto o registro está sendo salvo.
  bool _busy = false;

  @override
  void dispose() {
    _submitSignal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Scaffold(
      backgroundColor: p.background,
      appBar: AppBar(
        title: Text(widget.formTitle),
        actions: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.close_rounded),
            tooltip: 'Fechar',
          ),
        ],
      ),
      body: _CrudForm(
        fields: widget.fields,
        initial: widget.initial,
        bucket: widget.bucket,
        submitSignal: _submitSignal,
        onResult: (result) => Navigator.pop(context, result),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(RtSpace.md),
          child: RtButton(
            label: 'Salvar',
            size: 'large',
            icon: Icons.save_rounded,
            loading: _busy,
            onPressed: _busy
                ? null
                : () {
                    _busy = true;
                    _submitSignal.value++;
                  },
          ),
        ),
      ),
    );
  }
}

/// Formulário genérico do CRUD (tela cheia, estado preservado).
class _CrudForm extends ConsumerStatefulWidget {
  const _CrudForm({
    required this.fields,
    required this.initial,
    this.bucket,
    required this.submitSignal,
    required this.onResult,
  });

  final List<FieldSpec> fields;
  final Map<String, dynamic> initial;
  final String? bucket;
  final ValueNotifier<int> submitSignal;
  final ValueChanged<Map<String, dynamic>> onResult;

  @override
  ConsumerState<_CrudForm> createState() => _CrudFormState();
}

class _CrudFormState extends ConsumerState<_CrudForm> {
  final Map<String, dynamic> _values = {};
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (final f in widget.fields) {
      _values[f.key] = widget.initial[f.key];
      if (f.type == FieldType.text || f.type == FieldType.textarea || f.type == FieldType.number) {
        _controllers[f.key] = TextEditingController(text: widget.initial[f.key]?.toString() ?? '');
      }
    }
    // Sincroniza o texto dos controllers com o valor inicial (após o 1º frame).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final f in widget.fields) {
        final c = _controllers[f.key];
        if (c != null) {
          c.text = widget.initial[f.key]?.toString() ?? '';
        }
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    return ValueListenableBuilder<int>(
      valueListenable: widget.submitSignal,
      builder: (context, signal, _) {
        if (signal != _lastSignal) {
          _lastSignal = signal;
          WidgetsBinding.instance.addPostFrameCallback((_) => _submit());
        }
        return ListView(
          padding: const EdgeInsets.all(RtSpace.lg),
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: p.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(RtRadius.md),
                  ),
                  child: Icon(Icons.edit_note_rounded, color: p.primary),
                ),
                const SizedBox(width: RtSpace.md),
                Expanded(
                  child: Text('Preencha os campos — nada é perdido ao alternar opções',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: p.hint)),
                ),
              ],
            ),
            const SizedBox(height: RtSpace.md),
            for (final f in widget.fields) ...[
              _buildField(context, f),
              const SizedBox(height: RtSpace.md),
            ],
            const SizedBox(height: RtSpace.lg),
          ],
        );
      },
    );
  }

  int _lastSignal = 0;

  void _submit() {
    final missing = widget.fields.where((f) =>
        f.required && (_values[f.key] == null || _values[f.key].toString().isEmpty));
    if (missing.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha: ${missing.map((m) => m.label).join(', ')}')),
      );
      return;
    }
    // Remove campos NÃO preenchidos: enviar null explícito sobrescreve os
    // DEFAULTs do banco (ex.: status) e causa erro 23502 (not-null violation).
    final payload = Map<String, dynamic>.from(_values)
      ..removeWhere((_, v) => v == null);
    widget.onResult(payload);
  }

  Widget _buildField(BuildContext context, FieldSpec f) {
    final value = _values[f.key];
    final controller = _controllers[f.key];

    switch (f.type) {
      case FieldType.text:
        return TextField(
          controller: controller,
          onChanged: (v) => _values[f.key] = v,
          decoration: InputDecoration(labelText: f.label),
        );
      case FieldType.textarea:
        return TextField(
          controller: controller,
          onChanged: (v) => _values[f.key] = v,
          maxLines: f.maxLines,
          decoration: InputDecoration(labelText: f.label, alignLabelWithHint: true),
        );
      case FieldType.number:
        return TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (v) {
            // Converte com segurança para INTEIRO (evita "99.0" → 22P02).
            final intValue = int.tryParse(v);
            _values[f.key] = intValue ?? double.tryParse(v)?.toInt() ?? 0;
          },
          decoration: InputDecoration(labelText: f.label),
        );
      case FieldType.select:
        return _SelectField(field: f, value: value, onChanged: (v) => _values[f.key] = v);
      case FieldType.status:
        return DropdownButtonFormField<String>(
          initialValue: value?.toString().isEmpty == true ? null : value?.toString(),
          items: [
            for (final o in f.options) DropdownMenuItem(value: o, child: Text(o)),
          ],
          onChanged: (v) => _values[f.key] = v,
          decoration: InputDecoration(labelText: f.label),
        );
      case FieldType.chips:
        final selected = (value is List ? value.map((e) => e.toString()).toList() : const <String>[]);
        return ChipEditField(
          label: f.label,
          options: f.options,
          selected: selected,
          onChanged: (list) => _values[f.key] = list,
        );
      case FieldType.datetime:
        return InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value is DateTime ? value : DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2032),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime: value is DateTime
                    ? TimeOfDay.fromDateTime(value)
                    : const TimeOfDay(hour: 9, minute: 0),
              );
              if (time != null) {
                final combined = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                setState(() => _values[f.key] = combined.toUtc().toIso8601String());
              }
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(labelText: f.label),
            child: Text(value == null
                ? 'Selecionar data e hora'
                : value is DateTime
                    ? value.toString()
                    : value.toString()),
          ),
        );
      case FieldType.image:
        return UploadImageField(
          label: f.label,
          bucket: f.bucket ?? widget.bucket ?? 'candidate',
          initialUrl: value?.toString(),
          onChanged: (url) => _values[f.key] = url ?? '',
          height: 150,
        );
      case FieldType.boolField:
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(f.label),
          value: value == true,
          onChanged: (v) => setState(() => _values[f.key] = v),
        );
    }
  }
}

/// Chip de status colorido por opção.
class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.options});

  final String status;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(RtRadius.full),
      ),
      child: Text(status,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w700)),
    );
  }

  Color _colorFor(String status) {
    final s = status.toLowerCase();
    if (s.contains('conclu') || s.contains('aprov') || s.contains('ativo') || s == 'published') {
      return const Color(0xFF606C38);
    }
    if (s.contains('cancel') || s.contains('recus') || s.contains('inativo') || s.contains('archived')) {
      return const Color(0xFFAE2012);
    }
    if (s.contains('em_andamento') || s.contains('acontecendo')) {
      return const Color(0xFF457B9D);
    }
    if (s == 'draft') return const Color(0xFFBC6C25);
    return const Color(0xFF1565C0);
  }
}

/// Select com opções estáticas ou dinâmicas.
class _SelectField extends ConsumerStatefulWidget {
  const _SelectField({required this.field, this.value, required this.onChanged});

  final FieldSpec field;
  final dynamic value;
  final ValueChanged<String?> onChanged;

  @override
  ConsumerState<_SelectField> createState() => _SelectFieldState();
}

class _SelectFieldState extends ConsumerState<_SelectField> {
  List<DropdownEntry>? _entries;

  @override
  void initState() {
    super.initState();
    final loader = widget.field.optionLoader;
    if (loader != null) {
      loader().then((entries) {
        if (mounted) setState(() => _entries = entries);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = _entries ?? [
      for (final o in widget.field.options) DropdownEntry(o, o),
    ];
    final current = widget.value?.toString();

    return DropdownButtonFormField<String>(
      initialValue: current == null || current.isEmpty ? null : current,
      items: [
        for (final e in entries)
          DropdownMenuItem(
            value: e.value,
            child: Text(e.label, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: widget.onChanged,
      decoration: InputDecoration(labelText: widget.field.label),
    );
  }
}