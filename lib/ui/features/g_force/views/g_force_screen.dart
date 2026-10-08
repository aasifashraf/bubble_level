import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../domain/g_force.dart';
import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/g_force_view_model.dart';

/// G-force meter: the car from above on a soft dial. The side you're
/// pushed towards glows, green to orange to red with the force; the rim
/// lights the same way and keeps a dot at the peak in each direction.
class GForceScreen extends StatelessWidget {
  const GForceScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
  });

  final GForceViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolGForce,
    steps: [l.gHelp1, l.gHelp2, l.gHelp3, l.gHelp4],
    tip: l.gTip,
  );

  /// Green while gentle, orange once firm, red when hard.
  static List<DialZone> zones(Palette p) => [
    (from: 0, color: p.gaugeSafe),
    (from: GForceViewModel.firmAt, color: p.gaugeCaution),
    (from: GForceViewModel.hardAt, color: p.gaugeDanger),
  ];

  static String _g(double v) => '${formatDecimal(v, digits: 2)} g';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final r = viewModel.reading;
        return ToolFrame(
          title: l.toolGForce,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          bodyBottomInset: 190,
          body: SensorStateGate(
            state: r.state,
            ready: r.zeroed,
            missingText: l.noAccelerometerG,
            child: GForceDial(
              reading: r,
              zones: zones(Palette.of(context)),
              label: r.total < GForceViewModel.steadyBelow
                  ? null
                  : _g(viewModel.strength),
              semanticsLabel: l.gSemantics(formatDecimal(r.total, digits: 2)),
            ),
          ),
          footer: !r.zeroed
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatPanel([
                      (_g(r.peakSpeedUp), l.gSpeedUp),
                      (_g(r.peakBrake), l.gBrake),
                      (_g(r.peakCorner), l.gCorner),
                    ]),
                    const SizedBox(height: 14),
                    _status(context, l),
                    const SizedBox(height: 14),
                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: SoftButton(
                            label: l.gZero,
                            icon: Icons.center_focus_strong_rounded,
                            emphasis: true,
                            onPressed: viewModel.zero,
                          ),
                        ),
                        SoftIconButton(
                          icon: Icons.restart_alt_rounded,
                          tooltip: l.gResetPeaks,
                          onPressed: viewModel.resetPeaks,
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _status(BuildContext context, AppLocalizations l) {
    final vm = viewModel;
    if (vm.justZeroed) {
      return StatusBanner(icon: Icons.check_circle_rounded, text: l.gZeroed);
    }
    final value = formatDecimal(vm.strength, digits: 2);
    final (icon, text) = switch (vm.motion) {
      GMotion.steady => (Icons.check_circle_rounded, l.gSteady),
      // The way you're pushed: forward when braking, back speeding up.
      GMotion.braking => (Icons.north_rounded, l.gBraking(value)),
      GMotion.speedingUp => (Icons.south_rounded, l.gSpeedingUp(value)),
      GMotion.leftBend => (Icons.turn_left_rounded, l.gLeftBend(value)),
      GMotion.rightBend => (Icons.turn_right_rounded, l.gRightBend(value)),
    };
    return StatusBanner(
      icon: icon,
      text: text,
      tone: vm.strength >= GForceViewModel.hardAt
          ? StatusTone.warning
          : StatusTone.neutral,
    );
  }
}

/// The dial: a soft disc with the car from above, the glow on the side the
/// push goes, the lit rim with its peak dots and the value at the bright
/// spot. The push eases, so road bumps don't jump it.
class GForceDial extends StatelessWidget {
  const GForceDial({
    super.key,
    required this.reading,
    required this.zones,
    required this.label,
    required this.semanticsLabel,
  });

  final GReading reading;
  final List<DialZone> zones;

