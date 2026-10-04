import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'theme.dart';

/// Geometry of the reference design, in points of its 375-wide frame,
/// measured from it. Everything is scaled by [DialGeometry.scaleFor].
abstract final class DialGeometry {
  static const haloR = 229.0;
  static const haloDy = 11.0;
  static const dialR = 136.0;
  static const majorIn = 114.0, majorOut = 132.0;
  static const minorIn = 125.5, minorOut = 131.0;
  static const labelR = 104.0;
  static const letterR = 148.0;
  static const wellR = 87.0;
  static const trackR = 73.0;
  static const ballR = 12.0;
  static const buttonRimR = 58.5;
  static const buttonFaceR = 52.0;

  /// Half the vertical room the dial needs (letters plus margin).
  static const extent = 170.0;

  /// Scale so the dial is as wide as in the design relative to the screen,
  /// but never taller than the space between header and footer.
  static double scaleFor(Size size, {double reserved = 180}) => math.min(
    size.width / 375,
    math.max(0.3, (size.height - reserved) / (2 * extent)),
  );
}

/// The instrument from the reference design, painted at the centre of the
/// box it is given: soft halo, raised dial with a 15° scale and labels set
/// along the ring, recessed well, raised centre button carrying the reading,
/// and an orange ball riding the well.
///
/// Variants: [ballAngle] (degrees clockwise from 12 o'clock), [arcSweep]
/// (Angle), [waterAngle] (Level on an edge), [bubble] (Level flat, each axis
/// in [-1, 1]), [labels] (degree labels), [letters] (N/E/S/W), [locked]
/// (level reached: the button turns orange).
class InstrumentDial extends StatelessWidget {
  const InstrumentDial({
    super.key,
    required this.value,
    this.label = '',
    required this.semanticsLabel,
    this.ballAngle,
    this.arcSweep,
    this.waterAngle,
    this.bubble,
    this.labels = true,
    this.letters = false,
    this.locked = false,
    this.reserved = 180,
  });

  final String value;
  final String label;
  final String semanticsLabel;
  final double? ballAngle, arcSweep, waterAngle;
  final Offset? bubble;
  final bool labels, letters, locked;

  /// Vertical space taken by header and footer, kept clear of the dial.
  final double reserved;

  @override
  Widget build(BuildContext context) {
    final fontFamily = DefaultTextStyle.of(context).style.fontFamily;
    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: CustomPaint(
        size: Size.infinite,
        painter: DialPainter(
          palette: Palette.of(context),
          fontFamily: fontFamily,
          value: value,
          label: label,
          ballAngle: ballAngle,
          arcSweep: arcSweep,
          waterAngle: waterAngle,
          bubble: bubble,
          labels: labels,
          letters: letters,
          locked: locked,
          reserved: reserved,
        ),
      ),
    );
  }
}

const _deg = math.pi / 180;

/// The design's large soft circle behind the instrument, lit from the
/// top-left, with a highlight rim.
void paintHalo(Canvas canvas, Offset c, double r, Palette p) {
  final rect = Rect.fromCircle(center: c, radius: r);
  Shader shade(Color a, Color b) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [a, b],
  ).createShader(rect);
  canvas
    ..drawCircle(c, r, Paint()..shader = shade(p.haloLight, p.haloDark))
    ..drawCircle(
      c,
      r,
      Paint()
        ..shader = shade(p.haloRimLight, p.haloRimDark)
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.013,
    );
}

Offset _polar(Offset c, double r, double angle) =>
    c + Offset(math.sin(angle * _deg), -math.cos(angle * _deg)) * r;

class DialPainter extends CustomPainter {
  DialPainter({
    required this.palette,
    required this.fontFamily,
    required this.value,
    required this.label,
    required this.ballAngle,
    required this.arcSweep,
    required this.waterAngle,
    required this.bubble,
    required this.labels,
    required this.letters,
    required this.locked,
    required this.reserved,
  });

  final Palette palette;
  final String? fontFamily;
  final String value, label;
  final double? ballAngle, arcSweep, waterAngle;
  final Offset? bubble;
  final bool labels, letters, locked;
  final double reserved;

  @override
  void paint(Canvas canvas, Size size) {
    final s = DialGeometry.scaleFor(size, reserved: reserved);
    final c = size.center(Offset.zero);

    _halo(
      canvas,
      c + Offset(0, DialGeometry.haloDy * s),
      DialGeometry.haloR * s,
    );
    _dial(canvas, c, DialGeometry.dialR * s, s);
    _ticks(canvas, c, s);
    if (labels) _labels(canvas, c, s);
    if (letters) _letters(canvas, c, s);
    _well(canvas, c, DialGeometry.wellR * s, s);
    if (waterAngle != null) _water(canvas, c, s, waterAngle!);
    if (arcSweep != null && arcSweep!.abs() > 0.05) _arc(canvas, c, s);
    _button(canvas, c, s);
    _reading(canvas, c, s);
    if (bubble != null) _bubble(canvas, c, s);
    if (ballAngle != null) {
      _ball(canvas, _polar(c, DialGeometry.trackR * s, ballAngle!), s);
    }
  }

