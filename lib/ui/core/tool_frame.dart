import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/repositories/settings_repository.dart';
import 'theme.dart';

/// Full-screen page as in the design: content edge to edge behind the
/// status bar, the header floating on top, an optional footer at the bottom.
class ToolFrame extends StatelessWidget {
  const ToolFrame({
    super.key,
    required this.title,
    required this.body,
    this.onBack,
    this.leading,
    this.trailing,
    this.footer,
    this.bodyBottomInset = 0,
  });

  final String title;
  final Widget body;

  /// Shows the design's back tab on the left edge when set.
  final VoidCallback? onBack;

  /// Used instead of the back tab when there is nowhere to go back to.
  final Widget? leading;

  /// The header's right corner: the theme toggle on home, help on a tool.
  final Widget? trailing;
  final Widget? footer;

  /// Lifts the body off the bottom so a tall footer doesn't crowd it.
  final double bodyBottomInset;

  @override
  Widget build(BuildContext context) {
    final palette = Palette.of(context);
    final overlay =
        (palette.isDark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark)
            .copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: Scaffold(
        backgroundColor: palette.background,
        body: Stack(
          children: [
            Positioned.fill(bottom: bodyBottomInset, child: body),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        if (onBack != null)
                          BackTab(onTap: onBack!)
                        else
                          SizedBox(width: 56, child: leading),
                        Expanded(
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                title,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: palette.inkStrong,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 56, child: trailing),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (footer != null)
              Positioned(
                left: 24,
                right: 24,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: footer!,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// The design's back control: a dark tab attached to the left screen edge
/// with a white chevron.
class BackTab extends StatelessWidget {
  const BackTab({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Back',
      child: Semantics(
        button: true,
        label: 'Back',
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: CustomPaint(
            size: const Size(56, 70),
            painter: _BackTabPainter(Palette.of(context).tab),
          ),
        ),
      ),
    );
  }
}

class _BackTabPainter extends CustomPainter {
  _BackTabPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // 70pt tall, bulging 34.5pt out from the edge, as measured.
    final h = size.height;
    final tab = Path()
      ..moveTo(0, 0)
      ..cubicTo(0, h * 0.2, 34.5, h * 0.28, 34.5, h * 0.5)
      ..cubicTo(34.5, h * 0.72, 0, h * 0.8, 0, h)
      ..close();
    canvas
      ..drawPath(tab, Paint()..color = color)
      ..drawPath(
        Path()
          ..moveTo(18, h * 0.5 - 7)
          ..lineTo(11, h * 0.5)
          ..lineTo(18, h * 0.5 + 7),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = Colors.white,
      );
  }

  @override
  bool shouldRepaint(_BackTabPainter old) => old.color != color;
}

/// One-tap light/dark switch: a moon (with sparkles) in light mode, a sun
/// in dark mode, drawn as in the design.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key, required this.settings});

  final SettingsRepository settings;

  @override
  Widget build(BuildContext context) {
    final palette = Palette.of(context);
    final dark = palette.isDark;
    return IconButton(
      tooltip: dark ? 'Light mode' : 'Dark mode',
      onPressed: () =>
          settings.setThemeMode(dark ? ThemeMode.light : ThemeMode.dark),
      icon: CustomPaint(
        size: const Size(28, 28),
        painter: dark ? _SunPainter(palette.icon) : _MoonPainter(palette.icon),
      ),
    );
  }
}

class _MoonPainter extends CustomPainter {
  _MoonPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero) + const Offset(-1, 1.5);
    final moon = Path.combine(
      PathOperation.difference,
      Path()..addOval(Rect.fromCircle(center: c, radius: 10.5)),
      Path()..addOval(
        Rect.fromCircle(center: c + const Offset(6.5, -7), radius: 8),
      ),
    );
    final paint = Paint()..color = color;
    canvas.drawPath(moon, paint);
    _star(canvas, c + const Offset(9.5, -9.5), 4, paint);
    _star(canvas, c + const Offset(12.5, -3.5), 2.4, paint);
  }

  void _star(Canvas canvas, Offset c, double r, Paint paint) {
    final w = r * 0.28;
    canvas.drawPath(
      Path()
        ..moveTo(c.dx, c.dy - r)
        ..quadraticBezierTo(c.dx + w, c.dy - w, c.dx + r, c.dy)
        ..quadraticBezierTo(c.dx + w, c.dy + w, c.dx, c.dy + r)
        ..quadraticBezierTo(c.dx - w, c.dy + w, c.dx - r, c.dy)
        ..quadraticBezierTo(c.dx - w, c.dy - w, c.dx, c.dy - r)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(_MoonPainter old) => old.color != color;
}

class _SunPainter extends CustomPainter {
  _SunPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    canvas.drawCircle(c, 6.5, Paint()..color = color);
    final ray = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = color;
    for (var i = 0; i < 8; i++) {
      final a = i * math.pi / 4;
      final dir = Offset(math.cos(a), math.sin(a));
      canvas.drawLine(c + dir * 9.5, c + dir * 11.5, ray);
    }
  }

  @override
  bool shouldRepaint(_SunPainter old) => old.color != color;
}

/// Soft raised pill button in the dial's material; [emphasis] fills it
/// with the indicator orange.
class SoftButton extends StatelessWidget {
  const SoftButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.emphasis = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final fg = emphasis ? Colors.white : p.ink;
    return Container(
      height: 50,
      decoration: softSurface(
        p,
        radius: BorderRadius.circular(25),
        colors: emphasis ? [p.ballLight, p.ballDark] : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onPressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 20, color: fg),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: fg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A read-only value in the design's material: a soft raised tile with the
/// number above a small caption.
class ValueTile extends StatelessWidget {
  const ValueTile({super.key, required this.value, required this.caption});

  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      label: '$caption $value',
      excludeSemantics: true,
      child: Container(
        height: 60,
        decoration: softSurface(p, radius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  fontFeatures: readoutFeatures,
                  color: p.ink,
                ),
              ),
              Text(
                caption,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: p.label,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Soft raised surface in the dial's material, lit from the top-left: the
/// shared look of tiles, buttons and cards. [colors] overrides the face
/// gradient (e.g. the orange of an emphasised button).
BoxDecoration softSurface(
  Palette p, {
  required BorderRadius radius,
  List<Color>? colors,
}) => BoxDecoration(
  borderRadius: radius,
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: colors ?? [p.dialLight, p.dialDark],
  ),
  boxShadow: [
    BoxShadow(
      color: p.dialShadow.withValues(alpha: p.isDark ? 0.85 : 0.55),
      offset: const Offset(5, 10),
      blurRadius: 20,
    ),
    BoxShadow(
      color: p.dialGlow.withValues(alpha: p.isDark ? 0.45 : 1),
      offset: const Offset(-5, -5),
      blurRadius: 14,
    ),
  ],
);

/// Recessed track in the material of the dial's well: darker toward the
/// top-left where the rim casts its shadow.
BoxDecoration insetSurface(Palette p, {required BorderRadius radius}) =>
    BoxDecoration(
      borderRadius: radius,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: p.isDark
            ? [const Color(0xFF171717), p.wellLight]
            : [const Color(0xFFDCE5F2), p.wellLight],
      ),
      border: Border.all(
        color: p.isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
      ),
    );
