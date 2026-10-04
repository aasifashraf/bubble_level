import 'dart:math' as math;

import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/ui/core/format.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  /// The angle whose roof pitch is [rise]/12.
  double pitchDeg(double rise) => math.atan(rise / 12) * 180 / math.pi;

  test('roof pitch is rise per 12 of run', () {
    expect(formatAngle(0, AngleUnit.pitch), '0.0/12');
    expect(formatAngle(pitchDeg(4), AngleUnit.pitch), '4.0/12');
    expect(formatAngle(45, AngleUnit.pitch), '12.0/12');
    expect(formatAngle(-pitchDeg(6), AngleUnit.pitch, signed: true), '−6.0/12');
    expect(formatAngle(pitchDeg(6), AngleUnit.pitch, signed: true), '+6.0/12');
    // Vertical: no pitch.
    expect(formatAngle(90, AngleUnit.pitch), '—');
    expect(formatAngle(90, AngleUnit.pitch, signed: true), '—');
  });

  test('pitch uses the language’s decimal mark', () {
    final previous = Intl.defaultLocale;
    Intl.defaultLocale = 'de';
    addTearDown(() => Intl.defaultLocale = previous);
    expect(formatAngle(pitchDeg(4.5), AngleUnit.pitch), '4,5/12');
  });
}
