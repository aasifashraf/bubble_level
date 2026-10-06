import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../domain/scene_weather.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';

/// The Altimeter as a living mountain: a hiker in the app's orange climbs a
/// switchback path with your height and a flag marks the highest point.
/// Real ranges near and far, a meadow with pines, stones, sheep, a lake,
/// and children at play. The sky is scenery: sunny or a starry night by the
/// clock, snow in winter, or the weather the user picks; clouds, rain,
/// storms with lightning and snow days come and go with it.
class MountainScene extends StatefulWidget {
  const MountainScene({
    super.key,
    required this.height,
    required this.highest,
    required this.weather,
    required this.night,
    required this.semanticsLabel,
    this.bottomInset = 0,
  });

  /// Metres above the zero (0 before zeroing), and the highest so far.
  final double height, highest;
  final SceneWeather weather;
  final bool night;
  final String semanticsLabel;

  /// Room left at the bottom for the footer; the meadow ends above it.
  final double bottomInset;

  /// The height (m) that brings the hiker to the summit.
  static const summit = 100.0;

  @override
  State<MountainScene> createState() => _MountainSceneState();
}

class _MountainSceneState extends State<MountainScene>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_tick);
  Duration _last = Duration.zero;
  final _w = _World();

  @override
  void initState() {
    super.initState();
    // Start in the weather it is, not part-way there.
    _w
      ..settle(widget.weather, widget.night)
      ..shownHeight = widget.height.clamp(0.0, double.infinity);
    _ticker.start();
  }

  void _tick(Duration now) {
    final dt = _last == Duration.zero
        ? 1 / 60
        : ((now - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = now;
    setState(() => _w.step(dt, widget.weather, widget.night, widget.height));
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = ToolFrame.sideBySide(context)
        ? 0.0
        : ToolFrame.contentTop(context);
    return Semantics(
      label: widget.semanticsLabel,
      excludeSemantics: true,
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size.infinite,
          painter: _ScenePainter(
            world: _w,
            palette: Palette.of(context),
            highest: widget.highest,
            top: top,
            bottomInset: widget.bottomInset,
            pixelRatio: MediaQuery.devicePixelRatioOf(context),
          ),
        ),
      ),
    );
  }
}

/// The scene's state that moves on its own: weather easing in and out,
/// clouds, children, the hiker's walk, lightning.
class _World {
  final rnd = math.Random(7);
  double t = 0;

  /// 0 sunny … 1 cloudy … 2 rain … 3 storm; snow and night 0…1.
  double wv = 0, snowy = 0, night = 0, rainbow = 0;
  int _lastTarget = 0;
  double kidsOut = 1, kidT = 0;
  bool kidsRunning = false, kidsWantOut = true;
  double shownHeight = 0, hikerV = 0, hikerStep = 0;
  final clouds = [
    for (var i = 0; i < 7; i++)
      [i * 52.0, 26.0 + (i * 37) % 90, 0.6 + (i * 0.37) % 0.5],
  ];
  List<Offset>? bolt;
  double boltLife = 0;

  static double target(SceneWeather w) => switch (w) {
    SceneWeather.sunny => 0,
    SceneWeather.cloudy => 1,
    SceneWeather.rain => 2,
    SceneWeather.storm => 3,
    SceneWeather.snow => 0.9,
  };

  void settle(SceneWeather w, bool isNight) {
    wv = target(w);
    snowy = w == SceneWeather.snow ? 1 : 0;
    night = isNight ? 1 : 0;
    kidsOut = _wantOut ? 1 : 0;
    _lastTarget = wv.round();
  }

  double get cloudy => wv.clamp(0.0, 1.0);
  double get rain => _ease(((wv - 1.4)).clamp(0.0, 1.0));
  double get storm => _ease(((wv - 2.3) / 0.7).clamp(0.0, 1.0));
  double get wind => 0.25 + 0.4 * cloudy + 0.35 * storm;
  bool get _wantOut => rain < 0.25 && storm < 0.1 && night < 0.5;

  void step(double dt, SceneWeather w, bool isNight, double height) {
    t += dt;
    final tv = target(w);
    wv += (tv - wv) * math.min(1, dt * 1.5);
    snowy += ((w == SceneWeather.snow ? 1 : 0) - snowy) * math.min(1, dt * 1.5);
    night += ((isNight ? 1 : 0) - night) * math.min(1, dt);
    // A rainbow as rain clears.
    final tr = tv.round();
    if (_lastTarget >= 2 && tr < 2) rainbow = 1;
    _lastTarget = tr;
    rainbow = math.max(0, rainbow - dt * 0.12);
    // Children run home in the rain or at night, and come back out.
    kidsWantOut = _wantOut;
    final want = kidsWantOut ? 1.0 : 0.0, was = kidsOut;
    kidsOut +=
        (want - kidsOut).sign * math.min((want - kidsOut).abs(), dt * 0.45);
    kidsRunning = (kidsOut - was).abs() > 1e-4;
    kidT += dt * (kidsRunning ? 9 : 7);
    // Clouds drift with the wind.
    for (final c in clouds) {
      c[0] = (c[0] + dt * (6 + 22 * wind) * c[2] + 420) % 420;
    }
    // The hiker walks toward the height, at a walking pace.
    final h = height.clamp(0.0, MountainScene.summit * 1.2);
    final before = shownHeight;
    shownHeight += (h - shownHeight) * math.min(1, dt * 2.5);
    hikerV += ((shownHeight - before) / math.max(dt, 1e-3) - hikerV) * 0.15;
    if (hikerV.abs() > 0.3) {
      hikerStep += dt * math.min(12, 5 + hikerV.abs() * 0.6);
    }
    // Lightning in a storm.
    if (boltLife > 0) {
      boltLife -= dt;
      if (boltLife <= 0) bolt = null;
    } else if (storm > 0.6 && rnd.nextDouble() < dt * 0.6) {
      bolt = null; // laid out by the painter, which knows the size
      boltLife = 0.35;
    }
  }

  static double _ease(double t) => t * t * (3 - 2 * t);
}

