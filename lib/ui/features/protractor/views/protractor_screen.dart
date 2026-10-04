import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
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

  static const _help = ToolHelp(
    tool: 'Protractor',
    steps: [
      'Lay the phone flat and place the object on the screen, with its corner at the centre.',
      'Drag each orange handle so its line runs along one edge of the angle.',
      'Read the angle in the centre. Reflex is the other side (360° minus it).',
      'Tap Reset to start again.',
    ],
  );

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
          title: 'Protractor',
          onBack: onBack,
          trailing: const HelpButton(help: _help),
          bodyBottomInset: 120,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;
              double at(Offset p) => _angleAt(p, size);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanStart: (d) => viewModel.beginDrag(at(d.localPosition)),
                onPanUpdate: (d) => viewModel.dragTo(at(d.localPosition)),
                onTapUp: (d) => viewModel.beginDrag(at(d.localPosition)),
                child: InstrumentDial(
                  value: formatDegrees(angle),
                  semanticsLabel:
                      'Angle between the arms ${formatDegrees(angle)}',
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
              Row(
                spacing: 14,
                children: [
                  Expanded(
                    child: ValueTile(
                      value: formatDegrees(angle),
                      caption: 'Angle',
                    ),
                  ),
                  Expanded(
                    child: ValueTile(
                      value: formatDegrees(viewModel.reflex),
                      caption: 'Reflex',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const StatusBanner(
                icon: Icons.touch_app_rounded,
                text: 'Drag the orange handles along the edges',
              ),
              const SizedBox(height: 16),
              SoftButton(
                label: 'Reset',
                icon: Icons.restart_alt_rounded,
                onPressed: viewModel.reset,
              ),
            ],
          ),
        );
      },
    );
  }
}
