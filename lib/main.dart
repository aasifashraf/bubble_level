import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/repositories/orientation_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'data/services/motion_sensor_service.dart';
import 'data/services/sensor_availability_service.dart';
import 'ui/core/theme.dart';
import 'ui/home/home_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Full screen as in the design: draw behind the status and navigation
  // bars (each page sets transparent bars and matching icon colours).
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final settings = await SettingsRepository.load();
  final missingSensors = await const SensorAvailabilityService().missing();
  runApp(
    BubbleLevelApp(
      settings: settings,
      orientation: OrientationRepository(),
      missingSensors: missingSensors,
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
  });

  final SettingsRepository settings;
  final OrientationRepository orientation;

  /// Sensors this device lacks; their tools are shown as unavailable.
  final Set<SensorKind> missingSensors;

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
        title: 'Bubble Level & Angle Finder',
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
      ),
    );
  }
}
