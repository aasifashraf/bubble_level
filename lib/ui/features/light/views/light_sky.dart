import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../domain/light.dart';
import '../../../core/controls.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';

/// The light meter's instrument: a sky that follows the light. Dark is
/// night with a moon and stars; dim light is dawn; as it gets brighter the
/// sun rises along its arc until it stands high in direct sunlight. The
/// reading rests on soft hills in the app's raised material.
class LightSky extends StatefulWidget {
  const LightSky({
    super.key,
    required this.lux,
    required this.value,
    required this.footCandles,
    required this.semanticsLabel,
    this.bottomInset = 0,
  });

  final double lux;

  /// Room left free at the bottom for the footer; the hills run on behind
  /// it to the screen's edge.
  final double bottomInset;

  /// The reading as shown: lux, and foot-candles under it.
  final String value, footCandles;
  final String semanticsLabel;

  @override
  State<LightSky> createState() => _LightSkyState();
}

class _LightSkyState extends State<LightSky>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_tick);
  Duration _last = Duration.zero;

  /// The sky shown (0 night … 1 full sun), easing toward the reading.
  late double _shown = skyLevel(widget.lux);

  @override
  void didUpdateWidget(LightSky old) {
    super.didUpdateWidget(old);
    if (!_ticker.isActive && (skyLevel(widget.lux) - _shown).abs() > 1e-3) {
      _last = Duration.zero;
      _ticker.start();
    }
  }

  void _tick(Duration now) {
    final dt = _last == Duration.zero
        ? 1 / 60
        : ((now - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = now;
    final target = skyLevel(widget.lux);
    final next = _shown + (target - _shown) * math.min(1, dt * 4);
    setState(() => _shown = (target - next).abs() < 1e-3 ? target : next);
    if (_shown == target) _ticker.stop();
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
          final free = h - widget.bottomInset;
          final s = math.min(w / 375, (free - top) / 420).clamp(0.7, 1.25);
          final disc = 52 * s;
          final horizon = free - disc * 2 - 36 * s;
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _SkyPainter(
                    palette: p,
                    level: _shown,
                    horizon: horizon,
                    top: top,
                    scale: s,
                  ),
                ),
              ),
              Positioned(
                left: w / 2 - disc,
                top: horizon + 18 * s,
                width: disc * 2,
                height: disc * 2,
                child: _Readout(
                  value: widget.value,
                  footCandles: widget.footCandles,
                  scale: s,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// The reading on a raised disc: lux, and foot-candles under it.
class _Readout extends StatelessWidget {
  const _Readout({
    required this.value,
    required this.footCandles,
    required this.scale,
  });

  final String value, footCandles;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return DecoratedBox(
      decoration: softSurface(p, radius: BorderRadius.circular(999)),
      child: Padding(
        padding: EdgeInsets.all(12 * scale),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 34,
                  height: 1.05,
                  fontWeight: FontWeight.w700,
                  fontFeatures: readoutFeatures,
                  color: p.inkStrong,
                ),
              ),
              Text(
                'lx',
                textScaler: TextScaler.noScaling,
                style: TextStyle(fontSize: 12, color: p.label),
              ),
              const SizedBox(height: 2),
              Text(
                footCandles,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFeatures: readoutFeatures,
                  color: p.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkyPainter extends CustomPainter {
  _SkyPainter({
    required this.palette,
    required this.level,
    required this.horizon,
    required this.top,
    required this.scale,
  });

  final Palette palette;
  final double level, horizon, top, scale;

  // Sky colours, top and low: night, dawn, and day (light and dark theme).
  static const _night = [Color(0xFF1C2340), Color(0xFF344270)];
  static const _dawn = [Color(0xFF7896CD), Color(0xFFFAC4A0)];
  static const _dayLight = [Color(0xFFAAD6FA), Color(0xFFECF5FE)];
  static const _dayDark = [Color(0xFF466EA0), Color(0xFF78A0C8)];

  /// Stars: x across the width and y down to the horizon (0 to 1), and size.
  static const _stars = [
    (0.05, 0.10, 1.0),
    (0.14, 0.32, 1.5),
    (0.22, 0.12, 0.8),
    (0.31, 0.45, 1.2),
    (0.38, 0.22, 1.6),
    (0.47, 0.08, 1.0),
    (0.55, 0.36, 0.8),
    (0.63, 0.17, 1.4),
    (0.70, 0.52, 1.0),
    (0.81, 0.28, 1.2),
    (0.88, 0.09, 0.9),
    (0.94, 0.41, 1.5),
    (0.10, 0.58, 0.9),
    (0.27, 0.66, 1.1),
    (0.58, 0.62, 1.3),
    (0.86, 0.66, 0.8),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette, w = size.width, s = scale;
    double ease(double t) => t * t * (3 - 2 * t);
    final toDawn = ease((level / 0.5).clamp(0.0, 1.0));
    final toDay = ease(((level - 0.5) / 0.5).clamp(0.0, 1.0));
    final day = p.isDark ? _dayDark : _dayLight;
    Color sky(int i) =>
        Color.lerp(Color.lerp(_night[i], _dawn[i], toDawn), day[i], toDay)!;
    final skyRect = Rect.fromLTRB(0, 0, w, horizon + 40 * s);
    canvas.drawRect(
      skyRect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [sky(0), sky(1)],
        ).createShader(Rect.fromLTRB(0, 0, w, horizon)),
    );

    // Stars and the moon fade as the light grows.
    final night = (1 - level / 0.4).clamp(0.0, 1.0);
    if (night > 0) {
      final star = Paint()..color = Colors.white.withValues(alpha: night * 0.8);
      for (final (x, y, r) in _stars) {
        canvas.drawCircle(Offset(x * w, y * horizon), r * s, star);
      }
      final moon = Offset(w * 0.76, top + (horizon - top) * 0.25);
      canvas
        ..drawCircle(
          moon,
          16 * s,
          Paint()..color = const Color(0xFFF5F0E1).withValues(alpha: night),
        )
        ..drawCircle(
          moon + Offset(7, -6) * s,
          14 * s,
          // The sky's own colour at the moon, to cut the crescent.
          Paint()
            ..color = Color.lerp(
              sky(0),
              sky(1),
              (moon.dy / horizon).clamp(0.0, 1.0),
            )!.withValues(alpha: night),
        );
    }

    // The sun on its arc: below the horizon until the light is dim,
    // overhead in full sun.
    final rise = ((level - 0.25) / 0.75).clamp(0.0, 1.0);
    final a = math.pi * (1.12 - rise * 0.62);
    final sun = Offset(
      w / 2 + math.cos(a) * w * 0.42,
      horizon + 20 * s - math.sin(a) * (horizon - top - 30 * s),
    );
    if (sun.dy < horizon + 30 * s) {
      final glow = 60 * s;
      canvas
        ..drawCircle(
          sun,
          glow,
          Paint()
            ..shader = RadialGradient(
              colors: [
                const Color(0xF2FFF0C8),
                p.ballLight.withValues(alpha: 0.85),
                p.ballLight.withValues(alpha: 0),
              ],
              stops: const [0, 0.25, 1],
            ).createShader(Rect.fromCircle(center: sun, radius: glow)),
        )
        ..drawCircle(
          sun,
          13 * s,
          Paint()
            ..shader = RadialGradient(
              center: const Alignment(-0.4, -0.4),
              colors: [p.ballLight, p.ballDark],
            ).createShader(Rect.fromCircle(center: sun, radius: 13 * s)),
        );
    }

    // Soft hills in the page's own colour, each casting a soft shadow up.
    for (final (dy, freq, phase, alpha) in const [
      (6.0, 0.9, 1.3, 0.55),
      (30.0, 1.4, 0.4, 0.8),
      (58.0, 0.7, 2.2, 1.0),
    ]) {
      final y0 = horizon + dy * s;
      final hill = Path()..moveTo(0, size.height);
      for (var x = 0.0; x <= w + 6; x += 6) {
        hill.lineTo(x, y0 + math.sin(x / (60 * s) * freq + phase) * 12 * s);
      }
      hill
        ..lineTo(w, size.height)
        ..close();
      canvas
        ..drawPath(
          hill.shift(Offset(0, -2 * s)),
          Paint()
            ..color = p.dialShadow.withValues(alpha: alpha * 0.6)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, 9 * s),
        )
        ..drawPath(
          hill,
          Paint()..color = p.background.withValues(alpha: alpha),
        );
    }
  }

  @override
  bool shouldRepaint(_SkyPainter old) =>
      old.level != level ||
      old.horizon != horizon ||
      old.top != top ||
      old.scale != scale ||
      old.palette != palette;
}
