import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/repositories/settings_repository.dart';
import 'l10n.dart';
import 'theme.dart';

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
      tooltip: dark ? context.l10n.lightMode : context.l10n.darkMode,
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
