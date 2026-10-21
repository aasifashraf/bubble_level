// TEMPORARY: test APKs only. Everything here is off unless the APK is built
// with --dart-define=TEST_UNTIL=2026-11-15 (see commands.md). To remove it:
// delete this file, the `test*` strings in lib/l10n/app_*.arb, the "email"
// method in MainActivity.kt and AppDelegate.swift, and its few uses in
// main.dart and home_shell.dart. Keep MadeBy (support.dart): the signature
// under it isn't part of the test build.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controls.dart';
import 'l10n.dart';
import 'permission_prompt.dart';
import 'theme.dart';

/// The last day of a test APK, or null for a normal (store) build.
final DateTime? testBuildEnd = DateTime.tryParse(
  const String.fromEnvironment('TEST_UNTIL'),
);

/// Whether a test build that runs until [end] has ended at [now].
bool testBuildEnded(DateTime now, DateTime? end) =>
    end != null && !now.isBefore(end);

/// Where testers send feedback.
const testContactEmail = 'contact@aasifashraf.dev';

const _app = MethodChannel('bubble_level/app');

/// Opens the phone's email app to write to [testContactEmail], with the
/// subject filled in; without an email app, copies the address instead and
/// says so.
Future<void> emailOwner(BuildContext context) async {
  final l = context.l10n;
  bool opened;
  try {
    opened =
        await _app.invokeMethod<bool>('email', {
          'address': testContactEmail,
          'subject': l.testEmailSubject(l.homeTitle),
        }) ??
        false;
  } on PlatformException {
    opened = false;
  } on MissingPluginException {
    opened = false;
  }
  if (opened || !context.mounted) return;
  final messenger = ScaffoldMessenger.maybeOf(context);
  await Clipboard.setData(const ClipboardData(text: testContactEmail));
  messenger?.showSnackBar(SnackBar(content: Text(l.testEmailCopied)));
}

/// At the bottom of home in a test build: a soft card asking for feedback,
/// with one button that opens email.
class TestFeedback extends StatelessWidget {
  const TestFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: softSurface(p, radius: BorderRadius.circular(26)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 14,
            children: [
              // The orange ball, carrying the mail icon.
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [p.ballLight, p.ballDark],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: p.ballDark.withValues(alpha: 0.35),
                      offset: const Offset(3, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mail_outline_rounded,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text(
                      l.testFeedbackTitle(l.homeTitle),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: p.inkStrong,
                      ),
                    ),
                    Text(
                      l.testFeedbackBody,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: p.label,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SoftButton(
            label: l.testEmailMe,
            icon: Icons.mail_outline_rounded,
            emphasis: true,
            onPressed: () => emailOwner(context),
          ),
        ],
      ),
    );
  }
}

/// Shown instead of the app once a test build has ended.
class TestBuildEndedScreen extends StatelessWidget {
  const TestBuildEndedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    // Clear system bars over the app's background, as on every page.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (p.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
          .copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
          ),
      child: Scaffold(
        backgroundColor: p.background,
        body: SafeArea(
          child: PermissionPrompt(
            icon: Icons.update_rounded,
            title: l.testEndedTitle,
            body: l.testEndedBody,
            actions: [
              SoftButton(
                label: testContactEmail,
                icon: Icons.mail_outline_rounded,
                emphasis: true,
                onPressed: () => emailOwner(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
