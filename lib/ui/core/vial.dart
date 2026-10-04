import 'package:flutter/material.dart';

import 'theme.dart';

/// A classic spirit-level tube in the dial's materials: a raised capsule
/// carrying a recessed glass channel, 1° ticks, two centre marks and an
/// orange bubble that floats toward the high end.
///
/// [position] is the bubble's offset along the tube in [-1, 1]: +1 is the
/// right end (horizontal) or the top end (vertical). [markGap] is the level
/// tolerance as a fraction of the bubble's travel, so the centre marks
/// bracket exactly the "level" zone. [locked] turns the marks orange.
class SpiritVial extends StatelessWidget {
  const SpiritVial({
    super.key,
    required this.position,
    required this.semanticsLabel,
    this.vertical = false,
    this.ticks = 10,
    required this.markGap,
    this.locked = false,
  });

  final double position;
  final String semanticsLabel;
  final bool vertical;

  /// Tick marks on each side of the centre (one per degree of travel).
  final int ticks;
  final double markGap;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: CustomPaint(
        size: Size.infinite,
        painter: _VialPainter(
          palette: Palette.of(context),
          position: position.clamp(-1.0, 1.0),
          vertical: vertical,
          ticks: ticks,
          markGap: markGap,
          locked: locked,
        ),
      ),
    );
  }
}

class _VialPainter extends CustomPainter {
  _VialPainter({
    required this.palette,
    required this.position,
    required this.vertical,
    required this.ticks,
    required this.markGap,
    required this.locked,
  });

  final Palette palette;
  final double position, markGap;
  final bool vertical, locked;
  final int ticks;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint lying down; a vertical tube is the same tube turned a quarter
    // anticlockwise, so +1 is at the top.
    if (vertical) {
      canvas
        ..translate(0, size.height)
        ..rotate(-1.5707963267948966);
      size = Size(size.height, size.width);
    }
    final p = palette;
    final k = size.height / 80; // the tube is designed 80 thick
    final body = Offset.zero & size;
    final bodyR = RRect.fromRectAndRadius(
      body,
      Radius.circular(size.height / 2),
    );

    // The tube floats like the dial: soft shadow down-right, glow up-left.
    canvas
      ..drawRRect(
        bodyR.shift(_onScreen(Offset(8 * k, 12 * k))),
        Paint()
          ..color = p.dialShadow.withValues(alpha: p.isDark ? 0.9 : 0.75)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 18 * k),
      )
      ..drawRRect(
        bodyR.shift(_onScreen(Offset(-6 * k, -6 * k))),
        Paint()
          ..color = p.dialGlow.withValues(alpha: p.isDark ? 0.55 : 1)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12 * k),
      )
      ..drawRRect(bodyR, _linear(body, p.dialLight, p.dialDark));

    // Recessed glass channel with the rim's shadow inside it.
    final glass = body.deflate(14 * k);
    final glassR = RRect.fromRectAndRadius(
      glass,
      Radius.circular(glass.height / 2),
    );
    final glassPath = Path()..addRRect(glassR);
    final inner = _onScreen(Offset(2 * k, 3.5 * k));
    canvas
      ..drawRRect(glassR, _linear(glass, p.wellDark, p.wellLight))
      ..save()
      ..clipPath(glassPath)
      ..translate(inner.dx, inner.dy)
      ..drawRRect(
        glassR,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7 * k
          ..color = p.wellShadow
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 * k),
      )
      ..restore();

    // Bubble geometry: an elongated capsule riding the channel.
    final c = glass.center;
    final bubbleH = glass.height * 0.66;
    final bubbleW = bubbleH * 1.9;
    final travel = glass.width / 2 - bubbleW / 2 - 6 * k;

    // Ticks, one per degree, on both edges of the glass.
    for (var i = 1; i <= ticks; i++) {
      final major = i % 5 == 0;
      final len = (major ? 9 : 5) * k;
      final paint = Paint()
        ..strokeWidth = (major ? 1.6 : 1) * k
        ..strokeCap = StrokeCap.round
        ..color = major ? p.tickMajor : p.tickMinor;
      for (final side in [-1, 1]) {
        final x = c.dx + side * (bubbleW / 2 + i / ticks * travel);
        if (x < glass.left + glass.height / 2) continue;
        if (x > glass.right - glass.height / 2) continue;
        canvas
          ..drawLine(
            Offset(x, glass.top + 2 * k),
            Offset(x, glass.top + 2 * k + len),
            paint,
          )
          ..drawLine(
            Offset(x, glass.bottom - 2 * k),
            Offset(x, glass.bottom - 2 * k - len),
            paint,
          );
      }
    }

    // Centre marks bracket the bubble when it's within tolerance.
    final markX = bubbleW / 2 + markGap * travel + 2 * k;
    final mark = Paint()
      ..strokeWidth = 2.4 * k
      ..strokeCap = StrokeCap.round
      ..color = locked ? p.ballDark : p.ink.withValues(alpha: 0.55);
    for (final side in [-1, 1]) {
      canvas.drawLine(
        Offset(c.dx + side * markX, glass.top + 1 * k),
        Offset(c.dx + side * markX, glass.bottom - 1 * k),
        mark,
      );
    }

    // The bubble: orange like the dial's ball, with a glassy highlight.
    final at = c + Offset(position * travel, 0);
    final bubble = Rect.fromCenter(center: at, width: bubbleW, height: bubbleH);
    final bubbleR = RRect.fromRectAndRadius(
      bubble,
      Radius.circular(bubbleH / 2),
    );
    canvas
      ..drawRRect(
        bubbleR.shift(_onScreen(Offset(1.5 * k, 3 * k))),
        Paint()
          ..color = p.isDark
              ? Colors.black.withValues(alpha: 0.55)
              : p.ballDark.withValues(alpha: 0.35)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 * k),
      )
      ..drawRRect(
        bubbleR,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.2, -0.4),
            radius: 1.1,
            colors: [p.ballLight, p.ballDark],
          ).createShader(bubble),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            bubble.left + bubbleH * 0.35,
            bubble.top + bubbleH * 0.14,
            bubbleW - bubbleH * 0.7,
            bubbleH * 0.2,
          ),
          Radius.circular(bubbleH * 0.1),
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.45),
      );
  }

  /// An offset meant on screen (light from the top-left, shadows down-right)
  /// expressed in the tube's own frame, which is turned when [vertical].
  Offset _onScreen(Offset o) => vertical ? Offset(-o.dy, o.dx) : o;

  /// Gradient from the screen's top-left to bottom-right, in the tube frame.
  Paint _linear(Rect r, Color topLeft, Color bottomRight) =>
      Paint()
        ..shader = LinearGradient(
          begin: vertical ? Alignment.topRight : Alignment.topLeft,
          end: vertical ? Alignment.bottomLeft : Alignment.bottomRight,
          colors: [topLeft, bottomRight],
        ).createShader(r);

  @override
  bool shouldRepaint(_VialPainter old) =>
      old.position != position ||
      old.locked != locked ||
      old.palette != palette ||
      old.vertical != vertical ||
      old.ticks != ticks ||
      old.markGap != markGap;
}
