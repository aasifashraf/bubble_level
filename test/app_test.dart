import 'dart:math' as math;

import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/data/services/ar_service.dart';
import 'package:bubble_level/data/services/location_service.dart';
import 'package:bubble_level/data/services/sensor_availability_service.dart';
import 'package:bubble_level/data/services/sound_service.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/g_force.dart';
import 'package:bubble_level/domain/ruler.dart';
import 'package:bubble_level/domain/scene_weather.dart';
import 'package:bubble_level/main.dart';
import 'package:bubble_level/ui/core/controls.dart';
import 'package:bubble_level/ui/core/dial.dart';
import 'package:bubble_level/ui/core/readout.dart';
import 'package:bubble_level/ui/core/theme.dart';
import 'package:bubble_level/ui/core/tool_frame.dart';
import 'package:bubble_level/ui/core/vial.dart';
import 'package:bubble_level/ui/features/altimeter/views/mountain_scene.dart';
import 'package:bubble_level/ui/features/angle/view_models/angle_view_model.dart';
import 'package:bubble_level/ui/features/angle/views/water_view.dart';
import 'package:bubble_level/ui/features/light/views/light_sky.dart';
import 'package:bubble_level/ui/features/metal/views/metal_heat.dart';
import 'package:bubble_level/ui/features/sound/views/sound_ripples.dart';
import 'package:bubble_level/ui/features/vibration/views/vibration_tach.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fakes.dart';

const _allTools = [
  'Level',
  'Angle',
  'Compass',
  'Protractor',
  'Ruler',
  'Metal detector',
  'Vibration',
  'Sound meter',
  'Light meter',
  'Altimeter',
  'Height',
  'Camera level',
  'G-force',
  'Speedometer',
  'Tape measure',
];

