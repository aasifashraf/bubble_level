import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/repositories/barometer_repository.dart';
import '../../data/repositories/g_force_repository.dart';
import '../../data/repositories/light_repository.dart';
import '../../data/repositories/orientation_repository.dart';
import '../../data/repositories/review_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/sound_repository.dart';
import '../../data/repositories/speed_repository.dart';
import '../../data/repositories/vibration_repository.dart';
import '../../data/services/ar_service.dart';
import '../../data/services/camera_service.dart';
import '../../data/services/display_rotation_service.dart';
import '../../data/services/location_service.dart';
import '../../data/services/microphone_service.dart';
import '../../data/services/motion_sensor_service.dart';
import '../../data/services/sensor_availability_service.dart';
import '../../data/services/sound_service.dart';
import '../core/dial.dart';
import '../core/help.dart';
import '../core/l10n.dart';
import '../core/sensor_view_model.dart';
import '../core/soft_switch.dart';
import '../core/theme.dart';
import '../core/theme_toggle.dart';
import '../core/tool_frame.dart';
import '../core/tool_rotation.dart';
import '../features/altimeter/view_models/altimeter_view_model.dart';
import '../features/altimeter/views/altimeter_screen.dart';
import '../features/angle/view_models/angle_view_model.dart';
import '../features/angle/views/angle_screen.dart';
import '../features/camera/view_models/camera_level_view_model.dart';
import '../features/camera/views/camera_level_screen.dart';
import '../features/compass/view_models/compass_view_model.dart';
import '../features/compass/views/compass_screen.dart';
import '../features/g_force/view_models/g_force_view_model.dart';
import '../features/g_force/views/g_force_screen.dart';
import '../features/height/view_models/height_view_model.dart';
import '../features/height/views/height_screen.dart';
import '../features/level/view_models/level_view_model.dart';
import '../features/level/views/level_screen.dart';
import '../features/light/view_models/light_view_model.dart';
import '../features/light/views/light_screen.dart';
import '../features/metal/view_models/metal_view_model.dart';
import '../features/metal/views/metal_screen.dart';
import '../features/protractor/view_models/protractor_view_model.dart';
import '../features/protractor/views/protractor_screen.dart';
import '../features/ruler/view_models/ruler_view_model.dart';
import '../features/ruler/views/ruler_screen.dart';
import '../features/settings/views/settings_sheet.dart';
import '../features/sound/view_models/sound_view_model.dart';
import '../features/sound/views/sound_screen.dart';
import '../features/speed/view_models/speed_view_model.dart';
import '../features/speed/views/speed_screen.dart';
import '../features/tape/view_models/tape_view_model.dart';
import '../features/tape/views/tape_screen.dart';
import '../features/vibration/view_models/vibration_view_model.dart';
import '../features/vibration/views/vibration_screen.dart';
import 'tool_glyphs.dart';
import 'tool_tiles.dart';

typedef _ToolEntry = ({
  HomeTool tool,
  String title,
  String subtitle,
  List<SensorKind> needs,
});

