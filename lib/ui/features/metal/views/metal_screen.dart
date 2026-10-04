import 'package:flutter/material.dart';

import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/metal_view_model.dart';

/// Metal detector: field strength on a 0–240 µT gauge; the button turns
/// orange when metal is detected.
class MetalScreen extends StatelessWidget {
  const MetalScreen({super.key, required this.viewModel, required this.onBack});

  final MetalViewModel viewModel;
  final VoidCallback onBack;

  static const _help = ToolHelp(
    tool: 'Metal detector',
    steps: [
      'Open the tool away from metal. That first reading counts as “no metal”.',
      'Move the phone slowly over the area. The sensor is usually near the top of the phone.',
      '“Metal nearby” means a small change. “Metal detected” means a strong one: the centre turns orange and the phone buzzes if vibration is on.',
      'If it shows metal with nothing there, move away from metal and tap Set baseline.',
    ],
    tip: 'It only senses iron, steel and magnets, not aluminium, copper, gold or silver. Magnetic phone cases affect it.',
  );

  static const _scaleMax = 240.0;
  static const _scale = [
    '0', '20', '40', '60', '80', '100', //
    '120', '140', '160', '180', '200', '220',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        return ToolFrame(
          title: 'Metal detector',
          onBack: onBack,
          trailing: const HelpButton(help: _help),
          bodyBottomInset: 120,
          body: SensorGate(
            reading: viewModel.reading,
            needsMagnetometer: true,
            child: state == null ? const SizedBox.shrink() : _dial(state),
          ),
          footer: state == null ? null : _footer(context, state),
        );
      },
    );
  }

  Widget _dial(MetalState state) {
    final sweep = (state.field / _scaleMax).clamp(0.0, 0.999) * 360;
    return InstrumentDial(
      value: '${state.field.round()}',
      label: 'µT',
      semanticsLabel: 'Magnetic field ${state.field.round()} microtesla',
      scaleLabels: _scale,
      arcSweep: sweep,
      ballAngle: sweep,
      locked: state.level == MetalLevel.detected,
      reserved: 200,
    );
  }

  Widget _footer(BuildContext context, MetalState state) {
    final (icon, text) = switch (state.level) {
      MetalLevel.clear => (Icons.check_circle_rounded, 'No metal nearby'),
      MetalLevel.nearby => (Icons.sensors_rounded, 'Metal nearby'),
      MetalLevel.detected => (Icons.warning_amber_rounded, 'Metal detected'),
    };
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: ValueTile(
                value: formatMicroTesla(state.field),
                caption: 'Field',
              ),
            ),
            Expanded(
              child: ValueTile(
                value: formatMicroTesla(state.change, signed: true),
                caption: 'Change',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        StatusBanner(icon: icon, text: text),
        const SizedBox(height: 4),
        Text(
          'Finds iron, steel and magnets',
          style: TextStyle(fontSize: 12, color: Palette.of(context).label),
        ),
        const SizedBox(height: 14),
        SoftButton(
          label: 'Set baseline',
          icon: Icons.my_location_rounded,
          onPressed: viewModel.setBaseline,
        ),
      ],
    );
  }
}
