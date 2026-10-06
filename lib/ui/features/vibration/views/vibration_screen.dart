import 'package:flutter/material.dart';

import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/vibration_view_model.dart';
import 'vibration_sweep.dart';

/// Vibration meter: a radar-like sweep drawing the last six seconds around
/// the live level, with peak and average.
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

  /// Green while still, orange once it's light vibration, red when strong.
  static List<DialZone> _zones(Palette p) => [
    (from: 0, color: p.gaugeSafe),
    (from: VibrationViewModel.lightAt, color: p.gaugeCaution),
    (from: VibrationViewModel.strongAt, color: p.gaugeDanger),
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final r = viewModel.reading;
        final (icon, text) = switch (viewModel.level) {
          VibrationLevel.still => (
            Icons.check_circle_rounded,
            context.l10n.still,
          ),
          VibrationLevel.light => (
            Icons.vibration_rounded,
            context.l10n.lightVibration,
          ),
          VibrationLevel.strong => (
            Icons.warning_amber_rounded,
            context.l10n.strongVibration,
          ),
        };
        final ready = r.history.isNotEmpty;
        return ToolFrame(
          title: context.l10n.toolVibration,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
          bodyBottomInset: 150,
          body: SensorStateGate(
            state: r.state,
            ready: ready,
            missingText: context.l10n.noAccelerometerVibration,
            child: VibrationSweep(
              current: r.current,
              peak: r.peak,
              zones: _zones(Palette.of(context)),
              value: formatDecimal(r.current),
              unit: 'm/s²',
              semanticsLabel: context.l10n.vibrationSemantics(
                formatDecimal(r.current),
              ),
            ),
          ),
          footer: !ready
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueTiles([
                      (formatAcceleration(r.peak), context.l10n.peak),
                      (formatAcceleration(r.rms), context.l10n.average),
                    ]),
                    const SizedBox(height: 14),
                    StatusBanner(
                      icon: icon,
                      text: text,
                      tone: viewModel.level == VibrationLevel.strong
                          ? StatusTone.warning
                          : StatusTone.neutral,
                    ),
                    const SizedBox(height: 14),
                    SoftButton(
                      label: context.l10n.resetPeak,
                      icon: Icons.restart_alt_rounded,
                      onPressed: viewModel.resetPeak,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