void main() {
  late FakeMotionSensorService sensors;
  late FakeMicrophoneService microphone;
  late FakeCameraService camera;
  late FakeLocationService location;
  late FakeArService ar;

  /// Phone-sized window unless [size] says otherwise.
  Future<void> pumpApp(
    WidgetTester tester, {
    Size size = const Size(411, 860),
    Map<String, Object> prefs = const {},
    Set<SensorKind> missing = const {},
    ArSupport arSupport = ArSupport.supported,
    SoundService sound = const SilentSoundService(),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues(prefs);
    final settings = await SettingsRepository.load();
    sensors = FakeMotionSensorService();
    microphone = FakeMicrophoneService();
    camera = FakeCameraService();
    location = FakeLocationService();
    ar = FakeArService()..supportResult = arSupport;
    await tester.pumpWidget(
      BubbleLevelApp(
        microphone: microphone,
        camera: camera,
        location: location,
        ar: ar,
        settings: settings,
        orientation: OrientationRepository(
          sensors: sensors,
          display: FakeDisplayRotationService(),
        ),
        sensors: sensors,
        missingSensors: missing,
        sound: sound,
      ),
    );
  }

  Future<void> openTool(WidgetTester tester, String name) async {
    // On small screens the list scrolls; bring the tool into view first.
    await tester.ensureVisible(find.text(name));
    await tester.pumpAndSettle();
    await tester.tap(find.text(name));
    await tester.pumpAndSettle();
  }

  /// Sends one accelerometer sample and lets the screen rebuild: the
  /// stream event lands after the first frame, the rebuild in the second.
  Future<void> send(WidgetTester tester, Vec3 up) async {
    sensors.sendUp(up);
    await tester.pump();
    await tester.pump();
  }

  testWidgets('home lists the three tools', (tester) async {
    await pumpApp(tester);
    expect(find.text('Compass'), findsOneWidget);
    expect(find.text('Level'), findsOneWidget);
    expect(find.text('Angle'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('home: grid and light by default, list on request, '
      'remembered', (tester) async {
    await pumpApp(tester);
    double y(String t) => tester.getCenter(find.text(t)).dy;
    double x(String t) => tester.getCenter(find.text(t)).dx;
    final settings = await SettingsRepository.load();
    expect(settings.themeMode, ThemeMode.light);

    // Grid: one row, Level, Angle, Compass left to right, no descriptions.
    expect(find.text('Bubble and spirit level'), findsNothing);
    expect(y('Level'), y('Compass'));
    expect(x('Level') < x('Angle') && x('Angle') < x('Compass'), isTrue);

    await tester.tap(find.byTooltip('List view'));
    await tester.pumpAndSettle();
    // List: same order top to bottom, with descriptions.
    expect(find.text('Bubble and spirit level'), findsOneWidget);
    expect(y('Level') < y('Angle') && y('Angle') < y('Compass'), isTrue);
    final reloaded = await SettingsRepository.load();
    expect(reloaded.homeLayout, HomeLayout.list);

    // Tools still open from the grid.
    await openTool(tester, 'Angle');
    await send(tester, Vec3.up);
    expect(find.text('Flat · angle from the Earth'), findsOneWidget);
  });

  testWidgets(
    'level, angle, protractor, compass, ruler and light hold portrait until '
    'turned; the choice is remembered per tool',
    (tester) async {
      final locks = <List<Object?>>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'SystemChrome.setPreferredOrientations') {
            locks.add(call.arguments as List<Object?>);
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      const portrait = ['DeviceOrientation.portraitUp'];
      const landscape = [
        'DeviceOrientation.landscapeLeft',
        'DeviceOrientation.landscapeRight',
      ];
      Future<void> back() async {
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();
      }

      await pumpApp(tester);
      for (final tool in [
        'Level',
        'Angle',
        'Protractor',
        'Compass',
        'Ruler',
        'Light meter',
      ]) {
        await openTool(tester, tool);
        expect(locks.last, portrait, reason: tool);
        expect(find.byTooltip('Turn to landscape'), findsOneWidget);
        await back();
        expect(locks.last, isEmpty, reason: 'home follows the phone');
      }

      // Turn Compass; it stays turned, and Level doesn't.
      await openTool(tester, 'Compass');
      await tester.tap(find.byTooltip('Turn to landscape'));
      await tester.pump();
      expect(locks.last, landscape);
      expect(find.byTooltip('Turn to portrait'), findsOneWidget);
      await back();
      await openTool(tester, 'Compass');
      expect(locks.last, landscape);
      await tester.tap(find.byTooltip('Turn to portrait'));
      await tester.pump();
      expect(locks.last, portrait);
      await tester.tap(find.byTooltip('Turn to landscape'));
      await tester.pump();
      await back();
      await openTool(tester, 'Level');
      expect(locks.last, portrait);
      await back();
      expect(
        (await SettingsRepository.load()).toolLandscape('compass'),
        isTrue,
      );

      // The Altimeter always stays portrait, with no rotate button.
      await openTool(tester, 'Altimeter');
      expect(locks.last, portrait);
      expect(find.byTooltip('Turn to landscape'), findsNothing);
      await back();
      expect(locks.last, isEmpty);

      // The other tools follow the phone and have no rotate button.
      final count = locks.length;
      await openTool(tester, 'Metal detector');
      expect(find.byTooltip('Turn to landscape'), findsNothing);
      expect(locks.length, count);
      await back();
    },
  );

  testWidgets('a tool opens full screen and the back tab returns home', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    expect(find.text('Waiting for sensors…'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Compass'), findsOneWidget);
    expect(find.text('Waiting for sensors…'), findsNothing);
  });

  testWidgets('level: reading, guidance, lock and unlock', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    final semantics = tester.ensureSemantics();

    await send(tester, Vec3.up);
    expect(find.bySemanticsLabel('Tilt from level 0.0°'), findsOneWidget);
    expect(find.text('Level'), findsWidgets);

    await tester.tap(find.text('Lock'));
    await tester.pump();
    expect(find.text('Locked · Level'), findsOneWidget);
    await tester.tap(find.text('Unlock'));
    await tester.pump();
    expect(find.text('Locked · Level'), findsNothing);
    semantics.dispose();
  });

  testWidgets('level: guidance says which side is high', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    await send(tester, const Vec3(0.1, 0, 1)); // right edge raised ~5.7°
    expect(find.text('Right side high'), findsOneWidget);
  });

  testWidgets('level: shows X and Y tilt', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    await send(tester, const Vec3(0.1, 0, 1)); // right edge raised ~5.7°
    expect(find.text('X · left / right'), findsOneWidget);
    expect(find.text('+5.7°'), findsOneWidget);
    expect(find.text('Y · forward / back'), findsOneWidget);
    expect(find.text('0.0°'), findsOneWidget);
  });

  testWidgets('level: on an edge it reads the angle from level', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    final semantics = tester.ensureSemantics();
    await send(tester, const Vec3(0.05, 1, 0)); // upright, about 2.9° off
    expect(find.bySemanticsLabel('From level 2.9°'), findsOneWidget);
    expect(find.text('Left end low'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('angle: on an edge it reads the edge’s slope, both edges', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpApp(tester);
    await openTool(tester, 'Angle');
    await tester.tap(find.byTooltip('On an edge'));
    await tester.pump();
    // Long side along a 30° ramp: gravity 60° round in the screen plane.
    final a = 60 * math.pi / 180;
    for (var i = 0; i < 60; i++) {
      await send(tester, Vec3(math.sin(a), math.cos(a), 0.02));
    }
    // The right side is up, so the left edge is the one measured.
    expect(
      find.bySemanticsLabel(
        'Measuring the left edge: 30.0° from level. Bottom edge 60.0°',
      ),
      findsOneWidget,
    );
    expect(find.text('Measuring the left edge'), findsOneWidget);
    expect(find.text('Bottom edge 60.0°'), findsOneWidget);
    // The screen is water, its surface level with the world: 60° round on
    // the screen against the phone.
    expect(find.byType(InstrumentDial), findsNothing);
    final water = tester.widget<WaterView>(find.byType(WaterView));
    expect(water.surface, closeTo(60, 0.5));
    expect(water.mark?.side, EdgeSide.left);
    expect(water.mark?.degrees, closeTo(30, 0.1));

    // Leaning the other way: the right edge now.
    for (var i = 0; i < 60; i++) {
      await send(tester, Vec3(-math.sin(a), math.cos(a), 0.02));
    }
    expect(find.text('Measuring the right edge'), findsOneWidget);
    expect(find.text('Bottom edge 60.0°'), findsOneWidget);
    expect(
      tester.widget<WaterView>(find.byType(WaterView)).mark?.side,
      EdgeSide.right,
    );

    // Set zero still measures from there.
    await tester.tap(find.text('Set zero here'));
    await tester.pump();
    expect(find.text('Measuring from your zero'), findsOneWidget);
    expect(find.text('Bottom edge 60.0°'), findsNothing);
    // The dial still shows it: from 0° round toward where it turned.
    WaterView water0() => tester.widget<WaterView>(find.byType(WaterView));
    expect(water0().mark?.degrees, closeTo(0, 0.1));
    // Turned 20° further clockwise (as seen): 20° round to the right.
    final b = 80 * math.pi / 180;
    for (var i = 0; i < 60; i++) {
      await send(tester, Vec3(-math.sin(b), math.cos(b), 0.02));
    }
    expect(water0().mark?.degrees, closeTo(20, 0.5));
    expect(water0().mark?.side, EdgeSide.right);

    // Back flat: the tilt from flat again, on the dial.
    await tester.tap(find.text('Clear zero'));
    await tester.tap(find.byTooltip('Flat on a surface'));
    await tester.pumpAndSettle();
    for (var i = 0; i < 60; i++) {
      await send(tester, Vec3.up);
    }
    expect(find.text('Flat · angle from the Earth'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('angle: flat by default, never switching by itself; Edge while '
      'flat asks to stand the phone up; the choice is remembered', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Angle');
    final a = 60 * math.pi / 180;
    Future<void> hold(Vec3 up) async {
      for (var i = 0; i < 60; i++) {
        await send(tester, up);
      }
    }

    // Flat by default: standing on an edge, or tipping past upright, still
    // reads the screen's tilt (it used to jump modes there).
    expect((await SettingsRepository.load()).angleMode, AngleMode.flat);
    await hold(Vec3(math.sin(a), math.cos(a), 0.02));
    expect(find.text('Flat · angle from the Earth'), findsOneWidget);
    await hold(const Vec3(0, 0.6, -0.8)); // past upright: 127° from flat
    expect(find.text('Flat · angle from the Earth'), findsOneWidget);

    // Held on edge: lying flat there's no edge to read.
    await tester.tap(find.byTooltip('On an edge'));
    await tester.pump();
    await hold(Vec3.up);
    expect(find.text('Stand the phone on one of its edges'), findsOneWidget);
    await hold(Vec3(math.sin(a), math.cos(a), 0.02));
    expect(find.text('Bottom edge 60.0°'), findsOneWidget);

    // Remembered when the tool opens again.
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await openTool(tester, 'Angle');
    await hold(Vec3.up);
    expect(find.text('Stand the phone on one of its edges'), findsOneWidget);

    // Flat again.
    await tester.tap(find.byTooltip('Flat on a surface'));
    await tester.pumpAndSettle();
    await hold(Vec3.up);
    expect(find.text('Flat · angle from the Earth'), findsOneWidget);
    expect(find.byTooltip('Automatic'), findsNothing);
  });

  testWidgets('angle: set and clear zero', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Angle');
    await send(tester, Vec3.up);
    expect(find.text('Flat · angle from the Earth'), findsOneWidget);

    await tester.tap(find.text('Set zero here'));
    await tester.pump();
    expect(find.text('Measuring from your zero'), findsOneWidget);

    await tester.tap(find.text('Clear zero'));
    await tester.pump();
    expect(find.text('Set zero here'), findsOneWidget);
  });

  testWidgets('compass: just the dial, reading the heading', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Compass');
    final semantics = tester.ensureSemantics();
    final pose = devicePose(heading: 200, pitch: 0);
    sensors
      ..sendUp(pose.up)
      ..sendMagnet(pose.field);
    await tester.pump();
    await send(tester, pose.up);
    expect(
      find.bySemanticsLabel(RegExp(r'^Magnetic heading 200 degrees')),
      findsOneWidget,
    );
    // Like a real compass: the card turns back by the heading so its N
    // faces north, and the ball stays at the top, where the phone points.
    final dial = tester.widget<InstrumentDial>(find.byType(InstrumentDial));
    expect(dial.cardTurn, closeTo(200, 1));
    expect(dial.ballAngle, 0);
    final turn = tester.widget<Transform>(
      find.descendant(
        of: find.byType(InstrumentDial),
        matching: find.byType(Transform),
      ),
    );
    // A turn of −200° about the centre puts N at 160° clockwise on screen.
    expect(
      turn.transform.getRotation().entry(1, 0),
      closeTo(math.sin(-200 * math.pi / 180), 0.02),
    );
    // Nothing but the instrument and the header on the compass.
    expect(find.byType(FilledButton), findsNothing);
    expect(find.byType(NavigationBar), findsNothing);
    semantics.dispose();
  });

  testWidgets('compass without a magnetometer explains why', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Compass');
    await send(tester, Vec3.up);
    sensors.magnet.addError(Exception('NO_SENSOR'));
    await tester.pump();
    await tester.pump();
    expect(find.textContaining('no magnetometer'), findsOneWidget);
  });

  testWidgets('the sun/moon button switches theme and is remembered', (
    tester,
  ) async {
    await pumpApp(tester);
    expect(
      Theme.of(tester.element(find.text('Compass'))).brightness,
      Brightness.light,
    );
    await tester.tap(find.byTooltip('Dark mode'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text('Compass'))).brightness,
      Brightness.dark,
    );
    expect(find.byTooltip('Light mode'), findsOneWidget);
    final reloaded = await SettingsRepository.load();
    expect(reloaded.themeMode, ThemeMode.dark);
  });

  testWidgets('tools show help, not the theme toggle', (tester) async {
    await pumpApp(tester);
    for (final tool in _allTools) {
      await openTool(tester, tool);
      expect(find.byTooltip('Dark mode'), findsNothing, reason: tool);
      expect(find.byTooltip('Light mode'), findsNothing, reason: tool);

      await tester.tap(find.byTooltip('How to use'));
      await tester.pumpAndSettle();
      expect(find.text('How to use $tool'), findsOneWidget, reason: tool);
      await tester.ensureVisible(find.text('Got it'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Got it'));
      await tester.pumpAndSettle();
      expect(find.text('How to use $tool'), findsNothing, reason: tool);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
    }
  });

  testWidgets('help fits a small phone with large text', (tester) async {
    await pumpApp(tester, size: const Size(320, 568));
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await openTool(tester, 'Level');
    await tester.tap(find.byTooltip('How to use'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    // The sheet scrolls, so the last control is still reachable.
    await tester.ensureVisible(find.text('Got it'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(find.text('How to use Level'), findsNothing);
  });

  testWidgets('settings sheet: theme and vibration are saved', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text('Settings'))).brightness,
      Brightness.dark,
    );

    // The vibration switch: the knob toggles on tap.
    // In the sheet, above home's Vibration tool.
    await tester.tap(find.text('Vibration').last);
    await tester.pumpAndSettle();
    final reloaded = await SettingsRepository.load();
    expect(reloaded.themeMode, ThemeMode.dark);
    expect(reloaded.haptics, isFalse);
  });

  testWidgets('settings opens the open-source licences, Inter’s included', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Open-source licences'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open-source licences'));
    await tester.pumpAndSettle();
    expect(find.byType(LicensePage), findsOneWidget);
    // Unit symbols are read out by name.
    await tester.pageBack();
    await tester.pumpAndSettle();
    final semantics = tester.ensureSemantics();
    expect(find.bySemanticsLabel('Roof pitch (rise per 12)'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('settings resets every tool’s calibration, only after '
      'confirming, and keeps other settings', (tester) async {
    await pumpApp(
      tester,
      prefs: {
        'edgeOffset': 1.5,
        'rulerPxPerMm:1080x2400': 16.2,
        'rulerMethod:1080x2400': 'card',
        'rulerPxPerMm:1812x2176': 14.0,
        'themeMode': 'dark',
        'rulerUnit': 'cm',
      },
    );
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Reset all calibrations'));
    await tester.pumpAndSettle();

    // Cancel changes nothing.
    await tester.tap(find.text('Reset all calibrations'));
    await tester.pumpAndSettle();
    expect(find.text('Reset all calibrations?'), findsOneWidget);
    expect(
      find.textContaining('in the Level (also used by the Angle tool)'),
      findsOneWidget,
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect((await SettingsRepository.load()).hasAnyCalibration, isTrue);

    await tester.tap(find.text('Reset all calibrations'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    final reloaded = await SettingsRepository.load();
    expect(reloaded.hasAnyCalibration, isFalse);
    expect(reloaded.isLevelCalibrated, isFalse);
    expect(reloaded.rulerPxPerMm('1080x2400'), isNull);
    expect(reloaded.rulerPxPerMm('1812x2176'), isNull);
    expect(reloaded.themeMode, ThemeMode.dark);
    expect(reloaded.rulerUnit, LengthUnit.cm);
    // Nothing left to reset: the card is shown as not calibrated.
    expect(find.text('Not calibrated'), findsOneWidget);
  });

  testWidgets('level: once calibrated, Calibrate also offers a reset', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    await send(tester, const Vec3(0.02, 0, 1)); // flat, about 1° off
    // Not calibrated: Calibrate acts at once.
    await tester.tap(find.text('Calibrate'));
    await tester.pumpAndSettle();
    expect(
      find.text('Calibrated. This position now reads 0°.'),
      findsOneWidget,
    );
    expect((await SettingsRepository.load()).isLevelCalibrated, isTrue);
    await tester.pump(const Duration(seconds: 5)); // the message goes
    await tester.pumpAndSettle();

    await tester.tap(find.text('Calibrate'));
    await tester.pumpAndSettle();
    expect(find.text('Calibrate here'), findsOneWidget);
    await tester.tap(find.text('Reset calibration'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Calibration removed. The Level uses the factory sensor zero again.',
      ),
      findsOneWidget,
    );
    expect((await SettingsRepository.load()).isLevelCalibrated, isFalse);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    // Back to acting at once.
    await tester.tap(find.text('Calibrate'));
    await tester.pumpAndSettle();
    expect(find.text('Calibrate here'), findsNothing);
  });

  testWidgets('roof pitch: the level reads in x/12, flat and on an edge', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('/12'));
    await tester.pumpAndSettle();
    expect((await SettingsRepository.load()).unit, AngleUnit.pitch);
    await tester.tapAt(const Offset(10, 10)); // dismiss
    await tester.pumpAndSettle();

    await openTool(tester, 'Level');
    final semantics = tester.ensureSemantics();
    await send(tester, Vec3.up);
    expect(find.bySemanticsLabel('Tilt from level 0.0/12'), findsOneWidget);
    // On an edge, 4/12 off level (18.4°): the slope tile reads the pitch.
    final rise = math.atan(4 / 12);
    for (var i = 0; i < 40; i++) {
      await send(tester, Vec3(math.sin(rise), math.cos(rise), 0.02));
    }
    expect(find.text('4.0/12'), findsWidgets);
    semantics.dispose();
  });

  testWidgets('settings sheet switches units', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('%'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10)); // dismiss
    await tester.pumpAndSettle();

    await openTool(tester, 'Level');
    final semantics = tester.ensureSemantics();
    await send(tester, Vec3.up);
    expect(find.bySemanticsLabel('Tilt from level 0.0%'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('dark theme renders every screen without errors', (tester) async {
    await pumpApp(tester, prefs: {'themeMode': 'dark'});
    final pose = devicePose(heading: 120, pitch: 0);
    for (final tool in _allTools) {
      await openTool(tester, tool);
      sensors
        ..sendUp(pose.up)
        ..sendMagnet(pose.field);
      await tester.pump();
      await send(tester, pose.up);
      expect(tester.takeException(), isNull, reason: tool);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
    }
  });

  for (final (name, size) in [
    ('small phone', const Size(320, 568)),
    ('tablet landscape', const Size(1200, 800)),
    ('phone landscape', const Size(860, 411)),
  ]) {
    testWidgets('no overflow on a $name with large text', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await pumpApp(tester, size: size);
      expect(tester.takeException(), isNull, reason: 'home');
      for (final tool in _allTools) {
        await openTool(tester, tool);
        await send(tester, const Vec3(0.1, 0, 1));
        expect(tester.takeException(), isNull, reason: tool);
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();
      }
    });
  }

  testWidgets('protractor: dragging an arm changes the angle', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Protractor');
    final semantics = tester.ensureSemantics();
    expect(
      find.bySemanticsLabel('Angle between the arms 60.0°'),
      findsOneWidget,
    );

    final centre = tester.getCenter(
      find.bySemanticsLabel(RegExp('^Angle between')),
    );
    Offset at(double degrees) {
      final a = degrees * math.pi / 180;
      return centre + Offset(math.sin(a), -math.cos(a)) * 150;
    }

    final gesture = await tester.startGesture(at(60));
    await gesture.moveTo(at(75));
    await gesture.moveTo(at(90));
    await gesture.up();
    await tester.pump();
    expect(
      find.bySemanticsLabel('Angle between the arms 90.0°'),
      findsOneWidget,
    );

    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(
      find.bySemanticsLabel('Angle between the arms 60.0°'),
      findsOneWidget,
    );
    semantics.dispose();
  });

  testWidgets('metal detector: field, status and baseline', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Metal detector');
    sensors
      ..sendMagnet(const Vec3(0, 45, 0))
      ..sendUp(Vec3.up);
    await tester.pump();
    await send(tester, Vec3.up);
    expect(find.text('No metal nearby'), findsOneWidget);
    // Field and baseline match before anything changes.
    expect(find.text('45 µT'), findsNWidgets(2));
    expect(find.text('Baseline'), findsOneWidget);
    expect(find.text('COLD'), findsOneWidget);
    await tester.tap(find.text('Set baseline'));
    await tester.pump();
    expect(tester.widget<MetalHeat>(find.byType(MetalHeat)).change, 0);

    // A magnet: the change shows on the disc, and it's hot.
    for (var i = 0; i < 30; i++) {
      sensors.sendMagnet(const Vec3(0, 105, 0));
      await send(tester, Vec3.up);
    }
    expect(
      tester.widget<MetalHeat>(find.byType(MetalHeat)).change,
      greaterThan(40),
    );
    expect(find.text('HOT'), findsOneWidget);
    expect(find.text('Metal detected'), findsOneWidget);
  });

  testWidgets('vibration: speed, strength, lock and reset', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Vibration');
    expect(find.text('Waiting for sensors…'), findsOneWidget);
    // A machine shaking at [hz] (the fake sensor reads 50 times a second).
    var t = 0;
    Future<void> shake(double hz, int samples) async {
      for (var i = 0; i < samples; i++, t++) {
        sensors.sendUserAccel(
          Vec3(3 * math.sin(2 * math.pi * hz * t * 0.02), 0, 0),
        );
      }
      await tester.pump();
      await tester.pump();
    }

    await shake(10, 20);
    expect(find.text('Finding the frequency…'), findsOneWidget);
    await shake(10, 130);
    expect(find.text('10.0 Hz'), findsOneWidget);
    expect(find.text('Vibrating at 10.0 Hz'), findsOneWidget);
    expect(find.text('Strength'), findsOneWidget);
    final tach = tester.widget<VibrationTach>(find.byType(VibrationTach));
    expect(tach.spectrum!.rpm, closeTo(600, 6));
    // The phone reads 50 times a second here, so the dial stops at 1000.
    expect(VibrationTach.maxRpm(tach.spectrum), 1000);
    await tester.pumpAndSettle();

    // Locked, a new speed doesn't change it.
    await tester.tap(find.text('Lock'));
    await shake(17, 150);
    expect(find.text('10.0 Hz'), findsOneWidget);
    await tester.tap(find.text('Unlock'));
    await tester.pump();
    expect(find.text('17.0 Hz'), findsOneWidget);

    // Reset starts again for the next machine.
    await tester.tap(find.byTooltip('Reset'));
    await tester.pump();
    await shake(17, 20);
    expect(find.text('Finding the frequency…'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('altimeter: zeroing measures height', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Altimeter');
    sensors.sendPressure(1013.25);
    await tester.pump();
    await tester.pump();
    expect(find.text('1013.3 hPa'), findsOneWidget);
    await tester.tap(find.text('Set zero here'));
    await tester.pump();
    expect(find.text('Clear zero'), findsOneWidget);
    expect(find.text('—'), findsNothing, reason: 'height from zero shown');

    // The weather button picks the scene's sky, and it's remembered.
    // (The scene never settles, so pump frames rather than settle.)
    await tester.tap(find.byTooltip('Weather'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.text('Snow'));
    await tester.pump(const Duration(milliseconds: 500));
    expect((await SettingsRepository.load()).sceneWeather, SceneWeather.snow);
    await tester.pump();
    expect(
      tester.widget<MountainScene>(find.byType(MountainScene)).weather,
      SceneWeather.snow,
    );
    expect(find.text('From zero'), findsOneWidget);

    // Back to automatic.
    await tester.tap(find.byTooltip('Weather'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.text('Auto (time of day and season)'));
    await tester.pump(const Duration(milliseconds: 500));
    expect((await SettingsRepository.load()).sceneWeather, isNull);
  });

  testWidgets('height: aim at the base, then the top', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Height');
    // Holds the phone at [deg] long enough for the readings to settle.
    Future<void> aim(double deg) async {
      final r = deg * math.pi / 180;
      for (var i = 0; i < 80; i++) {
        await send(tester, Vec3(0, math.sin(r), math.cos(r)));
      }
    }

    // Upright, the top edge isn't a sight line yet.
    await aim(88);
    expect(
      find.text('Hold the phone flatter and sight along its top edge'),
      findsOneWidget,
    );
    await aim(-6);
    expect(find.text('Aim the top edge at the base'), findsOneWidget);
    await tester.tap(find.text('Lock base'));
    await tester.pump();
    expect(find.text('15.2 m'), findsOneWidget);

    await aim(30);
    expect(find.text('Now aim the top edge at the top'), findsOneWidget);
    await tester.tap(find.text('Lock top'));
    await tester.pump();
    expect(find.text('10.4 m'), findsOneWidget);
    expect(find.text('Measure again'), findsOneWidget);

    // A known distance: type it, then only the top.
    await tester.tap(find.text('Distance'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('20.0 m'), findsOneWidget);
    expect(find.text('Lock top'), findsOneWidget);
    await aim(45);
    await tester.tap(find.text('Lock top'));
    await tester.pump();
    expect(find.text('21.6 m'), findsOneWidget);

    // Eye height is set the same way and remembered.
    await tester.tap(find.text('Eye height'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '1.5');
    await tester.pump();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect((await SettingsRepository.load()).eyeHeight, 1.5);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('camera level: explains, then a level grid over the picture', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Camera level');
    expect(find.text('Allow the camera'), findsOneWidget);
    expect(camera.opened, 0, reason: 'nothing before Allow');
    await tester.tap(find.text('Allow camera'));
    await tester.pump();
    await tester.pump();
    expect(camera.opened, 1);

    // Upright, turned 1.5° counter-clockwise.
    final r = 1.5 * math.pi / 180;
    for (var i = 0; i < 60; i++) {
      await send(tester, Vec3(math.sin(r), math.cos(r), 0));
    }
    expect(find.text('Tilted 1.5°'), findsOneWidget);
    expect(find.text('1.5°'), findsOneWidget);
    for (var i = 0; i < 60; i++) {
      await send(tester, const Vec3(0, 1, 0));
    }
    expect(find.text('Level'), findsWidgets);

    // Either pair of lines can be hidden.
    await tester.tap(find.text('True lines'));
    await tester.pump();
    await tester.tap(find.text('True lines'));
    await tester.pump();

    // Freeze holds the picture; the handles measure an edge in it: the
    // right end 6.3 px lower over 180 px is 2° off.
    await tester.tap(find.text('Freeze'));
    await tester.pump();
    expect(camera.feed!.frozen, isTrue);
    expect(find.text('Resume'), findsOneWidget);
    expect(find.text('Frozen'), findsOneWidget);
    expect(find.text('This edge is level'), findsOneWidget);
    await tester.drag(
      find.byKey(const ValueKey('edgeHandle1')),
      const Offset(0, 6.29),
    );
    await tester.pump();
    expect(find.text('Edge 2.0° off, lift the right'), findsOneWidget);
    // Live sensor changes don't move a frozen reading.
    await send(tester, Vec3(math.sin(r), math.cos(r), 0));
    expect(find.text('Edge 2.0° off, lift the right'), findsOneWidget);
    await tester.tap(find.byTooltip('Light'));
    await tester.pump();
    expect(camera.feed!.torchOn, isTrue);

    // Leaving lets the camera go.
    await tester.tap(find.byType(BackTab));
    await tester.pumpAndSettle();
    expect(camera.feed!.disposed, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('camera level: refused, it points to Settings', (tester) async {
    await pumpApp(tester);
    camera.result = FakeCameraResult.denied;
    await openTool(tester, 'Camera level');
    await tester.tap(find.text('Allow camera'));
    await tester.pumpAndSettle();
    expect(find.text('Camera access is off'), findsOneWidget);
    await tester.tap(find.text('Open settings'));
    await tester.pump();
    expect(camera.settingsOpened, 1);
  });

  testWidgets('g-force: zeroes itself, then reads braking and bends', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'G-force');
    // Upright in a mount facing the driver: forward is out of its back.
    Future<void> feel(Vec3 extra) async {
      for (var i = 0; i < 100; i++) {
        sensors.sendAccel(const Vec3(0, 9.81, 0) + extra);
      }
      await tester.pump();
      await tester.pump();
    }

    await feel(const Vec3(0, 0, 0));
    expect(find.text('Steady'), findsOneWidget);
    // Braking at half a g: the car slows, so the phone is pushed back.
    await feel(const Vec3(0, 0, 0.5 * standardGravity));
    expect(find.text('Braking 0.50 g'), findsOneWidget);
    expect(find.text('0.50 g'), findsWidgets);
    // A left bend: the car accelerates to its left (the phone's -x).
    await feel(const Vec3(-0.4 * standardGravity, 0, 0));
    expect(find.text('Left bend 0.40 g'), findsOneWidget);
    await tester.tap(find.byTooltip('Reset peaks'));
    await tester.pump();
    await tester.tap(find.text('Zero'));
    await tester.pump();
    expect(find.text('Zeroed: forward and down learned'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('tape measure: points chain into a shape with its area', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Tape measure');
    expect(ar.started, 1);
    expect(ar.listening, isTrue);

    // Corners two metres ahead (see FakeArService.send): each tap adds the
    // point under the aim.
    Future<void> aimAt(Vec3 v) async {
      ar.send(aim: v);
      await tester.pump();
      await tester.pump();
    }

    Future<void> tapButton(String label) async {
      await tester.tap(find.widgetWithText(SoftButton, label));
      await tester.pump();
      await tester.pump();
    }

    await aimAt(const Vec3(0, 0, -2));
    expect(find.text('Aim at the first corner and tap Add point'), findsOne);
    await tapButton('Add point');
    await aimAt(const Vec3(1, 0, -2));
    expect(find.text('1.00 m'), findsOne, reason: 'the live piece, totalled');
    await tapButton('Add point');
    await aimAt(const Vec3(1, 1, -2));
    await tapButton('Add point');

    // Back near the first corner it snaps and closes.
    await aimAt(const Vec3(0.03, 0.03, -2));
    expect(
      find.text('On the first point: tap Close shape for the area'),
      findsOne,
    );
    await tapButton('Close shape');
    await aimAt(const Vec3(0.5, 0.5, -2));
    expect(find.text('Perimeter'), findsOne);
    expect(find.text('≈ 0.50 m²'), findsOne);
    expect(find.text('3.41 m'), findsOne);
    expect(ar.points, hasLength(3));

    // Inches, shared with the ruler.
    await tester.tap(find.byTooltip('Units: centimetres or inches'));
    await tester.pump();
    await tester.pump();
    expect(find.text('≈ 5.4 ft²'), findsOne);

    // Undo opens the shape again.
    await tester.tap(find.byTooltip('Undo'));
    await tester.pump();
    await tester.pump();
    expect(find.text('Perimeter'), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(ar.stopped, 1, reason: 'AR stops with the tool');
  });

  testWidgets('tape measure: a phone without ARCore is told so', (
    tester,
  ) async {
    await pumpApp(tester);
    ar.supportResult = ArSupport.unsupported;
    await openTool(tester, 'Tape measure');
    expect(find.textContaining('doesn’t support AR (ARCore)'), findsOne);
    expect(ar.started, 0);
  });

  testWidgets('speedometer: explains, then speed and trip from GPS', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Speedometer');
    expect(find.text('Allow location'), findsWidgets);
    expect(location.listening, isFalse, reason: 'nothing before Allow');
    await tester.tap(find.widgetWithText(SoftButton, 'Allow location'));
    await tester.pump();
    await tester.pump();
    expect(location.listening, isTrue);
    expect(find.text('Finding satellites…'), findsOneWidget);

    // A minute heading north at 20 m/s (72 km/h), a fix a second.
    final start = DateTime(2026, 10, 7, 12);
    for (var i = 0; i <= 60; i++) {
      location.send(
        lat: 51.5 + i * 20 / 111195,
        lon: -0.12,
        speed: 20,
        altitude: 35,
        time: start.add(Duration(seconds: i)),
      );
    }
    await tester.pump();
    await tester.pump();
    expect(find.text('GPS ±5 m'), findsOneWidget);
    expect(find.text('72 km/h'), findsNWidgets(2), reason: 'top and average');
    expect(find.text('1.2 km'), findsOneWidget);
    expect(find.textContaining('51.51079° N'), findsOneWidget);

    // mph, remembered.
    await tester.tap(find.widgetWithText(SoftButton, 'km/h'));
    await tester.pump();
    expect(find.text('45 mph'), findsNWidgets(2));
    expect((await SettingsRepository.load()).speedMph, isTrue);

    // Reset trip starts again.
    await tester.tap(find.text('Reset trip'));
    await tester.pump();
    expect(find.text('0 mph'), findsNWidgets(2));

    // The scene's weather is picked here, apart from the Altimeter's.
    await tester.tap(find.byTooltip('Weather'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.tap(find.text('Storm'));
    await tester.pump(const Duration(milliseconds: 500));
    final saved = await SettingsRepository.load();
    expect(saved.driveWeather, SceneWeather.storm);
    expect(saved.sceneWeather, isNull);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('speedometer: refused, it points to Settings', (tester) async {
    await pumpApp(tester);
    location.requestResult = LocationAccess.denied;
    await openTool(tester, 'Speedometer');
    await tester.tap(find.widgetWithText(SoftButton, 'Allow location'));
    await tester.pumpAndSettle();
    expect(find.text('Location access is off'), findsOneWidget);
    await tester.tap(find.text('Open settings'));
    await tester.pump();
    expect(location.appSettingsOpened, 1);
  });

  testWidgets('altimeter: phones without a barometer are told so', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Altimeter');
    sensors.baro.addError(Exception('NO_SENSOR'));
    await tester.pump();
    await tester.pump();
    expect(find.textContaining('no barometer'), findsOneWidget);
  });

  group('sound meter', () {
    /// Mean square for a level of [db] (see domain/sound.dart).
    double ms(double db) => math.pow(10, (db - 90) / 10).toDouble();

    testWidgets('explains first, asks only on Allow, then measures', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await pumpApp(tester);
      await openTool(tester, 'Sound meter');
      expect(find.text('Allow the microphone'), findsOneWidget);
      expect(
        find.textContaining('never recorded, saved or sent'),
        findsOneWidget,
      );
      expect(microphone.requests, 0, reason: 'no prompt before the reason');

      await tester.tap(find.text('Allow microphone'));
      await tester.pumpAndSettle();
      expect(microphone.requests, 1);
      microphone.sendSound(ms(60), seconds: 3);
      await tester.pump();
      await tester.pump();
      expect(
        find.bySemanticsLabel('Sound level about 60 decibels'),
        findsOneWidget,
      );
      expect(find.text('Moderate, like a conversation'), findsOneWidget);
      expect(find.text('60 dB'), findsNWidgets(2)); // average and max
      semantics.dispose();
    });

    testWidgets('refused: points to Settings, and works once allowed there', (
      tester,
    ) async {
      await pumpApp(tester);
      microphone.grantOnRequest = false;
      await openTool(tester, 'Sound meter');
      await tester.tap(find.text('Allow microphone'));
      await tester.pumpAndSettle();
      expect(find.text('Microphone access is off'), findsOneWidget);
      await tester.tap(find.text('Open settings'));
      await tester.pump();
      expect(microphone.settingsOpened, 1);

      // Allowed in Settings, then back to the app.
      microphone.granted = true;
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      microphone.sendSound(ms(40), seconds: 2);
      await tester.pump();
      await tester.pump();
      expect(find.text('Quiet, like a library'), findsOneWidget);
    });

    testWidgets('loud: a hearing warning; Reset and the lock', (tester) async {
      await pumpApp(tester);
      microphone.granted = true;
      await openTool(tester, 'Sound meter');
      microphone.sendSound(ms(92), seconds: 3);
      await tester.pump();
      await tester.pump();
      final banner = tester.widget<StatusBanner>(find.byType(StatusBanner));
      expect(banner.tone, StatusTone.danger);
      expect(banner.text, 'Very loud: long exposure can damage hearing');

      // Quieter now; Reset starts Max again from the current level.
      microphone.sendSound(ms(50), seconds: 6);
      await tester.pump();
      await tester.pump();
      expect(find.text('92 dB'), findsOneWidget); // max
      await tester.tap(find.text('Reset'));
      await tester.pump();
      expect(find.text('92 dB'), findsNothing);

      await tester.tap(find.byTooltip('Lock reading'));
      await tester.pump();
      microphone.sendSound(ms(95), seconds: 3);
      await tester.pump();
      await tester.pump();
      expect(find.textContaining('Locked · '), findsOneWidget);
      expect(find.text('Quiet, like a library'), findsNothing);
    });

    testWidgets('ripples in the colour of each band, frozen by the lock', (
      tester,
    ) async {
      await pumpApp(tester);
      microphone.granted = true;
      await openTool(tester, 'Sound meter');
      microphone.sendSound(ms(60), seconds: 3);
      await tester.pump();
      await tester.pump();
      SoundRipples water() =>
          tester.widget<SoundRipples>(find.byType(SoundRipples));
      final p = Palette.light;
      // Green, yellow, orange, red and crimson from 0, 50, 70, 85, 100 dB.
      expect(water().zones, [
        (from: 0.0, color: p.gaugeSafe),
        (from: 50.0, color: p.gaugeModerate),
        (from: 70.0, color: p.gaugeCaution),
        (from: 85.0, color: p.gaugeDanger),
        (from: 100.0, color: p.gaugeExtreme),
      ]);
      expect(water().level, closeTo(60, 0.5));
      expect(water().history, isNotEmpty);
      expect(water().animate, isTrue);
      expect(zoneColor(water().zones, 60, blend: 5, end: 120), p.gaugeModerate);
      await tester.tap(find.byTooltip('Lock reading'));
      await tester.pump();
      expect(water().animate, isFalse, reason: 'the water holds still');
      await tester.tap(find.byTooltip('Unlock'));
      await tester.pump();
      StatusTone tone() =>
          tester.widget<StatusBanner>(find.byType(StatusBanner)).tone;
      expect(tone(), StatusTone.neutral);
      microphone.sendSound(ms(78), seconds: 12);
      await tester.pump();
      await tester.pump();
      expect(tone(), StatusTone.warning);
    });

    testWidgets('a phone without a microphone is marked on home', (
      tester,
    ) async {
      await pumpApp(tester, missing: {SensorKind.microphone});
      await tester.ensureVisible(find.text('Sound meter'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sound meter'));
      await tester.pumpAndSettle();
      expect(find.text('Sound meter isn’t available'), findsOneWidget);
    });
  });

  group('light meter', () {
    testWidgets('lux, foot-candles and what the light is good for', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      await pumpApp(tester);
      await openTool(tester, 'Light meter');
      expect(find.text('Waiting for sensors…'), findsOneWidget);
      sensors.sendLux(420);
      await tester.pump();
      await tester.pump();
      expect(find.bySemanticsLabel('Brightness 420 lux'), findsOneWidget);
      expect(find.text('420'), findsOneWidget);
      expect(find.text('39 fc'), findsOneWidget);
      expect(find.text('Good for reading and desk work'), findsOneWidget);
      semantics.dispose();
    });

    testWidgets('a night sky in the dark, the title turns light', (
      tester,
    ) async {
      await pumpApp(tester);
      await openTool(tester, 'Light meter');
      bool headerOnDark() =>
          tester.widget<ToolFrame>(find.byType(ToolFrame)).headerOnDark;
      sensors.sendLux(3);
      await tester.pump();
      await tester.pump();
      expect(tester.widget<LightSky>(find.byType(LightSky)).lux, 3);
      expect(headerOnDark(), isTrue);
      sensors.sendLux(20000);
      await tester.pumpAndSettle();
      expect(headerOnDark(), isFalse);
    });

    testWidgets('the lock holds a reading', (tester) async {
      await pumpApp(tester);
      await openTool(tester, 'Light meter');
      sensors.sendLux(420);
      await tester.pump();
      await tester.pump();
      await tester.tap(find.text('Lock'));
      await tester.pump();
      sensors.sendLux(12);
      await tester.pump();
      await tester.pump();
      expect(find.text('420'), findsOneWidget);
      expect(
        find.text('Locked · Good for reading and desk work'),
        findsOneWidget,
      );
      await tester.tap(find.text('Unlock'));
      await tester.pump();
      expect(find.text('12'), findsOneWidget);
      expect(find.text('Dim light'), findsOneWidget);
    });

    testWidgets('a phone without a light sensor says so', (tester) async {
      await pumpApp(tester);
      await openTool(tester, 'Light meter');
      sensors.lightSensor.addError(Exception('NO_SENSOR'));
      await tester.pump();
      await tester.pump();
      expect(find.textContaining('no light sensor'), findsOneWidget);
    });

    testWidgets('home marks it unavailable without the sensor', (tester) async {
      await pumpApp(tester, missing: {SensorKind.light});
      await tester.ensureVisible(find.text('Light meter'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Light meter'));
      await tester.pumpAndSettle();
      expect(find.text('Light meter isn’t available'), findsOneWidget);
      expect(find.textContaining('light sensor'), findsWidgets);
    });

    testWidgets('iPhones don’t list it: Apple keeps the sensor private', (
      tester,
    ) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      await pumpApp(tester);
      expect(find.text('Light meter'), findsNothing);
      expect(find.text('Altimeter'), findsOneWidget);
      debugDefaultTargetPlatformOverride = null;
    });
  });

  testWidgets('home marks tools this phone can’t run and explains why', (
    tester,
  ) async {
    await pumpApp(
      tester,
      prefs: {'homeLayout': 'list'},
      missing: {SensorKind.barometer},
    );
    await tester.ensureVisible(find.text('Altimeter'));
    await tester.pumpAndSettle();
    expect(find.text('Not available on this phone'), findsOneWidget);

    await tester.tap(find.text('Altimeter'));
    await tester.pumpAndSettle();
    expect(find.text('Altimeter isn’t available'), findsOneWidget);
    expect(
      find.textContaining('barometer (air pressure sensor)'),
      findsOneWidget,
    );
    // The tool itself didn't open.
    expect(find.text('Set zero here'), findsNothing);
    await tester.ensureVisible(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Tools that don't need it still open.
    await openTool(tester, 'Level');
    expect(find.byTooltip('Back'), findsOneWidget);
  });

  testWidgets('a phone without ARCore greys the tape measure out', (
    tester,
  ) async {
    await pumpApp(
      tester,
      prefs: {'homeLayout': 'list'},
      arSupport: ArSupport.unsupported,
    );
    await tester.ensureVisible(find.text('Tape measure'));
    await tester.pumpAndSettle();
    expect(find.text('Not available on this phone'), findsOneWidget);
    await tester.tap(find.text('Tape measure'));
    await tester.pumpAndSettle();
    expect(find.text('Tape measure isn’t available'), findsOneWidget);
    expect(find.textContaining('ARCore (augmented reality)'), findsOneWidget);
    expect(ar.started, 0, reason: 'the tool did not open');
  });

  testWidgets('no camera or GPS greys out the tools that need them', (
    tester,
  ) async {
    await pumpApp(
      tester,
      prefs: {'homeLayout': 'list'},
      missing: {SensorKind.camera, SensorKind.gps},
    );
    for (final tool in ['Camera level', 'Speedometer', 'Tape measure']) {
      await tester.ensureVisible(find.text(tool));
      await tester.pumpAndSettle();
      await tester.tap(find.text(tool));
      await tester.pumpAndSettle();
      expect(find.text('$tool isn’t available'), findsOneWidget, reason: tool);
      await tester.ensureVisible(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    }
    expect(find.text('Not available on this phone'), findsNWidgets(3));
  });

  testWidgets('grid view also marks unavailable tools', (tester) async {
    await pumpApp(
      tester,
      prefs: {'homeLayout': 'grid'},
      missing: {SensorKind.magnetometer},
    );
    // Compass and metal detector both need the magnetometer.
    expect(find.text('Not on this phone'), findsNWidgets(2));
  });

  testWidgets('a sensor that never reports gets a clear message', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Compass');
    await send(tester, Vec3.up); // accelerometer works, compass sensor silent
    expect(find.text('Waiting for sensors…'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    expect(find.textContaining('No readings from the sensor'), findsOneWidget);
  });

  testWidgets('compass warns about magnetic interference', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Compass');
    final pose = devicePose(heading: 90, pitch: 0);
    sensors
      ..sendUp(pose.up)
      ..sendMagnet(pose.field);
    await tester.pump();
    await send(tester, pose.up);
    expect(find.textContaining('Magnetic interference'), findsNothing);

    // A magnet next to the phone: far stronger than the Earth's field.
    for (var i = 0; i < 30; i++) {
      sensors.sendMagnet(pose.field * 4);
      await send(tester, pose.up);
    }
    expect(find.textContaining('Magnetic interference'), findsOneWidget);

    // Taken away again: the warning goes with it.
    for (var i = 0; i < 30; i++) {
      sensors.sendMagnet(pose.field);
      await send(tester, pose.up);
    }
    expect(find.textContaining('Magnetic interference'), findsNothing);

    // The system says the compass needs calibrating (as after a magnet
    // threw it off): ask for a figure 8, until it's calibrated again.
    sensors.magnetAccuracy.add(1);
    await send(tester, pose.up);
    expect(find.textContaining('figure 8 to calibrate'), findsOneWidget);
    sensors.magnetAccuracy.add(3);
    await send(tester, pose.up);
    expect(find.textContaining('figure 8 to calibrate'), findsNothing);
  });

  testWidgets('phone landscape: readings sit beside the dial', (tester) async {
    await pumpApp(tester, size: const Size(860, 411));
    await openTool(tester, 'Level');
    await send(tester, const Vec3(0, 1, 0.02));
    final dial = tester.getRect(find.bySemanticsLabel(RegExp('level')));
    final hold = tester.getRect(find.text('Lock'));
    expect(hold.left, greaterThan(430), reason: 'footer on the right');
    expect(dial.right, lessThanOrEqualTo(hold.left));
    // The header title is the topmost "Level" (the status line also says it).
    final title = tester
        .widgetList<Text>(find.text('Level'))
        .map((t) => tester.getRect(find.byWidget(t)))
        .reduce((a, b) => a.top < b.top ? a : b);
    expect(dial.top, greaterThanOrEqualTo(title.bottom));
  });

  testWidgets('sheets fit phone landscape with large text', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await pumpApp(tester, size: const Size(860, 411));
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'settings');
    tester.state<NavigatorState>(find.byType(Navigator).first).pop();
    await tester.pumpAndSettle();

    await openTool(tester, 'Vibration');
    await tester.tap(find.byTooltip('How to use'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'help');
  });

  group('level tube view', () {
    SpiritVial vial(WidgetTester tester, String label) => tester.widget(
      find.byWidgetPredicate(
        (w) => w is SpiritVial && w.semanticsLabel == label,
      ),
    );

    testWidgets('switches from the dial, and is remembered', (tester) async {
      await pumpApp(tester);
      await openTool(tester, 'Level');
      await send(tester, const Vec3(0.1, 0, 1)); // flat, right side high
      expect(find.byType(SpiritVial), findsNothing);

      await tester.tap(find.byTooltip('Tube view'));
      await tester.pump();
      // Flat: a left/right tube and a forward/back tube.
      expect(find.byType(SpiritVial), findsNWidgets(2));
      // The bubble floats toward the high (right) end.
      expect(vial(tester, 'Left and right tube').position, greaterThan(0.3));
      expect(vial(tester, 'Forward and back tube').position, closeTo(0, 0.05));

      // On an edge: one tube along it.
      for (var i = 0; i < 40; i++) {
        await send(tester, const Vec3(0, 1, 0.02));
      }
      expect(find.byType(SpiritVial), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await openTool(tester, 'Level');
      for (var i = 0; i < 40; i++) {
        await send(tester, const Vec3(0.1, 0, 1));
      }
      expect(find.byType(SpiritVial), findsNWidgets(2));
      expect((await SettingsRepository.load()).levelStyle, LevelStyle.tube);
    });

    testWidgets('on its side the level doesn’t turn itself: the water line '
        'and the tube follow the real edge instead', (tester) async {
      await pumpApp(tester);
      await openTool(tester, 'Level');
      // Standing on its left edge, about 2.9° off: edge 87.1°.
      for (var i = 0; i < 40; i++) {
        await send(tester, const Vec3(1, 0.05, 0.02));
      }
      expect(find.byType(RotatedBox), findsNothing);
      final dial = tester.widget<InstrumentDial>(find.byType(InstrumentDial));
      expect(dial.waterAngle, closeTo(87.1, 0.2));
      expect(dial.ballAngle, closeTo(177.1, 0.2));

      await tester.tap(find.byTooltip('Tube view'));
      await tester.pump();
      expect(find.byType(RotatedBox), findsNothing);
      final tube = vial(tester, 'Level tube');
      expect(tube.vertical, isTrue, reason: 'runs along the screen');
      expect(tube.position, greaterThan(0.1));
      final rect = tester.getRect(find.byType(SpiritVial));
      expect(rect.height, greaterThan(rect.width * 3));
    });

    testWidgets('landscape: the tube fills the space below the header', (
      tester,
    ) async {
      await pumpApp(
        tester,
        size: const Size(860, 411),
        prefs: {'levelStyle': 'tube'},
      );
      await openTool(tester, 'Level');
      for (var i = 0; i < 40; i++) {
        await send(tester, const Vec3(0, 1, 0.02));
      }
      final tube = tester.getRect(find.byType(SpiritVial));
      final hold = tester.getRect(find.text('Lock'));
      expect(tube.width, greaterThan(250), reason: 'not squeezed');
      expect(tube.top, greaterThan(88), reason: 'below the header');
      expect(tube.right, lessThanOrEqualTo(hold.left));
    });

    for (final (name, size) in [
      ('small phone', const Size(320, 568)),
      ('phone landscape', const Size(860, 411)),
      ('tablet landscape', const Size(1200, 800)),
    ]) {
      testWidgets('no overflow on a $name with large text', (tester) async {
        tester.platformDispatcher.textScaleFactorTestValue = 1.6;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await pumpApp(tester, size: size, prefs: {'levelStyle': 'tube'});
        await openTool(tester, 'Level');
        await send(tester, const Vec3(0.1, 0, 1));
        expect(tester.takeException(), isNull, reason: 'flat');
        for (var i = 0; i < 40; i++) {
          await send(tester, const Vec3(0, 1, 0.02));
        }
        expect(tester.takeException(), isNull, reason: 'edge');
      });
    }
  });

  group('sounds', () {
    testWidgets('metal detector beeps near metal; the speaker mutes it', (
      tester,
    ) async {
      final sound = RecordingSoundService();
      await pumpApp(tester, sound: sound);
      await openTool(tester, 'Metal detector');
      sensors.sendMagnet(const Vec3(0, 45, 0));
      await send(tester, Vec3.up);
      await tester.pump(const Duration(seconds: 2));
      expect(sound.ticks, 0, reason: 'no metal, no beep');

      // A magnet next to the phone: about 100 µT over the baseline.
      for (var i = 0; i < 30; i++) {
        sensors.sendMagnet(const Vec3(0, 145, 0));
        await send(tester, Vec3.up);
      }
      sound.ticks = 0;
      await tester.pump(const Duration(seconds: 2));
      expect(sound.ticks, greaterThan(8), reason: 'beeping fast');

      await tester.tap(find.byTooltip('Mute sound'));
      await tester.pump();
      expect(find.byTooltip('Turn sound on'), findsOneWidget);
      sound.ticks = 0;
      await tester.pump(const Duration(seconds: 2));
      expect(sound.ticks, 0, reason: 'muted');
      expect((await SettingsRepository.load()).sounds, isFalse);

      await tester.tap(find.byTooltip('Turn sound on'));
      await tester.pump();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      sound.ticks = 0;
      await tester.pump(const Duration(seconds: 2));
      expect(sound.ticks, 0, reason: 'closed');
    });

    testWidgets('Settings has a Sounds switch, remembered', (tester) async {
      await pumpApp(tester);
      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Sounds'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sounds'));
      await tester.pumpAndSettle();
      expect((await SettingsRepository.load()).sounds, isFalse);
    });
  });

  group('status tones', () {
    testWidgets('compass interference is an amber caution pill', (
      tester,
    ) async {
      await pumpApp(tester);
      await openTool(tester, 'Compass');
      final pose = devicePose(heading: 90, pitch: 0);
      for (var i = 0; i < 30; i++) {
        sensors.sendMagnet(pose.field * 4);
        await send(tester, pose.up);
      }
      expect(
        find.ancestor(
          of: find.textContaining('Magnetic interference'),
          matching: find.byWidgetPredicate(
            (w) =>
                w is DecoratedBox &&
                w.decoration is BoxDecoration &&
                (w.decoration as BoxDecoration).color ==
                    Palette.light.warningTint,
          ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('level reached reads in the success orange', (tester) async {
      await pumpApp(tester);
      await openTool(tester, 'Level');
      for (var i = 0; i < 10; i++) {
        await send(tester, Vec3.up);
      }
      final status = find.byWidgetPredicate(
        (w) =>
            w is Text &&
            w.data == 'Level' &&
            w.style?.color == Palette.light.success,
      );
      expect(status, findsOneWidget);
    });

    testWidgets('metal: no check until metal is found', (tester) async {
      await pumpApp(tester);
      await openTool(tester, 'Metal detector');
      sensors.sendMagnet(const Vec3(0, 45, 0));
      await send(tester, Vec3.up);
      expect(find.text('No metal nearby'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_rounded), findsNothing);
    });
  });

  group('lock', () {
    testWidgets('angle: the lock freezes the reading until unlocked', (
      tester,
    ) async {
      await pumpApp(tester);
      await openTool(tester, 'Angle');
      final semantics = tester.ensureSemantics();
      for (var i = 0; i < 20; i++) {
        await send(tester, const Vec3(0, 1, 1)); // 45°
      }
      expect(find.bySemanticsLabel('From level 45.0°'), findsOneWidget);

      await tester.tap(find.byTooltip('Lock reading'));
      await tester.pump();
      expect(find.text('Locked · Flat · angle from the Earth'), findsOneWidget);
      for (var i = 0; i < 20; i++) {
        await send(tester, Vec3.up); // lifted and laid flat
      }
      expect(find.bySemanticsLabel('From level 45.0°'), findsOneWidget);

      await tester.tap(find.byTooltip('Unlock'));
      for (var i = 0; i < 40; i++) {
        await send(tester, Vec3.up);
      }
      expect(find.bySemanticsLabel('From level 45.0°'), findsNothing);
      expect(find.text('Flat · angle from the Earth'), findsOneWidget);

      // Reopening the tool starts unlocked.
      await tester.tap(find.byTooltip('Lock reading'));
      await tester.pump();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await openTool(tester, 'Angle');
      expect(find.byTooltip('Lock reading'), findsOneWidget);
      semantics.dispose();
    });

    testWidgets('protractor: locked handles ignore drags; Reset is off', (
      tester,
    ) async {
      await pumpApp(tester);
      await openTool(tester, 'Protractor');
      final semantics = tester.ensureSemantics();
      await tester.tap(find.byTooltip('Lock handles'));
      await tester.pump();
      expect(
        find.text('Handles locked · tap the lock to adjust'),
        findsOneWidget,
      );
      final centre = tester.getCenter(
        find.bySemanticsLabel(RegExp('^Angle between')),
      );
      await tester.dragFrom(centre + const Offset(120, 0), const Offset(0, 80));
      await tester.pump();
      expect(
        find.bySemanticsLabel('Angle between the arms 60.0°'),
        findsOneWidget,
      );
      final reset = tester.widget<SoftButton>(
        find.widgetWithText(SoftButton, 'Reset'),
      );
      expect(reset.onPressed, isNull);

      await tester.tap(find.byTooltip('Unlock'));
      await tester.pump();
      await tester.dragFrom(centre + const Offset(120, 0), const Offset(0, 80));
      await tester.pump();
      expect(
        find.bySemanticsLabel('Angle between the arms 60.0°'),
        findsNothing,
      );
      semantics.dispose();
    });
  });
}
