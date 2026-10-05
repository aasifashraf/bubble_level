// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bubble Level & Angle Finder';

  @override
  String get homeTitle => 'Bubble Level';

  @override
  String get settings => 'Settings';

  @override
  String get tools => 'Tools';

  @override
  String get listView => 'List view';

  @override
  String get gridView => 'Grid view';

  @override
  String get back => 'Back';

  @override
  String get lightMode => 'Light mode';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get toolLevel => 'Level';

  @override
  String get toolLevelSubtitle => 'Bubble and spirit level';

  @override
  String get toolAngle => 'Angle';

  @override
  String get toolAngleSubtitle => 'Angle from level or from a zero';

  @override
  String get toolCompass => 'Compass';

  @override
  String get toolCompassSubtitle => 'Heading and direction';

  @override
  String get toolProtractor => 'Protractor';

  @override
  String get toolProtractorSubtitle => 'Measure angles on the screen';

  @override
  String get toolRuler => 'Ruler';

  @override
  String get toolRulerSubtitle => 'Measure length on the screen';

  @override
  String get toolMetal => 'Metal detector';

  @override
  String get toolMetalSubtitle => 'Find iron, steel and magnets';

  @override
  String get toolVibration => 'Vibration';

  @override
  String get toolVibrationSubtitle => 'Vibration meter with live graph';

  @override
  String get toolSound => 'Sound meter';

  @override
  String get toolSoundSubtitle => 'Noise level in decibels';

  @override
  String get toolAltimeter => 'Altimeter';

  @override
  String get toolAltimeterSubtitle => 'Air pressure and height';

  @override
  String get toolLight => 'Light meter';

  @override
  String get toolLightSubtitle => 'Brightness in lux';

  @override
  String get notAvailableOnPhone => 'Not available on this phone';

  @override
  String get notOnPhone => 'Not on this phone';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, not available on this phone';
  }

  @override
  String get howToUse => 'How to use';

  @override
  String get rotateLandscape => 'Turn to landscape';

  @override
  String get rotatePortrait => 'Turn to portrait';

  @override
  String howToUseTool(String tool) {
    return 'How to use $tool';
  }

  @override
  String get gotIt => 'Got it';

  @override
  String get goodToKnow => 'Good to know: ';

  @override
  String get ok => 'OK';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool isn’t available';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sensors',
      one: 'a sensor',
    );
    return '$tool needs $_temp0 this phone doesn’t have: $sensors.';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'This is a limit of the phone’s hardware, not a fault in the app. All the other tools work normally.';

  @override
  String get sensorAccelerometer => 'accelerometer';

  @override
  String get sensorMagnetometer => 'magnetometer (compass sensor)';

  @override
  String get sensorBarometer => 'barometer (air pressure sensor)';

  @override
  String get sensorLight => 'light sensor';

  @override
  String get sensorMicrophone => 'microphone';

  @override
  String get noAccelerometer =>
      'This phone has no accelerometer, so this tool can’t measure anything here. Tools that don’t need it still work.';

  @override
  String get noMagnetometer =>
      'This phone has no magnetometer (compass sensor), so this tool can’t work here. Tools that don’t need it still work.';

  @override
  String get noReadings =>
      'No readings from the sensor yet. Go back and open the tool again; if it keeps happening, restart your phone. Some phones don’t support this tool.';

  @override
  String get waitingForSensors => 'Waiting for sensors…';

  @override
  String get levelHelp1 =>
      'Lay the phone flat on the surface, or stand it on one of its edges.';

  @override
  String get levelHelp2 =>
      'Flat: centre the bubble. X is left/right tilt, Y is forward/back tilt. On an edge, you see the angle and slope.';

  @override
  String get levelHelp3 =>
      'Follow the hint on screen (for example “Right side high”) until it reads level: it turns orange and the phone chimes and buzzes (turn these off in Settings).';

  @override
  String get levelHelp4 =>
      'Tap Lock to freeze the reading, and Unlock to go live again.';

  @override
  String get levelHelp5 =>
      'Prefer a classic spirit level? Tap the tube icon in the switch; the round icon brings the dial back.';

  @override
  String get levelTip =>
      'If a surface you know is level doesn’t read 0°, put the phone on it and tap Calibrate. To undo it, tap Calibrate again and choose Reset calibration.';

  @override
  String get statusLevel => 'Level';

  @override
  String get leftEndLow => 'Left end low';

  @override
  String get rightEndLow => 'Right end low';

  @override
  String get rightSideHigh => 'Right side high';

  @override
  String get leftSideHigh => 'Left side high';

  @override
  String get topEdgeHigh => 'Top edge high';

  @override
  String get bottomEdgeHigh => 'Bottom edge high';

  @override
  String get calibrated => 'Calibrated. This position now reads 0°.';

  @override
  String get tooFarToCalibrate =>
      'Too far from level to calibrate. Place the phone on a level surface first.';

  @override
  String get dialView => 'Dial view';

  @override
  String get tubeView => 'Tube view';

  @override
  String get levelTube => 'Level tube';

  @override
  String get leftRightTube => 'Left and right tube';

  @override
  String get forwardBackTube => 'Forward and back tube';

  @override
  String tiltFromLevel(String value) {
    return 'Tilt from level $value';
  }

  @override
  String fromLevel(String value) {
    return 'From level $value';
  }

  @override
  String get xLeftRight => 'X · left / right';

  @override
  String get yForwardBack => 'Y · forward / back';

  @override
  String get angle => 'Angle';

  @override
  String get slope => 'Slope';

  @override
  String get lock => 'Lock';

  @override
  String get unlock => 'Unlock';

  @override
  String locked(String status) {
    return 'Locked · $status';
  }

  @override
  String get lockReading => 'Lock reading';

  @override
  String get lockHandles => 'Lock handles';

  @override
  String get handlesLocked => 'Handles locked · tap the lock to adjust';

  @override
  String get calibrate => 'Calibrate';

  @override
  String get angleHelp1 =>
      'Lay the phone on a surface to read its tilt, or stand it on an edge against a slope, rail or pipe: the big number is the long edge’s angle, the short edge’s is below.';

  @override
  String get angleHelp2 =>
      'To measure a change, hold the phone in the starting position and tap Set zero here.';

  @override
  String get angleHelp3 =>
      'Tilt or move the phone. The dial shows how many degrees it moved from your zero.';

  @override
  String get angleHelp4 => 'Tap Clear zero to go back to the angle from flat.';

  @override
  String get angleHelp5 =>
      'To read an angle you can’t see, hold the phone against the object, tap the lock, then lift it and read.';

  @override
  String get angleHelp6 =>
      'It switches between flat and on-edge by itself. To keep one, tap the flat or edge icon at the top; the first icon goes back to automatic.';

  @override
  String get angleTip =>
      'Lay the phone’s long side along a ramp, stair rail or roof to read its slope, or press the screen flat against a board or door to measure its tilt.';

  @override
  String movedFromZero(String value) {
    return 'Moved from zero $value';
  }

  @override
  String get measuringFromZero => 'Measuring from your zero';

  @override
  String get angleFromEarth => 'Angle from the Earth';

  @override
  String get angleFlatStatus => 'Flat · angle from the Earth';

  @override
  String get longEdgeFromLevel => 'On edge · long edge from level';

  @override
  String shortEdge(String value) {
    return 'Short edge $value';
  }

  @override
  String edgeAngleSemantics(String long, String short) {
    return 'Long edge $long from level, short edge $short';
  }

  @override
  String get angleModeAuto => 'Automatic';

  @override
  String get angleModeFlat => 'Flat on a surface';

  @override
  String get angleModeEdge => 'On an edge';

  @override
  String get standOnEdge => 'Stand the phone on one of its edges';

  @override
  String get clearZero => 'Clear zero';

  @override
  String get setZeroHere => 'Set zero here';

  @override
  String get compassHelp1 =>
      'Hold the phone level in front of you, away from metal, magnets and electronics.';

  @override
  String get compassHelp2 =>
      'Point the top of the phone in the direction you want to know.';

  @override
  String get compassHelp3 =>
      'The number is your heading in degrees and the letters are the direction. The orange ball marks it on the ring.';

  @override
  String get compassTip =>
      'It points to magnetic north, which can differ a few degrees from map north. If it seems wrong, move the phone in a figure 8 a few times.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Magnetic heading $heading degrees, $direction';
  }

  @override
  String get magneticInterference =>
      'Magnetic interference · move away from metal';

  @override
  String get dirN => 'N';

  @override
  String get dirNE => 'NE';

  @override
  String get dirE => 'E';

  @override
  String get dirSE => 'SE';

  @override
  String get dirS => 'S';

  @override
  String get dirSW => 'SW';

  @override
  String get dirW => 'W';

  @override
  String get dirNW => 'NW';

  @override
  String get protractorHelp1 =>
      'Lay the phone flat and place the object on the screen, with its corner at the centre.';

  @override
  String get protractorHelp2 =>
      'Drag each orange handle so its line runs along one edge of the angle.';

  @override
  String get protractorHelp3 =>
      'Read the angle in the centre. Reflex is the other side (360° minus it).';

  @override
  String get protractorHelp4 => 'Tap Reset to start again.';

  @override
  String get protractorHelp5 =>
      'Tap the lock to keep the handles in place while you move the object.';

  @override
  String armsSemantics(String value) {
    return 'Angle between the arms $value';
  }

  @override
  String get reflex => 'Reflex';

  @override
  String get dragHandles => 'Drag the orange handles along the edges';

  @override
  String get reset => 'Reset';

  @override
  String get rulerHelp1 =>
      'Lay the object on the screen, or hold the phone against it.';

  @override
  String get rulerHelp2 =>
      'Drag the orange lines to its two ends. Tap mm, cm or in to pick the unit; the other system shows below.';

  @override
  String get rulerHelp3 =>
      'For the best accuracy, tap Calibrate once and use a bank card, a ruler or the screen size.';

  @override
  String get rulerHelp4 =>
      'Tap the lock to keep the lines in place while you move the object.';

  @override
  String get rulerTip =>
      'It measures up to the length of the screen. Cases and curved edges hide the first millimetres, so measure between the lines, not from the edge of the phone.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'Length $mm millimetres, $inches inches';
  }

  @override
  String get rulerCalibrated => 'Calibrated with a card · ±0.5 mm';

  @override
  String get rulerReported =>
      'Screen size from the phone · calibrate for ±0.5 mm';

  @override
  String get unitMillimetres => 'Millimetres';

  @override
  String get unitCentimetres => 'Centimetres';

  @override
  String get unitInches => 'Inches';

  @override
  String get rulerEstimated => 'Not calibrated · lengths may be 10% off';

  @override
  String get calibrateCard => 'Calibrate';

  @override
  String get cardLongEdge =>
      'Lay any bank or ID card on the screen, long edge along the ruler, one end on the dark line. Drag the orange line to the card’s other end.';

  @override
  String get cardShortEdge =>
      'Lay any bank or ID card on the screen, short edge along the ruler, one end on the dark line. Drag the orange line to the card’s other end.';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get usePhoneDefault => 'Use the phone’s screen size';

  @override
  String get usePhoneDefaultInfo => 'Forget this calibration';

  @override
  String get cardMismatch =>
      'That doesn’t match a card. Line it up with the dark line and try again.';

  @override
  String get rotateToCalibrate => 'Turn the phone upright to calibrate';

  @override
  String get calibrateHow => 'Calibrate with';

  @override
  String get methodCard => 'A bank card';

  @override
  String get methodCardInfo => 'Any bank or ID card · ±0.5 mm';

  @override
  String get methodRuler => 'A ruler';

  @override
  String get methodRulerInfo => 'Most accurate · a ruler or tape measure';

  @override
  String get methodScreen => 'The screen size';

  @override
  String get methodScreenInfo => 'Nothing needed · about 1%';

  @override
  String rulerInstructions(String mark) {
    return 'Lay a ruler on the screen with its 0 on the dark line. Drag the orange line to the $mark mark.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'That doesn’t match $mark. Put the ruler’s 0 on the dark line and try again.';
  }

  @override
  String get screenSizeInstructions =>
      'Type the screen size in inches from the phone’s specs. Not sure? Search your phone’s model and “screen size”.';

  @override
  String get screenSizeMismatch =>
      'That size doesn’t fit this screen. Check the phone’s specs and try again.';

  @override
  String get rulerCalibratedRuler => 'Calibrated with a ruler · ±0.5 mm';

  @override
  String rulerCalibratedScreen(String size) {
    return 'Set for a $size-inch screen · about 1%';
  }

  @override
  String get metalHelp1 =>
      'Open the tool away from metal. That first reading counts as “no metal”.';

  @override
  String get metalHelp2 =>
      'Move the phone slowly over the area. The sensor is usually near the top of the phone. It beeps faster the closer you get to metal; tap the speaker to mute.';

  @override
  String get metalHelp3 =>
      '“Metal nearby” means a small change. “Metal detected” means a strong one: the centre turns orange and the phone buzzes if vibration is on.';

  @override
  String get metalHelp4 =>
      'Held still for a few seconds, it re-zeroes itself, so a false reading fades away. To check a spot again, move the phone away and back. Set baseline re-zeroes at once.';

  @override
  String get metalTip =>
      'It only senses iron, steel and magnets, not aluminium, copper, gold or silver. Magnetic phone cases affect it.';

  @override
  String metalSemantics(int value) {
    return 'Magnetic field $value microtesla';
  }

  @override
  String get noMetal => 'No metal nearby';

  @override
  String get metalNearby => 'Metal nearby';

  @override
  String get metalDetected => 'Metal detected';

  @override
  String get field => 'Field';

  @override
  String get change => 'Change';

  @override
  String get findsIronSteel => 'Finds iron, steel and magnets';

  @override
  String get setBaseline => 'Set baseline';

  @override
  String get muteSound => 'Mute sound';

  @override
  String get turnSoundOn => 'Turn sound on';

  @override
  String get vibrationHelp1 =>
      'Place the phone flat on the surface or machine you want to check, and keep your hands off it.';

  @override
  String get vibrationHelp2 =>
      'The dial shows vibration right now in m/s². The graph shows the last few seconds.';

  @override
  String get vibrationHelp3 =>
      'Peak is the strongest moment. Average is the level over the last second.';

  @override
  String get vibrationHelp4 => 'Tap Reset peak before each new test.';

  @override
  String get vibrationTip =>
      '“Still” is under 0.3 m/s² and “Strong” is over 2 m/s². Use the readings to compare; phone sensors aren’t lab instruments.';

  @override
  String get still => 'Still';

  @override
  String get lightVibration => 'Light vibration';

  @override
  String get strongVibration => 'Strong vibration';

  @override
  String get noAccelerometerVibration =>
      'This phone has no accelerometer, so vibration can’t be measured here. Tools that don’t need it still work.';

  @override
  String vibrationSemantics(String value) {
    return 'Vibration $value metres per second squared';
  }

  @override
  String get peak => 'Peak';

  @override
  String get average => 'Average';

  @override
  String get resetPeak => 'Reset peak';

  @override
  String get vibrationGraph => 'Vibration graph';

  @override
  String get altimeterHelp1 =>
      'The dial shows air pressure in hPa, and altitude is estimated from it.';

  @override
  String get altimeterHelp2 =>
      'To measure a height change, like stairs or floors, tap Set zero here where you start.';

  @override
  String get altimeterHelp3 =>
      'Go up or down. The centre shows the metres from your zero.';

  @override
  String get altimeterHelp4 => 'Tap Clear zero to go back.';

  @override
  String get altimeterTip =>
      'Weather changes air pressure, so altitude can be off by tens of metres. Height from your zero is accurate over short periods. This tool needs a phone with a barometer.';

  @override
  String get barometerIos =>
      'Can’t read the barometer. Turn on Motion & Fitness for this app in Settings › Privacy & Security, then open the Altimeter again.';

  @override
  String get noBarometer =>
      'This phone has no barometer (air pressure sensor), so the altimeter can’t work here. Other tools still work.';

  @override
  String get noLightSensor =>
      'This phone has no light sensor, so the light meter can’t work here. Other tools still work.';

  @override
  String lightSemantics(String value) {
    return 'Brightness $value lux';
  }

  @override
  String get illuminance => 'Brightness';

  @override
  String get footCandles => 'Foot-candles';

  @override
  String get lightDark => 'Dark';

  @override
  String get lightDim => 'Dim light';

  @override
  String get lightLivingRoom => 'Living-room light';

  @override
  String get lightReading => 'Good for reading and desk work';

  @override
  String get lightBright => 'Bright indoor light';

  @override
  String get lightOvercast => 'Overcast daylight';

  @override
  String get lightDaylight => 'Daylight';

  @override
  String get lightSun => 'Direct sunlight';

  @override
  String get lightHelp1 =>
      'The light sensor sits at the top of the screen, near the front camera.';

  @override
  String get lightHelp2 =>
      'Hold the phone where you want to measure, with the screen facing the light.';

  @override
  String get lightHelp3 =>
      'Read the lux and what the light is good for: 300–500 lx suits reading and desk work.';

  @override
  String get lightHelp4 =>
      'Tap Lock to keep a reading while you move the phone away.';

  @override
  String get lightTip =>
      'Light sensors differ between phones, so readings can be 10–20% off: good for comparing places, not a calibrated lux meter. Don’t cover the top of the screen.';

  @override
  String get noMicrophone =>
      'Can’t use the microphone. Another app may be using it: close that app, then open the sound meter again.';

  @override
  String soundSemantics(String value) {
    return 'Sound level about $value decibels';
  }

  @override
  String get decibelsApprox => 'dB (approx.)';

  @override
  String get soundAverage => 'Average';

  @override
  String get soundMax => 'Max';

  @override
  String get soundVeryQuiet => 'Very quiet';

  @override
  String get soundQuiet => 'Quiet, like a library';

  @override
  String get soundModerate => 'Moderate, like a conversation';

  @override
  String get soundLoud => 'Loud, like busy traffic';

  @override
  String get soundVeryLoud => 'Very loud: long exposure can damage hearing';

  @override
  String get soundDangerous => 'Dangerous: protect your ears';

  @override
  String get micTitle => 'Allow the microphone';

  @override
  String get micBody =>
      'The sound meter listens through the microphone to measure how loud it is. Sound is measured on your phone and never recorded, saved or sent.';

  @override
  String get micAllow => 'Allow microphone';

  @override
  String get micDeniedTitle => 'Microphone access is off';

  @override
  String get micDeniedBody =>
      'Turn on the microphone for this app in Settings to use the sound meter. Sound is never recorded, saved or sent.';

  @override
  String get openSettings => 'Open settings';

  @override
  String get tryAgain => 'Try again';

  @override
  String get soundHelp1 =>
      'Keep the microphone (on the bottom edge) uncovered and point the phone toward the sound.';

  @override
  String get soundHelp2 =>
      'The big number is the level now, averaged over about a second.';

  @override
  String get soundHelp3 =>
      'Average and Max count from when you opened the tool. Tap Reset to start them again.';

  @override
  String get soundHelp4 =>
      'From 85 dB, long exposure can damage hearing: the status line turns yellow.';

  @override
  String get soundTip =>
      'Phone microphones differ, so readings can be about 5 dB off: good for comparing, not a certified sound level meter. Very loud sounds (above about 110 dB) may read low.';

  @override
  String get metresFromZero => 'm from zero';

  @override
  String pressureSemantics(String value) {
    return 'Air pressure $value hectopascals';
  }

  @override
  String heightSemantics(String value) {
    return 'Height $value from zero';
  }

  @override
  String get pressure => 'Pressure';

  @override
  String get altitudeApprox => 'Altitude (approx.)';

  @override
  String get measuringHeight => 'Measuring height from your zero';

  @override
  String get airPressureAltitude => 'Air pressure and altitude';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get levelUnits => 'Level units';

  @override
  String get vibrateWhenLevel => 'Vibrate when level';

  @override
  String get sounds => 'Sounds';

  @override
  String get resetCalibration => 'Reset calibration';

  @override
  String get resetCalibrationHint => 'Use the factory sensor zero again';

  @override
  String get calibrateHere => 'Calibrate here';

  @override
  String get calibrateHereInfo => 'On a surface you know is level';

  @override
  String get calibrationRemoved =>
      'Calibration removed. The Level uses the factory sensor zero again.';

  @override
  String get resetAllCalibrations => 'Reset all calibrations';

  @override
  String get resetAllCalibrationsHint =>
      'Level and Ruler back to factory settings';

  @override
  String get resetAllTitle => 'Reset all calibrations?';

  @override
  String get resetAllBody =>
      'This removes the zero you set in the Level and the screen size you set in the Ruler. Both go back to their factory settings. Your other settings stay as they are, and you can calibrate again at any time.';

  @override
  String get notCalibrated => 'Not calibrated';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'Phone language';
}
