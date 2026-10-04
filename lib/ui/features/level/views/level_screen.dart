import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/angles.dart';
import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/readout.dart';
import '../../../core/soft_switch.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../../../core/vial.dart';
import '../view_models/level_view_model.dart';

/// Bubble level when the phone lies flat, water-line inclinometer when it
/// stands on an edge; the compass design with a glass bubble or a level line,
/// or (the user's choice) classic spirit-level tubes.
class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key, required this.viewModel, required this.onBack});

  final LevelViewModel viewModel;
  final VoidCallback onBack;

  static const _help = ToolHelp(
    tool: 'Level',
    steps: [
      'Lay the phone flat on the surface, or stand it on one of its edges.',
      'Flat: centre the bubble. X is left/right tilt, Y is forward/back tilt. On an edge, you see the angle and slope.',
      'Follow the hint on screen (for example “Right side high”) until it reads level: it turns orange and the phone chimes and buzzes (turn these off in Settings).',
      'Tap Hold to freeze the reading, and Release to go live again.',
      'Prefer a classic spirit level? Tap the tube icon in the switch; '
          'the round icon brings the dial back.',
    ],
    tip: 'If a surface you know is level doesn’t read 0°, put the phone on it and tap Calibrate. You can undo this in Settings.',
  );

  /// What to do, in words: which side is high or which way to turn.
  static (IconData, String) _guidance(LevelState state) {
    if (state.isLevel) return (Icons.check_circle_rounded, 'Level');
    if (state.mode == LevelMode.edge) {
      // Positive deviation: the left end has dropped; turn clockwise.
      return state.deviation > 0
          ? (Icons.rotate_right_rounded, 'Left end low')
          : (Icons.rotate_left_rounded, 'Right end low');
    }
    if (state.roll.abs() >= state.pitch.abs()) {
      return state.roll > 0
          ? (Icons.arrow_forward_rounded, 'Right side high')
          : (Icons.arrow_back_rounded, 'Left side high');
    }
    return state.pitch > 0
        ? (Icons.arrow_upward_rounded, 'Top edge high')
        : (Icons.arrow_downward_rounded, 'Bottom edge high');
  }

  Future<void> _calibrate(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await viewModel.calibrate();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(switch (result) {
            CalibrationResult.done => 'Calibrated. This position now reads 0°.',
            CalibrationResult.notLevel =>
              'Too far from level to calibrate. Place the phone on a level '
                  'surface first.',
            CalibrationResult.noData => 'Waiting for sensors…',
          }),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        return ToolFrame(
          title: 'Level',
          onBack: onBack,
          trailing: const HelpButton(help: _help),
          body: SensorGate(
            reading: viewModel.reading,
            child: state == null
                ? const SizedBox.shrink()
                : _instrument(context, state),
          ),
          footer: state == null ? null : _footer(context, state),
          bodyBottomInset: 120,
        );
      },
    );
  }

  /// Dial or tube. Portrait: the switch sits under the header, top right.
  /// Landscape: the body is already below the header and the switch moves
  /// to the controls column (see [_footer]), so the instrument has the
  /// whole left side.
  Widget _instrument(BuildContext context, LevelState state) {
    final tube = viewModel.style == LevelStyle.tube;
    if (ToolFrame.sideBySide(context)) {
      return tube
          ? Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: _tube(state, compact: true),
            )
          : _dial(state);
    }
    final top = MediaQuery.paddingOf(context).top + ToolFrame.headerHeight;
    return Stack(
      children: [
        Positioned.fill(
          child: tube
              ? Padding(
                  padding: EdgeInsets.only(top: top + 56, bottom: 90),
                  child: _tube(state, compact: false),
                )
              : _dial(state),
        ),
        Positioned(top: top + 4, right: 20, child: _styleSwitch()),
      ],
    );
  }

  Widget _styleSwitch() => SoftSwitch<LevelStyle>(
    value: viewModel.style,
    onChanged: viewModel.setStyle,
    options: const [
      (
        value: LevelStyle.dial,
        icon: Icons.adjust_rounded,
        tooltip: 'Dial view',
      ),
      (
        value: LevelStyle.tube,
        icon: Icons.straighten_rounded,
        tooltip: 'Tube view',
      ),
    ],
  );

  /// Classic spirit-level tubes: one along the edge the phone stands on, or
  /// two (left/right and forward/back) when it lies flat, like a torpedo
  /// level. Each bubble floats toward the high end.
  ///
  /// In a [compact] (landscape) box the reading takes a slim top row, so the
  /// tubes get the full height below it.
  Widget _tube(LevelState state, {required bool compact}) {
    final flat = state.mode == LevelMode.flat;
    final value = formatAngle(state.angle, viewModel.unit);
    const range = LevelViewModel.bubbleRange;
    const gap = LevelViewModel.tolerance / range;
    final locked = state.isLevel;
    final turns = (state.quadrant ~/ 90) % 4;
    // Turned a quarter, the top row would run down the side: stack instead.
    final beside = compact && turns.isEven;
    final reading = _TubeReading(value: value, locked: locked);

    SpiritVial vial(double degrees, String label, {bool vertical = false}) =>
        SpiritVial(
          position: degrees / range,
          semanticsLabel: label,
          vertical: vertical,
          markGap: gap,
          locked: locked,
        );

    /// The tubes sized to [box], leaving [below] for anything stacked above.
    Widget tubes(BoxConstraints box, double below) {
      final height = box.maxHeight - below;
      if (!flat) {
        final length = math.min(box.maxWidth - 48, 560.0);
        return SizedBox(
          width: length,
          height: (length * 0.2).clamp(52.0, 84.0),
          child: vial(state.deviation, 'Level tube'),
        );
      }
      final thick = (math.min(box.maxWidth, height) * 0.17).clamp(48.0, 80.0);
      final across = math.max(120.0, box.maxWidth - 72 - thick);
      return Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          SizedBox(
            width: math.min(across, 520),
            height: thick,
            child: vial(state.roll, 'Left and right tube'),
          ),
          SizedBox(
            width: thick,
            height: math.max(120, math.min(height, box.maxWidth * 0.8)),
            child: vial(state.pitch, 'Forward and back tube', vertical: true),
          ),
        ],
      );
    }

    // Scales down rather than overflowing in a very small box.
    Widget fit(Widget child) => Center(
      child: FittedBox(fit: BoxFit.scaleDown, child: child),
    );

    return RotatedBox(
      quarterTurns: turns,
      child: Semantics(
        label: '${flat ? 'Tilt from level' : 'From level'} $value',
        child: beside
            ? Column(
                children: [
                  SizedBox(height: 52, child: fit(reading)),
                  const SizedBox(height: 12),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, box) => fit(tubes(box, 0)),
                    ),
                  ),
                ],
              )
            : LayoutBuilder(
                builder: (context, box) => fit(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      reading,
                      const SizedBox(height: 24),
                      tubes(box, 80),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _dial(LevelState state) {
    final flat = state.mode == LevelMode.flat;
    final value = formatAngle(state.angle, viewModel.unit);
    // Standing on its side, the dial turns so the reading stays upright
    // even with auto-rotate off.
    return RotatedBox(
      quarterTurns: (state.quadrant ~/ 90) % 4,
      child: InstrumentDial(
        value: value,
        semanticsLabel: '${flat ? 'Tilt from level' : 'From level'} $value',
        labels: !flat,
        locked: state.isLevel,
        bubble: flat ? state.bubble : null,
        waterAngle: flat ? null : state.deviation,
        // The ball rides the well where the level line meets it.
        ballAngle: flat ? null : 90 + state.deviation,
        reserved: 200,
      ),
    );
  }

  Widget _footer(BuildContext context, LevelState state) {
    final (icon, guidance) = _guidance(state);
    final unit = viewModel.unit;
    final flat = state.mode == LevelMode.flat;
    // Flat: X = left/right tilt, Y = forward/back tilt. On an edge the
    // same tiles show the angle and the slope.
    final tiles = flat
        ? [
            ('X · left / right', formatAngle(state.roll, unit, signed: true)),
            (
              'Y · forward / back',
              formatAngle(state.pitch, unit, signed: true),
            ),
          ]
        : [
            ('Angle', formatDelta(state.deviation)),
            ('Slope', formatAngle(state.angle, AngleUnit.percent)),
          ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Landscape: the view switch heads the controls column.
        if (ToolFrame.sideBySide(context)) ...[
          _styleSwitch(),
          const SizedBox(height: 16),
        ],
        Row(
          spacing: 14,
          children: [
            for (final (caption, value) in tiles)
              Expanded(
                child: ValueTile(value: value, caption: caption),
              ),
          ],
        ),
        const SizedBox(height: 16),
        StatusBanner(
          icon: viewModel.held ? Icons.pause_circle_rounded : icon,
          text: viewModel.held ? 'Held · $guidance' : guidance,
        ),
        const SizedBox(height: 16),
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: SoftButton(
                label: viewModel.held ? 'Release' : 'Hold',
                icon: viewModel.held
                    ? Icons.play_arrow_rounded
                    : Icons.pause_rounded,
                onPressed: viewModel.toggleHold,
              ),
            ),
            Expanded(
              child: SoftButton(
                label: 'Calibrate',
                icon: Icons.tune_rounded,
                onPressed: () => _calibrate(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// The big reading above the tubes, in the dial's number style; orange
/// when level, like the dial's centre.
class _TubeReading extends StatelessWidget {
  const _TubeReading({required this.value, required this.locked});

  final String value;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return SizedBox(
      height: 56,
      child: FittedBox(
        child: Text(
          value,
          maxLines: 1,
          textScaler: TextScaler.noScaling,
          style: TextStyle(
            fontSize: 44,
            height: 1,
            fontWeight: FontWeight.w700,
            fontFeatures: readoutFeatures,
            color: locked ? p.ballDark : p.inkStrong,
          ),
        ),
      ),
    );
  }
}
