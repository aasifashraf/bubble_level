import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../core/controls.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/theme.dart';

/// Settings in the dial's design language: soft raised cards, recessed
/// tracks with a sliding raised pill, and a switch whose knob is the dial's
/// orange ball.
Future<void> showSettingsSheet(
  BuildContext context,
  SettingsRepository settings,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    // Never taller than the space below the status bar (landscape).
    useSafeArea: true,
    // The body paints the background itself so it follows a theme change
    // made from inside the sheet.
    backgroundColor: Colors.transparent,
    builder: (context) => ListenableBuilder(
      listenable: settings,
      builder: (context, _) => _SettingsBody(settings: settings),
    ),
  );
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody({required this.settings});

  final SettingsRepository settings;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: p.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: insetSurface(p, radius: BorderRadius.circular(3)),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                context.l10n.settings,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                  color: p.inkStrong,
                ),
              ),
              const SizedBox(height: 22),
              _Card(
                children: [
                  _Label(context.l10n.appearance),
                  const SizedBox(height: 12),
                  _Segmented<ThemeMode>(
                    value: settings.themeMode,
                    onChanged: settings.setThemeMode,
                    options: [
                      (
                        ThemeMode.system,
                        Icons.brightness_auto_rounded,
                        context.l10n.themeSystem,
                      ),
                      (
                        ThemeMode.light,
                        Icons.light_mode_rounded,
                        context.l10n.themeLight,
                      ),
                      (
                        ThemeMode.dark,
                        Icons.dark_mode_rounded,
                        context.l10n.themeDark,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _Card(
                children: [
                  Row(
                    children: [
                      Expanded(child: _Label(context.l10n.levelUnits)),
                      SizedBox(
                        width: 180,
                        child: _Segmented<AngleUnit>(
                          value: settings.unit,
                          onChanged: settings.setUnit,
                          options: const [
                            (AngleUnit.degrees, null, '°'),
                            (AngleUnit.percent, null, '%'),
                            (AngleUnit.pitch, null, '/12'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(height: 1, color: p.ink.withValues(alpha: 0.08)),
                  const SizedBox(height: 16),
                  _ToggleRow(
                    label: context.l10n.vibrateWhenLevel,
                    value: settings.haptics,
                    onChanged: settings.setHaptics,
                  ),
                  const SizedBox(height: 16),
                  Divider(height: 1, color: p.ink.withValues(alpha: 0.08)),
                  const SizedBox(height: 16),
                  _ToggleRow(
                    label: context.l10n.sounds,
                    value: settings.sounds,
                    onChanged: settings.setSounds,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _Card(children: [_LanguageRow(settings: settings)]),
              const SizedBox(height: 18),
              _ResetCard(settings: settings),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: softSurface(
        Palette.of(context),
        radius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Palette.of(context).ink,
      ),
    );
  }
}

/// A recessed track holding the options, with a raised pill that slides to
/// the selected one.
class _Segmented<T> extends StatelessWidget {
  const _Segmented({
    required this.value,
    required this.onChanged,
    required this.options,
  });

  final T value;
  final ValueChanged<T> onChanged;
  final List<(T, IconData?, String)> options;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final index = options.indexWhere((o) => o.$1 == value);
    final n = options.length;
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: insetSurface(p, radius: BorderRadius.circular(24)),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: AlignmentDirectional(
              n == 1 ? 0 : -1 + 2 * index / (n - 1),
              0,
            ),
            child: FractionallySizedBox(
              widthFactor: 1 / n,
              heightFactor: 1,
              child: DecoratedBox(
                decoration: softSurface(
                  p,
                  radius: BorderRadius.circular(20),
                  colors: p.isDark
                      ? [p.buttonRimTopLeft, p.buttonRimBottomRight]
                      : [Colors.white, p.dialLight],
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (final (i, (option, icon, label)) in options.indexed)
                Expanded(
                  child: Semantics(
                    button: true,
                    selected: i == index,
                    label: label,
                    excludeSemantics: true,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onChanged(option),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (icon != null) ...[
                                Icon(
                                  icon,
                                  size: 18,
                                  color: i == index ? p.ballDark : p.label,
                                ),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                label,
                                style: TextStyle(
                                  // Lone symbols (° and %) read larger.
                                  fontSize: label.length == 1 ? 20 : 15,
                                  fontWeight: i == index
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: i == index ? p.ink : p.label,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A recessed track; the knob is the dial's orange ball when on and a soft
/// raised button when off.
class _BallSwitch extends StatelessWidget {
  const _BallSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: Container(
          width: 60,
          height: 34,
          padding: const EdgeInsets.all(4),
          decoration: insetSurface(p, radius: BorderRadius.circular(17)),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutBack,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(-0.25, -0.3),
                  colors: value
                      ? [p.ballLight, p.ballDark]
                      : p.isDark
                      ? [p.buttonRimTopLeft, p.buttonRimBottomRight]
                      : [Colors.white, p.dialDark],
                ),
                boxShadow: [
                  BoxShadow(
                    color: value
                        ? p.ballDark.withValues(alpha: 0.4)
                        : p.dialShadow.withValues(alpha: p.isDark ? 0.8 : 0.7),
                    offset: const Offset(1, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Resets every tool's calibration, after saying exactly what goes.
class _ResetCard extends StatelessWidget {
  const _ResetCard({required this.settings});

  final SettingsRepository settings;

  Future<void> _confirm(BuildContext context) =>
      showAppSheet<void>(context, (context) {
        final l = context.l10n;
        final p = Palette.of(context);
        return AppSheet(
          title: l.resetAllTitle,
          action: Row(
            spacing: 14,
            children: [
              Expanded(
                child: SoftButton(
                  label: l.cancel,
                  icon: Icons.close_rounded,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: SoftButton(
                  label: l.reset,
                  icon: Icons.restart_alt_rounded,
                  emphasis: true,
                  onPressed: () {
                    settings.resetAllCalibrations();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          children: [
            Text(
              l.resetAllBody,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.45, color: p.ink),
            ),
          ],
        );
      });

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final enabled = settings.hasAnyCalibration;
    final radius = BorderRadius.circular(26);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: enabled ? 1 : 0.5,
      child: DecoratedBox(
        decoration: softSurface(p, radius: radius),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: radius,
            onTap: enabled ? () => _confirm(context) : null,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                spacing: 14,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: p.isDark
                            ? [p.buttonRimTopLeft, p.buttonRimBottomRight]
                            : [Colors.white, p.dialDark],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: p.buttonShadow.withValues(
                            alpha: p.isDark ? 0.8 : 0.9,
                          ),
                          offset: const Offset(3, 5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.restart_alt_rounded,
                      color: p.ink,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Label(context.l10n.resetAllCalibrations),
                        const SizedBox(height: 2),
                        Text(
                          enabled
                              ? context.l10n.resetAllCalibrationsHint
                              : context.l10n.notCalibrated,
                          style: TextStyle(fontSize: 13, color: p.label),
                        ),
                      ],
                    ),
                  ),
                  if (enabled)
                    Icon(Icons.chevron_right_rounded, color: p.label),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A label and a ball switch; the whole row toggles, as with platform
/// switches.
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => MergeSemantics(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Expanded(child: _Label(label)),
          _BallSwitch(value: value, onChanged: onChanged),
        ],
      ),
    ),
  );
}

/// "Language" with the current choice; opens the list of languages.
class _LanguageRow extends StatelessWidget {
  const _LanguageRow({required this.settings});

  final SettingsRepository settings;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final l = context.l10n;
    final current = settings.language;
    return MergeSemantics(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showLanguages(context, settings),
        child: Row(
          children: [
            Expanded(child: _Label(l.language)),
            Flexible(
              child: Text(
                current == null ? l.languageSystem : languageNames[current]!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 15, color: p.label),
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, color: p.label),
          ],
        ),
      ),
    );
  }
}

/// The phone's language first, then each language in its own name.
Future<void> _showLanguages(
  BuildContext context,
  SettingsRepository settings,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  backgroundColor: Colors.transparent,
  builder: (context) {
    final p = Palette.of(context);
    final l = context.l10n;
    Widget option(String? code, String name) {
      final selected = settings.language == code;
      return ListTile(
        title: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: p.ink,
          ),
        ),
        trailing: selected
            ? Icon(Icons.check_rounded, color: p.ballDark)
            : null,
        selected: selected,
        onTap: () {
          settings.setLanguage(code);
          Navigator.of(context).pop();
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: p.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: insetSurface(p, radius: BorderRadius.circular(3)),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                l.language,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: p.inkStrong,
                ),
              ),
              const SizedBox(height: 16),
              DecoratedBox(
                decoration: softSurface(p, radius: BorderRadius.circular(26)),
                child: Material(
                  // The rows' tap ripple paints on this, over the card.
                  type: MaterialType.transparency,
                  borderRadius: BorderRadius.circular(26),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        option(null, l.languageSystem),
                        for (final MapEntry(:key, :value)
                            in languageNames.entries)
                          option(key, value),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
