import '../../data/repositories/settings_repository.dart';
import '../../domain/angles.dart';

/// One decimal with a true minus sign (U+2212, the same width as "+" in
/// tabular figures), never "-0.0".
String _fixed(double v) {
  final s = v.toStringAsFixed(1);
  if (s == '-0.0') return '0.0';
  return s.startsWith('-') ? '−${s.substring(1)}' : s;
}

String _sign(String s) => s.startsWith('−') || s.startsWith('0.0') ? s : '+$s';

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

String formatPressure(double v) => '${v.toStringAsFixed(1)} hPa';

/// One decimal with an explicit sign: +3.2, −1.0, 0.0.
String formatSignedDecimal(double v) => _sign(_fixed(v));

String formatMeters(double v, {bool signed = false}) =>
    '${signed ? formatSignedDecimal(v) : _fixed(v)} m';
