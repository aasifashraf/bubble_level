import 'package:flutter/material.dart';

import '../../../core/dial.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
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

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolCompass,
    steps: [l.compassHelp1, l.compassHelp2, l.compassHelp3],
    tip: l.compassTip,
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        final heading = state == null ? 0 : state.heading.round() % 360;
        final reading = viewModel.reading;
        return ToolFrame(
          title: context.l10n.toolCompass,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
          body: SensorGate(
            reading: reading,
            needsMagnetometer: true,
            child: state == null
                ? const SizedBox.shrink()
                : InstrumentDial(
                    value: '$heading°',
                    label: context.l10n.direction(state.sector),
                    semanticsLabel: context.l10n.compassSemantics(
                      heading,
                      context.l10n.direction(state.sector),
                    ),
                    letters: [
                      for (final sector in const [0, 2, 4, 6])
                        context.l10n.direction(sector),
                    ],
                    // Like a real compass: the card turns so its N stays on
                    // north, and the ball at the top marks where the phone
                    // points.
                    cardTurn: state.heading,
                    ballAngle: 0,
                    reserved: 200,
                  ),
          ),
          // Only when needed: a field far from the Earth's means metal or
          // a magnet nearby, and the heading can't be trusted.
          footer: state == null || reading.magneticReliable
              ? null
              : StatusBanner(
                  icon: Icons.warning_amber_rounded,
                  text: context.l10n.magneticInterference,
                  tone: StatusTone.warning,
                ),
        );
      },
    );
  }
}
