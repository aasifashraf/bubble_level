import 'package:flutter/material.dart';

import 'l10n.dart';
import 'theme.dart';

/// Soft raised pill button in the dial's material; [emphasis] fills it
/// with the indicator orange. A null [onPressed] shows it disabled.
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
  final VoidCallback? onPressed;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final fg = emphasis ? Colors.white : p.ink;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: onPressed == null ? 0.45 : 1,
      child: Container(
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
      ),
    );
  }
}

/// Round soft button beside a pill button: the lock, the speaker. [active]
/// fills it with the indicator orange (a locked reading), so the state is
/// obvious at a glance.
class SoftIconButton extends StatelessWidget {
  const SoftIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.active = false,
    this.muted = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool active;

  /// Draws the icon in the label grey (e.g. sound off).
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      width: 50,
      height: 50,
      decoration: softSurface(
        p,
        radius: BorderRadius.circular(25),
        colors: active ? [p.ballLight, p.ballDark] : null,
      ),
      child: Semantics(
        toggled: active,
        child: IconButton(
          tooltip: tooltip,
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: active
                ? Colors.white
                : muted
                ? p.label
                : p.ink,
          ),
        ),
      ),
    );
  }
}

/// A read-only value in the design's material: a soft raised tile with the
/// number above a small caption.
/// The lock that tools use to freeze a reading or their handles: a round
/// icon button, or, [wide], a labelled one ("Lock" / "Unlock"). Filled
/// orange while locked. [tooltip] says what locking does; "Unlock" while
/// locked.
class LockButton extends StatelessWidget {
  const LockButton({
    super.key,
    required this.locked,
    required this.onPressed,
    this.tooltip,
    this.wide = false,
  });

  final bool locked;
  final VoidCallback onPressed;
  final String? tooltip;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final icon = locked ? Icons.lock_rounded : Icons.lock_open_rounded;
    if (wide) {
      return SoftButton(
        label: locked ? l.unlock : l.lock,
        icon: icon,
        emphasis: locked,
        onPressed: onPressed,
      );
    }
    return SoftIconButton(
      icon: icon,
      tooltip: locked ? l.unlock : (tooltip ?? l.lockReading),
      active: locked,
      onPressed: onPressed,
    );
  }
}

/// A row of [ValueTile]s sharing the width: (value, caption) each.
class ValueTiles extends StatelessWidget {
  const ValueTiles(this.tiles, {super.key});

  final List<(String value, String caption)> tiles;

  @override
  Widget build(BuildContext context) => Row(
    spacing: 14,
    children: [
      for (final (value, caption) in tiles)
        Expanded(
          child: ValueTile(value: value, caption: caption),
        ),
    ],
  );
}

/// Several readings on one raised panel, split by hairlines. A reading
/// with an entry in [onTap] can be tapped to edit it (a pencil marks it).
class StatPanel extends StatelessWidget {
  const StatPanel(this.stats, {super.key, this.onTap = const []});

  final List<(String value, String caption)> stats;
  final List<VoidCallback?> onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      height: 64,
      decoration: softSurface(p, radius: BorderRadius.circular(22)),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          for (final (i, (value, caption)) in stats.indexed) ...[
            if (i > 0)
              Container(width: 1, color: p.dialShadow.withValues(alpha: 0.6)),
            Expanded(
              child: _tappable(
                i < onTap.length ? onTap[i] : null,
                Semantics(
                  label: '$caption $value',
                  button: i < onTap.length && onTap[i] != null,
                  excludeSemantics: true,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            value,
                            textDirection: TextDirection.ltr,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.15,
                              fontWeight: FontWeight.w700,
                              fontFeatures: readoutFeatures,
                              color: p.ink,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 3,
                            children: [
                              Text(
                                caption,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: p.label,
                                ),
                              ),
                              if (i < onTap.length && onTap[i] != null)
                                Icon(
                                  Icons.edit_rounded,
                                  size: 11,
                                  color: p.label,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget _tappable(VoidCallback? onTap, Widget child) => onTap == null
      ? child
      : Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: child,
          ),
        );
}

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
                textDirection: TextDirection.ltr,
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
