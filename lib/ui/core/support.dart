import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controls.dart';
import 'l10n.dart';
import 'theme.dart';

/// The F-Droid build's support link. Google Play allows no donation link,
/// so the Play build never shows it.
const sponsorUrl = 'https://github.com/sponsors/aasifashraf';

/// The owner's website, under their name.
const websiteUrl = 'https://www.aasifashraf.dev';
const websiteName = 'aasifashraf.dev';
const ownerName = 'Aasif Ashraf';

const _app = MethodChannel('bubble_level/app');

/// Opens [url] in the browser; with no browser, copies it and says so.
Future<void> openLink(BuildContext context, String url) async {
  final copied = context.l10n.linkCopied;
  bool opened;
  try {
    opened = await _app.invokeMethod<bool>('openUrl', {'url': url}) ?? false;
  } on PlatformException {
    opened = false;
  } on MissingPluginException {
    opened = false;
  }
  if (opened || !context.mounted) return;
  final messenger = ScaffoldMessenger.maybeOf(context);
  await Clipboard.setData(ClipboardData(text: url));
  messenger?.showSnackBar(SnackBar(content: Text(copied)));
}

/// At the bottom of home in the F-Droid build: a recessed note (so it reads
/// as a note, not a tool) saying the app is free, with one plain button to
/// GitHub Sponsors. No pop ups, nothing locked.
class SupportCard extends StatelessWidget {
  const SupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: insetSurface(p, radius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Icon(Icons.favorite_rounded, size: 20, color: p.ballDark),
              Flexible(
                child: Text(
                  l.supportTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: p.inkStrong,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            l.supportBody,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, height: 1.4, color: p.label),
          ),
          const SizedBox(height: 16),
          SoftButton(
            label: l.supportButton,
            icon: Icons.favorite_rounded,
            iconColor: p.ballDark,
            onPressed: () => openLink(context, sponsorUrl),
          ),
        ],
      ),
    );
  }
}

/// Who made the app, with a link to their website.
class MadeBy extends StatelessWidget {
  const MadeBy({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final signature = context.l10n.madeBy(ownerName);
    final at = signature.indexOf(ownerName);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 12.5, color: p.label),
            children: at < 0
                ? [TextSpan(text: signature)]
                : [
                    TextSpan(text: signature.substring(0, at)),
                    TextSpan(
                      text: ownerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: p.ink,
                      ),
                    ),
                    TextSpan(text: signature.substring(at + ownerName.length)),
                  ],
          ),
          textAlign: TextAlign.center,
        ),
        Semantics(
          link: true,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => openLink(context, websiteUrl),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Text(
                websiteName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: p.ink,
                  decoration: TextDecoration.underline,
                  decorationColor: p.label,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
