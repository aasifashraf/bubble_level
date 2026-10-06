/// The weather shown in the Altimeter's mountain scene. It is scenery, not a
/// forecast: the barometer also measures height, so climbing 20 m drops the
/// pressure as much as a coming storm, and can't tell weather from stairs.
enum SceneWeather { sunny, cloudy, rain, storm, snow }

/// Countries mostly south of the equator, whose winter is June to August.
const _southern = {
  'AR', 'AU', 'BO', 'BR', 'BW', 'CL', 'FJ', 'LS', 'MG', 'MW', 'MZ', 'NA', //
  'NZ', 'PE', 'PY', 'SZ', 'UY', 'ZA', 'ZM', 'ZW',
};

/// The weather for the season when the user hasn't picked one: snow in
/// the winter months of their hemisphere (from the phone's region), sun
/// the rest of the year.
SceneWeather seasonalWeather(DateTime now, {String? countryCode}) {
  final south = _southern.contains(countryCode?.toUpperCase());
  final winter = south ? const {6, 7, 8} : const {12, 1, 2};
  return winter.contains(now.month) ? SceneWeather.snow : SceneWeather.sunny;
}

/// Night in the scene: from 7 pm to 6 am by the phone's clock.
bool isNight(DateTime now) => now.hour >= 19 || now.hour < 6;
