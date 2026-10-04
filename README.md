# Bubble Level & Angle Finder

A Flutter app for Android and iOS that turns the phone's motion sensors into
three instruments, all drawn in one soft, full-screen dial design:

- **Level:** a bubble level when the phone lies flat, and a spirit level with
  a tilting water line when it stands on an edge. It shows the X
  (left/right) and Y (forward/back) tilt and says in words which side is
  high. Includes Hold and one-tap calibration.
- **Angle:** the angle from the Earth, or tap **Set zero** and measure how far
  the phone has moved since.
- **Compass:** tilt-compensated magnetic heading, with N/E/S/W and the
  direction under the number.

It supports light and dark themes (one-tap sun/moon switch), degrees or
percent slope, and a list or grid home screen. It works on phones and tablets
in any orientation.

## How it works

- **Sensor fusion:** the gyroscope rotates the gravity estimate (smooth and
  fast), and the accelerometer slowly corrects it (no drift). Devices without
  a gyroscope fall back to a low-pass filter. Missing sensors show a clear
  message instead of failing.
- **Rotation aware:** a small native channel reports the UI rotation, so the
  sensor axes always match the screen, including on tablets and foldables.
- **Battery friendly:** sensors stop while the app is in the background, and
  only the open tool follows them.

## Project structure

```text
lib/
  domain/          pure math and models: angles, filters, readings, status
  data/
    services/      sensors_plus streams, display-rotation channel
    repositories/  orientation (fusion), settings (shared_preferences)
  ui/
    core/          theme tokens, dial painter, full-screen frame, formatting
    features/      level, angle, compass, settings (view models + views)
    home/          home screen (list / grid)
test/              domain, view-model and app-flow tests
```

The UI follows MVVM: views listen to `ChangeNotifier` view models, which read
the repositories.

## Run

```powershell
flutter pub get
flutter run                  # on a connected phone or emulator
flutter test                 # unit, view-model and widget tests
flutter build apk --release  # installable APK
```

See [commands.md](commands.md) for emulator, Wi-Fi debugging and preview
commands, and [store_listing.md](store_listing.md) for the store text.

## Credits

- Dial design based on the community "compass UI" Figma design.
- [Inter](https://github.com/rsms/inter) font, SIL Open Font License 1.1
  (`assets/fonts/Inter-OFL.txt`).
