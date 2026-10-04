import 'package:flutter/material.dart';

import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/angle_view_model.dart';

/// Angle from the Earth, or — after "Set zero" — how far the phone has
/// moved from a starting position; the compass design with an arc.
class AngleScreen extends StatelessWidget {
  const AngleScreen({super.key, required this.viewModel, required this.onBack});

  final AngleViewModel viewModel;
  final VoidCallback onBack;

  static const _help = ToolHelp(
    tool: 'Angle',
    steps: [
      'The dial shows how far the phone is tilted from lying flat: 0° flat, 90° upright.',
      'To measure a change, hold the phone in the starting position and tap Set zero here.',
      'Tilt or move the phone. The dial shows how many degrees it moved from your zero.',
      'Tap Clear zero to go back to the angle from flat.',
    ],
    tip: 'Press the phone flat against an object, like a board, door or ramp, to measure its angle.',
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        final degrees = state == null ? 0.0 : state.moved ?? state.tilt;
        final value = formatDegrees(degrees);
        final zeroed = state?.zeroed ?? false;
        return ToolFrame(
          title: 'Angle',
          onBack: onBack,
          trailing: const HelpButton(help: _help),
          body: SensorGate(
            reading: viewModel.reading,
            child: state == null
                ? const SizedBox.shrink()
                : InstrumentDial(
                    value: value,
                    semanticsLabel:
                        '${zeroed ? 'Moved from zero' : 'From level'} $value',
                    arcSweep: degrees,
                    ballAngle: degrees,
                    reserved: 300,
                  ),
          ),
          footer: state == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusBanner(
                      icon: zeroed
                          ? Icons.adjust_rounded
                          : Icons.public_rounded,
                      text: zeroed
                          ? 'Measuring from your zero'
                          : 'Angle from the Earth',
                    ),
                    const SizedBox(height: 16),
                    zeroed
                        ? SoftButton(
                            label: 'Clear zero',
                            icon: Icons.close_rounded,
                            onPressed: viewModel.clearZero,
                          )
                        : SoftButton(
                            label: 'Set zero here',
                            icon: Icons.adjust_rounded,
                            onPressed: viewModel.setZero,
                            emphasis: true,
                          ),
                  ],
                ),
        );
      },
    );
  }
}