  /// The value at the bright spot, or null while steady.
  final String? label;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final top = ToolFrame.sideBySide(context)
        ? 0.0
        : ToolFrame.contentTop(context);
    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: LayoutBuilder(
        builder: (context, box) {
          final w = box.maxWidth, h = box.maxHeight;
          final s = math.min(w / 320, (h - top) / 330).clamp(0.7, 1.6);
          final centre = Offset(w / 2, top + (h - top) / 2);
          final r = 128 * s;
          return Stack(
            children: [
              Positioned(
                left: centre.dx - r - 8 * s,
                top: centre.dy - r - 8 * s,
                width: (r + 8 * s) * 2,
                height: (r + 8 * s) * 2,
                child: DecoratedBox(
                  decoration: softSurface(
                    p,
                    radius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Positioned.fill(
                child: TweenAnimationBuilder<Offset>(
                  // Screen axes: right is a push to the right, up is a
                  // push forward (braking).
                  tween: Tween(end: Offset(reading.lat, reading.lon)),
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  builder: (context, push, _) => CustomPaint(
                    painter: _GlowPainter(
                      palette: p,
                      push: push,
                      peaks: reading.peaks,
                      colorOf: (g) => zoneColor(zones, g, blend: 0.08, end: 1),
                      label: label,
                      centre: centre,
                      radius: r,
                      scale: s,
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

class _GlowPainter extends CustomPainter {
  _GlowPainter({
    required this.palette,
    required this.push,
    required this.peaks,
    required this.colorOf,
    required this.label,
    required this.centre,
    required this.radius,
    required this.scale,
  });

  final Palette palette;

  /// The push on the screen's axes, g (x right, y down = speeding up).
  final Offset push;
  final List<double> peaks;
  final Color Function(double) colorOf;
  final String? label;
  final Offset centre;
  final double radius, scale;

  /// The push at which the glow is full, g.
  static const _full = 0.8;

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette, c = centre, r = radius, s = scale;
    final g = push.distance;
    final a = math.atan2(push.dy, push.dx);
    final k = (g / _full).clamp(0.0, 1.0);
    final colour = colorOf(g);

    // The rim, brightest towards the push.
    const steps = 90;
    final rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6 * s;
    for (var i = 0; i < steps; i++) {
      final at = i / steps * 2 * math.pi;
      final near = math.pow(math.max(0, math.cos(at - a)), 4).toDouble();
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: r - 6 * s),
        at,
        2 * math.pi / steps + 0.004,
        false,
        rim
          ..color = (g < 0.02 ? p.tickMinor : colour).withValues(
            alpha: 0.12 + near * k * 0.85,
          ),
      );
    }

    // The peak in each direction (sector 0 is straight ahead, the top).
    for (final (i, v) in peaks.indexed) {
      if (v <= 0.05) continue;
      final at = -math.pi / 2 + i / peaks.length * 2 * math.pi;
      canvas.drawCircle(
        c + Offset.fromDirection(at, r - 20 * s),
        3.2 * s,
        Paint()..color = colorOf(v),
      );
    }

    // The glow off the side of the car the push goes.
    if (g > 0.02) {
      final from = c + Offset(math.cos(a) * 40 * s, math.sin(a) * 52 * s);
      final spread = (40 + k * 70) * s;
      canvas.drawCircle(
        from,
        spread,
        Paint()
          ..shader = RadialGradient(
            colors: [
              colour.withValues(alpha: 0.1 + 0.55 * k),
              colour.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: from, radius: spread)),
      );
    }

    _car(canvas, c, s);

    // The value where the rim is brightest.
    if (label case final text?) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: 15 * s,
            fontWeight: FontWeight.w700,
            fontFeatures: readoutFeatures,
            color: p.inkStrong,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final at =
          c + Offset(math.cos(a) * (r + 30 * s), math.sin(a) * (r + 24 * s));
      // Kept on the screen when the push is sideways.
      final x = at.dx.clamp(tp.width / 2 + 12, size.width - tp.width / 2 - 12);
      tp.paint(canvas, Offset(x - tp.width / 2, at.dy - tp.height / 2));
    }
  }

  /// The car from above, nose up.
  void _car(Canvas canvas, Offset c, double s) {
    final p = palette;
    final body = RRect.fromRectAndCorners(
      Rect.fromCenter(center: c, width: 52 * s, height: 92 * s),
      topLeft: Radius.circular(20 * s),
      topRight: Radius.circular(20 * s),
      bottomLeft: Radius.circular(14 * s),
      bottomRight: Radius.circular(14 * s),
    );
    canvas
      ..drawRRect(
        body.shift(Offset(0, 4 * s)),
        Paint()
          ..color = p.dialShadow.withValues(alpha: 0.7)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8 * s),
      )
      ..drawRRect(
        body,
        Paint()
          ..shader = LinearGradient(colors: [p.tickMinor, p.tickMajor])
              .createShader(body.outerRect),
      );
    final glass = Paint()..color = p.isDark ? p.wellDark : p.dialLight;
    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(c.dx - 19 * s, c.dy - 26 * s, 38 * s, 20 * s),
          Radius.circular(6 * s),
        ),
        glass,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(c.dx - 18 * s, c.dy + 16 * s, 36 * s, 14 * s),
          Radius.circular(5 * s),
        ),
        glass,
      );
    final lamp = Paint()..color = p.ballLight;
    canvas
      ..drawCircle(c + Offset(-17 * s, -44 * s), 3 * s, lamp)
      ..drawCircle(c + Offset(17 * s, -44 * s), 3 * s, lamp);
  }

  @override
  bool shouldRepaint(_GlowPainter old) =>
      old.palette != palette ||
      old.push != push ||
      old.peaks != peaks ||
      old.label != label ||
      old.centre != centre ||
      old.radius != radius;
}
