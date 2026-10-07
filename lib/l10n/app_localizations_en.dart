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
  String get toolVibrationSubtitle => 'Vibration strength and speed (RPM)';

  @override
  String get toolSound => 'Sound meter';

  @override
  String get toolSoundSubtitle => 'Noise level in decibels';

  @override
  String get toolAltimeter => 'Altimeter';

  @override
  String get toolAltimeterSubtitle => 'Air pressure and altitude';

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
      'Follow the hint on screen (for example “Right side high”) until it reads level: it turns orange and the phone chimes and taps (turn these off in Settings).';

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
      'Lay the phone on a surface to read its tilt, or stand it on an edge against a slope, rail or pipe: the big number is the angle of the edge that glows orange, the bottom edge’s is below.';

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
      'Choose the mode with the switch at the top: flat on a surface, or standing on an edge. On an edge the screen fills with water that stays level, and the edge you’re measuring, the lower side, glows orange.';

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
  String get angleFlatStatus => 'Flat · angle from the Earth';

  @override
  String get measuringRightEdge => 'Measuring the right edge';

  @override
  String get measuringLeftEdge => 'Measuring the left edge';

  @override
  String bottomEdge(String value) {
    return 'Bottom edge $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: $value from level. Bottom edge $other';
  }

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
      'Point the top of the phone in the direction you want to know. Holding it upright? It reads the direction the back camera faces.';

  @override
  String get compassHelp3 =>
      'The number is your heading in degrees and the letters are the direction. The dial turns so its N always points north; the orange ball at the top marks where your phone points.';

  @override
  String get compassTip =>
      'It points to magnetic north, which can differ a few degrees from map north. If it seems wrong, move the phone in a figure 8 a few times.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Magnetic heading $heading degrees, $direction';
  }

  @override
  String get magneticInterference =>
      'Magnetic interference · move away from metal, then wave the phone in a figure 8';

  @override
  String get compassCalibrate =>
      'Wave the phone in a figure 8 to calibrate the compass';

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
  String get rotateToCalibrate => 'Turn to portrait to calibrate';

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
      '“Metal nearby” means a small change, “Metal detected” a strong one. Like the game of hot and cold, the screen warms from cool blue to glowing red as you get closer, and the phone buzzes on a find if vibration is on.';

  @override
  String get metalHelp4 =>
      'Hold the phone still for a few seconds and it re-zeroes itself, so a false reading fades away. To check a spot again, move the phone away and back. Tap Set baseline to re-zero at once.';

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
  String get heatCold => 'Cold';

  @override
  String get heatCool => 'Cool';

  @override
  String get heatWarm => 'Warm';

  @override
  String get heatWarmer => 'Warmer';

  @override
  String get heatHot => 'Hot';

  @override
  String get heatBurning => 'Burning';

  @override
  String get baseline => 'Baseline';

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
      'Place the phone flat on the running machine and keep your hands off it. On a small machine, hold it down firmly.';

  @override
  String get vibrationHelp2 =>
      'The needle shows the speed of the strongest vibration in RPM, with hertz under it (RPM is hertz × 60). The faint glow inside the dial is the whole spectrum; the needle points into its brightest part.';

  @override
  String get vibrationHelp3 =>
      'Strength is how hard it shakes, in m/s²: under 0.3 is still, over 2 is strong.';

  @override
  String get vibrationHelp4 =>
      'Tap Lock to hold a reading, and the reset button before measuring the next machine.';

  @override
  String get vibrationTip =>
      'Most phones measure up to 100 Hz (6000 RPM), some less; the dial shows your phone\'s limit. Faster vibration can show up as a wrong, lower speed. The strongest vibration is often the shaft speed, but can be twice it. Phone sensors aren\'t lab instruments.';

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
  String get frequency => 'Frequency';

  @override
  String get rpm => 'RPM';

  @override
  String get strength => 'Strength';

  @override
  String vibratingAt(String value) {
    return 'Vibrating at $value Hz';
  }

  @override
  String get noClearFrequency => 'No clear frequency';

  @override
  String get findingFrequency => 'Finding the frequency…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm revolutions per minute, $value hertz';
  }

  @override
  String get peak => 'Peak';

  @override
  String get average => 'Average';

  @override
  String get resetPeak => 'Reset peak';

  @override
  String get altimeterHelp1 =>
      'A hiker climbs the mountain with your height. The sky follows the time of day and the season; tap the weather button to pick your own.';

  @override
  String get altimeterHelp2 =>
      'To measure a height change, like stairs or floors, tap Set zero here where you start.';

  @override
  String get altimeterHelp3 =>
      'Go up or down: the hiker walks with you and the flag marks your highest point. The panel shows metres from your zero, air pressure and approximate altitude.';

  @override
  String get altimeterHelp4 => 'Tap Clear zero to show air pressure again.';

  @override
  String get altimeterTip =>
      'Weather changes air pressure, so altitude can be off by tens of metres. Height from your zero is accurate over short periods. This tool needs a phone with a barometer.';

  @override
  String get weather => 'Weather';

  @override
  String get weatherAuto => 'Auto (time of day and season)';

  @override
  String get weatherSunny => 'Sunny';

  @override
  String get weatherCloudy => 'Cloudy';

  @override
  String get weatherRain => 'Rain';

  @override
  String get weatherStorm => 'Storm';

  @override
  String get weatherSnow => 'Snow';

  @override
  String get fromZero => 'From zero';

  @override
  String get altitudeShort => 'Altitude';

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
      'The sky follows the light: night when it\'s dark, dawn in a dim room, and the sun climbs as it gets brighter. Read the lux and what the light is good for: 300 to 750 lx suits reading and desk work.';

  @override
  String get lightHelp4 =>
      'Tap Lock to keep a reading while you move the phone away.';

  @override
  String get lightTip =>
      'Light sensors differ between phones, so readings can be 10 to 20% off: good for comparing places, not a calibrated lux meter. Don’t cover the top of the screen.';

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
      'The big number is the level now, averaged over about a second. Ripples spread from it, more and further the louder it is: green when quiet, then yellow, orange, red and crimson. The bars below show the last three seconds.';

  @override
  String get soundHelp3 =>
      'Average and Max count from when you opened the tool. Tap Reset to start them again.';

  @override
  String get soundHelp4 =>
      'From 70 dB the status line turns yellow; from 85 dB, where long exposure can damage hearing, it turns red.';

  @override
  String get soundHelp5 =>
      'Tap the lock to keep a reading on screen while you move the phone.';

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
  String get unitDegrees => 'Degrees';

  @override
  String get unitPercent => 'Percent slope';

  @override
  String get unitRoofPitch => 'Roof pitch (rise per 12)';

  @override
  String get vibrateWhenLevel => 'Vibration';

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
      'This removes the calibration you set in the Level (also used by the Angle tool) and in the Ruler. Both go back to their factory settings. Your other settings stay as they are, and you can calibrate again at any time.';

  @override
  String get notCalibrated => 'Not calibrated';

  @override
  String get language => 'Language';

  @override
  String get licenses => 'Open-source licences';

  @override
  String get languageSystem => 'Phone language';

  @override
  String get toolHeight => 'Height';

  @override
  String get toolHeightSubtitle => 'Height and distance by sighting';

  @override
  String get heightHelp1 =>
      'Stand where you can see the object’s base and top. Hold the phone screen up and look along its top edge.';

  @override
  String get heightHelp2 =>
      'Aim the top edge at the base of the object and tap Lock base: this gives the distance.';

  @override
  String get heightHelp3 =>
      'Aim the top edge at the top and tap Lock top: the height appears.';

  @override
  String get heightHelp4 =>
      'Know the distance? Tap Distance and type it, then aim only at the top. Tap Eye height to set yours.';

  @override
  String get heightTip =>
      'About ±5% on level ground with your eye height set right (your height minus about 10 cm). Stand back so the top is under 70° and the base at least 3° below level. On a slope, type the distance.';

  @override
  String get lockBase => 'Lock base';

  @override
  String get lockTop => 'Lock top';

  @override
  String get measureAgain => 'Measure again';

  @override
  String get distance => 'Distance';

  @override
  String get objectHeight => 'Height';

  @override
  String get eyeHeight => 'Eye height';

  @override
  String get sightAngle => 'Sight angle';

  @override
  String get heightAimBase => 'Aim the top edge at the base';

  @override
  String get heightAimTop => 'Now aim the top edge at the top';

  @override
  String get heightDone => 'Done · tap Measure again for another';

  @override
  String get heightHoldFlatter =>
      'Hold the phone flatter and sight along its top edge';

  @override
  String get heightTooFar =>
      'Base too near level: step closer or type the distance';

  @override
  String get heightStepBack => 'Very steep: step back for a steadier reading';

  @override
  String get knownDistance => 'Distance to the base';

  @override
  String get knownDistanceHint =>
      'The distance along the ground to the object’s base. Clear it to measure by sighting.';

  @override
  String get eyeHeightHint =>
      'How high your eyes are above the ground: about your height minus 10 cm.';

  @override
  String get clear => 'Clear';
}
