import 'package:flutter/material.dart';

import 'theme.dart';

/// Soft raised pill button in the dial's material; [emphasis] fills it
/// with the indicator orange.
class SoftButton extends StatelessWidget {
  const SoftButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.emphasis = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final fg = emphasis ? Colors.white : p.ink;
    return Container(
      height: 50,
      decoration: softSurface(
        p,
        radius: BorderRadius.circular(25),
        colors: emphasis ? [p.ballLight, p.ballDark] : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onPressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 20, color: fg),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: fg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A read-only value in the design's material: a soft raised tile with the
/// number above a small caption.
class ValueTile extends StatelessWidget {
  const ValueTile({super.key, required this.value, required this.caption});

  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      label: '$caption $value',
      excludeSemantics: true,
      child: Container(
        height: 60,
        decoration: softSurface(p, radius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  fontFeatures: readoutFeatures,
                  color: p.ink,
                ),
              ),
              Text(
                caption,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: p.label,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Soft raised surface in the dial's material, lit from the top-left: the
/// shared look of tiles, buttons and cards. [colors] overrides the face
/// gradient (e.g. the orange of an emphasised button).
BoxDecoration softSurface(
  Palette p, {
  required BorderRadius radius,
  List<Color>? colors,
}) => BoxDecoration(
  borderRadius: radius,
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: colors ?? [p.dialLight, p.dialDark],
  ),
  boxShadow: [
    BoxShadow(
      color: p.dialShadow.withValues(alpha: p.isDark ? 0.85 : 0.55),
      offset: const Offset(5, 10),
      blurRadius: 20,
    ),
    BoxShadow(
      color: p.dialGlow.withValues(alpha: p.isDark ? 0.45 : 1),
      offset: const Offset(-5, -5),
      blurRadius: 14,
    ),
  ],
);

/// Recessed track in the material of the dial's well: darker toward the
/// top-left where the rim casts its shadow.
BoxDecoration insetSurface(Palette p, {required BorderRadius radius}) =>
    BoxDecoration(
      borderRadius: radius,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: p.isDark
            ? [const Color(0xFF171717), p.wellLight]
            : [const Color(0xFFDCE5F2), p.wellLight],
      ),
      border: Border.all(
        color: p.isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.9),
      ),
    );
