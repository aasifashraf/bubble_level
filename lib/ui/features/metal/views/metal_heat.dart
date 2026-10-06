import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/controls.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/metal_view_model.dart';

/// The metal detector as the game of hot and cold, seen through a thermal
/// camera: soft heat drifts over the screen, cool blue with nothing near,
/// through amber to red with a white-hot core on a find. A warm wave goes
/// out in time with the beeps and embers rise when it's hot. The change
/// sits on a raised disc with the game's word under it.
class MetalHeat extends StatefulWidget {
  const MetalHeat({
    super.key,
    required this.change,
    required this.value,
    required this.word,
    required this.wordColor,
    required this.semanticsLabel,
  });

  /// Change from the baseline, µT (either sign).
  final double change;

  /// The change as shown, and the game's word for it (Cold … Burning).
  final String value, word;
  final Color wordColor;
  final String semanticsLabel;

  /// The change that fills the screen with heat, µT.
  static const fullHeat = 120.0;

  @override
  State<MetalHeat> createState() => _MetalHeatState();
}

class _Ember {
  _Ember(this.x, this.y, this.speed);
  double x, y, life = 1;
  final double speed;
}

class _MetalHeatState extends State<MetalHeat>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_tick);
  Duration _last = Duration.zero;
  final _random = math.Random(3);

  /// Heat shown (0 cold … 1 burning), easing toward the reading.
  late double _heat = _target;
  double _time = 0, _sinceBeat = 0;
  final _waves = <double>[];
  final _embers = <_Ember>[];

  double get _target =>
      (widget.change.abs() / MetalHeat.fullHeat).clamp(0.0, 1.0);

  /// Still and cold, with nothing in flight: no need to animate.
  bool get _idle =>
      _target < 0.02 && _heat < 0.01 && _waves.isEmpty && _embers.isEmpty;

  @override
  void initState() {
    super.initState();
    if (!_idle) _ticker.start();
  }

  @override
  void didUpdateWidget(MetalHeat old) {
    super.didUpdateWidget(old);
    if (!_idle && !_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    }
  }

  void _tick(Duration now) {
    final dt = _last == Duration.zero
        ? 1 / 60
        : ((now - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = now;
    _time += dt;
    _heat += (_target - _heat) * math.min(1, dt * 3);
    // A wave in time with the beeps (the same rhythm, heard or not).
    final gap = MetalViewModel.beepGap(widget.change);
    _sinceBeat += dt;
    if (gap != null && _sinceBeat >= gap.inMicroseconds / 1e6) {
      _sinceBeat = 0;
      _waves.add(0);
    }
    for (var i = 0; i < _waves.length; i++) {
      _waves[i] += dt / 0.95;
    }
    _waves.removeWhere((w) => w >= 1);
    // Embers rise off the heat when it's hot.
    if (_heat > 0.3 && _random.nextDouble() < _heat * 0.6) {
      _embers.add(
        _Ember(_random.nextDouble() - 0.5, 0, 20 + _random.nextDouble() * 40),
      );
    }
    for (final e in _embers) {
      e
        ..y += e.speed * dt
        ..life -= dt * 0.5;
    }
    _embers.removeWhere((e) => e.life <= 0);
    setState(() {});
    if (_idle) _ticker.stop();
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
          final s = math.min(w / 300, (h - top) / 360).clamp(0.8, 1.6);
          final centre = Offset(w / 2, top + (h - top) * 0.48);
          final disc = 60 * s;
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _HeatPainter(
                    palette: p,
                    heat: _heat,
                    time: _time,
                    waves: _waves,
                    embers: _embers,
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
                            'µT',
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(fontSize: 12, color: p.label),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.word,
                            textScaler: TextScaler.noScaling,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: widget.wordColor,
                            ),
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

class _HeatPainter extends CustomPainter {
  _HeatPainter({
    required this.palette,
    required this.heat,
    required this.time,
    required this.waves,
    required this.embers,
    required this.centre,
    required this.scale,
  });

  final Palette palette;
  final double heat, time, scale;
  final List<double> waves;
  final List<_Ember> embers;
  final Offset centre;

  static const _whiteHot = Color(0xFFFFECD6);

  /// The thermal ramp in the app's colours: cool blue, a warm white (so
  /// blue never muddies into grey on its way to amber), amber, red,
  /// white-hot.
  Color _heatColor(double t) {
    final p = palette;
    final cool = p.isDark ? const Color(0xFF2C466E) : const Color(0xFFB0CEF0);
    final warm = p.isDark ? const Color(0xFF5A4535) : const Color(0xFFFFF1E2);
    final stops = [
      (0.0, cool),
      (0.15, warm),
      (0.4, p.gaugeCaution),
      (0.72, p.gaugeDanger),
      (1.0, _whiteHot),
    ];
    for (var i = 1; i < stops.length; i++) {
      final (b, cb) = stops[i];
      if (t <= b) {
        final (a, ca) = stops[i - 1];
        final f = ((t - a) / (b - a)).clamp(0.0, 1.0);
        return Color.lerp(ca, cb, f * f * (3 - 2 * f))!;
      }
    }
    return _whiteHot;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final s = scale, c = centre, k = heat;
    // Drifting blobs of heat around the reading, growing with the signal.
    for (final (phase, phase2, weight) in const [
      (0.0, 0.0, 1.0),
      (0.9, 1.7, 0.7),
      (2.1, 0.6, 0.6),
      (3.3, 2.4, 0.5),
    ]) {
      final at =
          c +
          Offset(
                math.sin(time * 0.6 + phase) * 40 * weight,
                math.cos(time * 0.5 + phase2) * 50 * weight,
              ) *
              s;
      final r = (90 + 170 * k) * (0.6 + 0.4 * weight) * s;
      canvas.drawCircle(
        at,
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              _heatColor(k * weight)
                  .withValues(alpha: 0.55 * (0.4 + 0.6 * weight)),
              _heatColor(k * weight * 0.6).withValues(alpha: 0.22),
              _heatColor(0).withValues(alpha: 0),
            ],
            stops: const [0, 0.6, 1],
          ).createShader(Rect.fromCircle(center: at, radius: r)),
      );
    }
    // A white-hot core on a find.
    if (k > 0.45) {
      final r = 90 * s;
      canvas.drawCircle(
        c,
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              _whiteHot.withValues(alpha: ((k - 0.45) * 1.4).clamp(0.0, 1.0)),
              _whiteHot.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: c, radius: r)),
      );
    }
    // Warm waves going out with the beeps: soft on both sides.
    final wave = _heatColor(k);
    for (final t in waves) {
      final r = (60 + 170 * t) * s, half = 14 * s, life = 1 - t;
      final inner = (r - half) / (r + half);
      canvas.drawCircle(
        c,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = half * 2
          ..shader = RadialGradient(
            colors: [
              wave.withValues(alpha: 0),
              wave.withValues(alpha: 0.35 * life),
              wave.withValues(alpha: 0),
            ],
            stops: [inner, (1 + inner) / 2, 1],
          ).createShader(Rect.fromCircle(center: c, radius: r + half)),
      );
    }
    // Embers rising.
    for (final e in embers) {
      canvas.drawCircle(
        c + Offset(e.x * 160 + math.sin(time * 3 + e.speed) * 3, 40 - e.y) * s,
        1.6 * s,
        Paint()
          ..color = _heatColor(0.6 + 0.4 * e.life)
              .withValues(alpha: e.life * 0.9),
      );
    }
  }

  /// The heat drifts on every frame.
  @override
  bool shouldRepaint(_HeatPainter old) => true;
}