/// The ranges, painted once per size and theme (rock is costly to draw).
class _Mountains {
  _Mountains(this.rock, this.snow, this.main, this.peakX, this.trail);
  final ui.Image rock, snow;
  final List<double> main;
  final int peakX;
  final List<Offset> trail;
  late final List<double> acc = () {
    final a = [0.0];
    for (var i = 1; i < trail.length; i++) {
      a.add(a.last + (trail[i] - trail[i - 1]).distance);
    }
    return a;
  }();

  /// A point along the trail, 0…1 by distance walked; with its direction.
  (Offset, double) at(double f) {
    final l = acc.last * f.clamp(0.0, 1.0);
    var k = 1;
    while (k < trail.length - 1 && acc[k] < l) {
      k++;
    }
    final seg = math.max(1e-6, acc[k] - acc[k - 1]);
    final u = (l - acc[k - 1]) / seg;
    final a = trail[k - 1], b = trail[k];
    return (
      Offset.lerp(a, b, u)!,
      (b.dx - a.dx).sign == 0 ? 1 : (b.dx - a.dx).sign,
    );
  }
}

_Mountains? _cache;
Object? _cacheKey;

double Function(double) _noise(int seed) {
  double r(int i) {
    final x = math.sin(i * 127.1 + seed * 311.7) * 43758.5453;
    return x - x.floorToDouble();
  }

  return (x) {
    final i = x.floor(), t = x - i, u = t * t * (3 - 2 * t);
    return r(i) * (1 - u) + r(i + 1) * u;
  };
}

/// A ridgeline: a few peaks plus rough fractal detail.
List<double> _ridge(
  int w,
  double base,
  List<(double, double, double)> peaks,
  double rough,
  int seed,
) {
  final n = _noise(seed);
  return [
    for (var x = 0; x <= w + 1; x++)
      () {
        var y = base;
        for (final (c, h, wd) in peaks) {
          y -= h * math.pow(math.max(0, 1 - (x - c).abs() / wd), 1.25);
        }
        var a = rough, f = 1 / 40;
        for (var o = 0; o < 5; o++) {
          y -= (n(x * f + o * 17) - 0.5) * a;
          a *= 0.5;
          f *= 2.1;
        }
        return y;
      }(),
  ];
}

Color _rgb(List<int> c) => Color.fromARGB(255, c[0], c[1], c[2]);

/// Rock lit by its slope (sun from the left), spurs down from each peak,
/// faint strata, haze toward the foot, and a snow cap above [snowY].
void _paintRange(
  Canvas c,
  List<double> ys,
  int w,
  double bottom,
  List<int> lit,
  List<int> dark,
  List<int> haze,
  double? snowY,
  int seed,
) {
  final n = _noise(seed + 9), n2 = _noise(seed + 23);
  double sl(double x) {
    final i = x.round().clamp(4, w - 4);
    return (ys[i + 4] - ys[i - 4]) / 8;
  }

  const step = 3.0;
  final paint = Paint();
  // Clip to the silhouette, so the ridgeline is smooth, not stepped.
  final outline = Path()..moveTo(0, bottom + 40);
  for (var x = 0; x <= w; x++) {
    outline.lineTo(x.toDouble(), ys[x]);
  }
  outline
    ..lineTo(w.toDouble(), bottom + 40)
    ..close();
  c
    ..save()
    ..clipPath(outline);
  for (var x = 0; x <= w; x++) {
    final y0 = ys[x];
    for (var y = y0; y < bottom + 40; y += step) {
      final d = y - y0;
      final s1 = sl(x - d * 0.42), s2 = sl(x + d * 0.42);
      final slope = s1 > 0 ? s1 : (s2 < 0 ? s2 : (s1 + s2) / 2);
      final l = (0.5 - slope * 1.0 + (n(x * 0.05 + y * 0.03) - 0.5) * 0.16)
          .clamp(0.0, 1.0);
      final band = math.sin((y + x * 0.25) * 0.22 + n(x * 0.02) * 4) * 0.035;
      final hz = math.min(1, d / (bottom - y0 + 40)) * 0.6;
      final col = [
        for (var i = 0; i < 3; i++)
          () {
            final base = (dark[i] + (lit[i] - dark[i]) * l) * (1 + band);
            return (base + (haze[i] - base) * hz).round().clamp(0, 255);
          }(),
      ];
      paint.color = _rgb(col);
      final lead = y == y0 ? 4.0 : 0.0;
      c.drawRect(
        Rect.fromLTWH(x - 0.3, y - lead, 1.6, step + 0.6 + lead),
        paint,
      );
    }
    if (snowY != null && y0 < snowY) {
      final depth = (snowY - y0) * 0.75 + (n2(x * 0.045) - 0.3) * 22;
      if (depth > 2) {
        final l0 = (0.5 - sl(x.toDouble())).clamp(0.0, 1.0);
        final cc = l0 > 0.45
            ? const Color(0xFFFFFFFF)
            : const Color(0xFFD6E2F2);
        paint.shader = ui.Gradient.linear(
          Offset(0, y0),
          Offset(0, y0 + depth),
          [
            cc.withValues(alpha: 0.98),
            cc.withValues(alpha: 0.92),
            cc.withValues(alpha: 0),
          ],
          const [0, 0.8, 1],
        );
        c.drawRect(Rect.fromLTWH(x - 0.3, y0 - 4, 1.6, depth + 4), paint);
        paint.shader = null;
      }
    }
  }
  c.restore();
}

