import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../domain/scene_weather.dart';
import '../../../core/theme.dart';

/// The view from the driver's seat, filling the screen: a sky that follows
/// the time of day (sun, sunset, moon and stars, a passing plane), hills
/// with turning wind turbines, power lines and roadside posts, the road
/// rushing past at the real speed, and the weather seen through the glass
/// (rain on the windscreen with the wiper, snow rushing at you, lightning
/// on the horizon). Below, a soft dashboard with the speed gauge and two
/// small windows. The weather is scenery, never a forecast.
class SpeedScene extends StatefulWidget {
  const SpeedScene({
    super.key,
    required this.speed,
    required this.maxSpeed,
    required this.readout,
    required this.unit,
    required this.left,
    required this.right,
    required this.dashTop,
    required this.weather,
    required this.dayPart,
  });

  /// Speed now, m/s (null before the first fix), and the gauge's top.
  final double? speed;
  final double maxSpeed;

  /// The speed as shown, in the user's unit, and that unit.
  final String readout, unit;

  /// The two windows: (value, caption).
  final (String, String) left, right;

  /// Where the dashboard starts, from the top.
  final double dashTop;

  final SceneWeather weather;
  final DayPart dayPart;

  @override
  State<SpeedScene> createState() => _SpeedSceneState();
}

/// Everything that moves in the scene, advanced each frame.
class _Motion {
  _Motion() {
    final r = math.Random(7);
    stars = [
      for (var i = 0; i < 70; i++)
        (
          r.nextDouble(),
          r.nextDouble() * 0.75,
          0.5 + r.nextDouble() * 1.2,
          r.nextDouble() * 2 * math.pi,
        ),
    ];
    flakes = [
      for (var i = 0; i < 140; i++)
        [r.nextDouble() * 2 * math.pi, r.nextDouble(), r.nextDouble()],
    ];
    drops = [
      for (var i = 0; i < 46; i++)
        [r.nextDouble(), r.nextDouble(), 0.5 + r.nextDouble(), r.nextDouble()],
    ];
    clouds = [
      for (var i = 0; i < 7; i++)
        [
          r.nextDouble(),
          0.12 + r.nextDouble() * 0.45,
          0.25 + r.nextDouble() * 0.3,
          0.2 + r.nextDouble() * 0.6,
        ],
    ];
  }

  final random = math.Random(11);

  /// Stars: x, y (fractions of the sky), size, twinkle phase.
  late final List<(double, double, double, double)> stars;

  /// Snowflakes: angle, spread, depth.
  late final List<List<double>> flakes;

  /// Drops on the glass: x, y, size, age.
  late final List<List<double>> drops;

  /// Clouds: x, height, width, drift speed.
  late final List<List<double>> clouds;

  double time = 0, road = 0, turbine = 0, wiper = 0, plane = 0.15;
  double flash = 0, nextFlash = 3;

  /// The lightning bolt's sideways steps on the way down.
  List<double> bolt = const [];

  void advance(double dt, double speed, SceneWeather weather) {
    time += dt;
    // One lane mark every 12 m of road.
    road = (road + speed * dt / 12) % 1;
    turbine += dt * 1.6;
    plane += dt * 0.025;
    if (plane > 1.4) plane = -0.4;
    for (final c in clouds) {
      c[0] += dt * 0.004 * c[3];
      if (c[0] > 1.3) c[0] = -0.4;
    }
    if (weather == SceneWeather.snow) {
      for (final f in flakes) {
        f[2] += dt * (0.08 + speed * 0.02);
        if (f[2] > 1) {
          f
            ..[0] = random.nextDouble() * 2 * math.pi
            ..[1] = random.nextDouble()
            ..[2] = 0;
        }
      }
    }
    if (weather == SceneWeather.rain || weather == SceneWeather.storm) {
      wiper += dt * 1.4;
      for (final d in drops) {
        d[3] += dt * 0.25;
        d[0] -= dt * speed * 0.004 * d[2];
        if (d[3] > 1 || d[0] < 0) {
          d
            ..[0] = random.nextDouble()
            ..[1] = random.nextDouble()
            ..[3] = 0;
        }
      }
    }
    if (weather == SceneWeather.storm) {
      nextFlash -= dt;
      if (nextFlash < 0) {
        flash = 1;
        nextFlash = 2.5 + random.nextDouble() * 4;
        bolt = [for (var i = 0; i < 12; i++) (random.nextDouble() - 0.5) * 24];
      }
      flash = math.max(0, flash - dt * 3);
    }
  }
}

