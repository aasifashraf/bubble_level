import 'package:flutter/material.dart';

import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/altimeter_view_model.dart';

/// Altimeter and barometer: pressure on a 950–1070 hPa gauge; after
/// "Set zero" the centre shows the height gained or lost since.
class AltimeterScreen extends StatelessWidget {
  const AltimeterScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
  });

  final AltimeterViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolAltimeter,
    steps: [
      l.altimeterHelp1,
      l.altimeterHelp2,
      l.altimeterHelp3,
      l.altimeterHelp4,
    ],
    tip: l.altimeterTip,
  );

  static const _scaleMin = 950.0, _scaleSpan = 120.0;
  static const _scale = [
    '950', '960', '970', '980', '990', '1000', //
    '1010', '1020', '1030', '1040', '1050', '1060',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final r = viewModel.reading;
        final pressure = r.pressure;
        final relative = viewModel.relative;
        final sweep = pressure == null
            ? 0.0
            : ((pressure - _scaleMin) / _scaleSpan).clamp(0.0, 0.999) * 360;
        return ToolFrame(
          title: context.l10n.toolAltimeter,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
          bodyBottomInset: 120,
          body: SensorStateGate(
            state: r.state,
            ready: pressure != null,
            // Home already hides this tool on phones known to lack a
            // barometer; on iPhone the usual cause is Motion & Fitness
            // access being off.
            missingText: Theme.of(context).platform == TargetPlatform.iOS
                ? context.l10n.barometerIos
                : context.l10n.noBarometer,
            child: pressure == null
                ? const SizedBox.shrink()
                : InstrumentDial(
                    value: relative == null
                        ? formatDecimal(pressure)
                        : formatSignedDecimal(relative),
                    label: relative == null
                        ? 'hPa'
                        : context.l10n.metresFromZero,
                    semanticsLabel: relative == null
                        ? context.l10n.pressureSemantics(
                            formatDecimal(pressure),
                          )
                        : context.l10n.heightSemantics(
                            formatMeters(relative, signed: true),
                          ),
                    scaleLabels: _scale,
                    arcSweep: sweep,
                    ballAngle: sweep,
                    reserved: 200,
                  ),
          ),
          footer: pressure == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: ValueTile(
                            value: formatPressure(pressure),
                            caption: context.l10n.pressure,
                          ),
                        ),
                        Expanded(
                          child: ValueTile(
                            value: '≈ ${formatMeters(r.altitude!)}',
                            caption: context.l10n.altitudeApprox,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    StatusBanner(
                      icon: viewModel.zeroed
                          ? Icons.adjust_rounded
                          : Icons.terrain_rounded,
                      text: viewModel.zeroed
                          ? context.l10n.measuringHeight
                          : context.l10n.airPressureAltitude,
                    ),
                    const SizedBox(height: 16),
                    viewModel.zeroed
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
                  ],
                ),
        );
      },
    );
  }
}
