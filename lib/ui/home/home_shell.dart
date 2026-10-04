import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/repositories/barometer_repository.dart';
import '../../data/repositories/orientation_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/vibration_repository.dart';
import '../../data/services/motion_sensor_service.dart';
import '../../data/services/sensor_availability_service.dart';
import '../../data/services/sound_service.dart';
import '../core/dial.dart';
import '../core/help.dart';
import '../core/soft_switch.dart';
import '../core/sensor_view_model.dart';
import '../core/theme.dart';
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
import '../features/vibration/view_models/vibration_view_model.dart';
import '../features/vibration/views/vibration_screen.dart';
import '../features/settings/views/settings_sheet.dart';

enum _Tool { level, angle, compass, protractor, metal, vibration, altimeter }

typedef _ToolEntry = ({
  _Tool tool,
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
  });

  final OrientationRepository orientation;
  final SettingsRepository settings;

  /// Sensors this device lacks; tools that need them are shown as
  /// unavailable and explain why instead of opening.
  final Set<SensorKind> missingSensors;

  /// The level chime and metal detector beep.
  final SoundService sound;

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
  );
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

  void _openTool(_Tool tool) {
    void back() => Navigator.of(context).pop();
    switch (tool) {
      case _Tool.level:
        _open(_level, (_) => LevelScreen(viewModel: _level, onBack: back));
      case _Tool.angle:
        _open(_angle, (_) => AngleScreen(viewModel: _angle, onBack: back));
      case _Tool.compass:
        _open(
          _compass,
          (_) => CompassScreen(viewModel: _compass, onBack: back),
        );
      case _Tool.protractor:
        _open(
          null,
          (_) => ProtractorScreen(viewModel: _protractor, onBack: back),
        );
      case _Tool.metal:
        _open(_metal, (_) => MetalScreen(viewModel: _metal, onBack: back));
      case _Tool.vibration:
        _open(
          _vibration,
          (_) => VibrationScreen(viewModel: _vibration, onBack: back),
        );
      case _Tool.altimeter:
        _open(
          _altimeter,
          (_) => AltimeterScreen(viewModel: _altimeter, onBack: back),
        );
    }
  }

  static const List<_ToolEntry> _tools = [
    (
      tool: _Tool.level,
      title: 'Level',
      subtitle: 'Bubble and spirit level',
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: _Tool.angle,
      title: 'Angle',
      subtitle: 'Angle from level or from a zero',
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: _Tool.compass,
      title: 'Compass',
      subtitle: 'Heading and direction',
      needs: [SensorKind.accelerometer, SensorKind.magnetometer],
    ),
    (
      tool: _Tool.protractor,
      title: 'Protractor',
      subtitle: 'Measure angles on the screen',
      needs: [],
    ),
    (
      tool: _Tool.metal,
      title: 'Metal detector',
      subtitle: 'Find iron, steel and magnets',
      needs: [SensorKind.accelerometer, SensorKind.magnetometer],
    ),
    (
      tool: _Tool.vibration,
      title: 'Vibration',
      subtitle: 'Vibration meter with live graph',
      needs: [SensorKind.accelerometer],
    ),
    (
      tool: _Tool.altimeter,
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
        _ToolTile(
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
            child: _ToolButton(
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

/// List row: round icon button, name and description, chevron.
class _ToolTile extends StatelessWidget {
  const _ToolTile({
    required this.tool,
    required this.title,
    required this.subtitle,
    required this.available,
    required this.onTap,
  });

  final _Tool tool;
  final String title;
  final String subtitle;

  /// False when the device lacks a sensor the tool needs: the row is
  /// dimmed and says so, and tapping explains why.
  final bool available;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final radius = BorderRadius.circular(28);
    return DecoratedBox(
      decoration: softSurface(p, radius: radius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              spacing: 16,
              children: [
                _ToolIcon(tool: tool, size: 60, available: available),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: available ? p.ink : p.label,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        available ? subtitle : 'Not available on this phone',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: p.label),
                      ),
                    ],
                  ),
                ),
                Icon(
                  available
                      ? Icons.chevron_right_rounded
                      : Icons.info_outline_rounded,
                  color: p.label,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Grid cell: a large round icon button with the name underneath.
class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.tool,
    required this.title,
    required this.available,
    required this.onTap,
  });

  final _Tool tool;
  final String title;
  final bool available;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      button: true,
      label: available ? title : '$title, not available on this phone',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToolIcon(tool: tool, size: 88, available: available),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: available ? p.ink : p.label,
              ),
            ),
            if (!available)
              Text(
                'Not on this phone',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(fontSize: 12, color: p.label),
              ),
          ],
        ),
      ),
    );
  }
}

/// A soft raised round button with the tool's line icon, as in the design:
/// light face, bright rim, soft shadow down-right.
class _ToolIcon extends StatelessWidget {
  const _ToolIcon({
    required this.tool,
    required this.size,
    this.available = true,
  });

  final _Tool tool;
  final double size;

  /// Unavailable tools draw their glyph faded, in the label grey.
  final bool available;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: p.isDark
              ? [p.buttonRimTopLeft, p.buttonRimBottomRight]
              : [Colors.white, p.dialDark],
        ),
        border: Border.all(
          color: p.isDark ? Colors.white.withValues(alpha: 0.06) : Colors.white,
          width: size * 0.04,
        ),
        boxShadow: [
          BoxShadow(
            color: p.buttonShadow.withValues(alpha: p.isDark ? 0.8 : 0.9),
            offset: Offset(size * 0.06, size * 0.1),
            blurRadius: size * 0.22,
          ),
        ],
      ),
      child: CustomPaint(
        painter: available
            ? _GlyphPainter(tool: tool, ink: p.ink, accent: p.ballDark)
            : _GlyphPainter(
                tool: tool,
                ink: p.label.withValues(alpha: 0.5),
                accent: p.label.withValues(alpha: 0.5),
              ),
      ),
    );
  }
}