class _SpeedSceneState extends State<SpeedScene>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_tick);
  final _motion = _Motion();
  Duration _last = Duration.zero;

  /// The gauge eases to the speed.
  double _shown = 0;

  void _tick(Duration now) {
    final dt = _last == Duration.zero
        ? 0.0
        : ((now - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = now;
    final target = widget.speed ?? 0;
    _motion.advance(dt, target, widget.weather);
    _shown += (target - _shown) * math.min(1, dt * 6);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // The sky lives (plane, turbines, weather) while the tool is open.
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size.infinite,
    painter: _ScenePainter(
      palette: Palette.of(context),
      motion: _motion,
      speed: widget.speed ?? 0,
      fill: (_shown / widget.maxSpeed).clamp(0.0, 1.0),
      readout: widget.readout,
      unit: widget.unit,
      left: widget.left,
      right: widget.right,
      dashTop: widget.dashTop,
      weather: widget.weather,
      dayPart: widget.dayPart,
    ),
  );
}

class _ScenePainter extends CustomPainter {
  _ScenePainter({
    required this.palette,
    required this.motion,
    required this.speed,
    required this.fill,
    required this.readout,
    required this.unit,
    required this.left,
    required this.right,
    required this.dashTop,
    required this.weather,
    required this.dayPart,
  });

  final Palette palette;
  final _Motion motion;
  final double speed, fill, dashTop;
  final String readout, unit;
  final (String, String) left, right;
  final SceneWeather weather;
  final DayPart dayPart;

  bool get _night => dayPart == DayPart.night;
  bool get _wet =>
      weather == SceneWeather.rain || weather == SceneWeather.storm;

  /// How much the weather greys the sky.
  double get _gloom => switch (weather) {
    SceneWeather.sunny => 0,
    SceneWeather.cloudy => 0.35,
    SceneWeather.storm => 0.65,
    _ => 0.45,
  };

  static Color _c(int r, int g, int b, [double a = 1]) =>
      Color.fromRGBO(r, g, b, a);

  static const _skies = {
    DayPart.day: (Color(0xFF78ACE4), Color(0xFFD6E8F8)),
    DayPart.dusk: (Color(0xFF404A80), Color(0xFFFFAA78)),
    DayPart.night: (Color(0xFF0A1022), Color(0xFF283454)),
  };
  static const _grounds = {
    DayPart.day: Color(0xFFAEC4A0),
    DayPart.dusk: Color(0xFF78706E),
    DayPart.night: Color(0xFF1E2428),
  };

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, cx = w / 2;
    final hz = dashTop * 0.64;
    final grey = _night ? const Color(0xFF181C24) : const Color(0xFF969EAA);
    final (skyTop, skyLow) = _skies[dayPart]!;
    final top = Color.lerp(skyTop, grey, _gloom)!;
    final low = Color.lerp(skyLow, grey, _gloom * 0.8)!;

    // The sky, to the very top of the screen.
    final sky = Rect.fromLTWH(0, 0, w, hz);
    canvas.drawRect(
      sky,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [top, low],
        ).createShader(sky),
    );
    _sunMoon(canvas, w, hz, top);
    _plane(canvas, w, hz);
    _clouds(canvas, w, hz);
    if (weather == SceneWeather.storm) _lightning(canvas, w, hz);

    // Hills with wind turbines, then the ground.
    final ground = Color.lerp(
      _grounds[dayPart]!,
      const Color(0xFF787E88),
      _gloom * 0.5,
    )!;
    double ridge(double x) =>
        hz - 22 - math.sin(x / 50) * 10 - math.sin(x / 23 + 1) * 5;
    final hills = Path()..moveTo(0, hz);
    for (var x = 0.0; x <= w; x += 10) {
      hills.lineTo(x, ridge(x));
    }
    hills
      ..lineTo(w, hz)
      ..close();
    canvas.drawPath(hills, Paint()..color = Color.lerp(ground, low, 0.45)!);
    _turbines(canvas, w, ridge);
    canvas.drawRect(
      Rect.fromLTWH(0, hz, w, size.height - hz),
      Paint()..color = ground,
    );
    if (weather == SceneWeather.snow) {
      canvas.drawRect(
        Rect.fromLTWH(0, hz, w, dashTop - hz + 40),
        Paint()..color = const Color(0xD9F5F8FC),
      );
    }

    _road(canvas, w, cx, hz);
    if (weather == SceneWeather.snow) _snow(canvas, w, cx, hz);
    if (_wet) _rain(canvas, w);

    // Windscreen pillars, and a soft glare on a sunny day.
    final pillar = Paint()
      ..color = palette.isDark ? const Color(0xFF1C1C1C) : palette.wellDark;
    canvas
      ..drawPath(
        Path()
          ..moveTo(0, 0)
          ..lineTo(w * 0.08, 0)
          ..lineTo(0, dashTop)
          ..close(),
        pillar,
      )
      ..drawPath(
        Path()
          ..moveTo(w, 0)
          ..lineTo(w * 0.92, 0)
          ..lineTo(w, dashTop)
          ..close(),
        pillar,
      );
    if (dayPart == DayPart.day && weather == SceneWeather.sunny) {
      canvas.drawRect(
        sky,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0.8, 0.4),
            colors: [Color(0x00FFFFFF), Color(0x1FFFFFFF), Color(0x00FFFFFF)],
          ).createShader(sky),
      );
    }
    // A shade behind the header, so its white title reads on any sky.
    final shade = Rect.fromLTWH(0, 0, w, 130);
    canvas.drawRect(
      shade,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, _night || _gloom > 0.5 ? 0.28 : 0.14),
            const Color(0x00000000),
          ],
        ).createShader(shade),
    );

    _dashboard(canvas, size);
  }

  void _sunMoon(Canvas canvas, double w, double hz, Color sky) {
    if (_night) {
      if (_wet) return;
      for (final (x, y, s, phase) in motion.stars) {
        final a =
            (0.4 + 0.5 * math.sin(motion.time * 1.1 + phase).abs()) *
            (1 - _gloom);
        canvas.drawCircle(
          Offset(x * w, y * hz),
          s,
          Paint()..color = Color.fromRGBO(255, 255, 255, a),
        );
      }
      final c = Offset(w * 0.86, hz * 0.66);
      canvas
        ..drawCircle(
          c,
          70,
          Paint()
            ..shader = RadialGradient(
              colors: [_c(255, 248, 225, 0.35), _c(255, 248, 225, 0)],
            ).createShader(Rect.fromCircle(center: c, radius: 70)),
        )
        ..drawCircle(c, 17, Paint()..color = const Color(0xFFFFF6DE))
        ..drawCircle(c + const Offset(7, -4), 15, Paint()..color = sky);
      return;
    }
    if (weather == SceneWeather.storm) return;
    final day = dayPart == DayPart.day;
    final c = day ? Offset(w * 0.86, hz * 0.66) : Offset(w * 0.3, hz - 34);
    final vis = (1 - _gloom * 1.2).clamp(0.0, 1.0);
    if (vis == 0) return;
    canvas
      ..drawCircle(
        c,
        120,
        Paint()
          ..shader = RadialGradient(
            colors: [_c(255, 236, 190, 0.75 * vis), _c(255, 236, 190, 0)],
          ).createShader(Rect.fromCircle(center: c, radius: 120)),
      )
      ..drawCircle(
        c,
        day ? 20 : 26,
        Paint()..color = day ? _c(255, 250, 232, vis) : _c(255, 186, 120, vis),
      );
  }

  void _plane(Canvas canvas, double w, double hz) {
    if (weather == SceneWeather.storm) return;
    final p = Offset(motion.plane * w, hz * 0.68 + motion.plane * 18);
    if (!_night) {
      final tail = p - Offset(160, 160 * 18 / w);
      canvas.drawLine(
        tail,
        p - const Offset(8, 0),
        Paint()
          ..strokeWidth = 2.5
          ..shader = LinearGradient(
            colors: [
              _c(255, 255, 255, 0),
              _c(255, 255, 255, 0.7 * (1 - _gloom)),
            ],
          ).createShader(Rect.fromPoints(tail, p)),
      );
    }
    final body = Paint()
      ..color = _night ? const Color(0xFF20242C) : const Color(0xD946515A);
    canvas
      ..save()
      ..translate(p.dx, p.dy)
      ..rotate(0.05)
      ..drawOval(
        Rect.fromCenter(center: Offset.zero, width: 18, height: 3.6),
        body,
      )
      ..drawPath(
        Path()
          ..moveTo(-1, 0)
          ..lineTo(-5, -6)
          ..lineTo(2, 0)
          ..lineTo(-5, 6)
          ..close(),
        body,
      )
      ..restore();
    if (_night && math.sin(motion.time * 5.5) > 0.6) {
      canvas.drawCircle(p, 1.8, Paint()..color = const Color(0xFFFF5050));
    }
  }

  void _clouds(Canvas canvas, double w, double hz) {
    if (weather == SceneWeather.sunny && dayPart != DayPart.dusk) return;
    final a = weather == SceneWeather.sunny ? 0.25 : 0.5 + _gloom * 0.4;
    final col = _night
        ? const Color(0xFF464C5A)
        : weather == SceneWeather.storm
        ? const Color(0xFF5C6270)
        : dayPart == DayPart.dusk
        ? const Color(0xFFFFC4AA)
        : const Color(0xFFFAFCFF);
    final paint = Paint()..color = col.withValues(alpha: a * 0.55);
    for (final c in motion.clouds) {
      final x = c[0] * w, y = c[1] * hz * 0.8, cw = c[2] * w;
      for (var k = 0; k < 5; k++) {
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(x + (k - 2) * cw * 0.18, y - math.sin(k * 1.3) * 8),
            width: cw * 0.44,
            height: cw * 0.22,
          ),
          paint,
        );
      }
    }
  }

  void _lightning(Canvas canvas, double w, double hz) {
    final f = motion.flash;
    if (f <= 0) return;
    if (f > 0.3 && motion.bolt.isNotEmpty) {
      var x = w * 0.22, y = 60.0;
      final bolt = Path()..moveTo(x, y);
      for (final dx in motion.bolt) {
        x += dx;
        y += 20;
        if (y > hz - 20) break;
        bolt.lineTo(x, y);
      }
      canvas.drawPath(
        bolt,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = _c(235, 240, 255, f),
      );
    }
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, hz),
      Paint()..color = _c(220, 228, 255, f * 0.35),
    );
  }

  void _turbines(Canvas canvas, double w, double Function(double) ridge) {
    final paint = Paint()
      ..color = _night ? _c(160, 170, 190, 0.5) : _c(255, 255, 255, 0.9)
      ..strokeCap = StrokeCap.round;
    for (final (tx, s) in const [(0.12, 1.0), (0.2, 0.8), (0.86, 0.9)]) {
      final x = tx * w, base = ridge(x), h = 34 * s;
      final hub = Offset(x, base - h);
      paint.strokeWidth = 1.6 * s;
      canvas.drawLine(Offset(x, base), hub, paint);
      for (var k = 0; k < 3; k++) {
        final a = motion.turbine + k * 2 * math.pi / 3;
        canvas.drawLine(hub, hub + Offset.fromDirection(a, 16 * s), paint);
      }
      if (_night && math.sin(motion.time * 2.5 + tx * 9) > 0.5) {
        canvas.drawCircle(hub, 1.6, Paint()..color = const Color(0xFFFF4A4A));
      }
    }
  }

  void _road(Canvas canvas, double w, double cx, double hz) {
    final bottom = dashTop + 30;
    final roadColor = _night
        ? const Color(0xFF2C3038)
        : _wet
        ? const Color(0xFF5C6470)
        : const Color(0xFFAAB0BA);
    canvas.drawPath(
      Path()
        ..moveTo(cx - 3, hz)
        ..lineTo(cx + 3, hz)
        ..lineTo(cx + w * 0.62, bottom)
        ..lineTo(cx - w * 0.62, bottom)
        ..close(),
      Paint()..color = roadColor,
    );
    if (_wet) {
      // A wet sheen down the middle.
      final sheen = Rect.fromLTRB(cx - 30, hz, cx + 30, bottom);
      canvas.drawPath(
        Path()
          ..moveTo(cx - 30, bottom)
          ..lineTo(cx, hz)
          ..lineTo(cx + 30, bottom)
          ..close(),
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x00FFFFFF), Color(0x2EFFFFFF)],
          ).createShader(sheen),
      );
    }
    if (_night) {
      final beam = Rect.fromLTRB(0, hz + 30, w, bottom);
      for (final side in const [-1.0, 1.0]) {
        canvas.drawPath(
          Path()
            ..moveTo(cx + side * 40, bottom)
            ..lineTo(cx + side * 150, bottom)
            ..lineTo(cx + side * 14, hz + 40)
            ..lineTo(cx + side * 2, hz + 40)
            ..close(),
          Paint()
            ..shader = const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0x52FFECBE), Color(0x00FFECBE)],
            ).createShader(beam),
        );
      }
    }
    double depth(double t) => t * t;
    final mark = Paint()
      ..color = _night ? const Color(0xBFFFFFFF) : const Color(0xFFFFFFFF);
    for (var k = 0; k < 8; k++) {
      final z = depth((k / 8 + motion.road) % 1);
      final y = hz + (bottom - hz) * z;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(cx, y + (3 + z * 18) / 2),
          width: 1 + z * 5,
          height: 3 + z * 18,
        ),
        mark,
      );
    }
    // Power line poles on the right, with sagging wires between them.
    final poles = <(Offset, double)>[];
    final pole = Paint()
      ..color = _night ? const Color(0xFF2B2F36) : const Color(0xE66E6054);
    for (var k = 0; k < 5; k++) {
      final z = depth((k / 5 + motion.road * 0.35) % 1);
      final x = cx + w * (0.1 + 0.9 * z), y = hz + (dashTop - hz) * z;
      final h = 8 + z * (dashTop - hz) * 1.1;
      poles.add((Offset(x, y - h), z));
      canvas
        ..drawRect(Rect.fromLTWH(x - 0.6 - z * 2, y - h, 1.2 + z * 4, h), pole)
        ..drawRect(
          Rect.fromLTWH(x - 3 - z * 14, y - h + 2, 6 + z * 28, 1 + z * 2.5),
          pole,
        );
    }
    poles.sort((a, b) => a.$2.compareTo(b.$2));
    final wire = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = _night ? _c(120, 130, 150, 0.5) : _c(60, 60, 60, 0.45);
    for (var k = 0; k < poles.length - 1; k++) {
      final a = poles[k].$1, b = poles[k + 1].$1;
      canvas.drawPath(
        Path()
          ..moveTo(a.dx, a.dy + 3)
          ..quadraticBezierTo(
            (a.dx + b.dx) / 2,
            (a.dy + b.dy) / 2 + 14,
            b.dx,
            b.dy + 3,
          ),
        wire,
      );
    }
    // Roadside posts on the left, orange topped.
    for (var k = 0; k < 8; k++) {
      final z = depth((k / 8 + motion.road) % 1);
      final x = cx - w * (0.04 + 0.62 * z) * 1.05, y = hz + (dashTop - hz) * z;
      final h = 4 + z * 30, pw = 1 + z * 4;
      canvas
        ..drawRect(
          Rect.fromLTWH(x - pw / 2, y - h, pw, h),
          Paint()
            ..color = weather == SceneWeather.snow
                ? const Color(0xFF99AAAA)
                : const Color(0xFFF2F2F2),
        )
        ..drawRect(
          Rect.fromLTWH(x - pw / 2, y - h, pw, 2 + z * 5),
          Paint()..color = palette.ballLight,
        );
    }
  }

  void _snow(Canvas canvas, double w, double cx, double hz) {
    final from = Offset(cx, hz - 20);
    final flake = Paint()..strokeCap = StrokeCap.round;
    for (final f in motion.flakes) {
      final a = f[0], z = f[2];
      final d = (0.05 + f[1]) * z * z * w * 1.2;
      final p = from + Offset(math.cos(a) * d, math.sin(a) * d * 0.7 + z * 40);
      if (p.dy > dashTop) continue;
      final trail = math.min(18.0, speed * z * 0.6);
      canvas.drawLine(
        p,
        p - Offset(math.cos(a) * trail, math.sin(a) * trail * 0.7),
        flake
          ..strokeWidth = 0.6 + z * 3.2
          ..color = _c(255, 255, 255, 0.3 + z * 0.6),
      );
    }
  }

  void _rain(Canvas canvas, double w) {
    final m = motion;
    final streak = Paint()
      ..strokeWidth = 1
      ..color = _c(220, 230, 245, 0.35);
    final ms = m.time * 1000;
    for (var k = 0; k < 80; k++) {
      final x = ((k * 37.3 + ms * 0.4) % (w + 60)) - 30;
      final y = (k * 53.1 + ms * 0.9) % (dashTop - 40);
      canvas.drawLine(
        Offset(x, y),
        Offset(x - 2 - speed * 0.15, y + 12),
        streak,
      );
    }
    // Drops on the glass; the wiper clears those it passes.
    final sweep = math.sin(m.wiper).abs() * math.pi * 0.85;
    final pivot = Offset(w * 0.3, dashTop + 6);
    for (final d in m.drops) {
      final p = Offset(d[0] * w, 30 + d[1] * (dashTop - 60));
      final at = math.atan2(pivot.dy - p.dy, p.dx - pivot.dx);
      if ((at - (math.pi - sweep)).abs() < 0.12) {
        d[3] = 0;
        continue;
      }
      final r = 1.5 + d[2] * 2.5;
      canvas.drawOval(
        Rect.fromCenter(center: p, width: r * 2, height: r * 2.4),
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.3, -0.3),
            colors: [_c(255, 255, 255, 0.75), _c(200, 215, 235, 0.15)],
          ).createShader(Rect.fromCircle(center: p, radius: r)),
      );
    }
    canvas
      ..save()
      ..translate(pivot.dx, pivot.dy)
      ..rotate(-math.pi + sweep)
      ..drawLine(
        Offset.zero,
        Offset(w * 0.62, 0),
        Paint()
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xFF1D1F23),
      )
      ..restore();
  }

  void _dashboard(Canvas canvas, Size size) {
    final p = palette, w = size.width, cx = w / 2;
    final dash = Path()
      ..moveTo(-10, size.height)
      ..lineTo(-10, dashTop + 10)
      ..quadraticBezierTo(cx, dashTop - 40, w + 10, dashTop + 10)
      ..lineTo(w + 10, size.height)
      ..close();
    final box = Rect.fromLTWH(0, dashTop - 40, w, size.height - dashTop + 40);
    canvas
      ..drawPath(
        dash.shift(const Offset(0, -6)),
        Paint()
          ..color = p.dialShadow.withValues(alpha: 0.6)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
      )
      ..drawPath(
        dash,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [p.dialLight, p.dialDark],
          ).createShader(box),
      );

    // The gauge: a recessed well with the orange arc and the ball.
    final s = (w / 380).clamp(0.8, 1.3);
    final c = Offset(cx, dashTop + 74 * s), r = 60 * s;
    final well = Paint()..color = p.isDark ? p.wellDark : p.wellLight;
    canvas.drawCircle(c, r + 12 * s, well);
    const start = 150 * math.pi / 180, sweep = 240 * math.pi / 180;
    final arc = Rect.fromCircle(center: c, radius: r);
    canvas.drawArc(
      arc,
      start,
      sweep,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7 * s
        ..strokeCap = StrokeCap.round
        ..color = p.isDark ? const Color(0xFF333333) : p.tickMinor,
    );
    if (fill > 0.003) {
      canvas.drawArc(
        arc,
        start,
        sweep * fill,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7 * s
          ..strokeCap = StrokeCap.round
          ..shader = LinearGradient(colors: [p.ballLight, p.ballDark])
              .createShader(arc),
      );
    }
    final tip = c + Offset.fromDirection(start + sweep * fill, r);
    final ball = 6.5 * s;
    canvas.drawCircle(
      tip,
      ball,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.4),
          colors: [p.ballLight, p.ballDark],
        ).createShader(Rect.fromCircle(center: tip, radius: ball)),
    );
    _text(canvas, readout, c + Offset(0, 2 * s), 32 * s, p.inkStrong, true);
    _text(canvas, unit, c + Offset(0, 24 * s), 10.5 * s, p.label, false);

    // Two small windows either side.
    for (final (dx, (value, caption)) in [(-1.0, left), (1.0, right)]) {
      final at = Offset(cx + dx * 128 * s, c.dy);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: at, width: 78 * s, height: 42 * s),
          Radius.circular(12 * s),
        ),
        well,
      );
      _text(canvas, value, at - Offset(0, 6 * s), 13 * s, p.ink, true);
      _text(canvas, caption, at + Offset(0, 11 * s), 9.5 * s, p.label, false);
    }
  }

  void _text(
    Canvas canvas,
    String text,
    Offset centre,
    double size,
    Color color,
    bool bold,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: size,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          fontFeatures: readoutFeatures,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    tp.paint(canvas, centre - Offset(tp.width / 2, tp.height / 2));
  }

  /// The scene moves every frame.
  @override
  bool shouldRepaint(_ScenePainter old) => true;
}
