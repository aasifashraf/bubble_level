import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/angles.dart';
import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
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

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolLevel,
    steps: [
      l.levelHelp1,
      l.levelHelp2,
      l.levelHelp3,
      l.levelHelp4,
      l.levelHelp5,
    ],
    tip: l.levelTip,
  );

  /// What to do, in words: which side is high or which way to turn.
  static (IconData, String) _guidance(AppLocalizations l, LevelState state) {
    if (state.isLevel) return (Icons.check_circle_rounded, l.statusLevel);
    if (state.mode == LevelMode.edge) {
      // Positive deviation: the left end has dropped; turn clockwise.
      return state.deviation > 0
          ? (Icons.rotate_right_rounded, l.leftEndLow)
          : (Icons.rotate_left_rounded, l.rightEndLow);
    }
    if (state.roll.abs() >= state.pitch.abs()) {
      return state.roll > 0
          ? (Icons.arrow_forward_rounded, l.rightSideHigh)
          : (Icons.arrow_back_rounded, l.leftSideHigh);
    }
    return state.pitch > 0
        ? (Icons.arrow_upward_rounded, l.topEdgeHigh)
        : (Icons.arrow_downward_rounded, l.bottomEdgeHigh);
  }

  /// Calibrates at once; once calibrated, offers calibrating again or going
  /// back to the factory zero (as the Ruler's Calibrate does).
  Future<void> _calibrateOrReset(BuildContext context) async {
    if (!viewModel.calibrated) return _calibrate(context);
    final l = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final action = await showOptionsSheet<VoidCallback>(
      context,
      title: l.calibrate,
      options: [
        (
          value: () => _calibrate(context),
          icon: Icons.tune_rounded,
          title: l.calibrateHere,
          subtitle: l.calibrateHereInfo,
          enabled: true,
        ),
        (
          value: () async {
            await viewModel.resetCalibration();
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(l.calibrationRemoved)));
          },
          icon: Icons.restart_alt_rounded,
          title: l.resetCalibration,
          subtitle: l.resetCalibrationHint,
          enabled: true,
        ),
      ],
    );
    if (context.mounted) action?.call();
  }

  Future<void> _calibrate(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final l = context.l10n;
    final result = await viewModel.calibrate();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(switch (result) {
            CalibrationResult.done => l.calibrated,
            CalibrationResult.notLevel => l.tooFarToCalibrate,
            CalibrationResult.noData => l.waitingForSensors,
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
          title: context.l10n.toolLevel,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
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
              child: _tube(context, state, compact: true),
            )
          : _dial(context, state);
    }
    final top = ToolFrame.contentTop(context);
    return Stack(
      children: [
        Positioned.fill(
          child: tube
              ? Padding(
                  padding: EdgeInsets.only(top: top + 56, bottom: 90),
                  child: _tube(context, state, compact: false),
                )
              : _dial(context, state),
        ),
        // At the end side, so it moves to the left in right-to-left
        // languages, as the other tools' switches do.
        PositionedDirectional(
          top: top + 4,
          end: 20,
          child: _styleSwitch(context),
        ),
      ],
    );
  }

  Widget _styleSwitch(BuildContext context) => SoftSwitch<LevelStyle>(
    value: viewModel.style,
    onChanged: viewModel.setStyle,
    options: [
      SoftSwitchOption(
        value: LevelStyle.dial,
        icon: Icons.adjust_rounded,
        tooltip: context.l10n.dialView,
      ),
      SoftSwitchOption(
        value: LevelStyle.tube,
        icon: Icons.straighten_rounded,
        tooltip: context.l10n.tubeView,
      ),
    ],
  );

  /// Classic spirit-level tubes: one along the edge the phone stands on, or
  /// two (left/right and forward/back) when it lies flat, like a torpedo
  /// level. Each bubble floats toward the high end.
  ///
  /// In a [compact] (landscape) box the reading takes a slim top row, so the
  /// tubes get the full height below it.
  Widget _tube(
    BuildContext context,
    LevelState state, {
    required bool compact,
  }) {
    final l = context.l10n;
    final flat = state.mode == LevelMode.flat;
    final value = formatAngle(state.angle, viewModel.unit);
    const range = LevelViewModel.bubbleRange;
    const gap = LevelViewModel.tolerance / range;
    final locked = state.isLevel;
    final reading = _TubeReading(value: value, locked: locked);
    // The screen never turns by itself (the header's rotate button does
    // that), so on its side the edge tube runs along the screen's length
    // to stay level in the world; the bubble's direction follows suit.
    final turns = (state.quadrant ~/ 90) % 4;
    final upright = turns.isEven;
    final edgePosition = switch (turns) {
      0 || 3 => state.deviation,
      _ => -state.deviation,
    };

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
        final length = math.min(
          upright ? box.maxWidth - 48 : height - 48,
          560.0,
        );
        final thick = (length * 0.2).clamp(52.0, 84.0);
        return SizedBox(
          width: upright ? length : thick,
          height: upright ? thick : length,
          child: vial(edgePosition, l.levelTube, vertical: !upright),
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
            child: vial(state.roll, l.leftRightTube),
          ),
          SizedBox(
            width: thick,
            height: math.max(120, math.min(height, box.maxWidth * 0.8)),
            child: vial(state.pitch, l.forwardBackTube, vertical: true),
          ),
        ],
      );
    }

    // Scales down rather than overflowing in a very small box.
    Widget fit(Widget child) => Center(
      child: FittedBox(fit: BoxFit.scaleDown, child: child),
    );

    return Semantics(
      label: flat ? l.tiltFromLevel(value) : l.fromLevel(value),
      child: compact
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
    );
  }

  Widget _dial(BuildContext context, LevelState state) {
    final l = context.l10n;
    final flat = state.mode == LevelMode.flat;
    final value = formatAngle(state.angle, viewModel.unit);
    // Drawn in the screen's frame (it only turns with the header's rotate
    // button), so the water line sits at the edge's full angle: the
    // deviation from the nearest side plus that side's quadrant.
    final water = state.deviation + state.quadrant;
    return InstrumentDial(
      value: value,
      semanticsLabel: flat ? l.tiltFromLevel(value) : l.fromLevel(value),
      labels: !flat,
      locked: state.isLevel,
      bubble: flat ? state.bubble : null,
      waterAngle: flat ? null : water,
      // The ball rides the well where the level line meets it.
      ballAngle: flat ? null : 90 + water,
      reserved: 200,
    );
  }

  Widget _footer(BuildContext context, LevelState state) {
    final l = context.l10n;
    final (icon, guidance) = _guidance(l, state);
    final unit = viewModel.unit;
    final flat = state.mode == LevelMode.flat;
    // Flat: X = left/right tilt, Y = forward/back tilt. On an edge the
    // same tiles show the angle and the slope: in the user's unit, or as a
    // percentage when that unit is degrees (the angle tile has those).
    final tiles = flat
        ? [
            (l.xLeftRight, formatAngle(state.roll, unit, signed: true)),
            (l.yForwardBack, formatAngle(state.pitch, unit, signed: true)),
          ]
        : [
            (l.angle, formatDelta(state.deviation)),
            (
              l.slope,
              formatAngle(
                state.angle,
                unit == AngleUnit.degrees ? AngleUnit.percent : unit,
              ),
            ),
          ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Landscape: the view switch heads the controls column.
        if (ToolFrame.sideBySide(context)) ...[
          _styleSwitch(context),
          const SizedBox(height: 16),
        ],
        ValueTiles([for (final (caption, value) in tiles) (value, caption)]),
        const SizedBox(height: 16),
        StatusBanner(
          icon: viewModel.locked ? Icons.lock_rounded : icon,
          text: viewModel.locked ? l.locked(guidance) : guidance,
          tone: state.isLevel ? StatusTone.success : StatusTone.neutral,
        ),
        const SizedBox(height: 16),
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: LockButton(
                locked: viewModel.locked,
                onPressed: viewModel.toggleLock,
                wide: true,
              ),
            ),
            Expanded(
              child: SoftButton(
                label: l.calibrate,
                icon: Icons.tune_rounded,
                onPressed: () => _calibrateOrReset(context),
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
          textDirection: TextDirection.ltr,
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
