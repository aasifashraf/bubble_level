import 'package:flutter/material.dart';

import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
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

  static const _help = ToolHelp(
    tool: 'Altimeter',
    steps: [
      'The dial shows air pressure in hPa, and altitude is estimated from it.',
      'To measure a height change, like stairs or floors, tap Set zero here where you start.',
      'Go up or down. The centre shows the metres from your zero.',
      'Tap Clear zero to go back.',
    ],
    tip: 'Weather changes air pressure, so altitude can be off by tens of metres. Height from your zero is accurate over short periods. This tool needs a phone with a barometer.',
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
          title: 'Altimeter',
          onBack: onBack,
          trailing: const HelpButton(help: _help),
          bodyBottomInset: 120,
          body: SensorStateGate(
            state: r.state,
            ready: pressure != null,
            // Home already hides this tool on phones known to lack a
            // barometer; on iPhone the usual cause is Motion & Fitness
            // access being off.
            missingText: Theme.of(context).platform == TargetPlatform.iOS
                ? 'Can’t read the barometer. Turn on Motion & Fitness for '
                      'this app in Settings › Privacy & Security, then open '
                      'the Altimeter again.'
                : 'This phone has no barometer (air pressure sensor), so '
                      'the altimeter can’t work here. Other tools still work.',
            child: pressure == null
                ? const SizedBox.shrink()
                : InstrumentDial(
                    value: relative == null
                        ? pressure.toStringAsFixed(1)
                        : formatSignedDecimal(relative),
                    label: relative == null ? 'hPa' : 'm from zero',
                    semanticsLabel: relative == null
                        ? 'Air pressure ${pressure.toStringAsFixed(1)} '
                              'hectopascals'
                        : 'Height ${formatMeters(relative, signed: true)} '
                              'from zero',
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
                            caption: 'Pressure',
                          ),
                        ),
                        Expanded(
                          child: ValueTile(
                            value: '≈ ${formatMeters(r.altitude!)}',
                            caption: 'Altitude (approx.)',
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
                          ? 'Measuring height from your zero'
                          : 'Air pressure and altitude',
                    ),
                    const SizedBox(height: 16),
                    viewModel.zeroed
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