_Mountains _mountains(double top, double bottom, bool dark, double scale) {
  final key = (top, bottom, dark, scale);
  if (_cache != null && _cacheKey == key) return _cache!;
  const w = 300;
  final far = _ridge(
    w,
    bottom - 105,
    [(w * 0.14, 80, 70), (w * 0.46, 110, 75), (w * 0.84, 95, 70)],
    18,
    3,
  );
  final mid = _ridge(
    w,
    bottom - 66,
    [(w * 0.06, 95, 60), (w * 0.3, 120, 70), (w * 0.98, 115, 70)],
    20,
    7,
  );
  final main = _ridge(
    w,
    bottom - 34,
    [(w * 0.64, 240, 118), (w * 0.84, 120, 60), (w * 0.3, 70, 60)],
    22,
    11,
  );
  ui.Image render(void Function(Canvas) draw) {
    final rec = ui.PictureRecorder();
    final c = Canvas(rec)..scale(scale);
    draw(c);
    return rec.endRecording().toImageSync(
      (w * scale).ceil(),
      ((bottom + 40) * scale).ceil(),
    );
  }

  final rock = render((c) {
    _paintRange(
      c,
      far,
      w,
      bottom,
      dark ? [96, 108, 126] : [204, 216, 234],
      dark ? [70, 80, 96] : [176, 192, 214],
      dark ? [60, 70, 86] : [222, 232, 244],
      top + 70,
      3,
    );
    _paintRange(
      c,
      mid,
      w,
      bottom,
      dark ? [84, 92, 104] : [170, 184, 204],
      dark ? [52, 58, 68] : [128, 144, 168],
      dark ? [56, 64, 76] : [200, 214, 232],
      top + 110,
      7,
    );
    _paintRange(
      c,
      main,
      w,
      bottom,
      dark ? [112, 116, 122] : [196, 190, 182],
      dark ? [48, 50, 56] : [106, 104, 108],
      dark ? [60, 64, 70] : [176, 186, 198],
      top + 96,
      11,
    );
  });
  final snow = render((c) {
    for (final ys in [far, mid, main]) {
      final path = Path()..moveTo(0, bottom + 40);
      for (var x = 0; x <= w; x++) {
        path.lineTo(x.toDouble(), ys[x]);
      }
      path
        ..lineTo(w.toDouble(), bottom + 40)
        ..close();
      c.drawPath(
        path,
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(0, top),
            Offset(0, bottom),
            const [Color(0xFFFFFFFF), Color(0xD9ECF2FA)],
          ),
      );
    }
  });
  var peakX = 0;
  for (var x = 0; x <= w; x++) {
    if (main[x] < main[peakX]) peakX = x;
  }
  // Switchbacks up the face, between its left edge and the middle.
  int left(double y) {
    var x = 0;
    while (x < peakX && main[x] > y) {
      x++;
    }
    return x;
  }

  final baseY = bottom - 40, peakY = main[peakX];
  const turns = 7;
  final trail = <Offset>[
    for (var i = 0; i <= turns; i++)
      () {
        final y = baseY + (peakY + 6 - baseY) * (i / turns), xl = left(y);
        final wide = math.max(10.0, (peakX - xl) * 0.75);
        return i == turns
            ? Offset(peakX.toDouble(), peakY + 3)
            : Offset(i.isOdd ? xl + wide : xl + 10.0, y);
      }(),
  ];
  _cacheKey = key;
  return _cache = _Mountains(rock, snow, main, peakX, trail);
}

class _ScenePainter extends CustomPainter {
  _ScenePainter({
    required this.world,
    required this.palette,
    required this.highest,
    required this.top,
    required this.bottomInset,
    required this.pixelRatio,
  });

  final _World world;
  final Palette palette;
  final double highest, top, bottomInset, pixelRatio;

  static const _w = 300.0;
  static const _trees = [
    (24.0, 0.85),
    (44.0, 0.95),
    (64.0, 0.82),
    (200.0, 0.92),
    (224.0, 0.86),
    (248.0, 0.97),
    (272.0, 0.88),
    (112.0, 0.97),
    (146.0, 0.9),
    (292.0, 0.8),
  ];
  static const _stones = [
    (16.0, 6.0, 7.0),
    (96.0, 14.0, 5.0),
    (128.0, 4.0, 8.0),
    (176.0, 18.0, 6.0),
    (250.0, 22.0, 5.0),
  ];
  static const _sheep = [
    (58.0, -2.0, 0.0),
    (118.0, 6.0, 1.7),
    (168.0, 0.0, 3.1),
  ];
  static const _kids = [
    (34.0, Color(0xFF4DABF7)),
    (92.0, Color(0xFFFF6B6B)),
    (150.0, Color(0xFFFFD43B)),
  ];
  static const _flowers = [
    Color(0xFFFFB4C8),
    Color(0xFFFFE07A),
    Color(0xFFFFFFFF),
    Color(0xFFC9A8FF),
  ];

  bool get _dark => palette.isDark;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw in a 300-wide design space, scaled to fit the width.
    final k = size.width / _w;
    final h = size.height / k;
    final top = this.top / k;
    final bottom = h - bottomInset / k - 40;
    canvas
      ..save()
      ..scale(k);
    final w = world;
    final m = _mountains(top, bottom, _dark, k * pixelRatio);
    double grassY(double x) =>
        bottom - 62 - math.sin(x / 45 + 1) * 14 - math.sin(x / 19) * 4;

    _sky(canvas, top, bottom);
    _sunMoon(canvas, top);
    if (w.rainbow > 0.01) _rainbow(canvas, bottom);
    _windInSky(canvas, top);

    // The ranges, snowed on in snow, darker in a storm or at night.
    final dst = Rect.fromLTWH(0, 0, _w, bottom + 40);
    canvas.drawImageRect(
      m.rock,
      Offset.zero & Size(m.rock.width.toDouble(), m.rock.height.toDouble()),
      dst,
      Paint()..filterQuality = FilterQuality.medium,
    );
    if (w.snowy > 0.01) {
      canvas.drawImageRect(
        m.snow,
        Offset.zero & Size(m.snow.width.toDouble(), m.snow.height.toDouble()),
        dst,
        Paint()..color = Color.fromRGBO(0, 0, 0, 0.6 * w.snowy),
      );
    }
    final shade =
        math.min(1.0, w.cloudy * 0.35 + w.rain * 0.4 + w.storm * 0.25) * 0.35 +
        w.night * 0.45;
    if (shade > 0.01) {
      canvas.drawRect(
        // From the very top, so the sky behind the header matches.
        Rect.fromLTWH(0, 0, _w, bottom + 40),
        Paint()..color = Color.fromRGBO(20, 26, 40, shade),
      );
    }
    final peak = Offset(m.peakX.toDouble(), m.main[m.peakX]);
    if (w.storm > 0.05) _summitSnow(canvas, peak);

    _meadow(canvas, bottom, h, grassY);
    _pines(canvas, grassY);
    _life(canvas, bottom, grassY);

