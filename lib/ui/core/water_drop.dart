import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'dial.dart';
import 'theme.dart';

/// The Level's bubble as a drop of water lying over the dial's centre: a
/// soft body that slides toward the high side, stretches as it goes,
/// overshoots and wobbles when it stops, and pulls itself round again with
/// surface tension. Clear, so the reading shows through, with a bright
/// highlight, a darker rim where the light bends, and light focused into
/// its shadow.
class WaterDropBubble extends StatefulWidget {
  const WaterDropBubble({
    super.key,
    required this.offset,
    required this.locked,
    required this.reserved,
  });

  /// Where the drop sits, each axis in −1…1 (as [InstrumentDial.bubble]).
  final Offset offset;

  /// Level reached: the drop glows orange.
  final bool locked;

  /// As [InstrumentDial.reserved], so the drop matches the dial's size.
  final double reserved;

  @override
  State<WaterDropBubble> createState() => _WaterDropBubbleState();
}

class _WaterDropBubbleState extends State<WaterDropBubble>
    with SingleTickerProviderStateMixin {
  /// Points around the rim.
  static const _n = 40;

  late final Ticker _ticker = createTicker(_tick);
  Duration _last = Duration.zero;

  /// The centre, in the same −1…1 units as the offset, and its speed.
  late Offset _at = widget.offset;
  Offset _speed = Offset.zero;

  /// Each rim point's radius as a fraction of the drop's, and its speed.
  final _rim = List<double>.filled(_n, 1);
  final _rimSpeed = List<double>.filled(_n, 0);

  @override
  void didUpdateWidget(WaterDropBubble old) {
    super.didUpdateWidget(old);
    if (widget.offset != old.offset && !_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    }
  }

  void _tick(Duration now) {
    final dt = _last == Duration.zero
        ? 1 / 60
        : ((now - _last).inMicroseconds / 1e6).clamp(0.0, 1 / 30);
    _last = now;
    // The centre: a lightly damped spring to where the tilt puts it.
    final accel = (widget.offset - _at) * 90 - _speed * 11;
    _speed += accel * dt;
    _at += _speed * dt;
    // The rim leans back against the acceleration and stretches along the
    // path; tension pulls neighbours together; the volume is kept.
    var mean = 0.0;
    var restless = 0.0;
    for (var i = 0; i < _n; i++) {
      final a = i / _n * 2 * math.pi;
      final d = Offset(math.cos(a), math.sin(a));
      final lean = -(accel.dx * d.dx + accel.dy * d.dy) * 0.0016;
      final along = (_speed.dx * d.dx + _speed.dy * d.dy).abs() * 0.05;
      final left = _rim[(i + _n - 1) % _n], right = _rim[(i + 1) % _n];
      final force =
          (1 + lean + along - _rim[i]) * 140 +
          (left + right - 2 * _rim[i]) * 160 -
          _rimSpeed[i] * 13;
      _rimSpeed[i] += force * dt;
      _rim[i] += _rimSpeed[i] * dt;
      mean += _rim[i];
      restless = math.max(restless, _rimSpeed[i].abs() + (_rim[i] - 1).abs());
    }
    mean /= _n;
    for (var i = 0; i < _n; i++) {
      _rim[i] /= mean;
    }
    // Still to the eye: snap the last fraction of a pixel and stop.
    final settled =
        (widget.offset - _at).distance < 3e-3 &&
        _speed.distance < 5e-3 &&
        restless < 6e-3;
    setState(() {
      if (settled) {
        _at = widget.offset;
        _speed = Offset.zero;
        _rim.fillRange(0, _n, 1);
        _rimSpeed.fillRange(0, _n, 0);
      }
    });
    if (settled) _ticker.stop();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _DropPainter(
          palette: Palette.of(context),
          at: _at,
          rim: List.of(_rim),
          locked: widget.locked,
          reserved: DialFit.reservedOf(context) ?? widget.reserved,
        ),
      ),
    );
  }
}

