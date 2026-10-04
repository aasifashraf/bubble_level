import 'package:flutter/material.dart';

import 'theme.dart';
import 'tool_frame.dart';

/// One choice in a [SoftSwitch].
typedef SoftSwitchOption<T> = ({T value, IconData icon, String tooltip});

/// A soft raised pill holding a few icon choices, the selected one pressed
/// in: home's list/grid switch and the Level tool's dial/tube switch.
class SoftSwitch<T> extends StatelessWidget {
  const SoftSwitch({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final T value;
  final List<SoftSwitchOption<T>> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return DecoratedBox(
      decoration: softSurface(p, radius: BorderRadius.circular(26)),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final o in options)
              Semantics(
                selected: o.value == value,
                child: IconButton(
                  tooltip: o.tooltip,
                  onPressed: () => onChanged(o.value),
                  style: IconButton.styleFrom(
                    backgroundColor: o.value == value
                        ? p.ink.withValues(alpha: p.isDark ? 0.14 : 0.08)
                        : Colors.transparent,
                  ),
                  icon: Icon(
                    o.icon,
                    size: 20,
                    color: o.value == value ? p.ink : p.label,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