    // The footpath, the highest point's flag, and the hiker.
    final pathPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..color = _dark ? const Color(0x52FFFFFF) : const Color(0xBFFFFAF0);
    for (var i = 1; i < m.trail.length; i++) {
      _dashed(canvas, m.trail[i - 1], m.trail[i], pathPaint);
    }
    final (flag, _) = m.at(highest / MountainScene.summit);
    if (highest > 0.5) _flag(canvas, flag);
    final f = w.shownHeight / MountainScene.summit;
    final (at, dir) = m.at(f);
    final walking = w.hikerV.abs() > 0.3;
    _hiker(
      canvas,
      at,
      w.hikerStep,
      walking,
      w.hikerV >= 0 ? dir : -dir,
      f >= 0.999 && !walking,
    );

    _birds(canvas, top);
    _clouds(canvas);
    _snowfall(canvas, top, bottom);
    _rain(canvas, top, bottom);
    _lightning(canvas, top, bottom);
    canvas.restore();
  }

  void _sky(Canvas c, double top, double bottom) {
    final w = world;
    List<int> mix(List<int> a, List<int> b, double t) => [
      for (var i = 0; i < 3; i++) (a[i] + (b[i] - a[i]) * t).round(),
    ];
    final clear = _dark
        ? [
            [34, 44, 60],
            [60, 72, 90],
          ]
        : [
            [150, 200, 245],
            [232, 242, 252],
          ];
    final grey = _dark
        ? [
            [26, 28, 34],
            [44, 48, 56],
          ]
        : [
            [110, 122, 142],
            [180, 188, 202],
          ];
    const night = [
      [12, 18, 36],
      [36, 48, 78],
    ];
    final k = math.min(1.0, w.cloudy * 0.35 + w.rain * 0.4 + w.storm * 0.25);
    List<int> at(int i) =>
        mix(mix(clear[i], grey[i], k), night[i], w.night * 0.9);
    c.drawRect(
      Rect.fromLTWH(0, 0, _w, bottom + 40),
      Paint()
        ..shader = ui.Gradient.linear(Offset(0, top), Offset(0, bottom), [
          _rgb(at(0)),
          _rgb(at(1)),
        ]),
    );
    if (w.snowy > 0.01) {
      c.drawRect(
        Rect.fromLTWH(0, 0, _w, bottom + 40),
        Paint()
          ..color = (_dark ? const Color(0xFF464C58) : const Color(0xFFE8EEF6))
              .withValues(alpha: 0.6 * w.snowy * (1 - w.night)),
      );
    }
  }

  void _sunMoon(Canvas c, double top) {
    final w = world;
    final sun =
        math.max(0.0, 1 - w.wv / 1.4) * (1 - w.night) * (1 - w.snowy * 0.6);
    final at = Offset(_w - 58, top + 54);
    if (sun > 0.01) {
      final ray = Paint()
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..color = const Color(0xB3FFBE5A).withValues(alpha: 0.7 * sun);
      for (var r = 0; r < 12; r++) {
        final a = w.t * 0.15 + r * math.pi / 6, len = 36 + (r.isOdd ? 6 : 0);
        c.drawLine(
          at + Offset.fromDirection(a, 26),
          at + Offset.fromDirection(a, len.toDouble()),
          ray,
        );
      }
      _ball(c, at, 18, sun);
    }
    if (w.night > 0.01) {
      final star = Paint()..color = Colors.white;
      final r = math.Random(11);
      for (var i = 0; i < 34; i++) {
        final x = r.nextDouble() * _w, y = top + r.nextDouble() * 170;
        star.color = Colors.white.withValues(
          alpha:
              w.night *
              (0.4 + 0.5 * (0.5 + 0.5 * math.sin(w.t * 1.7 + i))) *
              (1 - w.cloudy * 0.7),
        );
        c.drawCircle(Offset(x, y), 0.6 + (i % 3) * 0.4, star);
      }
      final moon = Offset(_w - 64, top + 50);
      c
        ..drawCircle(
          moon,
          14,
          Paint()..color = const Color(0xFFF5F0E1).withValues(alpha: w.night),
        )
        ..drawCircle(
          moon + const Offset(6, -5),
          12,
          Paint()..color = const Color(0xFF1C2440).withValues(alpha: w.night),
        );
    }
  }

  void _rainbow(Canvas c, double bottom) {
    const colors = [
      Color(0xFFFF6B6B),
      Color(0xFFFFA94D),
      Color(0xFFFFE066),
      Color(0xFF69DB7C),
      Color(0xFF4DABF7),
      Color(0xFF9775FA),
    ];
    for (var i = 0; i < colors.length; i++) {
      c.drawArc(
        Rect.fromCircle(
          center: Offset(_w * 0.3, bottom - 40),
          radius: 150 - i * 5.0,
        ),
        math.pi * 1.05,
        math.pi * 0.7,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..color = colors[i].withValues(
            alpha: 0.45 * world.rainbow * (1 - world.night),
          ),
      );
    }
  }

  void _windInSky(Canvas c, double top) {
    final w = world, n = 2 + (w.wind * 4).round();
    final a = _dark ? 0.25 : 0.75;
    for (var i = 0; i < n; i++) {
      final x = ((w.t * (50 + 150 * w.wind) + i * 97) % 460) - 80,
          y = top + 40 + i * 22;
      final path = Path()
        ..moveTo(x, y)
        ..cubicTo(x + 25, y - 5, x + 45, y + 4, x + 70 + 20 * w.wind, y - 1);
      c.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3
          ..strokeCap = StrokeCap.round
          ..shader = ui.Gradient.linear(
            Offset(x, y),
            Offset(x + 70, y),
            [
              Colors.white.withValues(alpha: 0),
              Colors.white.withValues(alpha: a),
              Colors.white.withValues(alpha: 0),
            ],
            const [0, 0.5, 1],
          ),
      );
    }
  }

  void _summitSnow(Canvas c, Offset peak) {
    final w = world;
    final p = Paint()..color = Colors.white.withValues(alpha: 0.85 * w.storm);
    for (var i = 0; i < 40; i++) {
      final fx = (i * 29 % 90).toDouble(), fy = (i * 41 % 70).toDouble();
      c.drawCircle(
        Offset(
          peak.dx - 45 + fx + math.sin(w.t * 2 + fy) * 3,
          peak.dy - 20 + ((fy + w.t * 25) % 70),
        ),
        1.6,
        p,
      );
    }
  }

  void _meadow(
    Canvas c,
    double bottom,
    double h,
    double Function(double) grassY,
  ) {
    final w = world;
    Path ground([double lift = 0]) {
      final p = Path()..moveTo(0, bottom);
      for (var x = 0.0; x <= _w; x += 6) {
        p.lineTo(x, grassY(x) - lift);
      }
      return p
        ..lineTo(_w, h)
        ..lineTo(0, h)
        ..close();
    }

    final dim = 1 - w.night * 0.45;
    Color tone(Color col) => Color.lerp(const Color(0xFF0E1622), col, dim)!;
    c.drawPath(
      ground(),
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(0, bottom - 90),
          Offset(0, bottom),
          [
            tone(_dark ? const Color(0xF2346042) : const Color(0xF296CE96)),
            tone(_dark ? const Color(0xFF22462E) : const Color(0xFF60AA6E)),
          ],
        ),
    );
    if (w.snowy < 0.99) {
      for (var i = 0; i < 26; i++) {
        final x = ((i * 47 + 13) % 300).toDouble();
        c.drawCircle(
          Offset(x, grassY(x) + 10 + (i * 13 % 22)),
          1.8,
          Paint()
            ..color = _flowers[i % 4].withValues(alpha: (1 - w.snowy) * dim),
        );
      }
    }
    if (w.snowy > 0.01) {
      c.drawPath(
        ground(1),
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(0, bottom - 80),
            Offset(0, bottom + 40),
            [
              tone(_dark ? const Color(0xFFD2DAE6) : Colors.white)
                  .withValues(alpha: w.snowy),
              tone(_dark ? const Color(0xFFA0ACBE) : const Color(0xFFDCE8F6))
                  .withValues(alpha: w.snowy),
            ],
          ),
      );
      final drift = Paint()
        ..color = const Color(0xFFBECEE4).withValues(alpha: 0.5 * w.snowy);
      for (var x = 10.0; x < _w; x += 46) {
        c.drawOval(
          Rect.fromCenter(
            center: Offset(x, grassY(x) + 26),
            width: 44,
            height: 8,
          ),
          drift,
        );
      }
    }
    // The lake: ripples in the rain, ice in the snow.
    final lake = Rect.fromCenter(
      center: Offset(_w * 0.78, bottom - 4),
      width: 112,
      height: 24,
    );
    c.drawOval(
      lake,
      Paint()
        ..color = tone(
          _dark ? const Color(0xFF1E3346) : const Color(0xFF7FB4E0),
        ),
    );
    final ripple = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var r = 0; r < 3; r++) {
      final t = (w.t * (w.rain > 0.1 ? 1.4 : 0.4) + r / 3) % 1;
      ripple.color = Colors.white.withValues(
        alpha: 0.5 * (1 - t) * (1 - w.snowy),
      );
      c.drawOval(
        Rect.fromCenter(
          center: Offset(_w * 0.78 - 18 + r * 18, bottom - 4),
          width: 12 + t * 32,
          height: 4 + t * 6,
        ),
        ripple,
      );
    }
    if (w.snowy > 0.01) {
      c.drawOval(
        lake,
        Paint()
          ..color = const Color(0xFFDEECFA).withValues(alpha: 0.9 * w.snowy),
      );
      final crack = Paint()
        ..color = Colors.white.withValues(alpha: w.snowy)
        ..strokeWidth = 1;
      c
        ..drawLine(
          Offset(_w * 0.78 - 30, bottom - 7),
          Offset(_w * 0.78 + 10, bottom - 2),
          crack,
        )
        ..drawLine(
          Offset(_w * 0.78 - 5, bottom - 10),
          Offset(_w * 0.78 + 24, bottom - 5),
          crack,
        );
    }
  }

  void _pines(Canvas c, double Function(double) grassY) {
    final w = world;
    final green = Color.lerp(
      const Color(0xFF0C1A14),
      _dark ? const Color(0xFF1E3A2A) : const Color(0xFF3E8A58),
      1 - w.night * 0.45,
    )!;
    for (var i = 0; i < _trees.length; i++) {
      final (x, kk) = _trees[i];
      final y = grassY(x) + 8,
          sz = 22 * kk,
          sw = math.sin(w.t * (2 + w.wind * 3) + i) * 2.5 * w.wind;
      for (var t = 0; t < 3; t++) {
        final ty = y - t * sz * 0.45,
            tx = x + sw * (t + 1) * 0.5,
            wd = sz * (0.42 - t * 0.09);
        c.drawPath(
          Path()
            ..moveTo(tx, ty - sz * 0.7)
            ..lineTo(x - wd, ty)
            ..lineTo(x + wd, ty)
            ..close(),
          Paint()..color = green,
        );
        if (w.snowy > 0.01) {
          c.drawPath(
            Path()
              ..moveTo(tx, ty - sz * 0.7)
              ..lineTo(tx - wd * 0.55, ty - sz * 0.32)
              ..lineTo(tx + wd * 0.55, ty - sz * 0.32)
              ..close(),
            Paint()..color = Colors.white.withValues(alpha: 0.95 * w.snowy),
          );
        }
      }
    }
  }

  void _life(Canvas c, double bottom, double Function(double) grassY) {
    final w = world;
    for (final (x, dy, r) in _stones) {
      final at = Offset(x, bottom + 8 + dy);
      c
        ..drawOval(
          Rect.fromCenter(center: at, width: r * 2, height: r * 1.2),
          Paint()
            ..color = _dark ? const Color(0xFF5A5F66) : const Color(0xFFA7AEB8),
        )
        ..drawOval(
          Rect.fromCenter(
            center: at - Offset(r * 0.3, r * 0.25),
            width: r * 0.9,
            height: r * 0.44,
          ),
          Paint()..color = const Color(0x59FFFFFF),
        );
    }
    if (w.snowy < 0.99) {
      for (final (x, dy, ph) in _sheep) {
        _sheepAt(
          c,
          Offset(x + math.sin(w.t * 0.2 + ph) * 6, bottom - 6 + dy),
          w.t * 1.3 + ph,
          1 - w.snowy,
        );
      }
    }
    final gy = bottom + 24;
    // Football while it's dry and light; they run home and back.
    if (w.kidsOut > 0.02 && w.snowy < 0.5) {
      final out = _World._ease(w.kidsOut);
      final xs = [
        for (var i = 0; i < _kids.length; i++)
          -40 -
              i * 18 +
              (_kids[i].$1 + math.sin(w.t * 1.3 + i * 2.1) * 14 + 40 + i * 18) *
                  out,
      ];
      final pass = (w.t * 0.7) % _kids.length,
          a = pass.floor(),
          u = pass - a,
          b = (a + 1) % _kids.length;
      final ballX = w.kidsRunning ? xs[0] + 8 : xs[a] + (xs[b] - xs[a]) * u;
      final ballY = gy - 3 - (w.kidsRunning ? 0 : math.sin(u * math.pi) * 16);
      for (var i = 0; i < _kids.length; i++) {
        final dir = w.kidsRunning
            ? (w.kidsWantOut ? 1.0 : -1.0)
            : (ballX > xs[i] ? 1.0 : -1.0);
        _person(
          c,
          Offset(xs[i], gy + (i % 2) * 4),
          w.kidT + i,
          true,
          dir,
          _kids[i].$2,
          0.85,
        );
      }
      c
        ..drawCircle(Offset(ballX, ballY), 3.2, Paint()..color = Colors.white)
        ..drawCircle(
          Offset(ballX + 0.8, ballY - 0.5),
          1.1,
          Paint()..color = const Color(0xFF333333),
        );
    }
    if (w.snowy > 0.5 && w.night < 0.5) {
      _snowGames(c, gy, grassY, ((w.snowy - 0.5) * 2).clamp(0.0, 1.0));
    }
  }

  void _snowGames(
    Canvas c,
    double gy,
    double Function(double) grassY,
    double alpha,
  ) {
    final w = world;
    c.saveLayer(null, Paint()..color = Color.fromRGBO(0, 0, 0, alpha));
    // A snowman, patted into shape.
    const sx = 122.0;
    final sy = gy + 2;
    for (final (dy, r) in const [(-7.0, 9.0), (-20.0, 7.0), (-30.0, 5.0)]) {
      final at = Offset(sx, sy + dy);
      c.drawCircle(
        at,
        r,
        Paint()
          ..shader = ui.Gradient.radial(
            at - Offset(r * 0.4, r * 0.4),
            r * 1.4,
            const [Colors.white, Color(0xFFD3DEEC)],
          ),
      );
    }
    final coal = Paint()..color = const Color(0xFF333333);
    for (final o in const [
      Offset(-2, -31),
      Offset(2, -31),
      Offset(0, -21),
      Offset(0, -17),
    ]) {
      c.drawCircle(Offset(sx, sy) + o, 0.9, coal);
    }
    c
      ..drawPath(
        Path()
          ..moveTo(sx + 1, sy - 30)
          ..lineTo(sx + 7, sy - 29)
          ..lineTo(sx + 1, sy - 28)
          ..close(),
        Paint()..color = const Color(0xFFFF8A1F),
      )
      ..drawRect(
        Rect.fromLTWH(sx - 5, sy - 36, 10, 2),
        Paint()..color = const Color(0xFF3A4048),
      )
      ..drawRect(
        Rect.fromLTWH(sx - 3.5, sy - 42, 7, 6),
        Paint()..color = const Color(0xFF3A4048),
      );
    final twig = Paint()
      ..color = const Color(0xFF6B5A48)
      ..strokeWidth = 1.2;
    c
      ..drawLine(Offset(sx - 6, sy - 21), Offset(sx - 13, sy - 26), twig)
      ..drawLine(Offset(sx + 6, sy - 21), Offset(sx + 13, sy - 27), twig);
    _person(
      c,
      Offset(sx + 18, gy),
      math.sin(w.t * 6) * 0.6,
      false,
      -1,
      const Color(0xFFFFD43B),
      0.85,
    );
    // A snowball fight.
    const ax = 40.0, bx = 196.0;
    final cyc = (w.t * 0.8) % 2, side = cyc < 1 ? 0 : 1, u = cyc % 1;
    _person(
      c,
      Offset(ax, gy),
      w.t * 3,
      u < 0.15 && side == 0,
      1,
      const Color(0xFF4DABF7),
      0.85,
    );
    _person(
      c,
      Offset(bx, gy + 3),
      w.t * 3,
      u < 0.15 && side == 1,
      -1,
      const Color(0xFFFF6B6B),
      0.85,
    );
    if (u > 0.08 && u < 0.92) {
      final from = side == 1 ? bx - 4 : ax + 4,
          to = side == 1 ? ax + 4 : bx - 4,
          t = (u - 0.08) / 0.84;
      final at = Offset(
        from + (to - from) * t,
        gy - 16 - math.sin(t * math.pi) * 26,
      );
      c
        ..drawCircle(at, 2.6, Paint()..color = Colors.white)
        ..drawCircle(
          at,
          2.6,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.8
            ..color = const Color(0x99A0B4D2),
        );
    } else if (u >= 0.92) {
      final x = side == 1 ? ax : bx;
      for (var q = 0; q < 5; q++) {
        c.drawCircle(
          Offset(
            x + math.cos(q.toDouble()) * 5 * (u - 0.9) * 20,
            gy - 16 + math.sin(q.toDouble()) * 4,
          ),
          1.5,
          Paint()..color = const Color(0xCCFFFFFF),
        );
      }
    }
    // A sledge run: across the whole meadow and off the right edge, a
    // pause, then again from the left.
    const across = 5.0, pause = 2.5;
    final run = w.t % (across + pause);
    if (run < across) {
      final lx = -24 + (run / across) * (_w + 48),
          ly = grassY(lx.clamp(0.0, _w)) + 16;
      final slope = math.atan2(grassY(lx + 4) - grassY(lx - 4), 8) * 0.6;
      c
        ..save()
        ..translate(lx, ly)
        ..rotate(slope)
        ..drawRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(-9, -3, 18, 4),
            const Radius.circular(2),
          ),
          Paint()..color = const Color(0xFFC2541A),
        )
        ..restore();
      c
        ..save()
        ..translate(lx, ly - 2)
        ..rotate(slope);
      _person(c, Offset.zero, 1.2, false, 1, const Color(0xFF9775FA), 0.75);
      c.restore();
      for (var q = 0; q < 4; q++) {
        c.drawCircle(
          Offset(lx - 12 - q * 4, ly - 2 - w.rnd.nextDouble() * 4),
          1.3,
          Paint()..color = const Color(0xB3FFFFFF),
        );
      }
    }
    c.restore();
  }

  void _sheepAt(Canvas c, Offset at, double t, double alpha) {
    final bob = math.max(0, math.sin(t)) * 2.5;
    final x = at.dx, y = at.dy;
    c.drawOval(
      Rect.fromCenter(center: Offset(x, y + 1), width: 20, height: 4),
      Paint()..color = Color.fromRGBO(0, 0, 0, 0.15 * alpha),
    );
    final leg = Paint()
      ..color = const Color(0xFF3A3A3A).withValues(alpha: alpha)
      ..strokeWidth = 1.6;
    for (final dx in const [-5.0, -1.0, 3.0, 6.0]) {
      c.drawLine(Offset(x + dx, y - 5), Offset(x + dx, y), leg);
    }
    final wool = Paint()
      ..color = (_dark ? const Color(0xFFD8D8D8) : Colors.white).withValues(
        alpha: alpha,
      );
    for (final (dx, dy, r) in const [
      (-5.0, -8.0, 4.5),
      (0.0, -10.0, 5.0),
      (5.0, -8.0, 4.5),
      (-1.0, -6.0, 4.5),
      (4.0, -6.0, 4.0),
    ]) {
      c.drawCircle(Offset(x + dx, y + dy), r, wool);
    }
    c
      ..save()
      ..translate(x + 10, y - 7 + bob)
      ..rotate(0.5)
      ..drawOval(
        Rect.fromCenter(center: Offset.zero, width: 6, height: 4.8),
        Paint()..color = const Color(0xFF3A3A3A).withValues(alpha: alpha),
      )
      ..restore();
  }

  void _person(
    Canvas c,
    Offset at,
    double step,
    bool moving,
    double dir,
    Color shirt,
    double scale,
  ) {
    final dark = _dark ? const Color(0xFFDDDDDD) : const Color(0xFF3A4048);
    c
      ..save()
      ..translate(at.dx, at.dy)
      ..scale(dir * scale, scale)
      ..drawOval(
        Rect.fromCenter(center: const Offset(0, 1), width: 12, height: 3.6),
        Paint()..color = const Color(0x29000000),
      );
    final limb = Paint()
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..color = dark;
    for (final ph in const [0.0, math.pi]) {
      final a = moving ? math.sin(step + ph) * 0.7 : 0.0;
      c.drawLine(const Offset(0, -9), Offset(math.sin(a) * 7, 0), limb);
    }
    c.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-3.2, -18, 6.4, 10),
        const Radius.circular(3),
      ),
      Paint()..color = shirt,
    );
    limb
      ..color = shirt
      ..strokeWidth = 2;
    for (final ph in const [0.0, math.pi]) {
      final a = moving ? math.sin(step + ph + math.pi) * 0.8 : 0.3;
      c.drawLine(const Offset(0, -15), Offset(math.sin(a) * 6, -9), limb);
    }
    c
      ..drawCircle(
        const Offset(0.5, -21.5),
        3.2,
        Paint()..color = const Color(0xFFF2C7A5),
      )
      ..drawArc(
        Rect.fromCircle(center: const Offset(0.5, -22.5), radius: 3.3),
        math.pi,
        math.pi,
        true,
        Paint()
          ..color = _dark ? const Color(0xFFAAAAAA) : const Color(0xFF5A4632),
      )
      ..restore();
  }

  /// The hiker: orange jacket, pack, stick; arms up on the summit.
  void _hiker(
    Canvas c,
    Offset at,
    double step,
    bool walking,
    double dir,
    bool summit,
  ) {
    final dark = _dark ? const Color(0xFFE8E8E8) : const Color(0xFF3A4048);
    c
      ..save()
      ..translate(at.dx, at.dy)
      ..scale(dir, 1)
      ..rotate(walking ? 0.12 : 0)
      ..drawOval(
        Rect.fromCenter(center: const Offset(0, 1), width: 14, height: 4),
        Paint()..color = const Color(0x2E000000),
      );
    final leg = Paint()
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..color = dark;
    for (final ph in const [0.0, math.pi]) {
      final a = walking ? math.sin(step + ph) * 0.55 : 0.0;
      c.drawPath(
        Path()
          ..moveTo(0, -10)
          ..lineTo(math.sin(a) * 5, -5)
          ..lineTo(math.sin(a) * 9 - (walking ? 1 : 0), 0),
        leg,
      );
    }
    c
      ..drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-7, -21, 5, 9),
          const Radius.circular(2),
        ),
        Paint()..color = const Color(0xFFC2541A),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-3.5, -22, 7, 12),
          const Radius.circular(3),
        ),
        Paint()
          ..shader = ui.Gradient.linear(
            const Offset(-3, -22),
            const Offset(3, -9),
            [palette.ballLight, palette.ballDark],
          ),
      );
    final arm = Paint()
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFFF8A3D);
    if (summit) {
      c
        ..drawLine(const Offset(0, -19), const Offset(-4, -27), arm)
        ..drawLine(const Offset(0, -19), const Offset(5, -28), arm);
    } else {
      final a = walking ? math.sin(step) * 0.6 : 0.15,
          hand = Offset(math.sin(a) * 6 + 2, -12);
      c
        ..drawLine(const Offset(0, -19), hand, arm)
        ..drawLine(
          hand - const Offset(0, 1),
          Offset(hand.dx + 3, 0),
          Paint()
            ..strokeWidth = 1.2
            ..color = _dark ? const Color(0xFFCCCCCC) : const Color(0xFF6B5A48),
        );
    }
    c
      ..drawCircle(
        const Offset(0.5, -25.5),
        3.3,
        Paint()..color = const Color(0xFFF2C7A5),
      )
      ..drawArc(
        Rect.fromCircle(center: const Offset(0.5, -26.5), radius: 3.4),
        math.pi,
        math.pi,
        true,
        Paint()..color = dark,
      )
      ..drawRect(const Rect.fromLTWH(-3, -26.8, 8, 1.2), Paint()..color = dark)
      ..restore();
  }

  void _flag(Canvas c, Offset at) {
    c
      ..drawLine(
        at,
        at - const Offset(0, 18),
        Paint()
          ..color = palette.inkStrong
          ..strokeWidth = 1.4,
      )
      ..drawPath(
        Path()
          ..moveTo(at.dx, at.dy - 18)
          ..lineTo(
            at.dx + 12 + math.sin(world.t * 8) * 2 * world.wind,
            at.dy - 14,
          )
          ..lineTo(at.dx, at.dy - 10)
          ..close(),
        Paint()..color = palette.ballDark,
      );
  }

  void _birds(Canvas c, double top) {
    final w = world,
        a = math.max(0.0, 1 - w.wv) * (1 - w.night) * (1 - w.snowy);
    if (a <= 0.01) return;
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = const Color(0xFF3C4650).withValues(alpha: 0.7 * a);
    for (var b = 0; b < 3; b++) {
      final x = ((w.t * 26 + b * 40) % 360) - 30,
          y = top + 120 + b * 12 + math.sin(w.t * 2 + b) * 4,
          f = math.sin(w.t * 9 + b) * 3;
      c.drawPath(
        Path()
          ..moveTo(x - 6, y - f)
          ..quadraticBezierTo(x - 2, y - 3, x, y)
          ..quadraticBezierTo(x + 2, y - 3, x + 6, y - f),
        p,
      );
    }
  }

  void _clouds(Canvas c) {
    final w = world, n = (2 + w.cloudy * 3 + w.rain * 2).round();
    final color = w.rain > 0.05
        ? (_dark ? const Color(0xFF424650) : const Color(0xFF8C94A4))
              .withValues(alpha: 0.75 + 0.2 * w.storm)
        : (_dark ? const Color(0x66C8D2E1) : const Color(0xEBFFFFFF));
    // Dimmed at night, like the rest of the scene.
    final cloud = Color.lerp(color, const Color(0xFF3A4458), w.night * 0.75)!;
    for (final cl in w.clouds.take(n)) {
      final x = cl[0] - 60,
          y = cl[1] + w.rain * 16,
          kk = cl[2] * (1 + w.rain * 0.35);
      for (final (dx, dy, r) in const [
        (0.0, 0.0, 22.0),
        (20.0, -8.0, 26.0),
        (44.0, 0.0, 20.0),
        (24.0, 6.0, 22.0),
      ]) {
        c.drawCircle(
          Offset(x + dx * kk, y + dy * kk),
          r * kk,
          Paint()..color = cloud,
        );
      }
    }
  }

  void _snowfall(Canvas c, double top, double bottom) {
    final w = world;
    if (w.snowy < 0.02) return;
    final p = Paint()..color = Colors.white.withValues(alpha: 0.9 * w.snowy);
    for (var i = 0; i < 90; i++) {
      final dx = (i * 37 % 300).toDouble(),
          dy = (i * 53 % 540).toDouble(),
          sp = 0.6 + (i % 5) * 0.12;
      final x = (dx + math.sin(w.t * 0.8 + dy) * 10 + w.t * 8) % _w,
          y = (dy + w.t * 40 * sp) % (bottom + 40);
      c.drawCircle(Offset(x, y), 1.2 + sp, p);
    }
  }

  void _rain(Canvas c, double top, double bottom) {
    final w = world;
    if (w.rain < 0.02) return;
    final p = Paint()
      ..strokeWidth = 1.2
      ..color = const Color(0xFFB9CDE8).withValues(alpha: 0.65 * w.rain);
    final n = (110 * w.rain).round();
    for (var i = 0; i < n; i++) {
      final dx = (i * 37 % 300).toDouble(),
          dy = (i * 53 % 500).toDouble(),
          sp = 0.7 + (i % 5) * 0.1;
      final x = (dx + w.t * 40) % _w, y = (dy + w.t * 420 * sp) % (bottom + 40);
      c.drawLine(Offset(x, y), Offset(x - 3 - w.wind * 4, y + 12), p);
    }
  }

  void _lightning(Canvas c, double top, double bottom) {
    final w = world;
    if (w.boltLife <= 0) return;
    if (w.bolt == null) {
      var x = 60 + w.rnd.nextDouble() * (_w - 120), y = 80.0;
      final pts = [Offset(x, y)];
      while (y < bottom - 90) {
        x += (w.rnd.nextDouble() - 0.5) * 34;
        y += 18 + w.rnd.nextDouble() * 16;
        pts.add(Offset(x, y));
      }
      w.bolt = pts;
    }
    c.drawRect(
      Rect.fromLTWH(0, 0, _w, bottom + 40),
      Paint()
        ..color = Colors.white.withValues(
          alpha: (w.boltLife * 0.9).clamp(0.0, 1.0),
        ),
    );
    final path = Path()..addPolygon(w.bolt!, false);
    c
      ..drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..color = const Color(0x66FFF6C0)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      )
      ..drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = const Color(0xFFFFF8D6),
      );
  }

  void _ball(Canvas c, Offset at, double r, double alpha) {
    c.drawCircle(
      at,
      r,
      Paint()
        ..shader = ui.Gradient.radial(at - Offset(r * 0.4, r * 0.4), r * 1.4, [
          palette.ballLight.withValues(alpha: alpha),
          palette.ballDark.withValues(alpha: alpha),
        ]),
    );
  }

  void _dashed(Canvas c, Offset a, Offset b, Paint p) {
    final d = (b - a).distance;
    final dir = (b - a) / d;
    for (var s = 0.0; s < d; s += 6) {
      c.drawLine(a + dir * s, a + dir * math.min(d, s + 2.5), p);
    }
  }

  /// The scene moves on every frame.
  @override
  bool shouldRepaint(_ScenePainter old) => true;
}
