import 'package:flutter/material.dart';

import '../../domain/scene_weather.dart';
import 'l10n.dart';
import 'theme.dart';

/// Picks the scene's weather: automatic (time of day and season) or one of
/// the five. The choice is remembered.
class WeatherButton extends StatelessWidget {
  const WeatherButton({
    super.key,
    required this.picked,
    required this.shown,
    required this.night,
    required this.onPick,
  });

  /// The user's pick, or null for Auto; the weather on screen now.
  final SceneWeather? picked;
  final SceneWeather shown;
  final bool night;
  final ValueChanged<SceneWeather?> onPick;

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
    // Indexed, since the menu never reports a null (Auto) choice.
    const choices = <SceneWeather?>[null, ...SceneWeather.values];
    return PopupMenuButton<int>(
      tooltip: l.weather,
      position: PopupMenuPosition.under,
      color: p.dialLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      onSelected: (i) => onPick(choices[i]),
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
          night && shown == SceneWeather.sunny
              ? Icons.nightlight_round
              : icon(shown),
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
