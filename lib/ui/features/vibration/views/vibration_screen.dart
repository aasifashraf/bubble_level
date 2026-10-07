import 'package:flutter/material.dart';

import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/vibration_view_model.dart';
import 'vibration_tach.dart';

/// Vibration meter: a rev counter for the vibration's speed, with its
/// frequency, RPM and strength on one panel.
class VibrationScreen extends StatelessWidget {
  const VibrationScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
  });

  final VibrationViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolVibration,
    steps: [
      l.vibrationHelp1,
      l.vibrationHelp2,
      l.vibrationHelp3,
      l.vibrationHelp4,
    ],
    tip: l.vibrationTip,
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final r = viewModel.reading;
        final hz = viewModel.frequency;
        final ready = r.history.isNotEmpty;
        return ToolFrame(
          title: l.toolVibration,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          bodyBottomInset: 170,
          body: SensorStateGate(
            state: r.state,
            ready: ready,
            missingText: l.noAccelerometerVibration,
            child: VibrationTach(
              spectrum: r.spectrum,
              rpmLabel: l.rpm,
              semanticsLabel: hz == null
                  ? l.vibrationSemantics(formatDecimal(r.rms))
                  : l.vibrationSpeedSemantics(
                      (hz * 60).round().toString(),
                      formatDecimal(hz),
                    ),
            ),
          ),
          footer: !ready
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatPanel([
                      (
                        hz == null ? '—' : '${formatDecimal(hz)} Hz',
                        l.frequency,
                      ),
                      (hz == null ? '—' : (hz * 60).round().toString(), l.rpm),
                      (formatAcceleration(r.rms), l.strength),
                    ]),
                    const SizedBox(height: 14),
                    _status(l),
                    const SizedBox(height: 14),
                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: LockButton(
                            locked: viewModel.locked,
                            wide: true,
                            onPressed: viewModel.toggleLock,
                          ),
                        ),
                        SoftIconButton(
                          icon: Icons.restart_alt_rounded,
                          tooltip: l.reset,
                          onPressed: viewModel.reset,
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _status(AppLocalizations l) {
    final vm = viewModel;
    final strong = vm.level == VibrationLevel.strong;
    if (vm.frequency case final hz?) {
      return StatusBanner(
        icon: strong ? Icons.warning_amber_rounded : Icons.graphic_eq_rounded,
        text: l.vibratingAt(formatDecimal(hz)),
        tone: strong ? StatusTone.warning : StatusTone.neutral,
      );
    }
    if (vm.level == VibrationLevel.still) {
      return StatusBanner(icon: Icons.check_circle_rounded, text: l.still);
    }
    return StatusBanner(
      icon: Icons.vibration_rounded,
      text: vm.reading.spectrum == null
          ? l.findingFrequency
          : l.noClearFrequency,
      tone: strong ? StatusTone.warning : StatusTone.neutral,
    );
  }
}
