import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'data/repositories/orientation_repository.dart';
import 'data/repositories/review_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/services/camera_service.dart';
import 'data/services/display_rotation_service.dart';
import 'data/services/location_service.dart';
import 'data/services/microphone_service.dart';
import 'data/services/motion_sensor_service.dart';
import 'data/services/sensor_availability_service.dart';
import 'data/services/sound_service.dart';
import 'l10n/app_localizations.dart';
import 'ui/core/test_build.dart';
import 'ui/core/theme.dart';
import 'ui/home/home_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // The bundled Inter font's licence, next to Flutter's and the packages'.
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'Inter',
    ], await rootBundle.loadString('assets/fonts/Inter-OFL.txt'));
  });
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
      testEnd: testBuildEnd,
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
    this.camera = const CameraService(),
    this.location = const LocationService(),
    this.testEnd,
    this.now = DateTime.now,
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

  /// The camera level's camera (fake in tests).
  final CameraService camera;

  /// The speedometer's GPS (fake in tests).
  final LocationService location;

  /// TEMPORARY: the last day of a test APK ([testBuildEnd] when built with
  /// TEST_UNTIL), or null for a normal build. A test build shows the
  /// feedback line on home and stops on that day.
  final DateTime? testEnd;
  final DateTime Function() now;

  /// Sensors for the vibration meter and altimeter (fakes in tests).
  final MotionSensorService sensors;

  @override
  State<BubbleLevelApp> createState() => _BubbleLevelAppState();
}

class _BubbleLevelAppState extends State<BubbleLevelApp> {
  // Built once: the app rebuilds on every settings change.
  final _light = buildTheme(Brightness.light);
  final _dark = buildTheme(Brightness.dark);

  /// TEMPORARY: a test build that is left open past its last day ends
  /// when the app is shown again.
  late final _testCheck = AppLifecycleListener(
    onShow: () {
      if (widget.testEnd != null) setState(() {});
    },
  );

  @override
  void initState() {
    super.initState();
    _testCheck;
  }

  @override
  void dispose() {
    _testCheck.dispose();
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
        theme: _light,
        darkTheme: _dark,
        themeMode: widget.settings.themeMode,
        home: testBuildEnded(widget.now(), widget.testEnd)
            ? const TestBuildEndedScreen()
            : home,
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
        camera: widget.camera,
        location: widget.location,
        testFeedback: widget.testEnd != null,
      ),
    );
  }
}
