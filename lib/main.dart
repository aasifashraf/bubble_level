import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'data/repositories/orientation_repository.dart';
import 'data/repositories/review_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/services/display_rotation_service.dart';
import 'data/services/microphone_service.dart';
import 'data/services/motion_sensor_service.dart';
import 'data/services/sensor_availability_service.dart';
import 'data/services/sound_service.dart';
import 'l10n/app_localizations.dart';
import 'ui/core/theme.dart';
import 'ui/home/home_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Full screen as in the design: draw behind the status and navigation
  // bars (each page sets transparent bars and matching icon colours).
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final settings = await SettingsRepository.load();
  final missingSensors = await const SensorAvailabilityService().missing();
  final review = await ReviewRepository.load();
  runApp(
    BubbleLevelApp(
      settings: settings,
      orientation: OrientationRepository(),
      missingSensors: missingSensors,
      sound: AudioSoundService(),
      review: review,
    ),
  );
}

class BubbleLevelApp extends StatefulWidget {
  const BubbleLevelApp({
    super.key,
    required this.settings,
    required this.orientation,
    this.sensors = const MotionSensorService(),
    this.missingSensors = const {},
    this.sound = const SilentSoundService(),
    this.review,
    this.display = const DisplayRotationService(),
    this.microphone = const MicrophoneService(),
  });

  final SettingsRepository settings;
  final OrientationRepository orientation;

  /// Sensors this device lacks; their tools are shown as unavailable.
  final Set<SensorKind> missingSensors;

  /// The level chime and metal detector beep (silent in tests).
  final SoundService sound;

  /// Asks for a store review after enough successes (none in tests).
  final ReviewRepository? review;

  /// Screen rotation and density (fake in tests).
  final DisplayRotationService display;

  /// The sound meter's microphone (fake in tests).
  final MicrophoneService microphone;

  /// Sensors for the vibration meter and altimeter (fakes in tests).
  final MotionSensorService sensors;

  @override
  State<BubbleLevelApp> createState() => _BubbleLevelAppState();
}

class _BubbleLevelAppState extends State<BubbleLevelApp> {
  @override
  void dispose() {
    widget.orientation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settings,
      builder: (context, home) => MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // The language chosen in Settings, or the phone's.
        locale: switch (widget.settings.language) {
          null => null,
          final code => Locale(code),
        },
        builder: (context, child) {
          // Numbers (decimal separator) follow the app's language.
          Intl.defaultLocale = Localizations.localeOf(context).toLanguageTag();
          return child!;
        },
        debugShowCheckedModeBanner: false,
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        themeMode: widget.settings.themeMode,
        home: home,
      ),
      child: HomeShell(
        orientation: widget.orientation,
        settings: widget.settings,
        sensors: widget.sensors,
        missingSensors: widget.missingSensors,
        sound: widget.sound,
        review: widget.review,
        display: widget.display,
        microphone: widget.microphone,
      ),
    );
  }
}
