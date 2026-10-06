import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';

/// The sound meter's instrument: sound spreads from a raised disc carrying
/// the level, like rings from a stone dropped in still water. Each "stone"
/// sends out a train of soft swells, lit from the top left like the rest of
/// the app and fading out on both sides; louder sound drops stones more
/// often, with taller swells that travel further, in the colour of its band.
/// A row of small bars underneath shows the last few seconds.
class SoundRipples extends StatefulWidget {
  const SoundRipples({
    super.key,
    required this.level,
    required this.history,
    required this.zones,
    required this.value,
    required this.unit,
    required this.semanticsLabel,
    this.animate = true,
  });

  /// The level now, dB.
  final double level;

  /// The last few seconds of levels, oldest first.
  final List<double> history;

  /// The bands' colours by their start, in dB.
  final List<DialZone> zones;

  final String value, unit, semanticsLabel;

  /// False holds the water still (the reading is locked).
  final bool animate;

  @override
  State<SoundRipples> createState() => _SoundRipplesState();
}

/// One swell, in design units (the disc's radius is [_disc]).
class _Swell {
  _Swell({
    required this.r,
    required this.height,
    required this.color,
    required this.loud,
  });

  double r;
  final double height;
  final Color color;

  /// How loud it was when it set off (0–1): how far it travels.
  final double loud;
}

