import 'package:flutter/material.dart';

import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/metal_view_model.dart';

/// Metal detector: field strength on a 0–240 µT gauge; the button turns
/// orange when metal is detected.
class MetalScreen extends StatelessWidget {
  const MetalScreen({super.key, required this.viewModel, required this.onBack});

  final MetalViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolMetal,
    steps: [l.metalHelp1, l.metalHelp2, l.metalHelp3, l.metalHelp4],
    tip: l.metalTip,
  );

  static const _scaleMax = 240.0;
  static const _scale = [
    '0', '20', '40', '60', '80', '100', //
    '120', '140', '160', '180', '200', '220',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        return ToolFrame(
          title: context.l10n.toolMetal,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
          bodyBottomInset: 120,
          body: SensorGate(
            reading: viewModel.reading,
            needsMagnetometer: true,
            child: state == null
                ? const SizedBox.shrink()
                : _dial(context, state),
          ),
          footer: state == null ? null : _footer(context, state),
        );
      },
    );
  }

  Widget _dial(BuildContext context, MetalState state) {
    final sweep = (state.field / _scaleMax).clamp(0.0, 0.999) * 360;
    return InstrumentDial(
      value: '${state.field.round()}',
      label: 'µT',
      semanticsLabel: context.l10n.metalSemantics(state.field.round()),
      scaleLabels: _scale,
      arcSweep: sweep,
      ballAngle: sweep,
      locked: state.level == MetalLevel.detected,
      reserved: 200,
    );
  }

  Widget _footer(BuildContext context, MetalState state) {
    final (icon, text) = switch (state.level) {
      // Finding metal is the goal: "detected" reads as a reached target.
      MetalLevel.clear => (Icons.search_rounded, context.l10n.noMetal),
      MetalLevel.nearby => (Icons.sensors_rounded, context.l10n.metalNearby),
      MetalLevel.detected => (
        Icons.check_circle_rounded,
        context.l10n.metalDetected,
      ),
    };
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: ValueTile(
                value: formatMicroTesla(state.field),
                caption: context.l10n.field,
              ),
            ),
            Expanded(
              child: ValueTile(
                value: formatMicroTesla(state.change, signed: true),
                caption: context.l10n.change,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        StatusBanner(
          icon: icon,
          text: text,
          tone: state.level == MetalLevel.detected
              ? StatusTone.success
              : StatusTone.neutral,
        ),
        const SizedBox(height: 4),
        Text(
          context.l10n.findsIronSteel,
          style: TextStyle(fontSize: 12, color: Palette.of(context).label),
        ),
        const SizedBox(height: 14),
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: SoftButton(
                label: context.l10n.setBaseline,
                icon: Icons.my_location_rounded,
                onPressed: viewModel.setBaseline,
              ),
            ),
            // The app-wide Sounds setting, also in Settings.
            SoftIconButton(
              icon: viewModel.soundOn
                  ? Icons.volume_up_rounded
                  : Icons.volume_off_rounded,
              tooltip: viewModel.soundOn
                  ? context.l10n.muteSound
                  : context.l10n.turnSoundOn,
              muted: !viewModel.soundOn,
              onPressed: viewModel.toggleSound,
            ),
          ],
        ),
      ],
    );
  }
}