  Paint _linear(Rect r, Color topLeft, Color bottomRight) =>
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [topLeft, bottomRight],
        ).createShader(r);

  void _halo(Canvas canvas, Offset c, double r) =>
      paintHalo(canvas, c, r, palette);

  void _dial(Canvas canvas, Offset c, double r, double s) {
    final p = palette;
    final rect = Rect.fromCircle(center: c, radius: r);
    canvas
      // Soft shadow down-right and a glow up-left: the dial floats.
      ..drawCircle(
        c + Offset(12 * s, 22 * s),
        r,
        Paint()
          ..color = p.dialShadow.withValues(alpha: p.isDark ? 0.9 : 0.75)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 26 * s),
      )
      ..drawCircle(
        c - Offset(10 * s, 10 * s),
        r,
        Paint()
          ..color = p.dialGlow.withValues(alpha: p.isDark ? 0.55 : 1)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 18 * s),
      )
      ..drawCircle(c, r, _linear(rect, p.dialLight, p.dialDark))
      ..drawCircle(
        c,
        r - 0.5 * s,
        _linear(
            rect,
            p.isDark ? const Color(0xFF3A3A3A) : Colors.white,
            (p.isDark ? const Color(0xFF3A3A3A) : Colors.white).withValues(
              alpha: 0,
            ),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1 * s,
      );
  }

  void _ticks(Canvas canvas, Offset c, double s) {
    final p = palette;
    for (var d = 0; d < 360; d += 15) {
      final cardinal = d % 90 == 0;
      final major = d % 30 == 0;
      final inner = major ? DialGeometry.majorIn : DialGeometry.minorIn;
      final outer = major ? DialGeometry.majorOut : DialGeometry.minorOut;
      canvas.drawLine(
        _polar(c, inner * s, d.toDouble()),
        _polar(c, outer * s, d.toDouble()),
        Paint()
          ..strokeWidth = (cardinal ? 1.5 : 1.2) * s
          ..color = cardinal
              ? p.tickCardinal
              : major
              ? p.tickMajor
              : p.tickMinor,
      );
    }
  }

  /// Degree labels every 30°, set along the ring with their tops outward,
  /// each with the design's small ring-shaped degree mark at the baseline.
  void _labels(Canvas canvas, Offset c, double s) {
    final p = palette;
    for (var d = 0; d < 360; d += 30) {
      final cardinal = d % 90 == 0;
      final color = cardinal ? p.inkStrong : p.label;
      final tp = TextPainter(
        text: TextSpan(
          text: '$d',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: (cardinal ? 10.5 : 9.5) * s,
            fontWeight: cardinal ? FontWeight.w700 : FontWeight.w500,
            fontFeatures: readoutFeatures,
            color: color,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final ring = 1.6 * s;
      final total = tp.width + 1.2 * s + ring * 2;
      canvas
        ..save()
        ..translate(c.dx, c.dy)
        ..rotate(d * _deg)
        ..translate(0, -DialGeometry.labelR * s);
      final origin = Offset(-total / 2, -tp.height / 2);
      tp.paint(canvas, origin);
      canvas
        ..drawCircle(
          origin + Offset(tp.width + 1.2 * s + ring, tp.height * 0.72),
          ring,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.8 * s
            ..color = color,
        )
        ..restore();
    }
  }

  void _letters(Canvas canvas, Offset c, double s) {
    final p = palette;
    for (final (letter, d) in const [
      ('N', 0.0),
      ('E', 90.0),
      ('S', 180.0),
      ('W', 270.0),
    ]) {
      final tp = TextPainter(
        text: TextSpan(
          text: letter,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 20 * s,
            fontWeight: letter == 'N' ? FontWeight.w600 : FontWeight.w400,
            color: letter == 'N' ? p.north : p.cardinal,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        _polar(c, DialGeometry.letterR * s, d) -
            Offset(tp.width / 2, tp.height / 2),
      );
    }
  }

  void _well(Canvas canvas, Offset c, double r, double s) {
    final p = palette;
    final rect = Rect.fromCircle(center: c, radius: r);
    final shape = Path()..addOval(rect);
    canvas
      ..drawPath(shape, _linear(rect, p.wellDark, p.wellLight))
      // Shadow cast inside the well by its upper-left rim.
      ..save()
      ..clipPath(shape)
      ..translate(2.5 * s, 4.5 * s)
      ..drawPath(
        shape,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 9 * s
          ..color = p.wellShadow
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 7 * s),
      )
      ..restore()
      ..drawCircle(
        c,
        r - 0.5 * s,
        _linear(
            rect,
            (p.isDark ? const Color(0xFF333333) : Colors.white).withValues(
              alpha: 0,
            ),
            p.isDark ? const Color(0xFF333333) : Colors.white,
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1 * s,
      );
  }

  void _water(Canvas canvas, Offset c, double s, double angle) {
    final p = palette;
    final r = DialGeometry.wellR * s;
    canvas
      ..save()
      ..clipPath(Path()..addOval(Rect.fromCircle(center: c, radius: r)))
      ..translate(c.dx, c.dy)
      ..rotate(angle * _deg)
      ..drawRect(
        Rect.fromLTRB(-r * 1.5, 0, r * 1.5, r * 1.5),
        Paint()..color = p.ballDark.withValues(alpha: p.isDark ? 0.16 : 0.12),
      )
      ..drawLine(
        Offset(-r * 1.5, 0),
        Offset(r * 1.5, 0),
        Paint()
          ..strokeWidth = 2 * s
          ..color = p.ballDark.withValues(alpha: 0.85),
      )
      ..restore();
  }

  void _arc(Canvas canvas, Offset c, double s) {
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: DialGeometry.trackR * s),
      -math.pi / 2,
      arcSweep! * _deg,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4 * s
        ..strokeCap = StrokeCap.round
        ..color = palette.ballDark.withValues(alpha: 0.75),
    );
  }

  void _button(Canvas canvas, Offset c, double s) {
    final p = palette;
    final rimR = DialGeometry.buttonRimR * s;
    final faceR = DialGeometry.buttonFaceR * s;
    final rim = Rect.fromCircle(center: c, radius: rimR);
    canvas
      ..drawCircle(
        c + Offset(8 * s, 14 * s),
        rimR,
        Paint()
          ..color = p.buttonShadow.withValues(alpha: p.isDark ? 0.85 : 0.95)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20 * s),
      )
      ..drawCircle(
        c,
        rimR,
        _linear(rim, p.buttonRimTopLeft, p.buttonRimBottomRight),
      )
      ..drawCircle(
        c,
        faceR,
        locked
            ? (Paint()
                ..shader = RadialGradient(
                  center: const Alignment(-0.3, -0.35),
                  colors: [p.ballLight, p.ballDark],
                ).createShader(Rect.fromCircle(center: c, radius: faceR)))
            : (Paint()..color = p.buttonFace),
      );
  }

  /// The big number with the design's raised ring degree sign, and the
  /// small line under it. Values are scaled down to fit the button.
  void _reading(Canvas canvas, Offset c, double s) {
    final p = palette;
    final ink = locked ? Colors.white : p.ink;
    final degrees = value.endsWith('°');
    final digits = degrees ? value.substring(0, value.length - 1) : value;
    final number = TextPainter(
      text: TextSpan(
        text: digits,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 38 * s,
          height: 1,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6 * s,
          fontFeatures: readoutFeatures,
          color: ink,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final ringR = 4.6 * s;
    final gap = 3 * s;
    final total = number.width + (degrees ? gap + ringR * 2 : 0);
    final maxW = DialGeometry.buttonFaceR * s * 1.7;
    final k = math.min(1.0, maxW / total);

    canvas
      ..save()
      // Centred on the button, or nudged up to make room for a label.
      ..translate(c.dx, c.dy + (label.isEmpty ? 0 : 2 * s))
      ..scale(k);
    final origin = Offset(-total / 2, -number.height / 2);
    number.paint(canvas, origin);
    if (degrees) {
      canvas.drawCircle(
        origin + Offset(number.width + gap + ringR, ringR - 1 * s),
        ringR,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2 * s
          ..color = ink,
      );
    }
    canvas.restore();
    if (label.isEmpty) return;

    final sub = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 17 * s,
          height: 1,
          fontWeight: FontWeight.w400,
          color: ink,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxW);
    sub.paint(canvas, c + Offset(-sub.width / 2, 37 * s - sub.height / 2));
  }

  /// Clear glass ring around the button that drifts toward the high side.
  void _bubble(Canvas canvas, Offset c, double s) {
    final p = palette;
    final centre = c + bubble! * 15 * s;
    final r = 64 * s;
    canvas
      ..drawCircle(
        centre,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2 * s
          ..color = (locked ? p.ballDark : p.ink).withValues(alpha: 0.55),
      )
      ..drawArc(
        Rect.fromCircle(center: centre, radius: r - 3 * s),
        math.pi * 1.08,
        math.pi * 0.4,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5 * s
          ..strokeCap = StrokeCap.round
          ..color = Colors.white.withValues(alpha: p.isDark ? 0.3 : 0.95),
      );
  }

  void _ball(Canvas canvas, Offset at, double s) {
    final p = palette;
    final r = DialGeometry.ballR * s;
    canvas
      ..drawCircle(
        at + Offset(1.5 * s, 3 * s),
        r,
        Paint()
          ..color = p.isDark
              ? Colors.black.withValues(alpha: 0.55)
              : p.ballDark.withValues(alpha: 0.35)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 * s),
      )
      ..drawCircle(
        at,
        r,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.1, -0.15),
            radius: 0.95,
            colors: [p.ballLight, p.ballDark],
          ).createShader(Rect.fromCircle(center: at, radius: r)),
      );
  }

  @override
  bool shouldRepaint(DialPainter old) =>
      old.palette != palette ||
      old.fontFamily != fontFamily ||
      old.value != value ||
      old.label != label ||
      old.ballAngle != ballAngle ||
      old.arcSweep != arcSweep ||
      old.waterAngle != waterAngle ||
      old.bubble != bubble ||
      old.labels != labels ||
      old.letters != letters ||
      old.locked != locked ||
      old.reserved != reserved;
}
