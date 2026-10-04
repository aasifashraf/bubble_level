import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/repositories/settings_repository.dart';
import 'l10n.dart';
import 'theme.dart';

/// Holds the screen in portrait or landscape, or (null) lets it follow the
/// phone again.
Future<void> lockOrientation(bool? landscape) =>
    SystemChrome.setPreferredOrientations(switch (landscape) {
      null => const [],
      true => const [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      false => const [DeviceOrientation.portraitUp],
    });

/// A tool that stays in portrait (so the screen can't flip while you
/// measure) unless the user turns it with the header's [RotateButton].
/// The choice is remembered per [tool].
class RotatableTool extends StatefulWidget {
  const RotatableTool({
    super.key,
    required this.settings,
    required this.tool,
    required this.child,
  });

  final SettingsRepository settings;

  /// The settings key for this tool's choice.
  final String tool;
  final Widget child;

  @override
  State<RotatableTool> createState() => _RotatableToolState();
}

class _RotatableToolState extends State<RotatableTool> {
  late bool _landscape = widget.settings.toolLandscape(widget.tool);

  void _toggle() {
    setState(() => _landscape = !_landscape);
    unawaited(lockOrientation(_landscape));
    unawaited(widget.settings.setToolLandscape(widget.tool, _landscape));
  }

  @override
  Widget build(BuildContext context) => _RotationScope(
    landscape: _landscape,
    onToggle: _toggle,
    child: widget.child,
  );
}

class _RotationScope extends InheritedWidget {
  const _RotationScope({
    required this.landscape,
    required this.onToggle,
    required super.child,
  });

  final bool landscape;
  final VoidCallback onToggle;

  @override
  bool updateShouldNotify(_RotationScope old) => old.landscape != landscape;
}

/// The header's rotate button: a disc like the help button with a white
/// rotate glyph. Shown only inside a [RotatableTool].
class RotateButton extends StatelessWidget {
  const RotateButton({super.key});

  /// Whether the page is a [RotatableTool], so the header makes room.
  static bool shown(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_RotationScope>() != null;

  @override
  Widget build(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_RotationScope>();
    if (scope == null) return const SizedBox.shrink();
    final p = Palette.of(context);
    final l = context.l10n;
    return IconButton(
      tooltip: scope.landscape ? l.rotatePortrait : l.rotateLandscape,
      onPressed: scope.onToggle,
      icon: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(color: p.tab, shape: BoxShape.circle),
        child: const Icon(
          Icons.screen_rotation_rounded,
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
