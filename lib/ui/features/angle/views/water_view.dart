import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../domain/angles.dart';
import '../../../core/controls.dart';
import '../../../core/theme.dart';
import '../view_models/angle_view_model.dart';

/// Where the half dial lights up: on which side, and how far round from
/// 0° (straight up).
typedef DialMark = ({EdgeSide side, double degrees});

/// The Angle tool on an edge: the screen fills with water whose surface
/// stays level with the world, so it tilts against the phone by the
/// phone's angle. It follows with a little slosh and settles, like water in
/// a glass. The water is the dial's soft white material, in layers that
/// deepen in shade; the reading sits in the middle under a half dial whose
/// ticks light up orange from straight up round to the reading.
class WaterView extends StatefulWidget {
  const WaterView({
    super.key,
    required this.surface,
    required this.value,
    required this.semanticsLabel,
    this.mark,
  });

  /// The water surface's angle on screen, degrees clockwise; null while no
  /// edge can be read (the surface then lies still and flat).
  final double? surface;

  final String value;
  final String semanticsLabel;

  /// What the half dial shows: the measured edge's angle, or how far the
  /// phone turned from a zero; null while there's no reading.
  final DialMark? mark;

  @override
  State<WaterView> createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView>
    with SingleTickerProviderStateMixin {
  // A lightly damped spring: the water overshoots a little and settles in
  // about a second.
  static const _stiffness = 40.0, _damping = 5.5;

  late final Ticker _ticker = createTicker(_tick);
  Duration _last = Duration.zero;

  /// Surface angle shown (degrees) and how fast it's turning (°/s).
  late double _angle = widget.surface ?? 0;
  double _speed = 0;

  /// Height of the waves (logical px) and their travel.
  double _waves = 0;
  double _phase = 0;

  double get _target {
    // The short way round, so 179° to −179° is a small step, not a spin.
    final t = widget.surface ?? 0;
    return _angle + wrap180(t - _angle);
  }

  @override
  void didUpdateWidget(WaterView old) {
    super.didUpdateWidget(old);
    if (widget.surface != old.surface && !_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    }
  }

  @override
  void initState() {
    super.initState();
    _ticker.start();
  }

  void _tick(Duration now) {
    final dt = _last == Duration.zero
        ? 1 / 60
        : ((now - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = now;
    final pull = _target - _angle;
    _speed += (_stiffness * pull - _damping * _speed) * dt;
    _angle += _speed * dt;
    // Turning stirs up waves; they die away on their own.
    _waves = math.min(
      22,
      _waves * math.exp(-dt / 0.9) + _speed.abs() * 0.035 * dt * 60,
    );
    _phase += dt * 3.2;
    final settled = pull.abs() < 0.05 && _speed.abs() < 0.05 && _waves < 0.15;
    setState(() {
      if (settled) {
        _angle = _target;
        _speed = 0;
        _waves = 0;
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
    final p = Palette.of(context);
    return Semantics(
      label: widget.semanticsLabel,
      excludeSemantics: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRect(
            child: CustomPaint(
              painter: _WaterPainter(
                palette: p,
                angle: _angle,
                waves: _waves,
                phase: _phase,
                mark: widget.mark,
              ),
            ),
          ),
          Center(child: _Readout(value: widget.value)),
        ],
      ),
    );
  }
}

/// The reading on a soft raised disc, readable over water and air alike.
class _Readout extends StatelessWidget {
  const _Readout({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      width: 148,
      height: 148,
      alignment: Alignment.center,
      decoration: softSurface(p, radius: BorderRadius.circular(74)),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            value,
            textDirection: TextDirection.ltr,
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              fontFeatures: readoutFeatures,
              color: p.inkStrong,
            ),
          ),
        ),
      ),
    );
  }
}

class _WaterPainter extends CustomPainter {
  _WaterPainter({
    required this.palette,
    required this.angle,
    required this.waves,
    required this.phase,
    required this.mark,
  });

  final Palette palette;
  final double angle, waves, phase;
  final DialMark? mark;

  static const _deg = math.pi / 180;

  /// The half dial, just outside the reading's disc: the track the ball
  /// runs on, where the ticks start, and the labels.
  static const _trackR = 92.0, _tickR = 104.0, _labelR = 140.0;

