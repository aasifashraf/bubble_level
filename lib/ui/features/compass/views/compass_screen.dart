import 'package:flutter/material.dart';

import '../../../core/dial.dart';
import '../../../core/help.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/compass_view_model.dart';

/// The compass exactly as designed: full screen, the dial and nothing else.
class CompassScreen extends StatelessWidget {
  const CompassScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
  });

  final CompassViewModel viewModel;
  final VoidCallback onBack;

  static const _help = ToolHelp(
    tool: 'Compass',
    steps: [
      'Hold the phone level in front of you, away from metal, magnets and electronics.',
      'Point the top of the phone in the direction you want to know.',
      'The number is your heading in degrees and the word is the direction. The orange ball marks it on the ring.',
    ],
    tip: 'It points to magnetic north, which can differ a few degrees from map north. If it seems wrong, move the phone in a figure 8 a few times.',
  );

  @override
  Widget build(BuildContext context) {
    return ToolFrame(
      title: 'Compass',
      onBack: onBack,
      trailing: const HelpButton(help: _help),
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