/// Home: the tools as a list (default) or a grid of soft round buttons in
/// the dial's material. Each opens full screen with the back tab; only the
/// open tool follows the sensors.
class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.orientation,
    required this.settings,
    this.sensors = const MotionSensorService(),
    this.missingSensors = const {},
    this.sound = const SilentSoundService(),
    this.review,
    this.display = const DisplayRotationService(),
    this.microphone = const MicrophoneService(),
    this.camera = const CameraService(),
    this.location = const LocationService(),
    this.ar = const ArService(),
  });

  final OrientationRepository orientation;
  final SettingsRepository settings;

  /// Sensors this device lacks; tools that need them are shown as
  /// unavailable and explain why instead of opening.
  final Set<SensorKind> missingSensors;

  /// The level chime and metal detector beep.
  final SoundService sound;

  /// Asks for a store review after enough successes (none in tests).
  final ReviewRepository? review;

  /// Screen rotation and density (the ruler's scale).
  final DisplayRotationService display;

  /// The sound meter's microphone.
  final MicrophoneService microphone;

  /// The camera level's camera.
  final CameraService camera;

  /// The speedometer's GPS.
  final LocationService location;

  /// The tape measure's AR.
  final ArService ar;

  /// Feeds the vibration and pressure sensors (orientation has its own).
  final MotionSensorService sensors;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  /// The tape measure is hidden until its points stay put: on phones they
  /// drift away from where they were placed, so its readings can't be
  /// trusted yet. Its code stays so it can come back.
  static const _tapeReady = false;

  /// ARCore support, asked once without holding up the launch. Until it
  /// answers the tape measure counts as available; it checks again when
  /// opened.
  bool _noAr = false;

  @override
  void initState() {
    super.initState();
    if (_tapeReady && defaultTargetPlatform == TargetPlatform.android) {
      unawaited(
        widget.ar.support().then((s) {
          if (s == ArSupport.unsupported && mounted) {
            setState(() => _noAr = true);
          }
        }),
      );
    }
  }

  late final _level = LevelViewModel(
    orientation: widget.orientation,
    settings: widget.settings,
    onLevelReached: HapticFeedback.selectionClick,
    onChime: widget.sound.chime,
    onSuccess: _recordSuccess,
  );
  late final _angle = AngleViewModel(
    orientation: widget.orientation,
    settings: widget.settings,
  );
  late final _compass = CompassViewModel(orientation: widget.orientation);
  late final _camera = CameraLevelViewModel(
    orientation: widget.orientation,
    settings: widget.settings,
    camera: widget.camera,
    onLevelReached: HapticFeedback.selectionClick,
  );
  late final _tape = TapeViewModel(
    settings: widget.settings,
    ar: widget.ar,
    onPlaced: HapticFeedback.selectionClick,
  );
  late final _height = HeightViewModel(
    orientation: widget.orientation,
    settings: widget.settings,
  );
  late final _protractor = ProtractorViewModel();
  late final _ruler = RulerViewModel(
    settings: widget.settings,
    display: widget.display,
  );
  late final _metal = MetalViewModel(
    orientation: widget.orientation,
    settings: widget.settings,
    onDetected: HapticFeedback.heavyImpact,
    onTick: widget.sound.tick,
    onSuccess: _recordSuccess,
  );

  void _recordSuccess() => unawaited(widget.review?.recordSuccess());
  late final _vibrationRepo = VibrationRepository(sensors: widget.sensors);
  late final _vibration = VibrationViewModel(repository: _vibrationRepo);
  late final _gForceRepo = GForceRepository(sensors: widget.sensors);
  late final _gForce = GForceViewModel(repository: _gForceRepo);
  late final _speedRepo = SpeedRepository(location: widget.location);
  late final _speed = SpeedViewModel(
    repository: _speedRepo,
    settings: widget.settings,
    location: widget.location,
  );
  late final _barometerRepo = BarometerRepository(sensors: widget.sensors);
  late final _altimeter = AltimeterViewModel(
    repository: _barometerRepo,
    settings: widget.settings,
  );
  late final _soundRepo = SoundRepository(microphone: widget.microphone);
  late final _sound = SoundViewModel(
    repository: _soundRepo,
    microphone: widget.microphone,
  );
  late final _lightRepo = LightRepository(sensors: widget.sensors);
  late final _light = LightViewModel(repository: _lightRepo);

  @override
  void dispose() {
    for (final vm in [
      _level,
      _angle,
      _compass,
      _height,
      _camera,
      _tape,
      _metal,
    ]) {
      vm.dispose();
    }
    _protractor.dispose();
    _ruler.dispose();
    _vibration.dispose();
    _gForce.dispose();
    _gForceRepo.dispose();
    _speed.dispose();
    _speedRepo.dispose();
    _altimeter.dispose();
    _light.dispose();
    _lightRepo.dispose();
    _sound.dispose();
    _soundRepo.dispose();
    _vibrationRepo.dispose();
    _barometerRepo.dispose();
    super.dispose();
  }

  bool _toolOpen = false;

  /// Tools that hold portrait unless turned with their rotate button.
  static const _rotatable = {
    HomeTool.level,
    HomeTool.angle,
    HomeTool.compass,
    HomeTool.protractor,
    HomeTool.ruler,
    HomeTool.light,
    HomeTool.gforce,
  };

  /// Tools that always stay portrait (their scene is drawn for it).
  static const _portraitOnly = {
    HomeTool.altimeter,
    HomeTool.height,
    HomeTool.camera,
    HomeTool.speed,
    HomeTool.tape,
  };

  /// Opens a tool full screen; its view model (if it uses sensors) follows
  /// them only while the tool is showing. A [_rotatable] [tool] holds its
  /// remembered orientation; the rest, and home, follow the phone.
  Future<void> _open(
    ActiveViewModel? vm,
    WidgetBuilder page, {
    HomeTool? tool,
  }) async {
    // Two quick taps would stack two tools; the second's close would
    // then stop the first while it's still showing.
    if (_toolOpen) return;
    _toolOpen = true;
    final rotatable = _rotatable.contains(tool) ? tool!.name : null;
    final portrait = _portraitOnly.contains(tool);
    if (rotatable != null) {
      unawaited(lockOrientation(widget.settings.toolLandscape(rotatable)));
    } else if (portrait) {
      unawaited(lockOrientation(false));
    }
    vm?.active = true;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: rotatable == null
            ? page
            : (context) => RotatableTool(
                settings: widget.settings,
                tool: rotatable,
                child: page(context),
              ),
      ),
    );
    vm?.active = false;
    if (rotatable != null || portrait) unawaited(lockOrientation(null));
    _toolOpen = false;
  }

  void _openTool(HomeTool tool) {
    void back() => Navigator.of(context).pop();
    switch (tool) {
      case HomeTool.level:
        _open(
          _level,
          (_) => LevelScreen(viewModel: _level, onBack: back),
          tool: tool,
        );
      case HomeTool.angle:
        _open(
          _angle,
          (_) => AngleScreen(viewModel: _angle, onBack: back),
          tool: tool,
        );
      case HomeTool.compass:
        _open(
          _compass,
          (_) => CompassScreen(viewModel: _compass, onBack: back),
          tool: tool,
        );
      case HomeTool.protractor:
        _protractor.unlock();
        _open(
          null,
          (_) => ProtractorScreen(viewModel: _protractor, onBack: back),
          tool: tool,
        );
      case HomeTool.ruler:
        _ruler.open();
        _open(
          null,
          (_) => RulerScreen(viewModel: _ruler, onBack: back),
          tool: tool,
        );
      case HomeTool.metal:
        _open(_metal, (_) => MetalScreen(viewModel: _metal, onBack: back));
      case HomeTool.vibration:
        _open(
          _vibration,
          (_) => VibrationScreen(viewModel: _vibration, onBack: back),
        );
      case HomeTool.sound:
        _open(_sound, (_) => SoundScreen(viewModel: _sound, onBack: back));
      case HomeTool.light:
        _open(
          _light,
          (_) => LightScreen(viewModel: _light, onBack: back),
          tool: tool,
        );
      case HomeTool.altimeter:
        _open(
          _altimeter,
          (_) => AltimeterScreen(viewModel: _altimeter, onBack: back),
          tool: tool,
        );
      case HomeTool.camera:
        _open(
          _camera,
          (_) => CameraLevelScreen(viewModel: _camera, onBack: back),
          tool: tool,
        );
      case HomeTool.tape:
        _open(
          _tape,
          (_) => TapeScreen(viewModel: _tape, onBack: back),
          tool: tool,
        );
      case HomeTool.speed:
        _open(
          _speed,
          (_) => SpeedScreen(viewModel: _speed, onBack: back),
          tool: tool,
        );
      case HomeTool.gforce:
        _open(
          _gForce,
          (_) => GForceScreen(viewModel: _gForce, onBack: back),
          tool: tool,
        );
      case HomeTool.height:
        _open(
          _height,
          (_) => HeightScreen(viewModel: _height, onBack: back),
          tool: tool,
        );
    }
  }

  /// The tools in display order, named in the user's language.
  static List<_ToolEntry> _tools(AppLocalizations l) => [
    (
      tool: HomeTool.level,
      title: l.toolLevel,
      subtitle: l.toolLevelSubtitle,
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: HomeTool.angle,
      title: l.toolAngle,
      subtitle: l.toolAngleSubtitle,
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: HomeTool.compass,
      title: l.toolCompass,
      subtitle: l.toolCompassSubtitle,
      needs: [SensorKind.accelerometer, SensorKind.magnetometer],
    ),
    (
      tool: HomeTool.protractor,
      title: l.toolProtractor,
      subtitle: l.toolProtractorSubtitle,
      needs: [],
    ),
    (
      tool: HomeTool.ruler,
      title: l.toolRuler,
      subtitle: l.toolRulerSubtitle,
      needs: [],
    ),
    (
      tool: HomeTool.metal,
      title: l.toolMetal,
      subtitle: l.toolMetalSubtitle,
      needs: [SensorKind.accelerometer, SensorKind.magnetometer],
    ),
    (
      tool: HomeTool.vibration,
      title: l.toolVibration,
      subtitle: l.toolVibrationSubtitle,
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: HomeTool.sound,
      title: l.toolSound,
      subtitle: l.toolSoundSubtitle,
      needs: [SensorKind.microphone],
    ),
    // iPhones have a light sensor, but Apple doesn't let apps read it.
    if (defaultTargetPlatform != TargetPlatform.iOS)
      (
        tool: HomeTool.light,
        title: l.toolLight,
        subtitle: l.toolLightSubtitle,
        needs: [SensorKind.light],
      ),
    (
      tool: HomeTool.altimeter,
      title: l.toolAltimeter,
      subtitle: l.toolAltimeterSubtitle,
      needs: [SensorKind.barometer],
    ),
    (
      tool: HomeTool.height,
      title: l.toolHeight,
      subtitle: l.toolHeightSubtitle,
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: HomeTool.camera,
      title: l.toolCamera,
      subtitle: l.toolCameraSubtitle,
      needs: [SensorKind.accelerometer, SensorKind.camera],
    ),
    (
      tool: HomeTool.gforce,
      title: l.toolGForce,
      subtitle: l.toolGForceSubtitle,
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: HomeTool.speed,
      title: l.toolSpeed,
      subtitle: l.toolSpeedSubtitle,
      needs: [SensorKind.gps],
    ),
    // ARCore only: not built for iPhone (ARKit) yet. Phones without ARCore
    // show it as unavailable, like any missing sensor.
    if (_tapeReady && defaultTargetPlatform == TargetPlatform.android)
      (
        tool: HomeTool.tape,
        title: l.toolTape,
        subtitle: l.toolTapeSubtitle,
        needs: [SensorKind.camera, SensorKind.ar],
      ),
  ];

  /// Sensors [t] needs that this device lacks.
  List<SensorKind> _missing(_ToolEntry t) => t.needs
      .where(
        (k) =>
            widget.missingSensors.contains(k) || (k == SensorKind.ar && _noAr),
      )
      .toList();

  /// Opens the tool, or explains why it can't work on this device.
  void _tap(_ToolEntry t) {
    final missing = _missing(t);
    if (missing.isEmpty) {
      _openTool(t.tool);
    } else {
      showUnavailableSheet(context, tool: t.title, missing: missing);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final palette = Palette.of(context);
    return ToolFrame(
      title: context.l10n.homeTitle,
      leading: IconButton(
        tooltip: context.l10n.settings,
        icon: Icon(Icons.tune_rounded, color: palette.ink),
        onPressed: () => showSettingsSheet(context, settings),
      ),
      trailing: ThemeToggle(settings: settings),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _Backdrop(palette))),
          // The list scrolls in the space below the header (88 below the
          // status bar), never under it.
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 88,
            ),
            child: SafeArea(
              top: false,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: ListenableBuilder(
                      listenable: settings,
                      builder: (context, _) {
                        final grid = settings.homeLayout == HomeLayout.grid;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                // Shrinks with an ellipsis rather than
                                // pushing the switch off in long languages.
                                Expanded(
                                  child: Text(
                                    context.l10n.tools,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: palette.label,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SoftSwitch<HomeLayout>(
                                  value: settings.homeLayout,
                                  onChanged: settings.setHomeLayout,
                                  options: [
                                    SoftSwitchOption(
                                      value: HomeLayout.list,
                                      icon: Icons.view_agenda_outlined,
                                      tooltip: context.l10n.listView,
                                    ),
                                    SoftSwitchOption(
                                      value: HomeLayout.grid,
                                      icon: Icons.grid_view_rounded,
                                      tooltip: context.l10n.gridView,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 22),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: grid ? _grid() : _list(context),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context) => Column(
    key: const ValueKey('list'),
    mainAxisSize: MainAxisSize.min,
    spacing: 18,
    children: [
      for (final t in _tools(context.l10n))
        ToolTile(
          tool: t.tool,
          title: t.title,
          subtitle: t.subtitle,
          available: _missing(t).isEmpty,
          onTap: () => _tap(t),
        ),
    ],
  );

  /// Rows of three round buttons, each cell a third of the width.
  Widget _grid() => LayoutBuilder(
    key: const ValueKey('grid'),
    builder: (context, constraints) => Wrap(
      runSpacing: 26,
      children: [
        for (final t in _tools(context.l10n))
          SizedBox(
            width: constraints.maxWidth / 3,
            child: ToolButton(
              tool: t.tool,
              title: t.title,
              available: _missing(t).isEmpty,
              onTap: () => _tap(t),
            ),
          ),
      ],
    ),
  );
}

/// The design's large soft circle, behind the tools.
class _Backdrop extends CustomPainter {
  const _Backdrop(this.palette);

  final Palette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final s = DialGeometry.scaleFor(size, reserved: 200);
    paintHalo(
      canvas,
      size.center(Offset.zero) + Offset(0, DialGeometry.haloDy * s),
      DialGeometry.haloR * s,
      palette,
    );
  }

  @override
  bool shouldRepaint(_Backdrop old) => old.palette != palette;
}
