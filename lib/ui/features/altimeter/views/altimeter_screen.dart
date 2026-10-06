import 'package:flutter/material.dart';

import '../../../../domain/scene_weather.dart';
import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
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
              : _WeatherButton(viewModel: viewModel),
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
                      (formatMeters(r.altitude!), l.altitudeShort),
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

/// Picks the scene's weather: automatic (time of day and season) or one of
/// the five. The choice is remembered.
class _WeatherButton extends StatelessWidget {
  const _WeatherButton({required this.viewModel});

  final AltimeterViewModel viewModel;

  static IconData icon(SceneWeather? w) => switch (w) {
    null => Icons.auto_mode_rounded,
    SceneWeather.sunny => Icons.wb_sunny_rounded,
    SceneWeather.cloudy => Icons.cloud_rounded,
    SceneWeather.rain => Icons.umbrella_rounded,
    SceneWeather.storm => Icons.thunderstorm_rounded,
    SceneWeather.snow => Icons.ac_unit_rounded,
  };

  static String label(AppLocalizations l, SceneWeather? w) => switch (w) {
    null => l.weatherAuto,
    SceneWeather.sunny => l.weatherSunny,
    SceneWeather.cloudy => l.weatherCloudy,
    SceneWeather.rain => l.weatherRain,
    SceneWeather.storm => l.weatherStorm,
    SceneWeather.snow => l.weatherSnow,
  };

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final picked = viewModel.pickedWeather;
    // Indexed, since the menu never reports a null (Auto) choice.
    const choices = <SceneWeather?>[null, ...SceneWeather.values];
    return PopupMenuButton<int>(
      tooltip: l.weather,
      position: PopupMenuPosition.under,
      color: p.dialLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      onSelected: (i) => viewModel.pickWeather(choices[i]),
      itemBuilder: (context) => [
        for (final (i, w) in choices.indexed)
          PopupMenuItem(
            value: i,
            child: Row(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon(w),
                  size: 20,
                  color: w == picked ? p.ballDark : p.ink,
                ),
                Flexible(
                  child: Text(
                    label(l, w),
                    style: TextStyle(
                      color: p.inkStrong,
                      fontWeight: w == picked
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
      icon: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(color: p.tab, shape: BoxShape.circle),
        child: Icon(
          // A clear night shows the moon.
          viewModel.night && (picked ?? viewModel.weather) == SceneWeather.sunny
              ? Icons.nightlight_round
              : icon(picked ?? viewModel.weather),
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
