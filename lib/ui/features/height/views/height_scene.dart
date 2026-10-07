import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/format.dart';
import '../../../core/theme.dart';

/// The measurement seen from the side, to scale: you at the left with the
/// phone at eye level, the object (a tree) on the right, and the sight
/// lines between. The orange ray is the live angle; dashed lines are the
/// locked ones. Distance and height bars appear only once measured; until
/// then the tree stands at a nominal place and size, with no numbers.
class HeightScene extends StatelessWidget {
  const HeightScene({
    super.key,
    required this.live,
    required this.eyeHeight,
    required this.distance,
    required this.height,
    required this.feet,
    required this.bottomInset,
  });

  /// The sight angle now (degrees), or null when not aiming.
  final double? live;
  final double eyeHeight;

  /// Measured (or typed) distance and height, metres, or null.
  final double? distance, height;
  final bool feet;

  /// The footer's height: the ground sits just above it.
  final double bottomInset;

  /// Where the tree stands before the distance is known, metres.
  static const _nominalDistance = 15.0;

  @override
  Widget build(BuildContext context) {
    final d = distance ?? _nominalDistance;
    // Until measured, the top sits about 35° up.
    final h = height ?? eyeHeight + d * 0.7;
    return TweenAnimationBuilder<Offset>(
      tween: Tween(end: Offset(d, h)),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, size, _) => TweenAnimationBuilder<double>(
        tween: Tween(end: distance == null ? 0 : 1),
        duration: const Duration(milliseconds: 400),
        builder: (context, showDistance, _) => TweenAnimationBuilder<double>(
          tween: Tween(end: height == null ? 0 : 1),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          builder: (context, showHeight, _) => CustomPaint(
            size: Size.infinite,
            painter: _ScenePainter(
              palette: Palette.of(context),
              live: live,
              eye: eyeHeight,
              distance: size.dx,
              height: size.dy,
              distanceLabel: distance == null
                  ? null
                  : formatDistance(distance!, feet: feet),
              heightLabel: height == null
                  ? null
                  : formatDistance(height!, feet: feet),
              showDistance: showDistance,
              showHeight: showHeight,
              top: MediaQuery.paddingOf(context).top + 190,
              bottomInset: bottomInset,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScenePainter extends CustomPainter {
  _ScenePainter({
    required this.palette,
    required this.live,
    required this.eye,
    required this.distance,
    required this.height,
    required this.distanceLabel,
    required this.heightLabel,
    required this.showDistance,
    required this.showHeight,
    required this.top,
    required this.bottomInset,
  });

  final Palette palette;
  final double? live;
  final double eye, distance, height;
  final String? distanceLabel, heightLabel;
  final double showDistance, showHeight;

  /// The highest the tree may reach, and the footer's height.
  final double top, bottomInset;

  static const _rad = math.pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette;
    final w = size.width;
    final ground = size.height - bottomInset - 40;
    const person = 44.0;
    // Metres to pixels: the distance, the crown's far half and the height
    // bar with its label fit across; the height under the live angle.
    final m = math.min(
      (w - person - 48) / (distance + height * _crownWidth),
      math.max(ground - top, 80) / math.max(height, eye * 1.2),
    );
    final tree = person + distance * m;
    final eyeAt = Offset(person, ground - eye * m);

    // Sky down to the ground, then the ground on behind the footer.
    final sky = Rect.fromLTRB(0, 0, w, ground);
    canvas
      ..drawRect(
        sky,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: p.isDark
                ? [p.dialDark, p.dialLight]
                : [p.background, p.haloDark],
          ).createShader(sky),
      )
      ..drawRect(
        Rect.fromLTRB(0, ground, w, size.height),
        Paint()
          ..color = Color.alphaBlend(
            p.dialShadow.withValues(alpha: p.isDark ? 0.5 : 0.4),
            p.background,
          ),
      );

    _tree(canvas, tree, ground, height * m);
    _person(canvas, person, ground, eye * m);

    // Level from the eye, faint.
    _dashed(
      canvas,
      eyeAt,
      Offset(w, eyeAt.dy),
      Paint()
        ..color = p.tickMinor
        ..strokeWidth = 1,
      2,
      5,
    );
    // The sight lines to the base and top, once measured.
    final locked = Paint()
      ..color = p.tickMajor
      ..strokeWidth = 1.5;
    if (showDistance > 0) {
      _dashed(
        canvas,
        eyeAt,
        Offset(tree, ground),
        locked..color = p.tickMajor.withValues(alpha: showDistance),
        5,
        5,
      );
    }
    if (showHeight > 0) {
      _dashed(
        canvas,
        eyeAt,
        Offset(tree, ground - height * m),
        locked..color = p.tickMajor.withValues(alpha: showHeight),
        5,
        5,
      );
    }

    // The live sight line, from the eye out of the picture.
    if (live case final a?) {
      final dir = Offset(math.cos(a * _rad), -math.sin(a * _rad));
      final end = eyeAt + dir * (w * 1.5);
      canvas.drawLine(
        eyeAt,
        end,
        Paint()
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round
          ..shader = LinearGradient(colors: [p.ballLight, p.ballDark])
              .createShader(Rect.fromPoints(eyeAt, eyeAt + dir * w)),
      );
      // The phone at the eye, tilted with it.
      canvas
        ..save()
        ..translate(eyeAt.dx + 5, eyeAt.dy)
        ..rotate(-a * _rad)
        ..drawRRect(
          RRect.fromLTRBR(
            -2,
            -2.5,
            (eye * m * 0.45).clamp(7, 15),
            2.5,
            const Radius.circular(2),
          ),
          Paint()..color = p.isDark ? p.tickMajor : p.tab,
        )
        ..restore();
    }

    // Distance along the ground.
    if (distanceLabel case final label? when showDistance > 0) {
      final y = ground + 10;
      canvas.drawLine(
        Offset(person, y),
        Offset(tree, y),
        _bar(Offset(person, y), Offset(tree, y), showDistance),
      );
      _label(canvas, label, Offset((person + tree) / 2, y + 16), showDistance);
    }

    // Height up beside the tree, with the ball on top.
    if (heightLabel case final label? when showHeight > 0) {
      final x = tree + _crown(height * m) + 16;
      final topY = ground - height * m * showHeight;
      canvas.drawLine(
        Offset(x, ground),
        Offset(x, topY),
        _bar(Offset(x, ground), Offset(x, topY), 1),
      );
      _ball(canvas, Offset(x, topY), 6);
      canvas
        ..save()
        ..translate(x + 18, ground - height * m / 2)
        ..rotate(-math.pi / 2);
      _label(canvas, label, Offset.zero, showHeight);
      canvas.restore();
    }
  }

  /// The crown's half width for a tree [h] pixels tall.
  static double _crown(double h) => h * _crownWidth;

  static const _crownWidth = 0.26;

  void _tree(Canvas canvas, double x, double ground, double h) {
    final p = palette;
    canvas.drawRRect(
      RRect.fromLTRBR(
        x - math.max(h * 0.025, 2),
        ground - h * 0.4,
        x + math.max(h * 0.025, 2),
        ground,
        const Radius.circular(2),
      ),
      Paint()..color = p.isDark ? p.tickMinor : p.tickMajor,
    );
    final crown = Rect.fromLTRB(
      x - _crown(h),
      ground - h,
      x + _crown(h),
      ground,
    );
    final leaves = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        // Scenery: faded, so the orange reading stays the focus.
        colors: p.isDark
            ? [p.tickMinor, Color.lerp(p.tickMinor, p.tickMajor, 0.3)!]
            : [p.tickMinor, p.tickMajor],
      ).createShader(crown);
    // Overlapping round clumps, the top one touching the measured top.
    final clumps = Path();
    for (final (dx, cy, r) in const [
      (0.0, 0.86, 0.14),
      (-0.09, 0.68, 0.17),
      (0.08, 0.6, 0.16),
      (0.0, 0.5, 0.18),
    ]) {
      clumps.addOval(
        Rect.fromCircle(
          center: Offset(x + dx * h, ground - h * cy),
          radius: h * r,
        ),
      );
    }
    canvas.drawPath(clumps, leaves);
  }

  void _person(Canvas canvas, double x, double ground, double eye) {
    final paint = Paint()
      ..color = palette.label
      ..strokeWidth = math.max(eye * 0.1, 1.5)
      ..strokeCap = StrokeCap.round;
    final head = math.max(eye * 0.11, 1.5);
    canvas
      ..drawLine(Offset(x, ground), Offset(x, ground - eye * 0.5), paint)
      ..drawRRect(
        RRect.fromLTRBR(
          x - eye * 0.13,
          ground - eye * 0.88,
          x + eye * 0.13,
          ground - eye * 0.46,
          Radius.circular(eye * 0.08),
        ),
        paint,
      )
      ..drawCircle(Offset(x, ground - eye), head, paint);
  }

  Paint _bar(Offset a, Offset b, double opacity) => Paint()
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round
    ..shader = LinearGradient(
      colors: [
        palette.ballLight.withValues(alpha: opacity),
        palette.ballDark.withValues(alpha: opacity),
      ],
    ).createShader(Rect.fromPoints(a, b));

  void _ball(Canvas canvas, Offset c, double r) {
    canvas
      ..drawCircle(
        c + const Offset(0, 2),
        r,
        Paint()
          ..color = palette.ballDark.withValues(alpha: 0.4)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      )
      ..drawCircle(
        c,
        r,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.4, -0.4),
            colors: [palette.ballLight, palette.ballDark],
          ).createShader(Rect.fromCircle(center: c, radius: r)),
      );
  }

  void _label(Canvas canvas, String text, Offset centre, double opacity) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          fontFeatures: readoutFeatures,
          color: palette.inkStrong.withValues(alpha: opacity),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, centre - Offset(tp.width / 2, tp.height / 2));
  }

  static void _dashed(
    Canvas canvas,
    Offset a,
    Offset b,
    Paint paint,
    double dash,
    double gap,
  ) {
    final length = (b - a).distance;
    if (length == 0) return;
    final dir = (b - a) / length;
    for (var t = 0.0; t < length; t += dash + gap) {
      canvas.drawLine(a + dir * t, a + dir * math.min(t + dash, length), paint);
    }
  }

  @override
  bool shouldRepaint(_ScenePainter old) =>
      old.palette != palette ||
      old.live != live ||
      old.eye != eye ||
      old.distance != distance ||
      old.height != height ||
      old.distanceLabel != distanceLabel ||
      old.heightLabel != heightLabel ||
      old.showDistance != showDistance ||
      old.showHeight != showHeight ||
      old.top != top ||
      old.bottomInset != bottomInset;
}
