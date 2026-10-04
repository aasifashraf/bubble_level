import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/angle_view_model.dart';

/// Angle from the Earth, or — after "Set zero" — how far the phone has
/// moved from a starting position; the compass design with an arc.
class AngleScreen extends StatelessWidget {
  const AngleScreen({
    super.key,
    required this.viewModel,
    required this.settings,
    required this.onBack,
  });

  final AngleViewModel viewModel;
  final SettingsRepository settings;
  final VoidCallback onBack;

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
          settings: settings,
          onBack: onBack,
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
