import 'package:flutter/material.dart';

import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/angle_view_model.dart';

/// Angle from the Earth, or — after "Set zero" — how far the phone has
/// moved from a starting position; the compass design with an arc.
class AngleScreen extends StatelessWidget {
  const AngleScreen({super.key, required this.viewModel, required this.onBack});

  final AngleViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolAngle,
    steps: [
      l.angleHelp1,
      l.angleHelp2,
      l.angleHelp3,
      l.angleHelp4,
      l.angleHelp5,
    ],
    tip: l.angleTip,
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
          title: context.l10n.toolAngle,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
          body: SensorGate(
            reading: viewModel.reading,
            child: state == null
                ? const SizedBox.shrink()
                : InstrumentDial(
                    value: value,
                    semanticsLabel: zeroed
                        ? context.l10n.movedFromZero(value)
                        : context.l10n.fromLevel(value),
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
                    _status(context, zeroed),
                    const SizedBox(height: 16),
                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: zeroed
                              ? SoftButton(
                                  label: context.l10n.clearZero,
                                  icon: Icons.close_rounded,
                                  onPressed: viewModel.clearZero,
                                )
                              : SoftButton(
                                  label: context.l10n.setZeroHere,
                                  icon: Icons.adjust_rounded,
                                  onPressed: viewModel.setZero,
                                  emphasis: true,
                                ),
                        ),
                        // Freezes the reading to read it after lifting the
                        // phone off what it measured.
                        SoftIconButton(
                          icon: viewModel.locked
                              ? Icons.lock_rounded
                              : Icons.lock_open_rounded,
                          tooltip: viewModel.locked
                              ? context.l10n.unlock
                              : context.l10n.lockReading,
                          active: viewModel.locked,
                          onPressed: viewModel.toggleLock,
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _status(BuildContext context, bool zeroed) {
    final l = context.l10n;
    final text = zeroed ? l.measuringFromZero : l.angleFromEarth;
    if (viewModel.locked) {
      return StatusBanner(icon: Icons.lock_rounded, text: l.locked(text));
    }
    return StatusBanner(
      icon: zeroed ? Icons.adjust_rounded : Icons.public_rounded,
      text: text,
    );
  }
}
