import 'package:bubble_level/ui/core/theme.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

/// WCAG 2 contrast ratio between two opaque colours.
double contrast(Color a, Color b) {
  final la = a.computeLuminance(), lb = b.computeLuminance();
  final (hi, lo) = la > lb ? (la, lb) : (lb, la);
  return (hi + 0.05) / (lo + 0.05);
}

void main() {
  test('orange (large bold) text is readable (3:1) on a pressed control, '
      'both themes', () {
    for (final p in [Palette.light, Palette.dark]) {
      // The pressed option's background: the pill with the ink tint.
      final pill = p.isDark ? p.dialLight : p.dialDark;
      final pressed = Color.alphaBlend(
        p.ink.withValues(alpha: p.isDark ? 0.14 : 0.08),
        pill,
      );
      expect(
        contrast(p.accentText, pressed),
        greaterThanOrEqualTo(3),
        reason: p.isDark ? 'dark' : 'light',
      );
      expect(contrast(p.accentText, p.background), greaterThanOrEqualTo(3));
    }
    // The line orange itself isn't enough in light mode: that's why.
    expect(
      contrast(Palette.light.ballDark, Palette.light.background),
      lessThan(3),
    );
  });
}
