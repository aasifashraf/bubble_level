import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/angles.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/level_view_model.dart';

/// Bubble level when the phone lies flat, water-line inclinometer when it
/// stands on an edge; the compass design with a glass bubble or a level line.
class LevelScreen extends StatelessWidget {
  const LevelScreen({
    super.key,
    required this.viewModel,
    required this.settings,
    required this.onBack,
  });

  final LevelViewModel viewModel;
  final SettingsRepository settings;
  final VoidCallback onBack;

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
          settings: settings,
          onBack: onBack,
          body: SensorGate(
            reading: viewModel.reading,
            child: state == null ? const SizedBox.shrink() : _dial(state),
          ),
          footer: state == null ? null : _footer(context, state),
          bodyBottomInset: 120,
        );
      },
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
