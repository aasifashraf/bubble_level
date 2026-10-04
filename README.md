# Bubble Level & Angle Finder

A Flutter app for Android and iOS that turns the phone's sensors into seven
tools, all drawn in one soft, full-screen dial design:

- **Level:** a bubble level when the phone lies flat, and a spirit level with
  a tilting water line when it stands on an edge. It shows the X
  (left/right) and Y (forward/back) tilt and says in words which side is
  high. A switch changes the dial for classic spirit-level tubes. Includes
  Hold, one-tap calibration and a chime when level.
- **Angle:** the angle from the Earth, or tap **Set zero** and measure how far
  the phone has moved since.
- **Compass:** tilt-compensated magnetic heading, with N/E/S/W, the direction
  under the number and a warning when nearby metal disturbs it.
- **Protractor:** drag two handles along an object's edges to read its angle.
- **Metal detector:** magnetic field strength and change from a baseline, with
  a beep that speeds up as metal gets closer.
- **Vibration meter:** live vibration with peak, average and a graph.
- **Altimeter:** air pressure, approximate altitude, and height from a zero.

Every tool has a short "How to use" guide. The app supports light and dark
themes, degrees or percent slope, a list or grid home screen, and sounds that
follow the phone's silent mode. It works on phones and tablets in portrait and
landscape.

## How it works

- **Sensor fusion:** the gyroscope rotates the gravity estimate (smooth and
  fast), and the accelerometer slowly corrects it (no drift). Devices without
  a gyroscope fall back to a low-pass filter.
- **Missing sensors:** a native check at launch marks tools the phone can't
  run (no magnetometer or barometer) on the home screen and explains why. A
  sensor that never reports gets a clear message after a few seconds. The
  vibration meter falls back to the accelerometer when there is no
  linear-acceleration sensor.
- **Rotation aware:** a small native channel reports the UI rotation, so the
  sensor axes always match the screen, including on tablets and foldables.
- **Battery friendly:** sensors stop while the app is in the background, and
  only the open tool follows them.

## Project structure

```text
lib/
  domain/          pure math and models: angles, filters, readings, status
  data/
    services/      sensors_plus streams, display-rotation and sensor
                   availability channels, sounds
    repositories/  orientation (fusion), settings (shared_preferences)
  ui/
    core/          theme tokens, dial and tube painters, full-screen frame,
                   help sheets, formatting
    features/      level, angle, compass, protractor, metal, vibration,
                   altimeter, settings (view models + views)
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
commands, [store_listing.md](store_listing.md) for the store text, and
[play_store_guide.md](play_store_guide.md) for publishing to Google Play.

## Credits

- Dial design based on the community "compass UI" Figma design.
- [Inter](https://github.com/rsms/inter) font, SIL Open Font License 1.1
  (`assets/fonts/Inter-OFL.txt`).
