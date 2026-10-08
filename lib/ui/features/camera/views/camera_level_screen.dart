import 'dart:math' as math;

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';

import '../../../../domain/camera_level.dart';
import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/permission_prompt.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/camera_level_view_model.dart';

/// Camera level: true level and plumb lines and the phone's own lines over
/// the camera's picture; frozen, two handles mark an edge to measure.
class CameraLevelScreen extends StatelessWidget {
  const CameraLevelScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
  });

  final CameraLevelViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolCamera,
    steps: [l.cameraHelp1, l.cameraHelp2, l.cameraHelp3, l.cameraHelp4],
    tip: l.cameraTip,
  );

  /// The panel below the picture, without the phone's bottom inset.
  static const _footer = 196.0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final vm = viewModel;
        final live = vm.access == CameraAccess.granted && vm.feed != null;
        return ToolFrame(
          title: l.toolCamera,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          headerOnDark: live,
          body: switch (vm.access) {
            CameraAccess.checking => const SizedBox.shrink(),
            CameraAccess.needed => PermissionPrompt(
              icon: Icons.photo_camera_rounded,
              title: l.cameraAllowTitle,
              body: l.cameraAllowBody,
              actions: [
                SoftButton(
                  label: l.cameraAllow,
                  icon: Icons.photo_camera_rounded,
                  emphasis: true,
                  onPressed: vm.allow,
                ),
              ],
            ),
            CameraAccess.denied => PermissionPrompt(
              icon: Icons.no_photography_rounded,
              title: l.cameraDeniedTitle,
              body: l.cameraDeniedBody,
              actions: [
                SoftButton(
                  label: l.openSettings,
                  icon: Icons.settings_rounded,
                  emphasis: true,
                  onPressed: vm.openSettings,
                ),
                SoftButton(
                  label: l.tryAgain,
                  icon: Icons.refresh_rounded,
                  onPressed: vm.allow,
                ),
              ],
            ),
            CameraAccess.missing => PermissionPrompt(
              icon: Icons.no_photography_rounded,
              title: l.toolCamera,
              body: l.noCamera,
              actions: const [],
            ),
            CameraAccess.granted => _CameraView(viewModel: vm),
          },
          footer: live ? _panel(l) : null,
        );
      },
    );
  }

  Widget _panel(AppLocalizations l) {
    final vm = viewModel;
    final pose = vm.pose;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatPanel([
          (pose == null ? '—' : '${formatDecimal(pose.tilt.abs())}°', l.tilt),
          (
            pose == null ? '—' : '${formatSignedDecimal(pose.pitch)}°',
            l.forwardBack,
          ),
        ]),
        const SizedBox(height: 12),
        _status(l, pose),
        const SizedBox(height: 12),
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: SoftButton(
                label: vm.frozen ? l.resume : l.freeze,
                icon: vm.frozen
                    ? Icons.play_arrow_rounded
                    : Icons.pause_rounded,
                emphasis: !vm.frozen,
                onPressed: vm.toggleFreeze,
              ),
            ),
            if (vm.torchAvailable)
              SoftIconButton(
                icon: vm.torch
                    ? Icons.flashlight_on_rounded
                    : Icons.flashlight_off_rounded,
                tooltip: l.torch,
                active: vm.torch,
                onPressed: vm.toggleTorch,
              ),
          ],
        ),
      ],
    );
  }

  Widget _status(AppLocalizations l, CameraPose? pose) {
    final vm = viewModel;
    if (pose == null) {
      return StatusBanner(
        icon: Icons.screen_rotation_alt_rounded,
        text: l.cameraHoldUpright,
      );
    }
    if (pose.pitch.abs() > CameraLevelViewModel.squareWithin) {
      return StatusBanner(
        icon: Icons.warning_amber_rounded,
        text: l.cameraFaceWall,
        tone: StatusTone.warning,
      );
    }
    if (vm.frozen) {
      return StatusBanner(
        icon: Icons.pan_tool_alt_rounded,
        text: l.cameraDragHandles,
      );
    }
    final text = vm.level
        ? l.cameraLevel
        : l.cameraTilted(formatDecimal(pose.tilt.abs()));
    return StatusBanner(
      icon: vm.level
          ? Icons.check_circle_rounded
          // Which way to turn the phone to level it.
          : pose.tilt > 0
          ? Icons.rotate_right_rounded
          : Icons.rotate_left_rounded,
      text: text,
      tone: vm.level ? StatusTone.success : StatusTone.neutral,
    );
  }
}

/// The picture with its lines, ending in a rounded edge above the panel.
class _CameraView extends StatelessWidget {
  const _CameraView({required this.viewModel});

