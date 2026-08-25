import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formats.dart';

/// Campo "Cidade" alimentado pela API oficial do IBGE (417 municípios da
/// Bahia, com cache local). Digitação filtra instantaneamente; tocar em um
/// resultado preenche o campo.
class RtCityField extends ConsumerStatefulWidget {
  const RtCityField({
    super.key,
    this.controller,
    this.label = 'Cidade',
    this.hintText = 'Ex: Barreiras',
  });

  /// Controlador externo (opcional) — mantém o valor para validação do form.
  final TextEditingController? controller;
  final String label;
  final String? hintText;

  @override
  ConsumerState<RtCityField> createState() => _RtCityFieldState();
}

class _RtCityFieldState extends ConsumerState<RtCityField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  late final FocusNode _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      final f = _focus.hasFocus;
      if (f != _focused) setState(() => _focused = f);
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final citiesAsync = ref.watch(ibgeCitiesProvider);
    final cities = citiesAsync.valueOrNull ?? const <String>[];
    final query = Fmt.normPt(_controller.text.trim());
    final matches = query.isEmpty
        ? const <String>[]
        : cities.where((c) => Fmt.normPt(c).contains(query)).take(6).toList();

    final showList = _focused &&
        _controller.text.trim().isNotEmpty &&
        (cities.isNotEmpty || citiesAsync.hasError);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          focusNode: _focus,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            suffixIcon: citiesAsync.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : const Icon(Icons.search_rounded, size: 20),
          ),
        ),
        if (showList)
          Material(
            color: p.surface,
            elevation: 3,
            borderRadius: BorderRadius.circular(RtRadius.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 4),
                children: [
                  if (citiesAsync.hasError)
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.cloud_off_rounded, color: p.hint),
                      title: const Text('Não foi possível carregar os municípios do IBGE'),
                      trailing: TextButton(
                        onPressed: () => ref.invalidate(ibgeCitiesProvider),
                        child: const Text('Tentar de novo'),
                      ),
                    )
                  else if (matches.isEmpty)
                    const ListTile(
                      dense: true,
                      leading: Icon(Icons.location_off_outlined),
                      title: Text('Nenhum município encontrado'),
                    )
                  else
                    for (final name in matches)
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.location_city_rounded, size: 20),
                        title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
                        onTap: () {
                          _controller.text = name;
                          setState(() {});
                          _focus.unfocus();
                        },
                      ),
                ],
              ),
            ),
          ),
        if (_focused && cities.isEmpty && !citiesAsync.isLoading)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              citiesAsync.hasError
                  ? 'Verifique sua conexão e tente novamente.'
                  : 'Carregando municípios da Bahia (IBGE)...',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.hint),
            ),
          ),
      ],
    );
  }
}