class _SoundRipplesState extends State<SoundRipples>
    with SingleTickerProviderStateMixin {
  /// The disc's radius in design units; everything scales with it.
  static const _disc = 58.0;

  /// Each stone's train: how far behind the first each swell starts, and
  /// how tall it is next to the first.
  static const _train = [(0.0, 1.0), (30.0, 0.6), (58.0, 0.32)];

  late final Ticker _ticker = createTicker(_tick);
  Duration _last = Duration.zero;
  final _swells = <_Swell>[];
  double _clock = 0;

  /// The furthest a swell can travel, in design units, from the layout.
  double _room = 160;

  double get _loud => ((widget.level - 25) / 85).clamp(0.0, 1.0);
  double get _every => 1.5 - 1.05 * _loud;
  double get _speed => 46 + 40 * _loud;
  double _reach(double loud) => _disc + 40 + (_room - _disc - 40) * loud;
  Color get _color => zoneColor(widget.zones, widget.level, blend: 5, end: 120);

  void _drop(double r) {
    final height = 0.35 + 0.65 * _loud;
    for (final (lag, k) in _train) {
      _swells.add(
        _Swell(r: r - lag, height: height * k, color: _color, loud: _loud),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Start mid-flow, so the water is already moving when it opens.
    for (var r = _disc + 6; r < _reach(_loud); r += _speed * _every) {
      _drop(r);
    }
    _sync();
  }

  @override
  void didUpdateWidget(SoundRipples old) {
    super.didUpdateWidget(old);
    _sync();
  }

  void _sync() {
    if (widget.animate && !_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    } else if (!widget.animate && _ticker.isActive) {
      _ticker.stop();
    }
  }

  void _tick(Duration now) {
    final dt = _last == Duration.zero
        ? 1 / 60
        : ((now - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = now;
    _clock += dt;
    if (_clock > _every) {
      _clock = 0;
      _drop(_disc);
    }
    final speed = _speed;
    for (final s in _swells) {
      s.r += dt * speed;
    }
    _swells.removeWhere((s) => s.r >= _reach(s.loud));
    setState(() {});
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
          // The disc fits the free space; the bars sit under it.
          final scale = math.min(w / 375, (h - top) / 440).clamp(0.6, 1.25);
          final unit = scale * 66 / _disc;
          final barsHeight = 56 * unit;
          final centre = Offset(w / 2, top + (h - top - barsHeight) / 2);
          final disc = _disc * unit;
          // Swells fade out before the bars and the sides.
          _room = math.min(w / 2, centre.dy - top + 40 * unit) / unit;
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _WaterPainter(
                    palette: p,
                    swells: _swells,
                    reach: _reach,
                    centre: centre,
                    unit: unit,
                    history: widget.history,
                    colorOf: (db) =>
                        zoneColor(widget.zones, db, blend: 5, end: 120),
                    barsBottom: h - 12 * unit,
                  ),
                ),
              ),
              Positioned(
                left: centre.dx - disc,
                top: centre.dy - disc,
                width: disc * 2,
                height: disc * 2,
                child: _Readout(
                  value: widget.value,
                  unit: widget.unit,
                  scale: scale,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// The level on a raised disc, as the dial's centre button.
class _Readout extends StatelessWidget {
  const _Readout({
    required this.value,
    required this.unit,
    required this.scale,
  });

  final String value, unit;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return DecoratedBox(
      decoration: softSurface(p, radius: BorderRadius.circular(999)),
      child: Padding(
        padding: EdgeInsets.all(14 * scale),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 44,
                  height: 1.05,
                  fontWeight: FontWeight.w700,
                  fontFeatures: readoutFeatures,
                  color: p.inkStrong,
                ),
              ),
              Text(
                unit,
                textScaler: TextScaler.noScaling,
                style: TextStyle(fontSize: 12, color: p.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaterPainter extends CustomPainter {
  _WaterPainter({
    required this.palette,
    required this.swells,
    required this.reach,
    required this.centre,
    required this.unit,
    required this.history,
    required this.colorOf,
    required this.barsBottom,
  });

  final Palette palette;
  final List<_Swell> swells;
  final double Function(double loud) reach;
  final Offset centre;
  final double unit;
  final List<double> history;
  final Color Function(double db) colorOf;
  final double barsBottom;

  static const _disc = _SoundRipplesState._disc;

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette;
    final shade = p.wellShadow.withValues(alpha: 1);
    final shadeAlpha = p.isDark ? 0.7 : 0.45;
    final sheen = p.isDark ? Colors.white : p.dialGlow;
    final sheenAlpha = p.isDark ? 0.16 : 0.9;
    for (final s in swells) {
      if (s.r < _disc + 2) continue;
      final life = 1 - (s.r - _disc) / (reach(s.loud) - _disc);
      if (life <= 0) continue;
      // Rises as it leaves the disc, then settles as it spreads.
      final rise = math.min(1.0, (s.r - _disc) / 14);
      final amp = s.height * life * life * (3 - 2 * life) * rise;
      if (amp <= 0.01) continue;
      final r = s.r * unit, half = (14 + 16 * amp) * unit;
      // Shade on the far side (light comes from the top left), the swell
      // in its band's colour, and a sheen on the near slope.
      _swell(
        canvas,
        Offset(3 + 3 * amp, 4 + 4 * amp) * unit,
        r + 2 * unit,
        half * 1.1,
        shade,
        shadeAlpha * amp,
      );
      _swell(canvas, Offset.zero, r, half, s.color, 0.5 * amp);
      _swell(
        canvas,
        Offset(-2 - 2 * amp, -3 - 2 * amp) * unit,
        r - half * 0.2,
        half * 0.55,
        sheen,
        sheenAlpha * math.min(1, amp * 1.3),
      );
    }
    _bars(canvas, size);
  }

  /// A ring of [color] that fades to nothing on both sides: no edges.
  void _swell(
    Canvas canvas,
    Offset shift,
    double r,
    double half,
    Color color,
    double alpha,
  ) {
    if (r - half <= 0 || alpha <= 0) return;
    final c = centre + shift;
    final inner = (r - half) / (r + half);
    Color a(double k) => color.withValues(alpha: alpha * k);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = half * 2
        ..shader = ui.Gradient.radial(
          c,
          r + half,
          [a(0), a(0.35), a(1), a(0.35), a(0)],
          [
            for (final k in [0, .25, .5, .75, 1]) inner + (1 - inner) * k,
          ],
        ),
    );
  }

  /// The last few seconds, one small rounded bar per level, newest on the
  /// right and brightest.
  void _bars(Canvas canvas, Size size) {
    if (history.isEmpty) return;
    const n = 30;
    final bw = 5 * unit, gap = 3.2 * unit, maxH = 44 * unit;
    final x0 = (size.width - (n * bw + (n - 1) * gap)) / 2;
    final recent = history.length > n
        ? history.sublist(history.length - n)
        : history;
    final first = n - recent.length;
    for (final (i, db) in recent.indexed) {
      final h = math.max(bw, db / 120 * maxH);
      final x = x0 + (first + i) * (bw + gap);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, barsBottom - h, bw, h),
          Radius.circular(bw / 2),
        ),
        Paint()
          ..color = colorOf(db)
              .withValues(alpha: i == recent.length - 1 ? 1 : 0.75),
      );
    }
  }

  /// The swells move on every frame.
  @override
  bool shouldRepaint(_WaterPainter old) => true;
}
