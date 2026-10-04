import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The tools on the home screen, in display order.
enum HomeTool {
  level,
  angle,
  compass,
  protractor,
  ruler,
  metal,
  vibration,
  sound,
  light,
  altimeter,
}

/// Line icons drawn in the design's stroke style.
class ToolGlyphPainter extends CustomPainter {
  const ToolGlyphPainter({
    required this.tool,
    required this.ink,
    required this.accent,
  });

  final HomeTool tool;
  final Color ink, accent;

  @override
  void paint(Canvas canvas, Size size) {
    // Icons are drawn on a 24-unit grid centred in the button.
    final u = size.shortestSide * 0.46 / 24;
    final c = size.center(Offset.zero);
    canvas
      ..save()
      ..translate(c.dx - 12 * u, c.dy - 12 * u)
      ..scale(u);
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.9
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = ink;
    switch (tool) {
      case HomeTool.level:
        // A spirit-level vial with its bubble between the marks.
        canvas
          ..drawRRect(
            RRect.fromLTRBR(1.5, 7.5, 22.5, 16.5, const Radius.circular(4.5)),
            line,
          )
          ..drawLine(const Offset(8, 9.5), const Offset(8, 14.5), line)
          ..drawLine(const Offset(16, 9.5), const Offset(16, 14.5), line)
          ..drawCircle(const Offset(12, 12), 2.2, Paint()..color = accent);
      case HomeTool.angle:
        // Two arms meeting at a vertex, with the angle's arc.
        canvas
          ..drawPath(
            Path()
              ..moveTo(21.5, 19.5)
              ..lineTo(3, 19.5)
              ..lineTo(16, 4.5),
            line,
          )
          ..drawArc(
            Rect.fromCircle(center: const Offset(3, 19.5), radius: 8),
            -math.atan2(15, 13),
            math.atan2(15, 13),
            false,
            line,
          )
          ..drawCircle(const Offset(16, 4.5), 1.8, Paint()..color = accent);
      case HomeTool.compass:
        // Ring with a two-tone needle, north half in the accent.
        canvas.drawCircle(const Offset(12, 12), 10, line);
        final north = Path()
          ..moveTo(15.8, 8.2)
          ..lineTo(13.4, 13.4)
          ..lineTo(10.6, 10.6)
          ..close();
        final south = Path()
          ..moveTo(8.2, 15.8)
          ..lineTo(10.6, 10.6)
          ..lineTo(13.4, 13.4)
          ..close();
        canvas
          ..drawPath(north, Paint()..color = accent)
          ..drawPath(south, line);
      case HomeTool.protractor:
        // Half-circle protractor with ticks and a reading arm.
        const o = Offset(12, 18);
        canvas
          ..drawArc(
            Rect.fromCircle(center: o, radius: 10),
            math.pi,
            math.pi,
            false,
            line,
          )
          ..drawLine(const Offset(1.5, 18), const Offset(22.5, 18), line);
        for (var d = 30; d < 180; d += 30) {
          final a = math.pi + d * math.pi / 180;
          final dir = Offset(math.cos(a), math.sin(a));
          canvas.drawLine(o + dir * 7.5, o + dir * 10, line);
        }
        canvas
          ..drawLine(
            o,
            o + Offset(math.cos(math.pi * 1.33), math.sin(math.pi * 1.33)) * 8,
            line..color = accent,
          )
          ..drawCircle(o, 1.6, Paint()..color = accent);
      case HomeTool.ruler:
        // A ruler laid at an angle, with ticks and one orange mark.
        canvas
          ..save()
          ..translate(12, 12)
          ..rotate(-math.pi / 4)
          ..drawRRect(
            RRect.fromLTRBR(-11, -4.5, 11, 4.5, const Radius.circular(1.5)),
            line,
          );
        for (var i = -8; i <= 8; i += 2) {
          final long = i % 4 == 0;
          canvas.drawLine(
            Offset(i.toDouble(), -4.5),
            Offset(i.toDouble(), long ? -0.5 : -2),
            line,
          );
        }
        canvas
          ..drawLine(
            const Offset(2, -4.5),
            const Offset(2, -0.5),
            Paint()
              ..strokeWidth = 1.9
              ..strokeCap = StrokeCap.round
              ..color = accent,
          )
          ..restore();
      case HomeTool.metal:
        // Horseshoe magnet with orange poles.
        canvas
          ..drawArc(
            Rect.fromCircle(center: const Offset(12, 12), radius: 7),
            0,
            math.pi,
            false,
            line,
          )
          ..drawLine(const Offset(5, 12), const Offset(5, 7.5), line)
          ..drawLine(const Offset(19, 12), const Offset(19, 7.5), line);
        final pole = Paint()
          ..strokeWidth = 3.4
          ..strokeCap = StrokeCap.round
          ..color = accent;
        canvas
          ..drawLine(const Offset(5, 3.5), const Offset(5, 6), pole)
          ..drawLine(const Offset(19, 3.5), const Offset(19, 6), pole);
      case HomeTool.vibration:
        // A phone with vibration marks either side.
        canvas.drawRRect(
          RRect.fromLTRBR(8, 3.5, 16, 20.5, const Radius.circular(2.2)),
          line,
        );
        for (final (x, h) in const [
          (4.5, 4.0),
          (1.5, 2.2),
          (19.5, 4.0),
          (22.5, 2.2),
        ]) {
          canvas.drawLine(Offset(x, 12 - h), Offset(x, 12 + h), line);
        }
        canvas.drawCircle(const Offset(12, 17.4), 1.2, Paint()..color = accent);
      case HomeTool.sound:
        // A speaker with orange sound waves.
        canvas.drawPath(
          Path()
            ..moveTo(3, 9.5)
            ..lineTo(6.5, 9.5)
            ..lineTo(11, 5.5)
            ..lineTo(11, 18.5)
            ..lineTo(6.5, 14.5)
            ..lineTo(3, 14.5)
            ..close(),
          line,
        );
        final wave = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.9
          ..strokeCap = StrokeCap.round
          ..color = accent;
        for (final r in [4.0, 7.5]) {
          canvas.drawArc(
            Rect.fromCircle(center: const Offset(12, 12), radius: r),
            -math.pi / 4,
            math.pi / 2,
            false,
            wave,
          );
        }
      case HomeTool.light:
        // A light bulb with an orange filament.
        canvas
          ..drawPath(
            Path()
              ..moveTo(9, 17)
              ..lineTo(9, 15.2)
              ..arcTo(
                Rect.fromCircle(center: const Offset(12, 9.5), radius: 6.5),
                math.pi * 0.62,
                math.pi * 1.76,
                false,
              )
              ..lineTo(15, 17)
              ..close(),
            line,
          )
          ..drawLine(const Offset(9.5, 20.2), const Offset(14.5, 20.2), line)
          ..drawPath(
            Path()
              ..moveTo(10, 10.5)
              ..lineTo(11, 12.5)
              ..lineTo(12, 10.5)
              ..lineTo(13, 12.5)
              ..lineTo(14, 10.5),
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.6
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round
              ..color = accent,
          );
      case HomeTool.altimeter:
        // Mountain peaks with an orange sun.
        canvas
          ..drawPath(
            Path()
              ..moveTo(1.5, 20)
              ..lineTo(9, 8)
              ..lineTo(13.5, 15)
              ..lineTo(16.5, 11)
              ..lineTo(22.5, 20)
              ..close(),
            line,
          )
          ..drawCircle(const Offset(18.5, 5), 2, Paint()..color = accent);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(ToolGlyphPainter old) =>
      old.tool != tool || old.ink != ink || old.accent != accent;
}
