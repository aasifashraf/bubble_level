import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/repositories/barometer_repository.dart';
import '../../data/repositories/orientation_repository.dart';
import '../../data/repositories/review_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/vibration_repository.dart';
import '../../data/services/motion_sensor_service.dart';
import '../../data/services/sensor_availability_service.dart';
import '../../data/services/sound_service.dart';
import '../core/dial.dart';
import '../core/help.dart';
import '../core/sensor_view_model.dart';
import '../core/soft_switch.dart';
import '../core/theme.dart';
import '../core/theme_toggle.dart';
import '../core/tool_frame.dart';
import '../features/altimeter/view_models/altimeter_view_model.dart';
import '../features/altimeter/views/altimeter_screen.dart';
import '../features/angle/view_models/angle_view_model.dart';
import '../features/angle/views/angle_screen.dart';
import '../features/compass/view_models/compass_view_model.dart';
import '../features/compass/views/compass_screen.dart';
import '../features/level/view_models/level_view_model.dart';
import '../features/level/views/level_screen.dart';
import '../features/metal/view_models/metal_view_model.dart';
import '../features/metal/views/metal_screen.dart';
import '../features/protractor/view_models/protractor_view_model.dart';
import '../features/protractor/views/protractor_screen.dart';
import '../features/settings/views/settings_sheet.dart';
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

  /// Feeds the vibration and pressure sensors (orientation has its own).
  final MotionSensorService sensors;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
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
  late final _protractor = ProtractorViewModel();
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
  late final _barometerRepo = BarometerRepository(sensors: widget.sensors);
  late final _altimeter = AltimeterViewModel(repository: _barometerRepo);

  @override
  void dispose() {
    for (final vm in [_level, _angle, _compass, _metal]) {
      vm.dispose();
    }
    _protractor.dispose();
    _vibration.dispose();
    _altimeter.dispose();
    _vibrationRepo.dispose();
    _barometerRepo.dispose();
    super.dispose();
  }

  /// Opens a tool full screen; its view model (if it uses sensors) follows
  /// them only while the tool is showing.
  Future<void> _open(ActiveViewModel? vm, WidgetBuilder page) async {
    vm?.active = true;
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: page));
    vm?.active = false;
  }

  void _openTool(HomeTool tool) {
    void back() => Navigator.of(context).pop();
    switch (tool) {
      case HomeTool.level:
        _open(_level, (_) => LevelScreen(viewModel: _level, onBack: back));
      case HomeTool.angle:
        _open(_angle, (_) => AngleScreen(viewModel: _angle, onBack: back));
      case HomeTool.compass:
        _open(
          _compass,
          (_) => CompassScreen(viewModel: _compass, onBack: back),
        );
      case HomeTool.protractor:
        _open(
          null,
          (_) => ProtractorScreen(viewModel: _protractor, onBack: back),
        );
      case HomeTool.metal:
        _open(_metal, (_) => MetalScreen(viewModel: _metal, onBack: back));
      case HomeTool.vibration:
        _open(
          _vibration,
          (_) => VibrationScreen(viewModel: _vibration, onBack: back),
        );
      case HomeTool.altimeter:
        _open(
          _altimeter,
          (_) => AltimeterScreen(viewModel: _altimeter, onBack: back),
        );
    }
  }

  static const List<_ToolEntry> _tools = [
    (
      tool: HomeTool.level,
      title: 'Level',
      subtitle: 'Bubble and spirit level',
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: HomeTool.angle,
      title: 'Angle',
      subtitle: 'Angle from level or from a zero',
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: HomeTool.compass,
      title: 'Compass',
      subtitle: 'Heading and direction',
      needs: [SensorKind.accelerometer, SensorKind.magnetometer],
    ),
    (
      tool: HomeTool.protractor,
      title: 'Protractor',
      subtitle: 'Measure angles on the screen',
      needs: [],
    ),
    (
      tool: HomeTool.metal,
      title: 'Metal detector',
      subtitle: 'Find iron, steel and magnets',
      needs: [SensorKind.accelerometer, SensorKind.magnetometer],
    ),
    (
      tool: HomeTool.vibration,
      title: 'Vibration',
      subtitle: 'Vibration meter with live graph',
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: HomeTool.altimeter,
      title: 'Altimeter',
      subtitle: 'Air pressure and height',
      needs: [SensorKind.barometer],
    ),
  ];

  /// Sensors [t] needs that this device lacks.
  List<SensorKind> _missing(_ToolEntry t) =>
      t.needs.where(widget.missingSensors.contains).toList();

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
      title: 'Bubble Level',
      leading: IconButton(
        tooltip: 'Settings',
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
                                Text(
                                  'Tools',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: palette.label,
                                  ),
                                ),
                                const Spacer(),
                                SoftSwitch<HomeLayout>(
                                  value: settings.homeLayout,
                                  onChanged: settings.setHomeLayout,
                                  options: const [
                                    (
                                      value: HomeLayout.list,
                                      icon: Icons.view_agenda_outlined,
                                      tooltip: 'List view',
                                    ),
                                    (
                                      value: HomeLayout.grid,
                                      icon: Icons.grid_view_rounded,
                                      tooltip: 'Grid view',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 22),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: grid ? _grid() : _list(),
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

  Widget _list() => Column(
    key: const ValueKey('list'),
    mainAxisSize: MainAxisSize.min,
    spacing: 18,
    children: [
      for (final t in _tools)
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
        for (final t in _tools)
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
