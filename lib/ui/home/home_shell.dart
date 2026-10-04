import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/repositories/orientation_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../core/dial.dart';
import '../core/sensor_view_model.dart';
import '../core/theme.dart';
import '../core/tool_frame.dart';
import '../features/angle/view_models/angle_view_model.dart';
import '../features/angle/views/angle_screen.dart';
import '../features/compass/view_models/compass_view_model.dart';
import '../features/compass/views/compass_screen.dart';
import '../features/level/view_models/level_view_model.dart';
import '../features/level/views/level_screen.dart';
import '../features/settings/views/settings_sheet.dart';

enum _Tool { level, angle, compass }

/// Home: the tools as a list (default) or a grid of soft round buttons in
/// the dial's material. Each opens full screen with the back tab; only the
/// open tool follows the sensors.
class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.orientation,
    required this.settings,
  });

  final OrientationRepository orientation;
  final SettingsRepository settings;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late final _level = LevelViewModel(
    orientation: widget.orientation,
    settings: widget.settings,
    onLevelReached: HapticFeedback.selectionClick,
  );
  late final _angle = AngleViewModel(
    orientation: widget.orientation,
    settings: widget.settings,
  );
  late final _compass = CompassViewModel(orientation: widget.orientation);

  @override
  void dispose() {
    _level.dispose();
    _angle.dispose();
    _compass.dispose();
    super.dispose();
  }

  Future<void> _open(SensorViewModel vm, WidgetBuilder page) async {
    vm.active = true;
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: page));
    vm.active = false;
  }

  void _openTool(_Tool tool) {
    final settings = widget.settings;
    void back() => Navigator.of(context).pop();
    switch (tool) {
      case _Tool.level:
        _open(
          _level,
          (_) =>
              LevelScreen(viewModel: _level, settings: settings, onBack: back),
        );
      case _Tool.angle:
        _open(
          _angle,
          (_) =>
              AngleScreen(viewModel: _angle, settings: settings, onBack: back),
        );
      case _Tool.compass:
        _open(
          _compass,
          (_) => CompassScreen(
            viewModel: _compass,
            settings: settings,
            onBack: back,
          ),
        );
    }
  }

  static const _tools = [
    (tool: _Tool.level, title: 'Level', subtitle: 'Bubble and spirit level'),
    (
      tool: _Tool.angle,
      title: 'Angle',
      subtitle: 'Angle from level or from a zero',
    ),
    (tool: _Tool.compass, title: 'Compass', subtitle: 'Heading and direction'),
  ];

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final palette = Palette.of(context);
    return ToolFrame(
      title: 'Bubble Level',
      settings: settings,
      leading: IconButton(
        tooltip: 'Settings',
        icon: Icon(Icons.tune_rounded, color: palette.ink),
        onPressed: () => showSettingsSheet(context, settings),
      ),
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
                                _LayoutSwitch(settings: settings),
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
          onTap: () => _openTool(t.tool),
        ),
    ],
  );

  Widget _grid() => Row(
    key: const ValueKey('grid'),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final t in _tools)
        Expanded(
          child: _ToolButton(
            tool: t.tool,
            title: t.title,
            onTap: () => _openTool(t.tool),
          ),
        ),
    ],
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

/// List / grid switch: a soft pill holding two icons, the current one
/// pressed in.
class _LayoutSwitch extends StatelessWidget {
  const _LayoutSwitch({required this.settings});

  final SettingsRepository settings;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    Widget option(HomeLayout layout, IconData icon, String tooltip) {
      final selected = settings.homeLayout == layout;
      return Semantics(
        selected: selected,
        child: IconButton(
          tooltip: tooltip,
          onPressed: () => settings.setHomeLayout(layout),
          style: IconButton.styleFrom(
            backgroundColor: selected
                ? p.ink.withValues(alpha: p.isDark ? 0.14 : 0.08)
                : Colors.transparent,
          ),
          icon: Icon(icon, size: 20, color: selected ? p.ink : p.label),
        ),
      );
    }

    return DecoratedBox(
      decoration: softSurface(p, radius: BorderRadius.circular(26)),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            option(HomeLayout.list, Icons.view_agenda_outlined, 'List view'),
            option(HomeLayout.grid, Icons.grid_view_rounded, 'Grid view'),
          ],
        ),
      ),
    );
  }
}

/// List row: round icon button, name and description, chevron.
class _ToolTile extends StatelessWidget {
  const _ToolTile({
    required this.tool,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final _Tool tool;
  final String title;
  final String subtitle;
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
                _ToolIcon(tool: tool, size: 60),
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
                          color: p.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: p.label),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: p.label),
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
    required this.onTap,
  });

  final _Tool tool;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      button: true,
      label: title,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ToolIcon(tool: tool, size: 88),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: p.ink,
              ),
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
  const _ToolIcon({required this.tool, required this.size});

  final _Tool tool;
  final double size;

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
        painter: _GlyphPainter(tool: tool, ink: p.ink, accent: p.ballDark),
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
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_GlyphPainter old) =>
      old.tool != tool || old.ink != ink || old.accent != accent;
}
