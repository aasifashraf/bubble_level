import 'package:flutter/material.dart';

import 'controls.dart';
import 'theme.dart';

/// One choice in a [SoftSwitch]: an [icon], a short [label] ("cm"), or a
/// drawn [glyph] (given the colour to draw in) when no icon says it.
@immutable
class SoftSwitchOption<T> {
  const SoftSwitchOption({
    required this.value,
    required this.tooltip,
    this.icon,
    this.label,
    this.glyph,
  });

  final T value;
  final String tooltip;
  final IconData? icon;
  final String? label;
  final Widget Function(Color color)? glyph;
}

/// A soft raised pill holding a few choices, the selected one pressed in:
/// home's list/grid switch, the Level's dial/tube switch, the Ruler's
/// units and the Angle's modes.
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
                  icon: o.glyph != null
                      ? SizedBox.square(
                          dimension: 26,
                          child: o.glyph!(o.value == value ? p.ink : p.label),
                        )
                      : o.icon != null
                      ? Icon(
                          o.icon,
                          size: 20,
                          color: o.value == value ? p.ink : p.label,
                        )
                      : SizedBox(
                          width: 40,
                          child: Text(
                            o.label ?? '',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              // Large text (18.7 px+ bold) so the orange
                              // reads at its 3:1 contrast.
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: o.value == value ? p.accentText : p.label,
                            ),
                          ),
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
