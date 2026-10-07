import 'package:flutter/material.dart';

import 'controls.dart';
import 'theme.dart';
import 'tool_frame.dart';

/// Why a tool needs a permission (and that nothing is recorded), with the
/// way forward: shown before the system asks, and after a refusal.
class PermissionPrompt extends StatelessWidget {
  const PermissionPrompt({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.actions,
  });

  final IconData icon;
  final String title, body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final top = ToolFrame.sideBySide(context)
        ? 0.0
        : ToolFrame.contentTop(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(28, top, 28, 24),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: softSurface(
                      p,
                      radius: BorderRadius.circular(42),
                    ),
                    child: Icon(icon, size: 40, color: p.ballDark),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: p.inkStrong,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, height: 1.45, color: p.ink),
                  ),
                  const SizedBox(height: 24),
                  for (final (i, a) in actions.indexed) ...[
                    if (i > 0) const SizedBox(height: 12),
                    a,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
