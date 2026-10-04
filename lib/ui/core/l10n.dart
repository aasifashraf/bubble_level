import 'package:flutter/widgets.dart';

import '../../data/services/sensor_availability_service.dart';
import '../../l10n/app_localizations.dart';

export '../../l10n/app_localizations.dart';

/// `context.l10n.someText`: the app's strings in the current language.
extension L10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension SensorNames on AppLocalizations {
  /// What a sensor is called, for "this phone doesn't have …".
  String sensorName(SensorKind kind) => switch (kind) {
    SensorKind.accelerometer => sensorAccelerometer,
    SensorKind.magnetometer => sensorMagnetometer,
    SensorKind.barometer => sensorBarometer,
    SensorKind.light => sensorLight,
    SensorKind.microphone => sensorMicrophone,
  };

  /// Compass direction abbreviation for one of the eight 45° sectors,
  /// clockwise from north.
  String direction(int sector) =>
      [dirN, dirNE, dirE, dirSE, dirS, dirSW, dirW, dirNW][sector % 8];
}

/// The app's languages, each named in itself, in the order shown in
/// Settings.
const languageNames = {
  'en': 'English',
  'es': 'Español',
  'pt': 'Português (Brasil)',
  'hi': 'हिन्दी',
  'id': 'Bahasa Indonesia',
  'de': 'Deutsch',
  'fr': 'Français',
  'ru': 'Русский',
  'tr': 'Türkçe',
  'ja': '日本語',
  'ar': 'العربية',
  'ur': 'اردو',
};