  final CameraLevelViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final vm = viewModel;
    final feed = vm.feed;
    final pose = vm.pose;
    final bottom =
        CameraLevelScreen._footer + MediaQuery.paddingOf(context).bottom;
    final top = ToolFrame.contentTop(context);
    final handles = vm.handles;
    final edge = vm.edge;
    return Stack(
      children: [
        Positioned.fill(
          bottom: bottom - 26,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(28),
            ),
            child: LayoutBuilder(
              builder: (context, box) {
                vm.area = box.biggest;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    if (feed != null)
                      ExcludeSemantics(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.hardEdge,
                          child: SizedBox(
                            width: 1000 * feed.aspectRatio,
                            height: 1000,
                            child: feed.preview,
                          ),
                        ),
                      ),
                    // Shade behind the header, so its white title reads, and a
                    // light veil over a frozen picture.
                    if (vm.frozen) const ColoredBox(color: Color(0x1F000000)),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment(0, -0.4),
                          colors: [Color(0x8C000000), Color(0x00000000)],
                        ),
                      ),
                    ),
                    Semantics(
                      label: pose == null
                          ? l.cameraHoldUpright
                          : l.cameraSemantics(formatDecimal(pose.tilt.abs())),
                      child: CustomPaint(
                        painter: _LinesPainter(
                          pose: pose,
                          showPhone: vm.showPhone && !vm.frozen,
                          showTrue: vm.showTrue,
                          edge: vm.showPhone ? handles : null,
                          level: vm.level,
                          palette: p,
                        ),
                      ),
                    ),
                    // The edge's ends, to drag onto an edge in the picture.
                    if (vm.showPhone && handles != null)
                      for (final (i, h) in handles.indexed)
                        Positioned(
                          left: h.dx - 24,
                          top: h.dy - 24,
                          width: 48,
                          height: 48,
                          child: Semantics(
                            label: l.cameraHandle,
                            child: GestureDetector(
                              key: ValueKey('edgeHandle$i'),
                              behavior: HitTestBehavior.opaque,
                              onPanUpdate: (d) =>
                                  vm.moveHandle(i, vm.handles![i] + d.delta),
                              child: Center(child: _Handle(palette: p)),
                            ),
                          ),
                        ),
                    Positioned(
                      top: top + 8,
                      left: 0,
                      right: 0,
                      child: Column(
                        spacing: 8,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              _Toggle(
                                label: l.cameraPhoneLines,
                                on: vm.showPhone,
                                onTap: vm.togglePhoneLines,
                              ),
                              _Toggle(
                                label: l.cameraTrueLines,
                                on: vm.showTrue,
                                onTap: vm.toggleTrueLines,
                              ),
                            ],
                          ),
                          if (vm.frozen) _Chip(text: l.cameraFrozen),
                        ],
                      ),
                    ),
                    if (edge != null && vm.showPhone)
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 44,
                        child: Center(child: _EdgeCard(edge: edge)),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// A switch for one pair of lines: white when on, dark glass when off.
class _Toggle extends StatelessWidget {
  const _Toggle({required this.label, required this.on, required this.onTap});

  final String label;
  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      toggled: on,
      excludeSemantics: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: const BoxConstraints(minHeight: 36, minWidth: 104),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: on ? const Color(0xEBFFFFFF) : const Color(0x61000000),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: on ? const Color(0xFF323232) : const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0x6B000000),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        const Icon(Icons.pause_rounded, size: 14, color: Color(0xFFFFFFFF)),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ],
    ),
  );
}

/// A white disc with the orange ball: one end of the edge line.
class _Handle extends StatelessWidget {
  const _Handle({required this.palette});

  final Palette palette;

  @override
  Widget build(BuildContext context) => Container(
    width: 26,
    height: 26,
    decoration: const BoxDecoration(
      color: Color(0xF2FFFFFF),
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: Color(0x59000000), blurRadius: 6)],
    ),
    alignment: Alignment.center,
    child: Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.4, -0.4),
          colors: [palette.ballLight, palette.ballDark],
        ),
      ),
    ),
  );
}

/// The edge's reading: how far off and which side to lift.
class _EdgeCard extends StatelessWidget {
  const _EdgeCard({required this.edge});

  final EdgeReading edge;

  /// Within this, the edge counts as level (or plumb).
  static const _true = 0.15;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final off = edge.offset.abs();
    final value = formatDecimal(off);
    final good = off < _true;
    final text = good
        ? (edge.plumb ? l.edgePlumb : l.edgeLevel)
        : edge.plumb
        ? l.edgeOffPlumb(value)
        : edge.offset > 0
        ? l.edgeLiftRight(value)
        : l.edgeLiftLeft(value);
    return Semantics(
      liveRegion: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: p.isDark ? const Color(0xF0262626) : const Color(0xF5FFFFFF),
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: good ? p.success : p.inkStrong,
          ),
        ),
      ),
    );
  }
}

