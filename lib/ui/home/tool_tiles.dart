import 'package:flutter/material.dart';

import '../core/controls.dart';
import '../core/l10n.dart';
import '../core/theme.dart';
import 'tool_glyphs.dart';

/// A top tool: a soft raised card with the tool's icon, name and what it
/// does. [wide] lays it out across the page (the first top tool); otherwise
/// it stacks for a half-width card.
class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.tool,
    required this.title,
    required this.subtitle,
    required this.available,
    required this.onTap,
    this.wide = false,
  });

  final HomeTool tool;
  final String title;
  final String subtitle;

  /// False when the device lacks a sensor the tool needs: the card is
  /// dimmed and says so, and tapping explains why.
  final bool available;
  final VoidCallback onTap;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final radius = BorderRadius.circular(26);
    final name = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: wide ? 19 : 16,
        fontWeight: FontWeight.w700,
        color: available ? p.inkStrong : p.label,
      ),
    );
    final about = Text(
      available ? subtitle : context.l10n.notAvailableOnPhone,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: wide ? 13 : 12, height: 1.3, color: p.label),
    );
    return Semantics(
      button: true,
      label: available
          ? '$title, $subtitle'
          : context.l10n.toolNotAvailableSemantics(title),
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: softSurface(p, radius: radius),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(wide ? 16 : 14),
              child: wide
                  ? Row(
                      spacing: 14,
                      children: [
                        ToolIcon(tool: tool, size: 64, available: available),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 2,
                            children: [name, about],
                          ),
                        ),
                        Icon(
                          available
                              ? Icons.chevron_right_rounded
                              : Icons.info_outline_rounded,
                          color: p.label,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ToolIcon(tool: tool, size: 50, available: available),
                        const SizedBox(height: 12),
                        name,
                        const SizedBox(height: 2),
                        about,
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Grid cell: a round icon button with the name underneath.
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
            ToolIcon(tool: tool, size: 62, available: available),
            const SizedBox(height: 9),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 13,
                height: 1.2,
                fontWeight: FontWeight.w500,
                color: available ? p.ink : p.label,
              ),
            ),
            if (!available)
              Text(
                context.l10n.notOnPhone,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(fontSize: 11, color: p.label),
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
