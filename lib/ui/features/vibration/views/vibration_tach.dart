import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../domain/vibration_frequency.dart';
import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';

/// The vibration meter's instrument, a rev counter: an arc from 0 to the
/// fastest speed this phone can measure, a needle that eases to the
/// vibration's speed with the orange ball at its tip, and the spectrum
/// glowing faintly along the inside of the arc, so the needle points into
/// its brightest part.
class VibrationTach extends StatelessWidget {
  const VibrationTach({
    super.key,
    required this.spectrum,
    required this.rpmLabel,
    required this.semanticsLabel,
  });

  /// The latest spectrum, or null until there's enough to work it out.
  final Spectrum? spectrum;

  /// "RPM" in the user's language.
  final String rpmLabel;
  final String semanticsLabel;

  /// The arc starts bottom left and sweeps 240° clockwise.
  static const _start = 150 * math.pi / 180, _sweep = 240 * math.pi / 180;

  /// The top of the scale, RPM: the phone's limit, rounded down to 500.
  static double maxRpm(Spectrum? s) => s == null
      ? FrequencyAnalyzer.ceiling * 60
      : math.max(500, (s.maxHz * 60 / 500).floor() * 500.0);

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final top = ToolFrame.sideBySide(context)
        ? 0.0
        : ToolFrame.contentTop(context);
    final rpm = spectrum?.rpm;
    final max = maxRpm(spectrum);
    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: LayoutBuilder(
        builder: (context, box) {
          final w = box.maxWidth, h = box.maxHeight;
          final s = math.min(w / 300, (h - top) / 290).clamp(0.8, 1.6);
          final centre = Offset(w / 2, top + (h - top) / 2);
          final r = 104 * s, face = r + 32 * s;
          return Stack(
            children: [
              Positioned(
                left: centre.dx - face,
                top: centre.dy - face,
                width: face * 2,
                height: face * 2,
                child: DecoratedBox(
                  decoration: softSurface(
                    p,
                    radius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Positioned.fill(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: math.min(rpm ?? 0, max)),
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOutCubic,
                  builder: (context, needle, _) => CustomPaint(
                    painter: _TachPainter(
                      palette: p,
                      spectrum: spectrum,
                      needle: needle,
                      max: max,
                      centre: centre,
                      radius: r,
                      scale: s,
                      caption: '× 1000 $rpmLabel',
                    ),
                  ),
                ),
              ),
              // The speed under the hub, with hertz below it.
              Positioned(
                left: centre.dx - r * 0.7,
                width: r * 1.4,
                top: centre.dy + 18 * s,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        rpm == null ? '—' : rpm.round().toString(),
                        textDirection: TextDirection.ltr,
                        textScaler: TextScaler.noScaling,
                        style: TextStyle(
                          fontSize: 38,
                          height: 1.05,
                          fontWeight: FontWeight.w700,
                          fontFeatures: readoutFeatures,
                          color: p.inkStrong,
                        ),
                      ),
                      Text(
                        rpm == null
                            ? rpmLabel
                            : '$rpmLabel · '
                                  '${formatDecimal(spectrum!.peakHz!)} Hz',
                        textScaler: TextScaler.noScaling,
                        style: TextStyle(fontSize: 13, color: p.label),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TachPainter extends CustomPainter {
  _TachPainter({
    required this.palette,
    required this.spectrum,
    required this.needle,
    required this.max,
    required this.centre,
    required this.radius,
    required this.scale,
    required this.caption,
  });

  final Palette palette;
  final Spectrum? spectrum;
  final double needle, max, radius, scale;
  final Offset centre;
  final String caption;

  double _angle(double rpm) =>
      VibrationTach._start + (rpm / max).clamp(0.0, 1.0) * VibrationTach._sweep;

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette, c = centre, r = radius, s = scale;

    // The spectrum, glowing inside the arc; orange round the main peak.
    if (spectrum case final sp?) {
      // Fades out towards the sensor's own noise: a still phone shows none.
      final shown = ((sp.strength - FrequencyAnalyzer.quietest) / 0.1).clamp(
        0.0,
        1.0,
      );
      final glow = Paint()
        ..strokeWidth = 3 * s
        ..strokeCap = StrokeCap.butt;
      final inner = r - 22 * s, depth = 26 * s;
      for (var k = 1; k < sp.levels.length; k++) {
        final hz = k * sp.step, v = sp.levels[k];
        if (v * shown < 0.05 || hz * 60 > max) continue;
        final near = sp.peakHz != null && (hz - sp.peakHz!).abs() <= 1.5;
        final d = Offset.fromDirection(_angle(hz * 60));
        canvas.drawLine(
          c + d * inner,
          c + d * (inner - v * depth),
          glow
            ..color = near
                ? p.ballDark.withValues(alpha: (0.3 + 0.6 * v) * shown)
                : p.tickMajor.withValues(alpha: 0.55 * v * shown),
        );
      }
    }

    // Numbered every 250, 500 or 1000 RPM (in thousands), whichever gives
    // at most six steps; four small ticks between.
    final every = [
      250.0,
      500.0,
      1000.0,
    ].firstWhere((e) => max / e <= 6, orElse: () => 1000);
    final ticks = (max / every * 4).round();
    final tick = Paint()..strokeCap = StrokeCap.round;
    for (var i = 0; i <= ticks; i++) {
      final v = every / 4 * i, major = i % 4 == 0;
      final d = Offset.fromDirection(_angle(v));
      canvas.drawLine(
        c + d * r,
        c + d * (r - (major ? 13 : 7) * s),
        tick
          ..strokeWidth = (major ? 2.2 : 1.2) * s
          ..color = major ? p.tickMajor : p.tickMinor,
      );
      if (major) {
        final k = v / 1000;
        _text(
          canvas,
          k == k.roundToDouble() ? '${k.round()}' : formatDecimal(k),
          c + d * (r + 17 * s),
          11 * s,
          p.label,
          FontWeight.w600,
        );
      }
    }
    _text(
      canvas,
      caption,
      c + Offset(0, r - 6 * s),
      10 * s,
      p.label,
      FontWeight.w500,
    );

    // The needle, a little tail behind the hub, the ball at its tip.
    final d = Offset.fromDirection(_angle(needle));
    final tip = c + d * (r - 18 * s);
    canvas.drawLine(
      c - d * 14 * s,
      tip,
      Paint()
        ..strokeWidth = 3 * s
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(colors: [p.ballLight, p.ballDark])
            .createShader(Rect.fromPoints(c, tip)),
    );
    final ball = 7 * s;
    canvas
      ..drawCircle(
        tip + Offset(0, 2 * s),
        ball,
        Paint()
          ..color = p.ballDark.withValues(alpha: 0.35)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4 * s),
      )
      ..drawCircle(
        tip,
        ball,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.4, -0.4),
            colors: [p.ballLight, p.ballDark],
          ).createShader(Rect.fromCircle(center: tip, radius: ball)),
      );
    // The hub.
    final hub = 11 * s;
    canvas
      ..drawCircle(
        c + Offset(2 * s, 3 * s),
        hub,
        Paint()
          ..color = p.dialShadow.withValues(alpha: 0.6)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4 * s),
      )
      ..drawCircle(
        c,
        hub,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [p.dialLight, p.dialDark],
          ).createShader(Rect.fromCircle(center: c, radius: hub)),
      );
  }

  void _text(
    Canvas canvas,
    String text,
    Offset at,
    double size,
    Color color,
    FontWeight weight,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: size, fontWeight: weight, color: color),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_TachPainter old) =>
      old.palette != palette ||
      old.spectrum != spectrum ||
      old.needle != needle ||
      old.max != max ||
      old.centre != centre ||
      old.radius != radius ||
      old.caption != caption;
}