/// The lines: true level and plumb (following gravity; orange when the
/// phone is level), the phone's own dashed lines with an arc between the
/// two horizontals, and, once frozen, the edge line through the handles.
class _LinesPainter extends CustomPainter {
  const _LinesPainter({
    required this.pose,
    required this.showPhone,
    required this.showTrue,
    required this.edge,
    required this.level,
    required this.palette,
  });

  final CameraPose? pose;
  final bool showPhone, showTrue, level;
  final List<Offset>? edge;
  final Palette palette;

  /// The true lines: a little see-through, so the picture shows past them.
  static const _true = Color(0xBFFFFFFF);

  /// The phone's dashed lines, a quiet grey.
  static const _phone = Color(0xCCB4BCC4);
  static const _shadow = Color(0x4D000000);

  /// Where the arc between the two lines sits, and its angle label.
  static const _arc = 130.0;

  @override
  void paint(Canvas canvas, Size size) {
    final pose = this.pose;
    if (pose == null) return;
    final c = size.center(Offset.zero);
    final reach = size.longestSide * 1.5;
    final turn = pose.rotation * math.pi / 180;

    void line(Offset a, Offset b, Paint paint, {bool dashed = false}) {
      final shadow = Paint()
        ..strokeWidth = paint.strokeWidth + 2
        ..color = _shadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      if (!dashed) {
        canvas
          ..drawLine(a, b, shadow)
          ..drawLine(a, b, paint);
        return;
      }
      final d = b - a, len = d.distance, u = d / len;
      for (var t = 0.0; t < len; t += 13) {
        final p0 = a + u * t, p1 = a + u * math.min(t + 7, len);
        canvas
          ..drawLine(p0, p1, shadow)
          ..drawLine(p0, p1, paint);
      }
    }

    // True level and plumb: the phone turned one way, the world appears
    // turned the other.
    if (showTrue) {
      final h = Offset(math.cos(turn), math.sin(turn)) * reach;
      final v = Offset(-math.sin(turn), math.cos(turn)) * reach;
      final paint = Paint()
        ..strokeWidth = level ? 3 : 2
        ..strokeCap = StrokeCap.round
        ..color = level ? palette.ballDark : _true;
      line(c - h, c + h, paint);
      line(c - v, c + v, paint);
    }

    if (showPhone) {
      final paint = Paint()
        ..strokeWidth = 1.6
        ..color = _phone;
      line(Offset(0, c.dy), Offset(size.width, c.dy), paint, dashed: true);
      line(Offset(c.dx, 0), Offset(c.dx, size.height), paint, dashed: true);
      // The angle between the phone's line and the nearest true line: an
      // orange wedge on the right, with its value just beyond it.
      if (showTrue && !level) _angle(canvas, c, pose.tilt);
    }

    // Frozen: the edge, a dashed guide through it and a solid part between
    // the handles.
    final e = edge;
    if (e != null) {
      final d = e[1] - e[0];
      if (d.distance > 0) {
        final u = d / d.distance * reach;
        line(
          e[0] - u,
          e[1] + u,
          Paint()
            ..strokeWidth = 1.4
            ..color = const Color(0xB3FFFFFF),
          dashed: true,
        );
      }
      line(
        e[0],
        e[1],
        Paint()
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..color = palette.ballDark,
      );
    }
  }

  void _angle(Canvas canvas, Offset c, double tilt) {
    final a = tilt * math.pi / 180;
    final from = math.min(0.0, a), sweep = a.abs();
    final box = Rect.fromCircle(center: c, radius: _arc);
    final orange = LinearGradient(colors: [palette.ballLight, palette.ballDark])
        .createShader(box);
    canvas
      ..drawPath(
        Path()
          ..moveTo(c.dx, c.dy)
          ..arcTo(box, from, sweep, false)
          ..close(),
        Paint()
          ..shader = LinearGradient(
            colors: [
              palette.ballLight.withValues(alpha: 0.45),
              palette.ballDark.withValues(alpha: 0.45),
            ],
          ).createShader(box),
      )
      ..drawArc(
        box,
        from,
        sweep,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..shader = orange,
      );
    // The value, on a dark glass chip beside the arc's middle.
    final mid = c + Offset.fromDirection(a / 2, _arc + 14);
    final tp = TextPainter(
      text: TextSpan(
        text: '${formatDecimal(tilt.abs())}°',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          fontFeatures: readoutFeatures,
          color: Color(0xFFFFFFFF),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final chip = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        mid.dx,
        mid.dy - tp.height / 2 - 4,
        tp.width + 16,
        tp.height + 8,
      ),
      Radius.circular((tp.height + 8) / 2),
    );
    canvas.drawRRect(chip, Paint()..color = const Color(0x8C000000));
    tp.paint(canvas, Offset(mid.dx + 8, mid.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(_LinesPainter old) =>
      old.pose != pose ||
      old.showPhone != showPhone ||
      old.showTrue != showTrue ||
      old.level != level ||
      old.palette != palette ||
      !listEquals(old.edge, edge);
}
