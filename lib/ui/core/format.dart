import 'package:intl/intl.dart';

import '../../data/repositories/settings_repository.dart';
import '../../domain/angles.dart';
import '../../domain/ruler.dart';

String? _sepLocale;
String _sep = '.';

/// The current language's decimal separator ("," in German, French,
/// Spanish …). Digits stay 0–9 in every language, as on instruments.
String get _decimalSeparator {
  final locale = Intl.getCurrentLocale();
  if (locale != _sepLocale) {
    _sepLocale = locale;
    final sep = NumberFormat.decimalPattern(locale).symbols.DECIMAL_SEP;
    _sep = sep == ',' ? ',' : '.';
  }
  return _sep;
}

/// [digits] decimals (one by default) with a true minus sign (U+2212, the
/// same width as "+" in tabular figures), never "-0.0".
String _fixed(double v, [int digits = 1]) {
  var s = v.toStringAsFixed(digits);
  if (double.parse(s) == 0) s = s.replaceFirst('-', '');
  s = s.replaceFirst('.', _decimalSeparator);
  return s.startsWith('-') ? '−${s.substring(1)}' : s;
}

bool _isZero(String s) => s.startsWith('0.0') || s.startsWith('0,0');

String _sign(String s) => s.startsWith('−') || _isZero(s) ? s : '+$s';

/// [digits] decimals in the current language: 3.2 / 3,2, −1.0.
String formatDecimal(double v, {int digits = 1}) => _fixed(v, digits);

/// A length of [mm] millimetres in [unit]: 50.0 mm, 5.00 cm, 1.97 in.
String formatLength(double mm, LengthUnit unit) => switch (unit) {
  LengthUnit.mm => '${_fixed(mm)} mm',
  LengthUnit.cm => '${_fixed(mm / 10, 2)} cm',
  LengthUnit.inch => '${_fixed(mm / mmPerInch, 2)} in',
};

String formatDegrees(double? deg) => deg == null ? '—' : '${_fixed(deg)}°';

/// Signed, with an explicit "+" so direction is obvious.
String formatDelta(double? deg) =>
    deg == null ? '—' : _sign(formatDegrees(deg));

/// In the user's unit; [signed] adds an explicit "+" for direction.
String formatAngle(double deg, AngleUnit unit, {bool signed = false}) {
  final s = switch (unit) {
    AngleUnit.degrees => formatDegrees(deg),
    AngleUnit.percent => switch (slopePercent(deg)) {
      null => '—',
      final p => '${_fixed(p)}%',
    },
    // Rise per 12 of run: the slope percent × 12 / 100.
    AngleUnit.pitch => switch (slopePercent(deg)) {
      null => '—',
      final p => '${_fixed(p * 0.12)}/12',
    },
  };
  return signed && s != '—' ? _sign(s) : s;
}

/// Explicit sign for a whole number: +3, −3, 0.
String _signedInt(int v) => v > 0
    ? '+$v'
    : v < 0
    ? '−${-v}'
    : '0';

String formatMicroTesla(double v, {bool signed = false}) =>
    '${signed ? _signedInt(v.round()) : v.round()} µT';

String formatAcceleration(double v) => '${_fixed(v)} m/s²';

String formatPressure(double v) => '${_fixed(v)} hPa';

/// Sound level in whole decibels: a phone can't do better.
String formatDb(double v) => v.round().toString();

/// Illuminance: one decimal below 10 (dim light), else whole numbers in
/// groups of three split by a narrow space, as in SI: 32 000.
String formatLux(double v) {
  if (v < 10) return _fixed(v);
  final digits = v.round().toString();
  final groups = <String>[];
  for (var end = digits.length; end > 0; end -= 3) {
    groups.insert(0, digits.substring(end < 3 ? 0 : end - 3, end));
  }
  return groups.join('\u202F');
}

/// One decimal with an explicit sign: +3.2, −1.0, 0.0.
String formatSignedDecimal(double v) => _sign(_fixed(v));

String formatMeters(double v, {bool signed = false}) =>
    '${signed ? formatSignedDecimal(v) : _fixed(v)} m';
