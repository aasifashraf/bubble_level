import 'package:flutter/material.dart';

import '../core/controls.dart';
import '../core/l10n.dart';
import '../core/theme.dart';
import 'tool_glyphs.dart';

/// List row: round icon button, name and description, chevron.
class ToolTile extends StatelessWidget {
  const ToolTile({
    super.key,
    required this.tool,
    required this.title,
    required this.subtitle,
    required this.available,
    required this.onTap,
  });

  final HomeTool tool;
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
                ToolIcon(tool: tool, size: 60, available: available),
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
                        available ? subtitle : context.l10n.notAvailableOnPhone,
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
class ToolButton extends StatelessWidget {
  const ToolButton({
    super.key,
    required this.tool,
    required this.title,
    required this.available,
    required this.onTap,
  });

  final HomeTool tool;
  final String title;
  final bool available;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      button: true,
      label: available ? title : context.l10n.toolNotAvailableSemantics(title),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ToolIcon(tool: tool, size: 88, available: available),
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
                context.l10n.notOnPhone,
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
class ToolIcon extends StatelessWidget {
  const ToolIcon({
    super.key,
    required this.tool,
    required this.size,
    this.available = true,
  });

  final HomeTool tool;
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
            ? ToolGlyphPainter(tool: tool, ink: p.ink, accent: p.ballDark)
            : ToolGlyphPainter(
                tool: tool,
                ink: p.label.withValues(alpha: 0.5),
                accent: p.label.withValues(alpha: 0.5),
              ),
      ),
    );
  }
}
