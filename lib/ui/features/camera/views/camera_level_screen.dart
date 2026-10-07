import 'dart:math' as math;

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

/// Camera level: graph paper that follows gravity over the camera's
/// picture, for lining up tiles, shelves, frames and wallpaper.
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
    final text = vm.level
        ? l.cameraLevel
        : l.cameraTilted(formatDecimal(pose.tilt.abs()));
    return StatusBanner(
      icon: vm.frozen
          ? Icons.pause_circle_rounded
          : vm.level
          ? Icons.check_circle_rounded
          // Which way to turn the phone to level it.
          : pose.tilt > 0
          ? Icons.rotate_right_rounded
          : Icons.rotate_left_rounded,
      text: vm.frozen ? l.locked(text) : text,
      tone: vm.level ? StatusTone.success : StatusTone.neutral,
    );
  }
}

/// The picture with its grid, ending in a rounded edge above the panel.
class _CameraView extends StatelessWidget {
  const _CameraView({required this.viewModel});

  final CameraLevelViewModel viewModel;

  /// Square sides for small, medium and large, logical pixels.
  static const _cells = [16.0, 26.0, 40.0];

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
    return Stack(
      children: [
        Positioned.fill(
          bottom: bottom - 26,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(28),
            ),
            child: Stack(
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
                // Shade behind the header, so its white title reads.
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
                    painter: _GridPainter(
                      rotation: pose?.rotation,
                      cell: _cells[vm.gridSize],
                      level: vm.level,
                      accent: p.ballDark,
                    ),
                  ),
                ),
                Positioned(
                  top: top + 8,
                  left: 0,
                  right: 0,
                  child: Center(child: _SizeSwitch(viewModel: vm)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Small, medium or large squares, on a dark glass pill over the picture.
class _SizeSwitch extends StatelessWidget {
  const _SizeSwitch({required this.viewModel});

  final CameraLevelViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final labels = [l.gridSmall, l.gridMedium, l.gridLarge];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0x61000000),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (i, label) in labels.indexed)
            Semantics(
              selected: viewModel.gridSize == i,
              button: true,
              label: label,
              excludeSemantics: true,
              child: Tooltip(
                message: label,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => viewModel.setGridSize(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 36,
                    decoration: BoxDecoration(
                      color: viewModel.gridSize == i
                          ? const Color(0xE6FFFFFF)
                          : const Color(0x00FFFFFF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: CustomPaint(
                      painter: _SizeIcon(
                        lines: 3 - i,
                        color: viewModel.gridSize == i
                            ? const Color(0xFF323232)
                            : const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A small square with [lines] lines each way inside: denser is smaller.
class _SizeIcon extends CustomPainter {
  const _SizeIcon({required this.lines, required this.color});

  final int lines;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const side = 16.0;
    final r = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: side,
      height: side,
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = color;
    canvas.drawRRect(
      RRect.fromRectAndRadius(r, const Radius.circular(2)),
      paint,
    );
    for (var i = 1; i <= lines; i++) {
      final d = side * i / (lines + 1);
      canvas
        ..drawLine(r.topLeft + Offset(d, 0), r.bottomLeft + Offset(d, 0), paint)
        ..drawLine(r.topLeft + Offset(0, d), r.topRight + Offset(0, d), paint);
    }
  }

  @override
  bool shouldRepaint(_SizeIcon old) => old.lines != lines || old.color != color;
}

/// Graph paper that stays level and plumb: every fourth line stronger, and
/// a cross in the middle that turns orange when the phone is level. Hidden
/// while the phone is held too flat to tell.
class _GridPainter extends CustomPainter {
  const _GridPainter({
    required this.rotation,
    required this.cell,
    required this.level,
    required this.accent,
  });

  /// The phone's turn in the screen's plane, degrees; null when unknown.
  final double? rotation;
  final double cell;
  final bool level;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final turn = rotation;
    if (turn == null) return;
    final c = size.center(Offset.zero);
    final reach = size.longestSide;
    canvas
      ..save()
      ..translate(c.dx, c.dy)
      // The phone turned one way, the world appears turned the other.
      ..rotate(turn * math.pi / 180);
    final faint = Paint()
      ..strokeWidth = 0.8
      ..color = const Color(0x40FFFFFF);
    final strong = Paint()
      ..strokeWidth = 1.2
      ..color = const Color(0x8CFFFFFF);
    final n = (reach / cell).ceil();
    for (var k = -n; k <= n; k++) {
      final d = k * cell;
      final paint = k % 4 == 0 ? strong : faint;
      canvas
        ..drawLine(Offset(-reach, d), Offset(reach, d), paint)
        ..drawLine(Offset(d, -reach), Offset(d, reach), paint);
    }
    // The cross, with a soft shadow so it reads on any picture.
    final arm = cell * 1.6;
    final cross = Path()
      ..moveTo(-arm, 0)
      ..lineTo(arm, 0)
      ..moveTo(0, -arm)
      ..lineTo(0, arm);
    canvas
      ..drawPath(
        cross,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = const Color(0x40000000)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
      )
      ..drawPath(
        cross,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2
          ..strokeCap = StrokeCap.round
          ..color = level ? accent : const Color(0xFFFFFFFF),
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.rotation != rotation ||
      old.cell != cell ||
      old.level != level ||
      old.accent != accent;
}
