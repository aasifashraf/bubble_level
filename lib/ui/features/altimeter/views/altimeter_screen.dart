import 'package:flutter/material.dart';

import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../../../core/weather_button.dart';
import '../view_models/altimeter_view_model.dart';
import 'mountain_scene.dart';

/// Altimeter: a hiker climbs a living mountain with your height above the
/// zero, under a sky that follows the time of day and the season (or the
/// weather you pick). Height, pressure and altitude sit on one panel.
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

  /// The footer's height: the meadow's life stays above it, the grass
  /// runs on behind it to the bottom.
  static const _footer = 150.0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final r = viewModel.reading;
        final pressure = r.pressure;
        final relative = viewModel.relative;
        final landscape = ToolFrame.sideBySide(context);
        return ToolFrame(
          title: l.toolAltimeter,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          action: pressure == null
              ? null
              : WeatherButton(
                  picked: viewModel.pickedWeather,
                  shown: viewModel.weather,
                  night: viewModel.night,
                  onPick: viewModel.pickWeather,
                ),
          // The night sky is dark behind the header.
          headerOnDark: pressure != null && viewModel.night && !landscape,
          body: SensorStateGate(
            state: r.state,
            ready: pressure != null,
            // Home already hides this tool on phones known to lack a
            // barometer; on iPhone the usual cause is Motion & Fitness
            // access being off.
            missingText: Theme.of(context).platform == TargetPlatform.iOS
                ? l.barometerIos
                : l.noBarometer,
            child: pressure == null
                ? const SizedBox.shrink()
                : MountainScene(
                    height: relative ?? 0,
                    highest: viewModel.highest,
                    weather: viewModel.weather,
                    night: viewModel.night,
                    bottomInset: landscape ? 0 : _footer,
                    semanticsLabel: relative == null
                        ? l.pressureSemantics(formatDecimal(pressure))
                        : l.heightSemantics(
                            formatMeters(relative, signed: true),
                          ),
                  ),
          ),
          footer: pressure == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatPanel([
                      (
                        relative == null
                            ? '—'
                            : formatMeters(relative, signed: true),
                        l.fromZero,
                      ),
                      (formatPressure(pressure), l.pressure),
                      // Whole metres, marked approximate: without a known
                      // reference the weather alone moves it by many metres.
                      ('≈ ${r.altitude!.round()} m', l.altitudeShort),
                    ]),
                    const SizedBox(height: 14),
                    viewModel.zeroed
                        ? SoftButton(
                            label: l.clearZero,
                            icon: Icons.close_rounded,
                            onPressed: viewModel.clearZero,
                          )
                        : SoftButton(
                            label: l.setZeroHere,
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
