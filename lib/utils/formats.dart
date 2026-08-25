import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// Formatação de datas e moeda em pt-BR.
abstract final class Fmt {
  static final _date = DateFormat("d 'de' MMMM, yyyy", 'pt_BR');
  static final _dateShort = DateFormat('dd/MM/yyyy', 'pt_BR');
  static final _time = DateFormat('HH:mm', 'pt_BR');
  static final _weekday = DateFormat('EEE', 'pt_BR');
  static final _monthYear = DateFormat('MMMM yyyy', 'pt_BR');

  static Future<void> init() async {
    Intl.defaultLocale = 'pt_BR';
    await initializeDateFormatting('pt_BR');
  }

  static String date(DateTime? d) => d == null ? '-' : _date.format(d);

  static String dateShort(DateTime? d) => d == null ? '-' : _dateShort.format(d);

  static String time(DateTime? d) => d == null ? '-' : _time.format(d);

  static String monthYear(DateTime d) => _monthYear.format(d);

  static String weekday(DateTime d) =>
      _weekday.format(d).toUpperCase().replaceAll('.', '');

  static String ago(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'agora';
    if (diff.inMinutes < 60) return 'Há ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Há ${diff.inHours} h';
    if (diff.inDays == 1) return 'Ontem';
    if (diff.inDays < 30) return 'Há ${diff.inDays} dias';
    return _date.format(d);
  }

  static String timeRange(DateTime s, DateTime? e) =>
      '${_time.format(s)}${e != null ? ' – ${_time.format(e)}' : ''}';

  /// Normaliza texto para busca sem acentos (ex.: "luis" encontra "Luís").
  static String normPt(String input) {
    const accents = {
      'á': 'a', 'à': 'a', 'ã': 'a', 'â': 'a', 'ä': 'a',
      'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
      'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
      'ó': 'o', 'ò': 'o', 'õ': 'o', 'ô': 'o', 'ö': 'o',
      'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
      'ç': 'c', 'ñ': 'n',
    };
    final buf = StringBuffer();
    for (final r in input.toLowerCase().split('')) {
      buf.write(accents[r] ?? r);
    }
    return buf.toString();
  }
}