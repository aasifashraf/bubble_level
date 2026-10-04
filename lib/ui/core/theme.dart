import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

export '../../domain/status.dart';

/// Design tokens sampled from the reference compass design (light and dark
/// frames). Names follow the design's layers.
@immutable
class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.background,
    required this.haloLight,
    required this.haloDark,
    required this.haloRimLight,
    required this.haloRimDark,
    required this.dialLight,
    required this.dialDark,
    required this.dialShadow,
    required this.dialGlow,
    required this.wellLight,
    required this.wellDark,
    required this.wellShadow,
    required this.buttonRimTopLeft,
    required this.buttonRimBottomRight,
    required this.buttonFace,
    required this.buttonShadow,
    required this.ink,
    required this.inkStrong,
    required this.label,
    required this.tickMajor,
    required this.tickMinor,
    required this.tickCardinal,
    required this.cardinal,
    required this.north,
    required this.ballLight,
    required this.ballDark,
    required this.accentText,
    required this.tab,
    required this.icon,
    required this.success,
    required this.warning,
    required this.warningTint,
    required this.gaugeSafe,
    required this.gaugeCaution,
    required this.gaugeDanger,
    required this.dangerTint,
  });

  static const light = Palette(
    background: Color(0xFFF3F8FE),
    haloLight: Color(0xFFFFFFFF),
    haloDark: Color(0xFFE9F1FB),
    haloRimLight: Color(0xFFFFFFFF),
    haloRimDark: Color(0xFFE0EDFE),
    dialLight: Color(0xFFF6FAFF),
    dialDark: Color(0xFFEEF5FF),
    dialShadow: Color(0xFFB8CDEB),
    dialGlow: Color(0xFFFFFFFF),
    wellLight: Color(0xFFF0F6FE),
    wellDark: Color(0xFFE9F0FA),
    wellShadow: Color(0x247A93B8),
    buttonRimTopLeft: Color(0xFFE1ECFF),
    buttonRimBottomRight: Color(0xFFF7FAFF),
    buttonFace: Color(0xFFF5F9FF),
    buttonShadow: Color(0xFFBED3F3),
    ink: Color(0xFF46515A),
    inkStrong: Color(0xFF323232),
    label: Color(0xFF929699),
    tickMajor: Color(0xFF9CA5AC),
    tickMinor: Color(0xFFCFD6DC),
    tickCardinal: Color(0xFFFF5C31),
    cardinal: Color(0xFF46515A),
    north: Color(0xFFF60001),
    ballLight: Color(0xFFFFA54E),
    ballDark: Color(0xFFFF6E36),
    accentText: Color(0xFFF14300),
    tab: Color(0xFF39424B),
    icon: Color(0xFF48525C),
    success: Color(0xFFC2410C),
    warning: Color(0xFFB45309),
    warningTint: Color(0xFFFDF0C8),
    gaugeSafe: Color(0xFF22A45D),
    gaugeCaution: Color(0xFFFF8A1F),
    gaugeDanger: Color(0xFFE5383B),
    dangerTint: Color(0xFFFDE2E1),
  );

  static const dark = Palette(
    background: Color(0xFF272727),
    haloLight: Color(0xFF383838),
    haloDark: Color(0xFF1E1E1E),
    haloRimLight: Color(0xFF3C3C3C),
    haloRimDark: Color(0xFF1C1C1C),
    dialLight: Color(0xFF2B2B2B),
    dialDark: Color(0xFF252525),
    dialShadow: Color(0xFF0B0B0B),
    dialGlow: Color(0xFF353535),
    wellLight: Color(0xFF242424),
    wellDark: Color(0xFF1E1E1E),
    wellShadow: Color(0xB3000000),
    buttonRimTopLeft: Color(0xFF5A5F65),
    buttonRimBottomRight: Color(0xFF3E454E),
    buttonFace: Color(0xFF434C57),
    buttonShadow: Color(0xFF0E0E0E),
    ink: Color(0xFFFFFFFF),
    inkStrong: Color(0xFFFFFFFF),
    label: Color(0xFF939393),
    tickMajor: Color(0xFFB4B4B4),
    tickMinor: Color(0xFF6E6E6E),
    tickCardinal: Color(0xFFFFFFFF),
    cardinal: Color(0xFF959CA6),
    north: Color(0xFFF60100),
    ballLight: Color(0xFFFFA54E),
    ballDark: Color(0xFFFF6E36),
    accentText: Color(0xFFFFA54E),
    tab: Color(0xFF39424B),
    icon: Color(0xFFFDB52B),
    success: Color(0xFFFFA54E),
    warning: Color(0xFFFBBF24),
    warningTint: Color(0x29FBBF24),
    gaugeSafe: Color(0xFF3DD68C),
    gaugeCaution: Color(0xFFFFA54E),
    gaugeDanger: Color(0xFFFF5A52),
    dangerTint: Color(0x33FF5A52),
  );

  final Color background;
  final Color haloLight, haloDark, haloRimLight, haloRimDark;
  final Color dialLight, dialDark, dialShadow, dialGlow;
  final Color wellLight, wellDark, wellShadow;

  /// The centre button's rim: concave in light (darker top-left), raised in
  /// dark (lighter top-left), as in the design.
  final Color buttonRimTopLeft, buttonRimBottomRight, buttonFace, buttonShadow;

  /// Main text and numerals; [inkStrong] for the bold cardinal-degree labels.
  final Color ink, inkStrong, label;
  final Color tickMajor, tickMinor, tickCardinal;

  /// E, S, W letters; [north] for N.
  final Color cardinal, north;

  /// The glossy indicator ball: highlight and body.
  final Color ballLight, ballDark;

  /// The indicator orange for large bold text (18.7 px+, WCAG AA 3:1) on a
  /// pressed control: in light mode the lightest shade of the lines' hue
  /// that reaches 3:1 (the line orange itself is 2.3:1); in dark mode the
  /// ball's light orange (4.6:1).
  final Color accentText;

  /// The back tab on the left edge, and the sun/moon icon.
  final Color tab, icon;

  /// Status text for "target reached" (level, metal found): the dial's
  /// orange, deepened in light mode so small text stays readable.
  final Color success;

  /// Caution ("the reading can't be trusted"): the icon colour and the soft
  /// pill behind the status line.
  final Color warning, warningTint;

  /// A meter's zones on its dial, like a traffic light: fine, take care,
  /// harmful. [dangerTint] backs a status line in the harmful zone.
  final Color gaugeSafe, gaugeCaution, gaugeDanger, dangerTint;

  bool get isDark => background.computeLuminance() < 0.2;

  /// The app's palette, or the default for the current brightness when a
  /// widget is used outside the app theme.
  static Palette of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<Palette>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  @override
  Palette copyWith() => this;

  @override
  Palette lerp(Palette? other, double t) => t < 0.5 ? this : (other ?? this);
}

/// Numerals use tabular figures so digits don't jitter as values change.
const readoutFeatures = [FontFeature.tabularFigures()];

ThemeData buildTheme(Brightness brightness) {
  final p = brightness == Brightness.light ? Palette.light : Palette.dark;
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF808080),
    brightness: brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
  ).copyWith(surface: p.background, onSurface: p.ink, primary: p.ink);
  // Apple platforms use the system font, San Francisco. Its license doesn't
  // allow bundling elsewhere, so Android uses Inter, the closest open match.
  final apple =
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;
  return ThemeData(
    colorScheme: scheme,
    fontFamily: apple ? null : 'Inter',
    brightness: brightness,
    scaffoldBackgroundColor: p.background,
    extensions: [p],
  );
}