class _DropPainter extends CustomPainter {
  _DropPainter({
    required this.palette,
    required this.at,
    required this.rim,
    required this.locked,
    required this.reserved,
  });

  final Palette palette;
  final Offset at;
  final List<double> rim;
  final bool locked;
  final double reserved;

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette;
    final s = DialGeometry.scaleFor(size, reserved: reserved);
    // Same place and size as the glass ring it replaces.
    final c = size.center(Offset.zero) + at * 15 * s;
    final r = 64 * s;
    final n = rim.length;
    final points = [
      for (var i = 0; i < n; i++)
        c + Offset.fromDirection(i / n * 2 * math.pi, r * rim[i]),
    ];
    final drop = Path();
    for (var i = 0; i <= n; i++) {
      final a = points[i % n], b = points[(i + 1) % n];
      final mid = (a + b) / 2;
      i == 0
          ? drop.moveTo(mid.dx, mid.dy)
          : drop.quadraticBezierTo(a.dx, a.dy, mid.dx, mid.dy);
    }
    drop.close();
    // Tinted with the app's orange, like the ball it replaces.
    final water = p.ballDark;

    // Its shadow, with light focused into a bright spot inside it.
    canvas
      ..drawPath(
        drop.shift(Offset(5, 8) * s),
        Paint()
          ..color = p.ballDark.withValues(alpha: p.isDark ? 0.3 : 0.22)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6 * s),
      )
      ..drawCircle(
        c + Offset(r * 0.28, r * 0.34),
        r * 0.5,
        Paint()
          ..shader = ui.Gradient.radial(
            c + Offset(r * 0.28, r * 0.34),
            r * 0.5,
            [
              p.ballLight.withValues(alpha: p.isDark ? 0.3 : 0.45),
              p.ballLight.withValues(alpha: 0),
            ],
          ),
      );

    // The water: clear in the middle, deeper at the rim where light bends.
    canvas
      ..save()
      ..clipPath(drop)
      ..drawPaint(
        Paint()
          ..shader = ui.Gradient.radial(
            c - Offset(r * 0.2, r * 0.25),
            r * 1.15,
            [
              p.ballLight.withValues(alpha: 0.06),
              p.ballLight.withValues(alpha: 0.14),
              water.withValues(alpha: p.isDark ? 0.55 : 0.5),
            ],
            const [0, 0.72, 1],
          ),
      )
      // A sharp highlight near the top left, following its shape.
      ..drawOval(
        Rect.fromCenter(
          center: c - Offset(r * 0.38, r * 0.44),
          width: r * 0.7,
          height: r * 0.42,
        ),
        Paint()
          ..shader = ui.Gradient.radial(
            c - Offset(r * 0.38, r * 0.44),
            r * 0.38,
            [
              Colors.white.withValues(alpha: 0.95),
              Colors.white.withValues(alpha: 0),
            ],
          ),
      )
      ..restore();

    // The edge: a thin bright line at the top left, darker at the bottom
    // right; orange when level.
    canvas.drawPath(
      drop,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = (locked ? 2.4 : 1.4) * s
        ..shader = ui.Gradient.linear(
          c - Offset(r, r),
          c + Offset(r, r),
          locked
              ? [p.ballLight, p.ballDark]
              : [
                  Colors.white.withValues(alpha: p.isDark ? 0.5 : 0.95),
                  water.withValues(alpha: 0.6),
                ],
        ),
    );
    if (locked) {
      canvas.drawPath(
        drop,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6 * s
          ..color = p.ballDark.withValues(alpha: 0.25)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 * s),
      );
    }
  }

  @override
  bool shouldRepaint(_DropPainter old) =>
      old.at != at ||
      old.locked != locked ||
      old.palette != palette ||
      old.reserved != reserved ||
      !_same(old.rim, rim);

  static bool _same(List<double> a, List<double> b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