  /// How deep each layer of the water starts below the surface.
  static const _layers = [64.0, 150.0, 260.0];

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    canvas
      ..save()
      ..translate(c.dx, c.dy)
      ..rotate(angle * _deg);
    _water(canvas, size.longestSide);
    canvas.restore();
    _dial(canvas, c);
  }

  /// In the water's own frame: level is the x axis, down is +y.
  void _water(Canvas canvas, double r) {
    final p = palette;
    // A wavy line across the whole box at any angle, and the water below it.
    Path line(double Function(double) y) {
      final path = Path()..moveTo(-r, y(-r));
      for (var x = -r; x <= r; x += 8) {
        path.lineTo(x, y(x));
      }
      return path;
    }

    Path body(double Function(double) y) => line(y)
      ..lineTo(r, r)
      ..lineTo(-r, r)
      ..close();

    // Two overlapping waves on the surface; a fainter one behind, out of
    // step, gives the water depth.
    double front(double x) =>
        waves * math.sin(x / 46 + phase) +
        waves * 0.45 * math.sin(x / 23 - phase * 1.7);
    double back(double x) =>
        waves * 0.8 * math.sin(x / 38 - phase * 1.3) - 10 - waves * 0.4;

    final water = body(front);
    final glowColor = p.isDark ? p.haloRimLight : p.dialGlow;
    canvas
      ..drawPath(
        body(back),
        Paint()..color = p.dialShadow.withValues(alpha: p.isDark ? 0.5 : 0.22),
      )
      // The water stands raised from the page like the dial: a soft shadow
      // along its surface ...
      ..drawPath(
        water.shift(const Offset(0, -4)),
        Paint()
          ..color = p.dialShadow.withValues(alpha: p.isDark ? 0.9 : 0.6)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
      )
      // ... and the dial's white shading, brightest at the surface.
      ..drawPath(
        water,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [p.haloLight, p.dialLight, p.haloRimDark],
            stops: const [0, 0.25, 1],
          ).createShader(Rect.fromLTRB(-r, 0, r, r * 0.7)),
      );

    // Deeper layers, each a shade darker, with gentle swells that move
    // with the slosh. Their edges are blurred so each shade melts into the
    // next while the waves still show.
    final layer = Paint()
      ..color = p.dialShadow.withValues(alpha: p.isDark ? 0.26 : 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    for (final (i, depth) in _layers.indexed) {
      final amp = 6 + waves * 0.5;
      final dir = i.isEven ? 1 : -1;
      double y(double x) =>
          depth +
          amp * math.sin(x / (70 + i * 18) + dir * phase * 0.8 + i * 1.9) +
          amp * 0.4 * math.sin(x / 31 - dir * phase * 1.2 + i);
      canvas.drawPath(body(y), layer);
    }

    // Light catching the surface.
    canvas.drawPath(
      line(front),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..color = glowColor,
    );
  }

  /// A half dial over the reading, in the phone's frame: 0° straight up,
  /// 90° at each side. On the [mark]'s side the ticks light up orange from
  /// 0° round to the reading, with the ball at the end.
  void _dial(Canvas canvas, Offset c) {
    final p = palette;
    const up = -90.0;

    double? to;
    if (mark case final m?) {
      final d = m.degrees.clamp(0.0, 90.0);
      to = m.side == EdgeSide.right ? up + d : up - d;
    }
    final sweep = to == null ? 0.0 : to - up;
    // How far along the lit stretch [a] is (0 at the long edge, 1 at the
    // ball), or null outside it.
    // Up to the reading as shown (to 0.1°), so "90.0°" from 89.96° still
    // lights the 90 tick.
    double? lit(double a) {
      if (to == null) return null;
      final along = (a - up) * (sweep < 0 ? -1 : 1);
      if (along < 0 || along > sweep.abs() + 0.05) return null;
      return sweep.abs() < 0.5 ? 0 : (along / sweep.abs()).clamp(0.0, 1.0);
    }

    // The track, faded.
    final rect = Rect.fromCircle(center: c, radius: _trackR);
    canvas.drawArc(
      rect,
      math.pi,
      math.pi,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..color = p.tickMinor.withValues(alpha: 0.6),
    );

    // Ticks every 5°, longer every 15° and 30°, longest up the long edge.
    final tick = Paint()..strokeCap = StrokeCap.round;
    for (var a = -180; a <= 0; a += 5) {
      final major = a % 30 == 0;
      final len = a == up
          ? 24.0
          : major
          ? 14.0
          : a % 15 == 0
          ? 10.0
          : 6.0;
      final t = lit(a.toDouble());
      final d = Offset.fromDirection(a * _deg);
      canvas.drawLine(
        c + d * _tickR,
        c + d * (_tickR + len),
        tick
          ..strokeWidth = major ? 2.4 : 1.6
          ..color = t != null
              ? Color.lerp(p.ballLight, p.ballDark, t)!
              : (major ? p.tickMajor : p.tickMinor).withValues(alpha: 0.7),
      );
    }

    // Labels every 30°: degrees from the long edge.
    for (var a = -180; a <= 0; a += 30) {
      final on = lit(a.toDouble()) != null;
      final text = TextPainter(
        text: TextSpan(
          text: '${(a - up).abs().round()}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: on ? FontWeight.w700 : FontWeight.w500,
            fontFeatures: readoutFeatures,
            color: on ? p.accentText : p.label,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final at = c + Offset.fromDirection(a * _deg, _labelR);
      text
        ..paint(canvas, at - Offset(text.width / 2, text.height / 2))
        ..dispose();
    }

    if (to == null) return;
    // The lit stretch of track: light at the long edge, deepening toward
    // the ball; 10° spare at each end keeps the round caps inside the
    // gradient.
    final span = sweep.abs() + 20;
    canvas.drawArc(
      rect,
      up * _deg,
      sweep * _deg,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          endAngle: span * _deg,
          colors: sweep >= 0
              ? [p.ballLight, p.ballDark]
              : [p.ballDark, p.ballLight],
          stops: [10 / span, 1 - 10 / span],
          transform: GradientRotation((math.min(up, to) - 10) * _deg),
        ).createShader(rect),
    );
    final ball = c + Offset.fromDirection(to * _deg, _trackR);
    canvas
      ..drawCircle(
        ball + const Offset(1, 2),
        9,
        Paint()
          ..color = p.ballDark.withValues(alpha: 0.35)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      )
      ..drawCircle(
        ball,
        8,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.4, -0.4),
            colors: [p.ballLight, p.ballDark],
          ).createShader(Rect.fromCircle(center: ball, radius: 8)),
      );
  }

  @override
  bool shouldRepaint(_WaterPainter old) =>
      old.angle != angle ||
      old.waves != waves ||
      old.phase != phase ||
      old.mark != mark ||
      old.palette != palette;
}