/// Line icons drawn in the design's stroke style.
class _GlyphPainter extends CustomPainter {
  const _GlyphPainter({
    required this.tool,
    required this.ink,
    required this.accent,
  });

  final _Tool tool;
  final Color ink, accent;

  @override
  void paint(Canvas canvas, Size size) {
    // Icons are drawn on a 24-unit grid centred in the button.
    final u = size.shortestSide * 0.46 / 24;
    final c = size.center(Offset.zero);
    canvas
      ..save()
      ..translate(c.dx - 12 * u, c.dy - 12 * u)
      ..scale(u);
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.9
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = ink;
    switch (tool) {
      case _Tool.level:
        // A spirit-level vial with its bubble between the marks.
        canvas
          ..drawRRect(
            RRect.fromLTRBR(1.5, 7.5, 22.5, 16.5, const Radius.circular(4.5)),
            line,
          )
          ..drawLine(const Offset(8, 9.5), const Offset(8, 14.5), line)
          ..drawLine(const Offset(16, 9.5), const Offset(16, 14.5), line)
          ..drawCircle(const Offset(12, 12), 2.2, Paint()..color = accent);
      case _Tool.angle:
        // Two arms meeting at a vertex, with the angle's arc.
        canvas
          ..drawPath(
            Path()
              ..moveTo(21.5, 19.5)
              ..lineTo(3, 19.5)
              ..lineTo(16, 4.5),
            line,
          )
          ..drawArc(
            Rect.fromCircle(center: const Offset(3, 19.5), radius: 8),
            -math.atan2(15, 13),
            math.atan2(15, 13),
            false,
            line,
          )
          ..drawCircle(const Offset(16, 4.5), 1.8, Paint()..color = accent);
      case _Tool.compass:
        // Ring with a two-tone needle, north half in the accent.
        canvas.drawCircle(const Offset(12, 12), 10, line);
        final north = Path()
          ..moveTo(15.8, 8.2)
          ..lineTo(13.4, 13.4)
          ..lineTo(10.6, 10.6)
          ..close();
        final south = Path()
          ..moveTo(8.2, 15.8)
          ..lineTo(10.6, 10.6)
          ..lineTo(13.4, 13.4)
          ..close();
        canvas
          ..drawPath(north, Paint()..color = accent)
          ..drawPath(south, line);
      case _Tool.protractor:
        // Half-circle protractor with ticks and a reading arm.
        const o = Offset(12, 18);
        canvas
          ..drawArc(
            Rect.fromCircle(center: o, radius: 10),
            math.pi,
            math.pi,
            false,
            line,
          )
          ..drawLine(const Offset(1.5, 18), const Offset(22.5, 18), line);
        for (var d = 30; d < 180; d += 30) {
          final a = math.pi + d * math.pi / 180;
          final dir = Offset(math.cos(a), math.sin(a));
          canvas.drawLine(o + dir * 7.5, o + dir * 10, line);
        }
        canvas
          ..drawLine(
            o,
            o + Offset(math.cos(math.pi * 1.33), math.sin(math.pi * 1.33)) * 8,
            line..color = accent,
          )
          ..drawCircle(o, 1.6, Paint()..color = accent);
      case _Tool.metal:
        // Horseshoe magnet with orange poles.
        canvas
          ..drawArc(
            Rect.fromCircle(center: const Offset(12, 12), radius: 7),
            0,
            math.pi,
            false,
            line,
          )
          ..drawLine(const Offset(5, 12), const Offset(5, 7.5), line)
          ..drawLine(const Offset(19, 12), const Offset(19, 7.5), line);
        final pole = Paint()
          ..strokeWidth = 3.4
          ..strokeCap = StrokeCap.round
          ..color = accent;
        canvas
          ..drawLine(const Offset(5, 3.5), const Offset(5, 6), pole)
          ..drawLine(const Offset(19, 3.5), const Offset(19, 6), pole);
      case _Tool.vibration:
        // A phone with vibration marks either side.
        canvas.drawRRect(
          RRect.fromLTRBR(8, 3.5, 16, 20.5, const Radius.circular(2.2)),
          line,
        );
        for (final (x, h) in const [
          (4.5, 4.0),
          (1.5, 2.2),
          (19.5, 4.0),
          (22.5, 2.2),
        ]) {
          canvas.drawLine(Offset(x, 12 - h), Offset(x, 12 + h), line);
        }
        canvas.drawCircle(const Offset(12, 17.4), 1.2, Paint()..color = accent);
      case _Tool.altimeter:
        // Mountain peaks with an orange sun.
        canvas
          ..drawPath(
            Path()
              ..moveTo(1.5, 20)
              ..lineTo(9, 8)
              ..lineTo(13.5, 15)
              ..lineTo(16.5, 11)
              ..lineTo(22.5, 20)
              ..close(),
            line,
          )
          ..drawCircle(const Offset(18.5, 5), 2, Paint()..color = accent);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_GlyphPainter old) =>
      old.tool != tool || old.ink != ink || old.accent != accent;
}
