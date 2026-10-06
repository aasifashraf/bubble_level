import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';

/// The vibration meter's instrument, like a radar: a hand sweeps round once
/// every [turn], writing the vibration as a soft swell around the reading
/// that fades behind it. Faint rings mark light and strong vibration and a
/// notch marks the peak. The scale is gentle (square root), so a slight
/// tremor still shows and a drill doesn't overflow.
class VibrationSweep extends StatefulWidget {
  const VibrationSweep({
    super.key,
    required this.current,
    required this.peak,
    required this.zones,
    required this.value,
    required this.unit,
    required this.semanticsLabel,
  });

  /// Vibration now and the largest since reset, m/s².
  final double current, peak;

  /// The bands' colours by their start, m/s².
  final List<DialZone> zones;

  final String value, unit, semanticsLabel;

  /// Where the rings sit: light and strong vibration, m/s².
  static const rings = [0.3, 2.0];

  /// One sweep of the hand.
  static const turn = Duration(seconds: 6);

  /// The top of the scale, m/s².
  static const full = 6.0;

  @override
  State<VibrationSweep> createState() => _VibrationSweepState();
}

class _VibrationSweepState extends State<VibrationSweep>
    with SingleTickerProviderStateMixin {
  /// Readings around the dial, one slot per step of the hand.
  static const _slots = 144;

  late final Ticker _ticker = createTicker(_tick);
  final _values = List<double>.filled(_slots, 0);

  /// The hand's position in slots, and the slot it last wrote.
  double _hand = 0;
  int _head = 0;

  /// The slot holding the peak, or null once it has been swept over.
  int? _peakSlot;
  Duration _last = Duration.zero;

  void _tick(Duration now) {
    final dt = _last == Duration.zero
        ? 0.0
        : ((now - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = now;
    final turn = VibrationSweep.turn.inMicroseconds / 1e6;
    _hand = (_hand + dt * _slots / turn) % _slots;
    while (_head != _hand.floor()) {
      _head = (_head + 1) % _slots;
      _values[_head] = widget.current;
      if (_head == _peakSlot) _peakSlot = null;
    }
    if (widget.peak > 0 && (widget.current - widget.peak).abs() < 1e-9) {
      _peakSlot = _head;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _ticker.start();
  }

  @override
  void didUpdateWidget(VibrationSweep old) {
    super.didUpdateWidget(old);
    // Reset peak: the old notch no longer marks it.
    if (widget.peak < old.peak) _peakSlot = null;
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final top = ToolFrame.sideBySide(context)
        ? 0.0
        : ToolFrame.contentTop(context);
    return Semantics(
      label: widget.semanticsLabel,
      excludeSemantics: true,
      child: LayoutBuilder(
        builder: (context, box) {
          final w = box.maxWidth, h = box.maxHeight;
          final s = math.min(w / 300, (h - top) / 330).clamp(0.8, 1.6);
          final centre = Offset(w / 2, top + (h - top) / 2);
          final disc = 64 * s;
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _SweepPainter(
                    palette: p,
                    values: _values,
                    head: _head,
                    hand: _hand,
                    current: widget.current,
                    peak: widget.peak,
                    peakSlot: _peakSlot,
                    colorOf: (v) =>
                        zoneColor(widget.zones, v, blend: 0.4, end: 12),
                    centre: centre,
                    scale: s,
                  ),
                ),
              ),
              Positioned(
                left: centre.dx - disc,
                top: centre.dy - disc,
                width: disc * 2,
                height: disc * 2,
                child: DecoratedBox(
                  decoration: softSurface(
                    p,
                    radius: BorderRadius.circular(999),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14 * s),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.value,
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(
                              fontSize: 40,
                              height: 1.05,
                              fontWeight: FontWeight.w700,
                              fontFeatures: readoutFeatures,
                              color: p.inkStrong,
                            ),
                          ),
                          Text(
                            widget.unit,
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(fontSize: 12, color: p.label),
                          ),
                          const SizedBox(height: 6),
                          // The level's colour, at a glance.
                          DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: zoneColor(
                                widget.zones,
                                widget.current,
                                blend: 0.4,
                                end: 12,
                              ),
                            ),
                            child: const SizedBox.square(dimension: 7),
                          ),
                        ],
                      ),
                    ),
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

class _SweepPainter extends CustomPainter {
  _SweepPainter({
    required this.palette,
    required this.values,
    required this.head,
    required this.hand,
    required this.current,
    required this.peak,
    required this.peakSlot,
    required this.colorOf,
    required this.centre,
    required this.scale,
  });

  final Palette palette;
  final List<double> values;
  final int head;
  final double hand, current, peak;
  final int? peakSlot;
  final Color Function(double) colorOf;
  final Offset centre;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette, s = scale, c = centre, n = values.length;
    final r0 = 70 * s, span = 62 * s;
    double len(double v) =>
        span * math.sqrt(math.min(1, v / VibrationSweep.full));
    double angleOf(num i) => -math.pi / 2 + i / n * 2 * math.pi;
    // 0 for the newest slot, near 1 for the oldest.
    double age(int i) => ((head - i + n) % n) / n;

    // Faint dashed rings at light and strong vibration.
    for (final v in VibrationSweep.rings) {
      final r = r0 + 6 * s + len(v);
      final dash = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = colorOf(v + 0.01).withValues(alpha: 0.45);
      final steps = (2 * math.pi * r / (7 * s)).floor();
      for (var k = 0; k < steps; k += 1) {
        final a = k / steps * 2 * math.pi;
        canvas.drawArc(
          Rect.fromCircle(center: c, radius: r),
          a,
          2 * s / r,
          false,
          dash,
        );
      }
    }

    // The swell: a smooth closed shape through every slot.
    final points = [
      for (var i = 0; i < n; i++)
        c +
            Offset.fromDirection(
              angleOf(i),
              r0 + 6 * s + len(values[i]) * (1 - 0.35 * age(i)),
            ),
    ];
    final swell = Path();
    for (var i = 0; i < n; i++) {
      final a = points[i], b = points[(i + 1) % n];
      final mid = (a + b) / 2;
      i == 0
          ? swell.moveTo(mid.dx, mid.dy)
          : swell.quadraticBezierTo(a.dx, a.dy, mid.dx, mid.dy);
    }
    swell.close();
    final tint = colorOf(current);
    canvas.drawPath(
      swell,
      Paint()
        ..shader = RadialGradient(
          colors: [
            tint.withValues(alpha: 0.05),
            tint.withValues(alpha: 0.22),
            tint.withValues(alpha: 0.4),
          ],
          stops: [r0 / (r0 + 6 * s + span), 0.8, 1],
        ).createShader(Rect.fromCircle(center: c, radius: r0 + 6 * s + span)),
    );

    // Fine bars on top, each in its own colour, fading behind the hand.
    final bar = Paint()
      ..strokeWidth = 2.2 * s
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < n; i++) {
      // Nothing to draw at rest: the swell's edge says it.
      if (len(values[i]) < 1.5 * s) continue;
      final fade = 1 - age(i);
      final d = Offset.fromDirection(angleOf(i));
      canvas.drawLine(
        c + d * (r0 + 6 * s),
        points[i],
        bar
          ..color = colorOf(values[i])
              .withValues(alpha: 0.15 + 0.75 * fade * fade),
      );
    }

    // A soft trail just behind the hand, like radar.
    final ha = angleOf(hand);
    final reach = r0 + 6 * s + span + 6 * s;
    const trail = 0.9;
    canvas.drawPath(
      Path()
        ..moveTo(c.dx, c.dy)
        ..arcTo(
          Rect.fromCircle(center: c, radius: reach),
          ha - trail,
          trail,
          false,
        )
        ..close(),
      Paint()
        ..shader = SweepGradient(
          colors: [
            p.ballLight.withValues(alpha: 0),
            p.ballLight.withValues(alpha: 0.2),
          ],
          stops: const [0, trail / (2 * math.pi)],
          transform: GradientRotation(ha - trail),
        ).createShader(Rect.fromCircle(center: c, radius: reach)),
    );

    // The hand, with the orange ball riding the swell.
    final tip = c + Offset.fromDirection(ha, r0 + 6 * s + len(current));
    canvas.drawLine(
      c + Offset.fromDirection(ha, r0 - 2 * s),
      tip,
      Paint()
        ..strokeWidth = 2 * s
        ..strokeCap = StrokeCap.round
        ..color = p.ink,
    );
    final ball = 7.5 * s;
    canvas.drawCircle(
      tip,
      ball,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.4),
          colors: [p.ballLight, p.ballDark],
        ).createShader(Rect.fromCircle(center: tip, radius: ball)),
    );

    // A notch where the peak was written.
    if (peakSlot case final slot?) {
      final a = angleOf(slot);
      final at = c + Offset.fromDirection(a, r0 + 6 * s + len(peak) + 7 * s);
      canvas
        ..save()
        ..translate(at.dx, at.dy)
        ..rotate(a + math.pi / 2)
        ..drawPath(
          Path()
            ..moveTo(-4 * s, -4 * s)
            ..lineTo(4 * s, -4 * s)
            ..lineTo(0, 3 * s)
            ..close(),
          Paint()..color = p.ink,
        )
        ..restore();
    }
  }

  /// The hand moves on every frame.
  @override
  bool shouldRepaint(_SweepPainter old) => true;
}
