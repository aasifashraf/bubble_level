import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/protractor_view_model.dart';

/// On-screen protractor: drag the two orange handles so the arms follow an
/// object's edges; the centre shows the angle between them.
class ProtractorScreen extends StatelessWidget {
  const ProtractorScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
  });

  final ProtractorViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolProtractor,
    steps: [
      l.protractorHelp1,
      l.protractorHelp2,
      l.protractorHelp3,
      l.protractorHelp4,
      l.protractorHelp5,
    ],
  );

  /// Touches closer than this to the centre, logical pixels, move no arm.
  static const _deadZone = 40.0;

  /// Degrees clockwise from 12 o'clock of [position] around the centre of
  /// a box of [size].
  static double _angleAt(Offset position, Size size) {
    final d = position - size.center(Offset.zero);
    return (math.atan2(d.dx, -d.dy) * 180 / math.pi + 360) % 360;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final angle = viewModel.angle;
        return ToolFrame(
          title: context.l10n.toolProtractor,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
          bodyBottomInset: 120,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;
              double at(Offset p) => _angleAt(p, size);
              // Near the centre a touch's direction is arbitrary, and it's
              // where the object's corner and the reading sit.
              bool central(Offset p) =>
                  (p - size.center(Offset.zero)).distance < _deadZone;
              void begin(Offset p) => central(p)
                  ? viewModel.ignoreDrag()
                  : viewModel.beginDrag(at(p));
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanStart: (d) => begin(d.localPosition),
                onPanUpdate: (d) => viewModel.dragTo(at(d.localPosition)),
                onTapUp: (d) => begin(d.localPosition),
                child: InstrumentDial(
                  value: formatDegrees(angle),
                  semanticsLabel: context.l10n.armsSemantics(
                    formatDegrees(angle),
                  ),
                  arms: [viewModel.arm(0), viewModel.arm(1)],
                  arcStart: viewModel.arcStart,
                  arcSweep: angle,
                  reserved: 200,
                ),
              );
            },
          ),
          footer: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueTiles([
                (formatDegrees(angle), context.l10n.angle),
                (formatDegrees(viewModel.reflex), context.l10n.reflex),
              ]),
              const SizedBox(height: 16),
              viewModel.locked
                  ? StatusBanner(
                      icon: Icons.lock_rounded,
                      text: context.l10n.handlesLocked,
                    )
                  : StatusBanner(
                      icon: Icons.touch_app_rounded,
                      text: context.l10n.dragHandles,
                    ),
              const SizedBox(height: 16),
              Row(
                spacing: 14,
                children: [
                  Expanded(
                    child: SoftButton(
                      label: context.l10n.reset,
                      icon: Icons.restart_alt_rounded,
                      onPressed: viewModel.locked ? null : viewModel.reset,
                    ),
                  ),
                  // Keeps the handles in place while the object is moved.
                  LockButton(
                    locked: viewModel.locked,
                    onPressed: viewModel.toggleLock,
                    tooltip: context.l10n.lockHandles,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
