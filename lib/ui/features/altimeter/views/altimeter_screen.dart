import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/altimeter_view_model.dart';

/// Altimeter and barometer: pressure on a 950–1070 hPa gauge; after
/// "Set zero" the centre shows the height gained or lost since.
class AltimeterScreen extends StatelessWidget {
  const AltimeterScreen({
    super.key,
    required this.viewModel,
    required this.settings,
    required this.onBack,
  });

  final AltimeterViewModel viewModel;
  final SettingsRepository settings;
  final VoidCallback onBack;

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
          settings: settings,
          onBack: onBack,
          bodyBottomInset: 120,
          body: SensorStateGate(
            state: r.state,
            ready: pressure != null,
            missingText:
                'This device has no barometer, so pressure and altitude '
                'aren’t available.',
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
