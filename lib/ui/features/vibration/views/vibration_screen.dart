import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/vibration_view_model.dart';

/// Vibration meter: live level on a 0–12 m/s² gauge, peak and average, and
/// a graph of the last few seconds.
class VibrationScreen extends StatelessWidget {
  const VibrationScreen({
    super.key,
    required this.viewModel,
    required this.settings,
    required this.onBack,
  });

  final VibrationViewModel viewModel;
  final SettingsRepository settings;
  final VoidCallback onBack;

  static const _scaleMax = 12.0;
  static const _scale = [
    '0', '1', '2', '3', '4', '5', //
    '6', '7', '8', '9', '10', '11',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final r = viewModel.reading;
        final sweep = (r.current / _scaleMax).clamp(0.0, 0.999) * 360;
        final (icon, text) = switch (viewModel.level) {
          VibrationLevel.still => (Icons.check_circle_rounded, 'Still'),
          VibrationLevel.light => (Icons.vibration_rounded, 'Light vibration'),
          VibrationLevel.strong => (
            Icons.warning_amber_rounded,
            'Strong vibration',
          ),
        };
        final ready = r.history.isNotEmpty;
        return ToolFrame(
          title: 'Vibration',
          settings: settings,
          onBack: onBack,
          bodyBottomInset: 190,
          body: SensorStateGate(
            state: r.state,
            ready: ready,
            missingText:
                'This device can’t measure motion, so the vibration meter '
                'isn’t available.',
            child: InstrumentDial(
              value: r.current.toStringAsFixed(1),
              label: 'm/s²',
              semanticsLabel:
                  'Vibration ${r.current.toStringAsFixed(1)} metres per '
                  'second squared',
              scaleLabels: _scale,
              arcSweep: sweep,
              ballAngle: sweep,
              locked: viewModel.level == VibrationLevel.strong,
              reserved: 200,
            ),
          ),
          footer: !ready
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: ValueTile(
                            value: formatAcceleration(r.peak),
                            caption: 'Peak',
                          ),
                        ),
                        Expanded(
                          child: ValueTile(
                            value: formatAcceleration(r.rms),
                            caption: 'Average',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _Graph(values: r.history),
                    const SizedBox(height: 14),
                    StatusBanner(icon: icon, text: text),
                    const SizedBox(height: 14),
                    SoftButton(
                      label: 'Reset peak',
                      icon: Icons.restart_alt_rounded,
                      onPressed: viewModel.resetPeak,
                    ),
                  ],
                ),
        );
      },
    );
  }
}

/// The last few seconds of vibration as a soft orange line.
class _Graph extends StatelessWidget {
  const _Graph({required this.values});

  final List<double> values;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: softSurface(p, radius: BorderRadius.circular(20)),
      child: Semantics(
        label: 'Vibration graph',
        child: CustomPaint(
          size: Size.infinite,
          painter: _GraphPainter(values: values, color: p.ballDark),
        ),
      ),
    );
  }
}

class _GraphPainter extends CustomPainter {
  _GraphPainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    // Scale to the larger of the recent maximum and a floor, so a still
    // phone draws a calm, low line rather than amplified noise.
    final top = math.max(values.reduce(math.max), 1.0);
    final dx = size.width / (values.length - 1);
    final line = Path();
    for (final (i, v) in values.indexed) {
      final point = Offset(i * dx, size.height * (1 - v / top));
      i == 0
          ? line.moveTo(point.dx, point.dy)
          : line.lineTo(point.dx, point.dy);
    }
    final fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas
      ..drawPath(
        fill,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0)],
          ).createShader(Offset.zero & size),
      )
      ..drawPath(
        line,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round
          ..color = color,
      );
  }

  @override
  bool shouldRepaint(_GraphPainter old) =>
      old.values != values || old.color != color;
}
