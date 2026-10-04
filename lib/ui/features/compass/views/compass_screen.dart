import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../core/dial.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/compass_view_model.dart';

/// The compass exactly as designed: full screen, the dial and nothing else.
class CompassScreen extends StatelessWidget {
  const CompassScreen({
    super.key,
    required this.viewModel,
    required this.settings,
    required this.onBack,
  });

  final CompassViewModel viewModel;
  final SettingsRepository settings;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ToolFrame(
      title: 'Compass',
      settings: settings,
      onBack: onBack,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final state = viewModel.state;
          final heading = state == null ? 0 : state.heading.round() % 360;
          return SensorGate(
            reading: viewModel.reading,
            needsMagnetometer: true,
            child: state == null
                ? const SizedBox.shrink()
                : InstrumentDial(
                    value: '$heading°',
                    label: state.cardinalName,
                    semanticsLabel:
                        'Magnetic heading $heading degrees, '
                        '${state.cardinalName}',
                    letters: true,
                    ballAngle: state.heading,
                    reserved: 200,
                  ),
          );
        },
      ),
    );
  }
}
