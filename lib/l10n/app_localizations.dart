import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('ur'),
  ];

  /// Full app name, used by the system task switcher.
  ///
  /// In en, this message translates to:
  /// **'Bubble Level & Angle Finder'**
  String get appTitle;

  /// Short app name in the home screen header.
  ///
  /// In en, this message translates to:
  /// **'Bubble Level'**
  String get homeTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @homeTopTools.
  ///
  /// In en, this message translates to:
  /// **'Your top tools'**
  String get homeTopTools;

  /// No description provided for @homeMoreTools.
  ///
  /// In en, this message translates to:
  /// **'More tools'**
  String get homeMoreTools;

  /// No description provided for @homeArrange.
  ///
  /// In en, this message translates to:
  /// **'Arrange'**
  String get homeArrange;

  /// No description provided for @arrangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Arrange tools'**
  String get arrangeTitle;

  /// No description provided for @arrangeHint.
  ///
  /// In en, this message translates to:
  /// **'Drag to change the order. The first three are your top tools.'**
  String get arrangeHint;

  /// No description provided for @arrangeStar.
  ///
  /// In en, this message translates to:
  /// **'Make it a top tool'**
  String get arrangeStar;

  /// No description provided for @arrangeUnstar.
  ///
  /// In en, this message translates to:
  /// **'Remove from top tools'**
  String get arrangeUnstar;

  /// No description provided for @arrangeReset.
  ///
  /// In en, this message translates to:
  /// **'Popular order'**
  String get arrangeReset;

  /// No description provided for @arrangeDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get arrangeDone;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// Tool name: bubble / spirit level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get toolLevel;

  /// No description provided for @toolLevelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bubble and spirit level'**
  String get toolLevelSubtitle;

  /// Tool name: inclinometer / angle finder.
  ///
  /// In en, this message translates to:
  /// **'Angle'**
  String get toolAngle;

  /// No description provided for @toolAngleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Angle from level or from a zero'**
  String get toolAngleSubtitle;

  /// No description provided for @toolCompass.
  ///
  /// In en, this message translates to:
  /// **'Compass'**
  String get toolCompass;

  /// No description provided for @toolCompassSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Heading and direction'**
  String get toolCompassSubtitle;

  /// No description provided for @toolProtractor.
  ///
  /// In en, this message translates to:
  /// **'Protractor'**
  String get toolProtractor;

  /// No description provided for @toolProtractorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Measure angles on the screen'**
  String get toolProtractorSubtitle;

  /// No description provided for @toolRuler.
  ///
  /// In en, this message translates to:
  /// **'Ruler'**
  String get toolRuler;

  /// No description provided for @toolRulerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Measure length on the screen'**
  String get toolRulerSubtitle;

  /// No description provided for @toolMetal.
  ///
  /// In en, this message translates to:
  /// **'Metal detector'**
  String get toolMetal;

  /// No description provided for @toolMetalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find iron, steel and magnets'**
  String get toolMetalSubtitle;

  /// Tool name: vibration meter.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get toolVibration;

  /// No description provided for @toolVibrationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Vibration strength and speed (RPM)'**
  String get toolVibrationSubtitle;

  /// No description provided for @toolSound.
  ///
  /// In en, this message translates to:
  /// **'Sound meter'**
  String get toolSound;

  /// No description provided for @toolSoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Noise level in decibels'**
  String get toolSoundSubtitle;

  /// No description provided for @toolAltimeter.
  ///
  /// In en, this message translates to:
  /// **'Altimeter'**
  String get toolAltimeter;

  /// No description provided for @toolAltimeterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Air pressure and altitude'**
  String get toolAltimeterSubtitle;

  /// No description provided for @toolLight.
  ///
  /// In en, this message translates to:
  /// **'Light meter'**
  String get toolLight;

  /// No description provided for @toolLightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Brightness in lux'**
  String get toolLightSubtitle;

  /// No description provided for @notAvailableOnPhone.
  ///
  /// In en, this message translates to:
  /// **'Not available on this phone'**
  String get notAvailableOnPhone;

  /// Very short version of notAvailableOnPhone, under a grid icon.
  ///
  /// In en, this message translates to:
  /// **'Not on this phone'**
  String get notOnPhone;

  /// No description provided for @toolNotAvailableSemantics.
  ///
  /// In en, this message translates to:
  /// **'{tool}, not available on this phone'**
  String toolNotAvailableSemantics(String tool);

  /// Tooltip of the help button on every tool.
  ///
  /// In en, this message translates to:
  /// **'How to use'**
  String get howToUse;

  /// No description provided for @rotateLandscape.
  ///
  /// In en, this message translates to:
  /// **'Turn to landscape'**
  String get rotateLandscape;

  /// No description provided for @rotatePortrait.
  ///
  /// In en, this message translates to:
  /// **'Turn to portrait'**
  String get rotatePortrait;

  /// No description provided for @howToUseTool.
  ///
  /// In en, this message translates to:
  /// **'How to use {tool}'**
  String howToUseTool(String tool);

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// Bold lead-in before a tip; keep the trailing space.
  ///
  /// In en, this message translates to:
  /// **'Good to know: '**
  String get goodToKnow;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @toolUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'{tool} isn’t available'**
  String toolUnavailableTitle(String tool);

  /// No description provided for @toolUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'{tool} needs {count, plural, =1{a sensor} other{sensors}} this phone doesn’t have: {sensors}.'**
  String toolUnavailableBody(String tool, int count, String sensors);

  /// No description provided for @listSeparator.
  ///
  /// In en, this message translates to:
  /// **', '**
  String get listSeparator;

  /// No description provided for @hardwareLimitTip.
  ///
  /// In en, this message translates to:
  /// **'This is a limit of the phone’s hardware, not a fault in the app. All the other tools work normally.'**
  String get hardwareLimitTip;

  /// No description provided for @sensorAccelerometer.
  ///
  /// In en, this message translates to:
  /// **'accelerometer'**
  String get sensorAccelerometer;

  /// No description provided for @sensorMagnetometer.
  ///
  /// In en, this message translates to:
  /// **'magnetometer (compass sensor)'**
  String get sensorMagnetometer;

  /// No description provided for @sensorBarometer.
  ///
  /// In en, this message translates to:
  /// **'barometer (air pressure sensor)'**
  String get sensorBarometer;

  /// No description provided for @sensorLight.
  ///
  /// In en, this message translates to:
  /// **'light sensor'**
  String get sensorLight;

  /// No description provided for @sensorMicrophone.
  ///
  /// In en, this message translates to:
  /// **'microphone'**
  String get sensorMicrophone;

  /// No description provided for @sensorCamera.
  ///
  /// In en, this message translates to:
  /// **'back camera'**
  String get sensorCamera;

  /// No description provided for @sensorGps.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get sensorGps;

  /// No description provided for @noAccelerometer.
  ///
  /// In en, this message translates to:
  /// **'This phone has no accelerometer, so this tool can’t measure anything here. Tools that don’t need it still work.'**
  String get noAccelerometer;

  /// No description provided for @noMagnetometer.
  ///
  /// In en, this message translates to:
  /// **'This phone has no magnetometer (compass sensor), so this tool can’t work here. Tools that don’t need it still work.'**
  String get noMagnetometer;

  /// No description provided for @noReadings.
  ///
  /// In en, this message translates to:
  /// **'No readings from the sensor yet. Go back and open the tool again; if it keeps happening, restart your phone. Some phones don’t support this tool.'**
  String get noReadings;

  /// No description provided for @waitingForSensors.
  ///
  /// In en, this message translates to:
  /// **'Waiting for sensors…'**
  String get waitingForSensors;

  /// No description provided for @levelHelp1.
  ///
  /// In en, this message translates to:
  /// **'Lay the phone flat on the surface, or stand it on one of its edges.'**
  String get levelHelp1;

  /// No description provided for @levelHelp2.
  ///
  /// In en, this message translates to:
  /// **'Flat: centre the bubble. X is left/right tilt, Y is forward/back tilt. On an edge, you see the angle and slope.'**
  String get levelHelp2;

  /// No description provided for @levelHelp3.
  ///
  /// In en, this message translates to:
  /// **'Follow the hint on screen (for example “Right side high”) until it reads level: it turns orange and the phone chimes and taps (turn these off in Settings).'**
  String get levelHelp3;

  /// No description provided for @levelHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Lock to freeze the reading, and Unlock to go live again.'**
  String get levelHelp4;

  /// No description provided for @levelHelp5.
  ///
  /// In en, this message translates to:
  /// **'Prefer a classic spirit level? Tap the tube icon in the switch; the round icon brings the dial back.'**
  String get levelHelp5;

  /// No description provided for @levelTip.
  ///
  /// In en, this message translates to:
  /// **'If a surface you know is level doesn’t read 0°, put the phone on it and tap Calibrate. To undo it, tap Calibrate again and choose Reset calibration.'**
  String get levelTip;

  /// Status when the surface is exactly level (adjective).
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get statusLevel;

  /// No description provided for @leftEndLow.
  ///
  /// In en, this message translates to:
  /// **'Left end low'**
  String get leftEndLow;

  /// No description provided for @rightEndLow.
  ///
  /// In en, this message translates to:
  /// **'Right end low'**
  String get rightEndLow;

  /// No description provided for @rightSideHigh.
  ///
  /// In en, this message translates to:
  /// **'Right side high'**
  String get rightSideHigh;

  /// No description provided for @leftSideHigh.
  ///
  /// In en, this message translates to:
  /// **'Left side high'**
  String get leftSideHigh;

  /// No description provided for @topEdgeHigh.
  ///
  /// In en, this message translates to:
  /// **'Top edge high'**
  String get topEdgeHigh;

  /// No description provided for @bottomEdgeHigh.
  ///
  /// In en, this message translates to:
  /// **'Bottom edge high'**
  String get bottomEdgeHigh;

  /// No description provided for @calibrated.
  ///
  /// In en, this message translates to:
  /// **'Calibrated. This position now reads 0°.'**
  String get calibrated;

  /// No description provided for @tooFarToCalibrate.
  ///
  /// In en, this message translates to:
  /// **'Too far from level to calibrate. Place the phone on a level surface first.'**
  String get tooFarToCalibrate;

  /// No description provided for @dialView.
  ///
  /// In en, this message translates to:
  /// **'Dial view'**
  String get dialView;

  /// Classic spirit-level vial view.
  ///
  /// In en, this message translates to:
  /// **'Tube view'**
  String get tubeView;

  /// No description provided for @levelTube.
  ///
  /// In en, this message translates to:
  /// **'Level tube'**
  String get levelTube;

  /// No description provided for @leftRightTube.
  ///
  /// In en, this message translates to:
  /// **'Left and right tube'**
  String get leftRightTube;

  /// No description provided for @forwardBackTube.
  ///
  /// In en, this message translates to:
  /// **'Forward and back tube'**
  String get forwardBackTube;

  /// No description provided for @tiltFromLevel.
  ///
  /// In en, this message translates to:
  /// **'Tilt from level {value}'**
  String tiltFromLevel(String value);

  /// No description provided for @fromLevel.
  ///
  /// In en, this message translates to:
  /// **'From level {value}'**
  String fromLevel(String value);

  /// No description provided for @xLeftRight.
  ///
  /// In en, this message translates to:
  /// **'X · left / right'**
  String get xLeftRight;

  /// No description provided for @yForwardBack.
  ///
  /// In en, this message translates to:
  /// **'Y · forward / back'**
  String get yForwardBack;

  /// No description provided for @angle.
  ///
  /// In en, this message translates to:
  /// **'Angle'**
  String get angle;

  /// No description provided for @slope.
  ///
  /// In en, this message translates to:
  /// **'Slope'**
  String get slope;

  /// No description provided for @lock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get lock;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked · {status}'**
  String locked(String status);

  /// No description provided for @lockReading.
  ///
  /// In en, this message translates to:
  /// **'Lock reading'**
  String get lockReading;

  /// No description provided for @lockHandles.
  ///
  /// In en, this message translates to:
  /// **'Lock handles'**
  String get lockHandles;

  /// No description provided for @handlesLocked.
  ///
  /// In en, this message translates to:
  /// **'Handles locked · tap the lock to adjust'**
  String get handlesLocked;

  /// No description provided for @calibrate.
  ///
  /// In en, this message translates to:
  /// **'Calibrate'**
  String get calibrate;

  /// No description provided for @angleHelp1.
  ///
  /// In en, this message translates to:
  /// **'Lay the phone on a surface to read its tilt, or stand it on an edge against a slope, rail or pipe: the big number is the angle of the edge that glows orange, the bottom edge’s is below.'**
  String get angleHelp1;

  /// No description provided for @angleHelp2.
  ///
  /// In en, this message translates to:
  /// **'To measure a change, hold the phone in the starting position and tap Set zero here.'**
  String get angleHelp2;

  /// No description provided for @angleHelp3.
  ///
  /// In en, this message translates to:
  /// **'Tilt or move the phone. The dial shows how many degrees it moved from your zero.'**
  String get angleHelp3;

  /// No description provided for @angleHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Clear zero to go back to the angle from flat.'**
  String get angleHelp4;

  /// No description provided for @angleHelp5.
  ///
  /// In en, this message translates to:
  /// **'To read an angle you can’t see, hold the phone against the object, tap the lock, then lift it and read.'**
  String get angleHelp5;

  /// No description provided for @angleHelp6.
  ///
  /// In en, this message translates to:
  /// **'Choose the mode with the switch at the top: flat on a surface, or standing on an edge. On an edge the screen fills with water that stays level, and the edge you’re measuring, the lower side, glows orange.'**
  String get angleHelp6;

  /// No description provided for @angleTip.
  ///
  /// In en, this message translates to:
  /// **'Lay the phone’s long side along a ramp, stair rail or roof to read its slope, or press the screen flat against a board or door to measure its tilt.'**
  String get angleTip;

  /// No description provided for @movedFromZero.
  ///
  /// In en, this message translates to:
  /// **'Moved from zero {value}'**
  String movedFromZero(String value);

  /// No description provided for @measuringFromZero.
  ///
  /// In en, this message translates to:
  /// **'Measuring from your zero'**
  String get measuringFromZero;

  /// No description provided for @angleFlatStatus.
  ///
  /// In en, this message translates to:
  /// **'Flat · angle from the Earth'**
  String get angleFlatStatus;

  /// No description provided for @measuringRightEdge.
  ///
  /// In en, this message translates to:
  /// **'Measuring the right edge'**
  String get measuringRightEdge;

  /// No description provided for @measuringLeftEdge.
  ///
  /// In en, this message translates to:
  /// **'Measuring the left edge'**
  String get measuringLeftEdge;

  /// No description provided for @bottomEdge.
  ///
  /// In en, this message translates to:
  /// **'Bottom edge {value}'**
  String bottomEdge(String value);

  /// No description provided for @edgeAngleSemantics.
  ///
  /// In en, this message translates to:
  /// **'{edge}: {value} from level. Bottom edge {other}'**
  String edgeAngleSemantics(String edge, String value, String other);

  /// No description provided for @angleModeFlat.
  ///
  /// In en, this message translates to:
  /// **'Flat on a surface'**
  String get angleModeFlat;

  /// No description provided for @angleModeEdge.
  ///
  /// In en, this message translates to:
  /// **'On an edge'**
  String get angleModeEdge;

  /// No description provided for @standOnEdge.
  ///
  /// In en, this message translates to:
  /// **'Stand the phone on one of its edges'**
  String get standOnEdge;

  /// No description provided for @clearZero.
  ///
  /// In en, this message translates to:
  /// **'Clear zero'**
  String get clearZero;

  /// No description provided for @setZeroHere.
  ///
  /// In en, this message translates to:
  /// **'Set zero here'**
  String get setZeroHere;

  /// No description provided for @compassHelp1.
  ///
  /// In en, this message translates to:
  /// **'Hold the phone level in front of you, away from metal, magnets and electronics.'**
  String get compassHelp1;

  /// No description provided for @compassHelp2.
  ///
  /// In en, this message translates to:
  /// **'Point the top of the phone in the direction you want to know. Holding it upright? It reads the direction the back camera faces.'**
  String get compassHelp2;

  /// No description provided for @compassHelp3.
  ///
  /// In en, this message translates to:
  /// **'The number is your heading in degrees and the letters are the direction. The dial turns so its N always points north; the orange ball at the top marks where your phone points.'**
  String get compassHelp3;

  /// No description provided for @compassTip.
  ///
  /// In en, this message translates to:
  /// **'It points to magnetic north, which in some places differs from map north by 10 degrees or more. If it seems wrong, move the phone in a figure 8 a few times.'**
  String get compassTip;

  /// No description provided for @compassSemantics.
  ///
  /// In en, this message translates to:
  /// **'Magnetic heading {heading} degrees, {direction}'**
  String compassSemantics(int heading, String direction);

  /// No description provided for @magneticInterference.
  ///
  /// In en, this message translates to:
  /// **'Magnetic interference · move away from metal, then wave the phone in a figure 8'**
  String get magneticInterference;

  /// No description provided for @compassCalibrate.
  ///
  /// In en, this message translates to:
  /// **'Wave the phone in a figure 8 to calibrate the compass'**
  String get compassCalibrate;

  /// Compass abbreviation: north. Also the N on the dial.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get dirN;

  /// No description provided for @dirNE.
  ///
  /// In en, this message translates to:
  /// **'NE'**
  String get dirNE;

  /// No description provided for @dirE.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get dirE;

  /// No description provided for @dirSE.
  ///
  /// In en, this message translates to:
  /// **'SE'**
  String get dirSE;

  /// No description provided for @dirS.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get dirS;

  /// No description provided for @dirSW.
  ///
  /// In en, this message translates to:
  /// **'SW'**
  String get dirSW;

  /// No description provided for @dirW.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get dirW;

  /// No description provided for @dirNW.
  ///
  /// In en, this message translates to:
  /// **'NW'**
  String get dirNW;

  /// No description provided for @protractorHelp1.
  ///
  /// In en, this message translates to:
  /// **'Lay the phone flat and place the object on the screen, with its corner at the centre.'**
  String get protractorHelp1;

  /// No description provided for @protractorHelp2.
  ///
  /// In en, this message translates to:
  /// **'Drag each orange handle so its line runs along one edge of the angle.'**
  String get protractorHelp2;

  /// No description provided for @protractorHelp3.
  ///
  /// In en, this message translates to:
  /// **'Read the angle in the centre. Reflex is the other side (360° minus it).'**
  String get protractorHelp3;

  /// No description provided for @protractorHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Reset to start again.'**
  String get protractorHelp4;

  /// No description provided for @protractorHelp5.
  ///
  /// In en, this message translates to:
  /// **'Tap the lock to keep the handles in place while you move the object.'**
  String get protractorHelp5;

  /// No description provided for @armsSemantics.
  ///
  /// In en, this message translates to:
  /// **'Angle between the arms {value}'**
  String armsSemantics(String value);

  /// Reflex angle: 360° minus the angle.
  ///
  /// In en, this message translates to:
  /// **'Reflex'**
  String get reflex;

  /// No description provided for @dragHandles.
  ///
  /// In en, this message translates to:
  /// **'Drag the orange handles along the edges'**
  String get dragHandles;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @rulerHelp1.
  ///
  /// In en, this message translates to:
  /// **'Lay the object on the screen, or hold the phone against it.'**
  String get rulerHelp1;

  /// No description provided for @rulerHelp2.
  ///
  /// In en, this message translates to:
  /// **'Drag the orange lines to its two ends. Tap mm, cm or in to pick the unit; the other system shows below.'**
  String get rulerHelp2;

  /// No description provided for @rulerHelp3.
  ///
  /// In en, this message translates to:
  /// **'For the best accuracy, tap Calibrate once and use a bank card, a ruler or the screen size.'**
  String get rulerHelp3;

  /// No description provided for @rulerHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap the lock to keep the lines in place while you move the object.'**
  String get rulerHelp4;

  /// No description provided for @rulerTip.
  ///
  /// In en, this message translates to:
  /// **'It measures up to the length of the screen. Cases and curved edges hide the first millimetres, so measure between the lines, not from the edge of the phone.'**
  String get rulerTip;

  /// No description provided for @rulerWidthOn.
  ///
  /// In en, this message translates to:
  /// **'Measure width too'**
  String get rulerWidthOn;

  /// No description provided for @rulerArea.
  ///
  /// In en, this message translates to:
  /// **'Area {value}'**
  String rulerArea(String value);

  /// No description provided for @rulerBoxSemantics.
  ///
  /// In en, this message translates to:
  /// **'Length {length} millimetres, width {width} millimetres, area {area} square centimetres'**
  String rulerBoxSemantics(String length, String width, String area);

  /// No description provided for @rulerHelp5.
  ///
  /// In en, this message translates to:
  /// **'Tap the box button at the top to measure width too: drag the two side lines to the object’s sides to read its width and area. Width can only be as wide as the screen.'**
  String get rulerHelp5;

  /// No description provided for @rulerSemantics.
  ///
  /// In en, this message translates to:
  /// **'Length {mm} millimetres, {inches} inches'**
  String rulerSemantics(String mm, String inches);

  /// No description provided for @rulerCalibrated.
  ///
  /// In en, this message translates to:
  /// **'Calibrated with a card · ±0.5 mm'**
  String get rulerCalibrated;

  /// No description provided for @rulerReported.
  ///
  /// In en, this message translates to:
  /// **'Screen size from the phone · calibrate for ±0.5 mm'**
  String get rulerReported;

  /// No description provided for @unitMillimetres.
  ///
  /// In en, this message translates to:
  /// **'Millimetres'**
  String get unitMillimetres;

  /// No description provided for @unitCentimetres.
  ///
  /// In en, this message translates to:
  /// **'Centimetres'**
  String get unitCentimetres;

  /// No description provided for @unitInches.
  ///
  /// In en, this message translates to:
  /// **'Inches'**
  String get unitInches;

  /// No description provided for @rulerEstimated.
  ///
  /// In en, this message translates to:
  /// **'Not calibrated · lengths may be 10% off'**
  String get rulerEstimated;

  /// No description provided for @cardLongEdge.
  ///
  /// In en, this message translates to:
  /// **'Lay any bank or ID card on the screen, long edge along the ruler, one end on the dark line. Drag the orange line to the card’s other end.'**
  String get cardLongEdge;

  /// No description provided for @cardShortEdge.
  ///
  /// In en, this message translates to:
  /// **'Lay any bank or ID card on the screen, short edge along the ruler, one end on the dark line. Drag the orange line to the card’s other end.'**
  String get cardShortEdge;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @usePhoneDefault.
  ///
  /// In en, this message translates to:
  /// **'Use the phone’s screen size'**
  String get usePhoneDefault;

  /// No description provided for @usePhoneDefaultInfo.
  ///
  /// In en, this message translates to:
  /// **'Forget this calibration'**
  String get usePhoneDefaultInfo;

  /// No description provided for @cardMismatch.
  ///
  /// In en, this message translates to:
  /// **'That doesn’t match a card. Line it up with the dark line and try again.'**
  String get cardMismatch;

  /// No description provided for @rotateToCalibrate.
  ///
  /// In en, this message translates to:
  /// **'Turn to portrait to calibrate'**
  String get rotateToCalibrate;

  /// No description provided for @calibrateHow.
  ///
  /// In en, this message translates to:
  /// **'Calibrate with'**
  String get calibrateHow;

  /// No description provided for @methodCard.
  ///
  /// In en, this message translates to:
  /// **'A bank card'**
  String get methodCard;

  /// No description provided for @methodCardInfo.
  ///
  /// In en, this message translates to:
  /// **'Any bank or ID card · ±0.5 mm'**
  String get methodCardInfo;

  /// No description provided for @methodRuler.
  ///
  /// In en, this message translates to:
  /// **'A ruler'**
  String get methodRuler;

  /// No description provided for @methodRulerInfo.
  ///
  /// In en, this message translates to:
  /// **'Most accurate · a ruler or tape measure'**
  String get methodRulerInfo;

  /// No description provided for @methodScreen.
  ///
  /// In en, this message translates to:
  /// **'The screen size'**
  String get methodScreen;

  /// No description provided for @methodScreenInfo.
  ///
  /// In en, this message translates to:
  /// **'Nothing needed · about 1%'**
  String get methodScreenInfo;

  /// No description provided for @rulerInstructions.
  ///
  /// In en, this message translates to:
  /// **'Lay a ruler on the screen with its 0 on the dark line. Drag the orange line to the {mark} mark.'**
  String rulerInstructions(String mark);

  /// No description provided for @rulerMismatch.
  ///
  /// In en, this message translates to:
  /// **'That doesn’t match {mark}. Put the ruler’s 0 on the dark line and try again.'**
  String rulerMismatch(String mark);

  /// No description provided for @screenSizeInstructions.
  ///
  /// In en, this message translates to:
  /// **'Type the screen size in inches from the phone’s specs. Not sure? Search your phone’s model and “screen size”.'**
  String get screenSizeInstructions;

  /// No description provided for @screenSizeMismatch.
  ///
  /// In en, this message translates to:
  /// **'That size doesn’t fit this screen. Check the phone’s specs and try again.'**
  String get screenSizeMismatch;

  /// No description provided for @rulerCalibratedRuler.
  ///
  /// In en, this message translates to:
  /// **'Calibrated with a ruler · ±0.5 mm'**
  String get rulerCalibratedRuler;

  /// No description provided for @rulerCalibratedScreen.
  ///
  /// In en, this message translates to:
  /// **'Set for a {size}-inch screen · about 1%'**
  String rulerCalibratedScreen(String size);

  /// No description provided for @metalHelp1.
  ///
  /// In en, this message translates to:
  /// **'Open the tool away from metal. That first reading counts as “no metal”.'**
  String get metalHelp1;

  /// No description provided for @metalHelp2.
  ///
  /// In en, this message translates to:
  /// **'Move the phone slowly over the area. The sensor is usually near the top of the phone. It beeps faster the closer you get to metal; tap the speaker to mute.'**
  String get metalHelp2;

  /// No description provided for @metalHelp3.
  ///
  /// In en, this message translates to:
  /// **'“Metal nearby” means a small change, “Metal detected” a strong one. Like the game of hot and cold, the screen warms from cool blue to glowing red as you get closer, and the phone buzzes on a find if vibration is on.'**
  String get metalHelp3;

  /// No description provided for @metalHelp4.
  ///
  /// In en, this message translates to:
  /// **'Hold the phone still for a few seconds and it re-zeroes itself, so a false reading fades away. To check a spot again, move the phone away and back. Tap Set baseline to re-zero at once.'**
  String get metalHelp4;

  /// No description provided for @metalTip.
  ///
  /// In en, this message translates to:
  /// **'It only senses iron, steel and magnets, not aluminium, copper, gold or silver. Magnetic phone cases affect it.'**
  String get metalTip;

  /// No description provided for @metalSemantics.
  ///
  /// In en, this message translates to:
  /// **'Magnetic field {value} microtesla'**
  String metalSemantics(int value);

  /// No description provided for @noMetal.
  ///
  /// In en, this message translates to:
  /// **'No metal nearby'**
  String get noMetal;

  /// No description provided for @metalNearby.
  ///
  /// In en, this message translates to:
  /// **'Metal nearby'**
  String get metalNearby;

  /// No description provided for @metalDetected.
  ///
  /// In en, this message translates to:
  /// **'Metal detected'**
  String get metalDetected;

  /// No description provided for @heatCold.
  ///
  /// In en, this message translates to:
  /// **'Cold'**
  String get heatCold;

  /// No description provided for @heatCool.
  ///
  /// In en, this message translates to:
  /// **'Cool'**
  String get heatCool;

  /// No description provided for @heatWarm.
  ///
  /// In en, this message translates to:
  /// **'Warm'**
  String get heatWarm;

  /// No description provided for @heatWarmer.
  ///
  /// In en, this message translates to:
  /// **'Warmer'**
  String get heatWarmer;

  /// No description provided for @heatHot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get heatHot;

  /// No description provided for @heatBurning.
  ///
  /// In en, this message translates to:
  /// **'Burning'**
  String get heatBurning;

  /// No description provided for @baseline.
  ///
  /// In en, this message translates to:
  /// **'Baseline'**
  String get baseline;

  /// Magnetic field strength.
  ///
  /// In en, this message translates to:
  /// **'Field'**
  String get field;

  /// Change of the magnetic field from the baseline.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @findsIronSteel.
  ///
  /// In en, this message translates to:
  /// **'Finds iron, steel and magnets'**
  String get findsIronSteel;

  /// No description provided for @setBaseline.
  ///
  /// In en, this message translates to:
  /// **'Set baseline'**
  String get setBaseline;

  /// No description provided for @muteSound.
  ///
  /// In en, this message translates to:
  /// **'Mute sound'**
  String get muteSound;

  /// No description provided for @turnSoundOn.
  ///
  /// In en, this message translates to:
  /// **'Turn sound on'**
  String get turnSoundOn;

  /// No description provided for @vibrationHelp1.
  ///
  /// In en, this message translates to:
  /// **'Place the phone flat on the running machine and keep your hands off it. On a small machine, hold it down firmly.'**
  String get vibrationHelp1;

  /// No description provided for @vibrationHelp2.
  ///
  /// In en, this message translates to:
  /// **'The needle shows the speed of the strongest vibration in RPM, with hertz under it (RPM is hertz × 60). The faint glow inside the dial is the whole spectrum; the needle points into its brightest part.'**
  String get vibrationHelp2;

  /// No description provided for @vibrationHelp3.
  ///
  /// In en, this message translates to:
  /// **'Strength is how hard it shakes, in m/s²: under 0.3 is still, over 2 is strong.'**
  String get vibrationHelp3;

  /// No description provided for @vibrationHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Lock to hold a reading, and the reset button before measuring the next machine.'**
  String get vibrationHelp4;

  /// No description provided for @vibrationTip.
  ///
  /// In en, this message translates to:
  /// **'Most phones measure up to 100 Hz (6000 RPM), some less; the dial shows your phone’s limit. Faster vibration can show up as a wrong, lower speed. The strongest vibration is often the shaft speed, but can be twice it. Phone sensors aren’t lab instruments.'**
  String get vibrationTip;

  /// No description provided for @still.
  ///
  /// In en, this message translates to:
  /// **'Still'**
  String get still;

  /// No description provided for @lightVibration.
  ///
  /// In en, this message translates to:
  /// **'Light vibration'**
  String get lightVibration;

  /// No description provided for @strongVibration.
  ///
  /// In en, this message translates to:
  /// **'Strong vibration'**
  String get strongVibration;

  /// No description provided for @noAccelerometerVibration.
  ///
  /// In en, this message translates to:
  /// **'This phone has no accelerometer, so vibration can’t be measured here. Tools that don’t need it still work.'**
  String get noAccelerometerVibration;

  /// No description provided for @vibrationSemantics.
  ///
  /// In en, this message translates to:
  /// **'Vibration {value} metres per second squared'**
  String vibrationSemantics(String value);

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @rpm.
  ///
  /// In en, this message translates to:
  /// **'RPM'**
  String get rpm;

  /// No description provided for @strength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get strength;

  /// No description provided for @vibratingAt.
  ///
  /// In en, this message translates to:
  /// **'Vibrating at {value} Hz'**
  String vibratingAt(String value);

  /// No description provided for @noClearFrequency.
  ///
  /// In en, this message translates to:
  /// **'No clear frequency'**
  String get noClearFrequency;

  /// No description provided for @findingFrequency.
  ///
  /// In en, this message translates to:
  /// **'Finding the frequency…'**
  String get findingFrequency;

  /// No description provided for @vibrationSpeedSemantics.
  ///
  /// In en, this message translates to:
  /// **'{rpm} revolutions per minute, {value} hertz'**
  String vibrationSpeedSemantics(String rpm, String value);

  /// No description provided for @peak.
  ///
  /// In en, this message translates to:
  /// **'Peak'**
  String get peak;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// No description provided for @resetPeak.
  ///
  /// In en, this message translates to:
  /// **'Reset peak'**
  String get resetPeak;

  /// No description provided for @altimeterHelp1.
  ///
  /// In en, this message translates to:
  /// **'The hiker on the mountain moves up and down as your height changes. The sky follows the time of day and the season; tap the weather button to pick your own.'**
  String get altimeterHelp1;

  /// No description provided for @altimeterHelp2.
  ///
  /// In en, this message translates to:
  /// **'To measure a height change, like stairs or floors, tap Set zero here where you start.'**
  String get altimeterHelp2;

  /// No description provided for @altimeterHelp3.
  ///
  /// In en, this message translates to:
  /// **'Go up or down: the hiker walks with you and the flag marks your highest point. The panel shows metres from your zero, air pressure and approximate altitude.'**
  String get altimeterHelp3;

  /// No description provided for @altimeterHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Clear zero to stop measuring from your zero: the From zero reading goes blank.'**
  String get altimeterHelp4;

  /// No description provided for @altimeterTip.
  ///
  /// In en, this message translates to:
  /// **'Weather keeps changing air pressure, so without a known starting height the altitude can be off by a hundred metres or more. Trust the height change from Set zero here over a short time. This tool needs a phone with a barometer.'**
  String get altimeterTip;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @weatherAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto (time of day and season)'**
  String get weatherAuto;

  /// No description provided for @weatherSunny.
  ///
  /// In en, this message translates to:
  /// **'Sunny'**
  String get weatherSunny;

  /// No description provided for @weatherCloudy.
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get weatherCloudy;

  /// No description provided for @weatherRain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get weatherRain;

  /// No description provided for @weatherStorm.
  ///
  /// In en, this message translates to:
  /// **'Storm'**
  String get weatherStorm;

  /// No description provided for @weatherSnow.
  ///
  /// In en, this message translates to:
  /// **'Snow'**
  String get weatherSnow;

  /// No description provided for @fromZero.
  ///
  /// In en, this message translates to:
  /// **'From zero'**
  String get fromZero;

  /// No description provided for @altitudeShort.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get altitudeShort;

  /// No description provided for @barometerIos.
  ///
  /// In en, this message translates to:
  /// **'Can’t read the barometer. Turn on Motion & Fitness for this app in Settings › Privacy & Security, then open the Altimeter again.'**
  String get barometerIos;

  /// No description provided for @noBarometer.
  ///
  /// In en, this message translates to:
  /// **'This phone has no barometer (air pressure sensor), so the Altimeter can’t work here. Other tools still work.'**
  String get noBarometer;

  /// No description provided for @noLightSensor.
  ///
  /// In en, this message translates to:
  /// **'This phone has no light sensor, so the Light meter can’t work here. Other tools still work.'**
  String get noLightSensor;

  /// No description provided for @lightSemantics.
  ///
  /// In en, this message translates to:
  /// **'Brightness {value} lux'**
  String lightSemantics(String value);

  /// No description provided for @illuminance.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get illuminance;

  /// No description provided for @footCandles.
  ///
  /// In en, this message translates to:
  /// **'Foot-candles'**
  String get footCandles;

  /// No description provided for @lightDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get lightDark;

  /// No description provided for @lightDim.
  ///
  /// In en, this message translates to:
  /// **'Dim light'**
  String get lightDim;

  /// No description provided for @lightLivingRoom.
  ///
  /// In en, this message translates to:
  /// **'Living-room light'**
  String get lightLivingRoom;

  /// No description provided for @lightReading.
  ///
  /// In en, this message translates to:
  /// **'Good for reading and desk work'**
  String get lightReading;

  /// No description provided for @lightBright.
  ///
  /// In en, this message translates to:
  /// **'Bright indoor light'**
  String get lightBright;

  /// No description provided for @lightOvercast.
  ///
  /// In en, this message translates to:
  /// **'Overcast daylight'**
  String get lightOvercast;

  /// No description provided for @lightDaylight.
  ///
  /// In en, this message translates to:
  /// **'Daylight'**
  String get lightDaylight;

  /// No description provided for @lightSun.
  ///
  /// In en, this message translates to:
  /// **'Direct sunlight'**
  String get lightSun;

  /// No description provided for @lightHelp1.
  ///
  /// In en, this message translates to:
  /// **'The light sensor sits at the top of the screen, near the front camera.'**
  String get lightHelp1;

  /// No description provided for @lightHelp2.
  ///
  /// In en, this message translates to:
  /// **'Hold the phone where you want to measure, with the screen facing the light.'**
  String get lightHelp2;

  /// No description provided for @lightHelp3.
  ///
  /// In en, this message translates to:
  /// **'The sky follows the light: night when it’s dark, dawn in a dim room, and the sun climbs as it gets brighter. Read the lux and what the light is good for: 300 to 750 lux suits reading and desk work.'**
  String get lightHelp3;

  /// No description provided for @lightHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Lock to keep a reading while you move the phone away.'**
  String get lightHelp4;

  /// No description provided for @lightTip.
  ///
  /// In en, this message translates to:
  /// **'Phone light sensors aren’t calibrated, so readings can differ a lot between phones. Use it to compare light in one place with the same phone, not as a calibrated lux meter. Don’t cover the top of the screen.'**
  String get lightTip;

  /// No description provided for @noMicrophone.
  ///
  /// In en, this message translates to:
  /// **'Can’t use the microphone. Another app may be using it: close that app, then open the Sound meter again.'**
  String get noMicrophone;

  /// No description provided for @soundSemantics.
  ///
  /// In en, this message translates to:
  /// **'Sound level about {value} decibels'**
  String soundSemantics(String value);

  /// No description provided for @decibelsApprox.
  ///
  /// In en, this message translates to:
  /// **'dB (approx.)'**
  String get decibelsApprox;

  /// No description provided for @soundMax.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get soundMax;

  /// No description provided for @soundVeryQuiet.
  ///
  /// In en, this message translates to:
  /// **'Very quiet'**
  String get soundVeryQuiet;

  /// No description provided for @soundQuiet.
  ///
  /// In en, this message translates to:
  /// **'Quiet, like a library'**
  String get soundQuiet;

  /// No description provided for @soundModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate, like a conversation'**
  String get soundModerate;

  /// No description provided for @soundLoud.
  ///
  /// In en, this message translates to:
  /// **'Loud, like busy traffic'**
  String get soundLoud;

  /// No description provided for @soundVeryLoud.
  ///
  /// In en, this message translates to:
  /// **'Very loud: long exposure can damage hearing'**
  String get soundVeryLoud;

  /// No description provided for @soundDangerous.
  ///
  /// In en, this message translates to:
  /// **'Dangerous: protect your ears'**
  String get soundDangerous;

  /// No description provided for @micTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow the microphone'**
  String get micTitle;

  /// No description provided for @micBody.
  ///
  /// In en, this message translates to:
  /// **'The Sound meter listens through the microphone to measure how loud it is. Sound is measured on your phone and never recorded, saved or sent.'**
  String get micBody;

  /// No description provided for @micAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow microphone'**
  String get micAllow;

  /// No description provided for @micDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Microphone access is off'**
  String get micDeniedTitle;

  /// No description provided for @micDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on the microphone for this app in Settings to use the Sound meter. Sound is never recorded, saved or sent.'**
  String get micDeniedBody;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @soundHelp1.
  ///
  /// In en, this message translates to:
  /// **'Keep the microphone (on the bottom edge) uncovered and point the phone toward the sound.'**
  String get soundHelp1;

  /// No description provided for @soundHelp2.
  ///
  /// In en, this message translates to:
  /// **'The big number is the level now, averaged over about a second. Ripples spread from it, more and further the louder it is: green when quiet, then yellow, orange, red and crimson. The bars below show the last three seconds.'**
  String get soundHelp2;

  /// No description provided for @soundHelp3.
  ///
  /// In en, this message translates to:
  /// **'Average and Max count from when you opened the tool. Tap Reset to start them again.'**
  String get soundHelp3;

  /// No description provided for @soundHelp4.
  ///
  /// In en, this message translates to:
  /// **'From 70 dB the status line turns yellow; from 85 dB, where long exposure can damage hearing, it turns red.'**
  String get soundHelp4;

  /// No description provided for @soundHelp5.
  ///
  /// In en, this message translates to:
  /// **'Tap the lock to keep a reading on screen while you move the phone.'**
  String get soundHelp5;

  /// No description provided for @soundTip.
  ///
  /// In en, this message translates to:
  /// **'Phone microphones aren’t calibrated sound level meters and differ between models, so readings are approximate (often within about 5 to 10 dB) and very loud sounds can read low. For anything official, use a calibrated sound level meter.'**
  String get soundTip;

  /// Short label under the height on the dial; keep it short.
  ///
  /// In en, this message translates to:
  /// **'m from zero'**
  String get metresFromZero;

  /// No description provided for @pressureSemantics.
  ///
  /// In en, this message translates to:
  /// **'Air pressure {value} hectopascals'**
  String pressureSemantics(String value);

  /// No description provided for @heightSemantics.
  ///
  /// In en, this message translates to:
  /// **'Height {value} from zero'**
  String heightSemantics(String value);

  /// No description provided for @pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @altitudeApprox.
  ///
  /// In en, this message translates to:
  /// **'Altitude (approx.)'**
  String get altitudeApprox;

  /// No description provided for @measuringHeight.
  ///
  /// In en, this message translates to:
  /// **'Measuring height from your zero'**
  String get measuringHeight;

  /// No description provided for @airPressureAltitude.
  ///
  /// In en, this message translates to:
  /// **'Air pressure and altitude'**
  String get airPressureAltitude;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @levelUnits.
  ///
  /// In en, this message translates to:
  /// **'Level units'**
  String get levelUnits;

  /// No description provided for @unitDegrees.
  ///
  /// In en, this message translates to:
  /// **'Degrees'**
  String get unitDegrees;

  /// No description provided for @unitPercent.
  ///
  /// In en, this message translates to:
  /// **'Percent slope'**
  String get unitPercent;

  /// No description provided for @unitRoofPitch.
  ///
  /// In en, this message translates to:
  /// **'Roof pitch (rise per 12)'**
  String get unitRoofPitch;

  /// No description provided for @vibrateWhenLevel.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibrateWhenLevel;

  /// No description provided for @sounds.
  ///
  /// In en, this message translates to:
  /// **'Sounds'**
  String get sounds;

  /// No description provided for @resetCalibration.
  ///
  /// In en, this message translates to:
  /// **'Reset calibration'**
  String get resetCalibration;

  /// No description provided for @resetCalibrationHint.
  ///
  /// In en, this message translates to:
  /// **'Use the factory sensor zero again'**
  String get resetCalibrationHint;

  /// No description provided for @calibrateHere.
  ///
  /// In en, this message translates to:
  /// **'Calibrate here'**
  String get calibrateHere;

  /// No description provided for @calibrateHereInfo.
  ///
  /// In en, this message translates to:
  /// **'On a surface you know is level'**
  String get calibrateHereInfo;

  /// No description provided for @calibrationRemoved.
  ///
  /// In en, this message translates to:
  /// **'Calibration removed. The Level uses the factory sensor zero again.'**
  String get calibrationRemoved;

  /// No description provided for @resetAllCalibrations.
  ///
  /// In en, this message translates to:
  /// **'Reset all calibrations'**
  String get resetAllCalibrations;

  /// No description provided for @resetAllCalibrationsHint.
  ///
  /// In en, this message translates to:
  /// **'Level and Ruler back to factory settings'**
  String get resetAllCalibrationsHint;

  /// No description provided for @resetAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset all calibrations?'**
  String get resetAllTitle;

  /// No description provided for @resetAllBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the calibration you set in the Level (also used by the Angle tool) and in the Ruler. Both go back to their factory settings. Your other settings stay as they are, and you can calibrate again at any time.'**
  String get resetAllBody;

  /// No description provided for @notCalibrated.
  ///
  /// In en, this message translates to:
  /// **'Not calibrated'**
  String get notCalibrated;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Open-source licences'**
  String get licenses;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'Phone language'**
  String get languageSystem;

  /// No description provided for @toolHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get toolHeight;

  /// No description provided for @toolHeightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Height and distance by sighting'**
  String get toolHeightSubtitle;

  /// No description provided for @heightHelp1.
  ///
  /// In en, this message translates to:
  /// **'Stand where you can see the object’s base and top. Hold the phone screen up and look along its top edge.'**
  String get heightHelp1;

  /// No description provided for @heightHelp2.
  ///
  /// In en, this message translates to:
  /// **'Aim the top edge at the base of the object and tap Lock base: this gives the distance.'**
  String get heightHelp2;

  /// No description provided for @heightHelp3.
  ///
  /// In en, this message translates to:
  /// **'Aim the top edge at the top and tap Lock top: the height appears.'**
  String get heightHelp3;

  /// No description provided for @heightHelp4.
  ///
  /// In en, this message translates to:
  /// **'Know the distance? Tap Distance and type it, then aim only at the top. Tap Eye height to set yours.'**
  String get heightHelp4;

  /// No description provided for @heightTip.
  ///
  /// In en, this message translates to:
  /// **'About ±5% on level ground with your eye height set right (your height minus about 10 cm). Stand back so the top is under 70° and the base at least 3° below level. On a slope, type the distance.'**
  String get heightTip;

  /// No description provided for @lockBase.
  ///
  /// In en, this message translates to:
  /// **'Lock base'**
  String get lockBase;

  /// No description provided for @lockTop.
  ///
  /// In en, this message translates to:
  /// **'Lock top'**
  String get lockTop;

  /// No description provided for @measureAgain.
  ///
  /// In en, this message translates to:
  /// **'Measure again'**
  String get measureAgain;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @objectHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get objectHeight;

  /// No description provided for @eyeHeight.
  ///
  /// In en, this message translates to:
  /// **'Eye height'**
  String get eyeHeight;

  /// No description provided for @sightAngle.
  ///
  /// In en, this message translates to:
  /// **'Sight angle'**
  String get sightAngle;

  /// No description provided for @heightAimBase.
  ///
  /// In en, this message translates to:
  /// **'Aim the top edge at the base'**
  String get heightAimBase;

  /// No description provided for @heightAimTop.
  ///
  /// In en, this message translates to:
  /// **'Now aim the top edge at the top'**
  String get heightAimTop;

  /// No description provided for @heightDone.
  ///
  /// In en, this message translates to:
  /// **'Done · tap Measure again for another'**
  String get heightDone;

  /// No description provided for @heightHoldFlatter.
  ///
  /// In en, this message translates to:
  /// **'Hold the phone flatter and sight along its top edge'**
  String get heightHoldFlatter;

  /// No description provided for @heightTooFar.
  ///
  /// In en, this message translates to:
  /// **'Base too near level: step closer or type the distance'**
  String get heightTooFar;

  /// No description provided for @heightStepBack.
  ///
  /// In en, this message translates to:
  /// **'Very steep: step back for a steadier reading'**
  String get heightStepBack;

  /// No description provided for @knownDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance to the base'**
  String get knownDistance;

  /// No description provided for @knownDistanceHint.
  ///
  /// In en, this message translates to:
  /// **'The distance along the ground to the object’s base. Clear it to measure by sighting.'**
  String get knownDistanceHint;

  /// No description provided for @eyeHeightHint.
  ///
  /// In en, this message translates to:
  /// **'How high your eyes are above the ground: about your height minus 10 cm.'**
  String get eyeHeightHint;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @toolCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera level'**
  String get toolCamera;

  /// No description provided for @toolCameraSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Level lines over the camera, measure any edge'**
  String get toolCameraSubtitle;

  /// No description provided for @cameraHelp1.
  ///
  /// In en, this message translates to:
  /// **'Point the back camera at a wall, a picture, a shelf or a door. Hold the phone upright, facing the wall squarely.'**
  String get cameraHelp1;

  /// No description provided for @cameraHelp2.
  ///
  /// In en, this message translates to:
  /// **'Solid lines follow gravity: they are always truly level and plumb. Dashed lines are fixed to your phone, and the small arc between them shows how far it is tilted. The true lines turn orange when the phone is level.'**
  String get cameraHelp2;

  /// No description provided for @cameraHelp3.
  ///
  /// In en, this message translates to:
  /// **'To check an object, tap Freeze, then drag the two orange handles onto one of its edges, like the top of a frame. It shows how far that edge is off level and which side to lift, even if your hand wasn’t level. Drag the line upright to check a plumb edge.'**
  String get cameraHelp3;

  /// No description provided for @cameraHelp4.
  ///
  /// In en, this message translates to:
  /// **'The two buttons at the top show or hide the phone lines and the true lines. The light helps in dark corners; Resume goes back to the live picture.'**
  String get cameraHelp4;

  /// No description provided for @cameraTip.
  ///
  /// In en, this message translates to:
  /// **'For an exact edge reading, face the wall squarely (Forward/back under 5°) and measure near the middle of the picture, where the lens bends lines least. Uses the Level’s on-edge calibration. The picture is never recorded, saved or sent.'**
  String get cameraTip;

  /// No description provided for @cameraAllowTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow the camera'**
  String get cameraAllowTitle;

  /// No description provided for @cameraAllowBody.
  ///
  /// In en, this message translates to:
  /// **'The Camera level draws level lines over the camera’s picture and measures edges in it. The picture stays on your phone and is never recorded, saved or sent.'**
  String get cameraAllowBody;

  /// No description provided for @cameraAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow camera'**
  String get cameraAllow;

  /// No description provided for @cameraDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera access is off'**
  String get cameraDeniedTitle;

  /// No description provided for @cameraDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on the camera for this app in Settings to use the Camera level. The picture is never recorded, saved or sent.'**
  String get cameraDeniedBody;

  /// No description provided for @noCamera.
  ///
  /// In en, this message translates to:
  /// **'Can’t use the camera. Another app may be using it, or this phone has none: close other camera apps, then open the Camera level again.'**
  String get noCamera;

  /// No description provided for @tilt.
  ///
  /// In en, this message translates to:
  /// **'Tilt'**
  String get tilt;

  /// No description provided for @forwardBack.
  ///
  /// In en, this message translates to:
  /// **'Forward/back'**
  String get forwardBack;

  /// No description provided for @cameraLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get cameraLevel;

  /// No description provided for @cameraTilted.
  ///
  /// In en, this message translates to:
  /// **'Tilted {value}°'**
  String cameraTilted(String value);

  /// No description provided for @cameraHoldUpright.
  ///
  /// In en, this message translates to:
  /// **'Hold the phone upright, camera to the wall'**
  String get cameraHoldUpright;

  /// No description provided for @freeze.
  ///
  /// In en, this message translates to:
  /// **'Freeze'**
  String get freeze;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @torch.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get torch;

  /// No description provided for @cameraSemantics.
  ///
  /// In en, this message translates to:
  /// **'Camera view with level lines, tilted {value} degrees'**
  String cameraSemantics(String value);

  /// No description provided for @cameraPhoneLines.
  ///
  /// In en, this message translates to:
  /// **'Phone lines'**
  String get cameraPhoneLines;

  /// No description provided for @cameraTrueLines.
  ///
  /// In en, this message translates to:
  /// **'True lines'**
  String get cameraTrueLines;

  /// No description provided for @cameraFrozen.
  ///
  /// In en, this message translates to:
  /// **'Frozen'**
  String get cameraFrozen;

  /// No description provided for @cameraDragHandles.
  ///
  /// In en, this message translates to:
  /// **'Drag the handles onto an edge'**
  String get cameraDragHandles;

  /// No description provided for @cameraFaceWall.
  ///
  /// In en, this message translates to:
  /// **'Face the wall squarely'**
  String get cameraFaceWall;

  /// No description provided for @edgeLevel.
  ///
  /// In en, this message translates to:
  /// **'This edge is level'**
  String get edgeLevel;

  /// No description provided for @edgePlumb.
  ///
  /// In en, this message translates to:
  /// **'This edge is plumb'**
  String get edgePlumb;

  /// No description provided for @edgeLiftRight.
  ///
  /// In en, this message translates to:
  /// **'Edge {value}° off, lift the right'**
  String edgeLiftRight(String value);

  /// No description provided for @edgeLiftLeft.
  ///
  /// In en, this message translates to:
  /// **'Edge {value}° off, lift the left'**
  String edgeLiftLeft(String value);

  /// No description provided for @edgeOffPlumb.
  ///
  /// In en, this message translates to:
  /// **'Edge {value}° off plumb'**
  String edgeOffPlumb(String value);

  /// No description provided for @cameraHandle.
  ///
  /// In en, this message translates to:
  /// **'Edge handle'**
  String get cameraHandle;

  /// No description provided for @toolGForce.
  ///
  /// In en, this message translates to:
  /// **'G-force'**
  String get toolGForce;

  /// No description provided for @toolGForceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Braking, speeding up and cornering in g'**
  String get toolGForceSubtitle;

  /// No description provided for @gHelp1.
  ///
  /// In en, this message translates to:
  /// **'Fix the phone in a car mount, screen facing you. While the car stands still, tap Zero: the meter learns which way is down and which way is forward.'**
  String get gHelp1;

  /// No description provided for @gHelp2.
  ///
  /// In en, this message translates to:
  /// **'Drive: the side of the car you’re pushed toward glows. Braking lights the front, speeding up the back, a bend the outside. Green is gentle, orange firm, red hard.'**
  String get gHelp2;

  /// No description provided for @gHelp3.
  ///
  /// In en, this message translates to:
  /// **'The panel holds the strongest speed up, brake and corner since Zero, and the dots on the rim hold the strongest push in each direction. The reset button clears them.'**
  String get gHelp3;

  /// No description provided for @gHelp4.
  ///
  /// In en, this message translates to:
  /// **'Keep your eyes on the road: let a passenger read it, or check the peaks once you’ve stopped.'**
  String get gHelp4;

  /// No description provided for @gTip.
  ///
  /// In en, this message translates to:
  /// **'Readings come from the accelerometer and are approximate: they rely on a firm mount and on Zero taken while standing still, and are a little noisier on rough roads. If the mount moves, stop and tap Zero again. Over 0.5 g is a hard stop or a fast bend for an everyday car.'**
  String get gTip;

  /// No description provided for @gZero.
  ///
  /// In en, this message translates to:
  /// **'Zero'**
  String get gZero;

  /// No description provided for @gResetPeaks.
  ///
  /// In en, this message translates to:
  /// **'Reset peaks'**
  String get gResetPeaks;

  /// No description provided for @gSpeedUp.
  ///
  /// In en, this message translates to:
  /// **'Speed up'**
  String get gSpeedUp;

  /// No description provided for @gBrake.
  ///
  /// In en, this message translates to:
  /// **'Brake'**
  String get gBrake;

  /// No description provided for @gCorner.
  ///
  /// In en, this message translates to:
  /// **'Corner'**
  String get gCorner;

  /// No description provided for @gSteady.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get gSteady;

  /// No description provided for @gBraking.
  ///
  /// In en, this message translates to:
  /// **'Braking {value} g'**
  String gBraking(String value);

  /// No description provided for @gSpeedingUp.
  ///
  /// In en, this message translates to:
  /// **'Speeding up {value} g'**
  String gSpeedingUp(String value);

  /// No description provided for @gLeftBend.
  ///
  /// In en, this message translates to:
  /// **'Left bend {value} g'**
  String gLeftBend(String value);

  /// No description provided for @gRightBend.
  ///
  /// In en, this message translates to:
  /// **'Right bend {value} g'**
  String gRightBend(String value);

  /// No description provided for @gSemantics.
  ///
  /// In en, this message translates to:
  /// **'G-force {value} g'**
  String gSemantics(String value);

  /// No description provided for @gZeroed.
  ///
  /// In en, this message translates to:
  /// **'Zeroed: forward and down learned'**
  String get gZeroed;

  /// No description provided for @noAccelerometerG.
  ///
  /// In en, this message translates to:
  /// **'This phone has no accelerometer, so g-force can’t be measured here. Other tools still work.'**
  String get noAccelerometerG;

  /// No description provided for @toolSpeed.
  ///
  /// In en, this message translates to:
  /// **'Speedometer'**
  String get toolSpeed;

  /// No description provided for @toolSpeedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Speed, trip and GPS altitude'**
  String get toolSpeedSubtitle;

  /// No description provided for @speedHelp1.
  ///
  /// In en, this message translates to:
  /// **'Allow location, then put the phone where it can see the sky, like on the dashboard or in a windscreen mount. Outdoors, the first fix takes a few seconds.'**
  String get speedHelp1;

  /// No description provided for @speedHelp2.
  ///
  /// In en, this message translates to:
  /// **'The gauge on the dashboard shows your speed from GPS, with the trip distance and altitude either side. The panel keeps the distance, top speed and average since you last reset.'**
  String get speedHelp2;

  /// No description provided for @speedHelp3.
  ///
  /// In en, this message translates to:
  /// **'Tap the coordinates to copy them. The unit button switches between km/h and mph, and Reset trip starts the distance, top and average again.'**
  String get speedHelp3;

  /// No description provided for @speedHelp4.
  ///
  /// In en, this message translates to:
  /// **'Keep your eyes on the road: let a passenger read it, or check the trip once you’ve stopped.'**
  String get speedHelp4;

  /// No description provided for @speedTip.
  ///
  /// In en, this message translates to:
  /// **'Speed comes from the satellites and is usually within about 1 km/h on open roads; in tunnels, between tall buildings or indoors it can lag or drop out. GPS altitude can be 10 to 50 m off, so use the Altimeter for height changes. Location is used only while this tool is open and never leaves your phone.'**
  String get speedTip;

  /// No description provided for @speedAllowTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get speedAllowTitle;

  /// No description provided for @speedAllowBody.
  ///
  /// In en, this message translates to:
  /// **'The Speedometer uses GPS to measure your speed, distance and altitude. Location is used only while this tool is open on screen, never in the background, and never leaves your phone.'**
  String get speedAllowBody;

  /// No description provided for @speedAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get speedAllow;

  /// No description provided for @speedDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Location access is off'**
  String get speedDeniedTitle;

  /// No description provided for @speedDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on location for this app in Settings to use the Speedometer. It is used only while the tool is open and never leaves your phone.'**
  String get speedDeniedBody;

  /// No description provided for @speedServiceOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Location is switched off'**
  String get speedServiceOffTitle;

  /// No description provided for @speedServiceOffBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on location in the phone’s settings to use the Speedometer.'**
  String get speedServiceOffBody;

  /// No description provided for @speedDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get speedDistance;

  /// No description provided for @speedTop.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get speedTop;

  /// No description provided for @speedAverage.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get speedAverage;

  /// No description provided for @speedTrip.
  ///
  /// In en, this message translates to:
  /// **'Trip'**
  String get speedTrip;

  /// No description provided for @speedAltitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get speedAltitude;

  /// No description provided for @speedResetTrip.
  ///
  /// In en, this message translates to:
  /// **'Reset trip'**
  String get speedResetTrip;

  /// No description provided for @speedFinding.
  ///
  /// In en, this message translates to:
  /// **'Finding satellites…'**
  String get speedFinding;

  /// No description provided for @speedGps.
  ///
  /// In en, this message translates to:
  /// **'GPS ±{value} m'**
  String speedGps(String value);

  /// No description provided for @speedWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak GPS: speed may lag'**
  String get speedWeak;

  /// No description provided for @speedApproximate.
  ///
  /// In en, this message translates to:
  /// **'Precise location is off: turn it on for a steady speed'**
  String get speedApproximate;

  /// No description provided for @speedStill.
  ///
  /// In en, this message translates to:
  /// **'Standing still'**
  String get speedStill;

  /// No description provided for @speedCopied.
  ///
  /// In en, this message translates to:
  /// **'Coordinates copied'**
  String get speedCopied;

  /// No description provided for @speedUnitTooltip.
  ///
  /// In en, this message translates to:
  /// **'Switch between km/h and mph'**
  String get speedUnitTooltip;

  /// No description provided for @speedKmh.
  ///
  /// In en, this message translates to:
  /// **'km/h'**
  String get speedKmh;

  /// No description provided for @speedMph.
  ///
  /// In en, this message translates to:
  /// **'mph'**
  String get speedMph;

  /// No description provided for @speedSemantics.
  ///
  /// In en, this message translates to:
  /// **'Speed {value}'**
  String speedSemantics(String value);

  /// No description provided for @speedCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates, tap to copy'**
  String get speedCoordinates;

  /// No description provided for @noGps.
  ///
  /// In en, this message translates to:
  /// **'This phone has no GPS, so speed can’t be measured here. Other tools still work.'**
  String get noGps;

  /// No description provided for @speedSceneHelp.
  ///
  /// In en, this message translates to:
  /// **'The sky follows the time of day. The weather button picks the scene: Auto follows the season, or choose sun, clouds, rain, storm or snow. It’s scenery, not a forecast.'**
  String get speedSceneHelp;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Free, with no ads'**
  String get supportTitle;

  /// No description provided for @supportBody.
  ///
  /// In en, this message translates to:
  /// **'Built by one person in spare time. If it helps you, you can support it.'**
  String get supportBody;

  /// No description provided for @supportButton.
  ///
  /// In en, this message translates to:
  /// **'Support on GitHub'**
  String get supportButton;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied'**
  String get linkCopied;

  /// No description provided for @madeBy.
  ///
  /// In en, this message translates to:
  /// **'Designed and built by {name}'**
  String madeBy(String name);

  /// No description provided for @testFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Help make {app} better'**
  String testFeedbackTitle(String app);

  /// No description provided for @testFeedbackBody.
  ///
  /// In en, this message translates to:
  /// **'Found a problem or have an idea? I read every message.'**
  String get testFeedbackBody;

  /// No description provided for @testEmailMe.
  ///
  /// In en, this message translates to:
  /// **'Email me'**
  String get testEmailMe;

  /// No description provided for @testEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'{app} feedback'**
  String testEmailSubject(String app);

  /// No description provided for @testEmailCopied.
  ///
  /// In en, this message translates to:
  /// **'Email address copied'**
  String get testEmailCopied;

  /// No description provided for @testEndedTitle.
  ///
  /// In en, this message translates to:
  /// **'This test version has ended'**
  String get testEndedTitle;

  /// No description provided for @testEndedBody.
  ///
  /// In en, this message translates to:
  /// **'Thank you for testing! Please get the new version. To get it, write to me:'**
  String get testEndedBody;

  /// No description provided for @toolTracker.
  ///
  /// In en, this message translates to:
  /// **'Tracker check'**
  String get toolTracker;

  /// No description provided for @toolTrackerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hidden trackers following you'**
  String get toolTrackerSubtitle;

  /// No description provided for @sensorBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get sensorBluetooth;

  /// No description provided for @trackerHelp1.
  ///
  /// In en, this message translates to:
  /// **'Tap Scan here to list Bluetooth trackers near you that are away from their owners: AirTag, Galaxy SmartTag, Tile, Chipolo and Find Hub tags.'**
  String get trackerHelp1;

  /// No description provided for @trackerHelp2.
  ///
  /// In en, this message translates to:
  /// **'To find out if one is following you, tap Check while I move and keep this tool open on a walk or drive; the screen stays on. A tracker heard at 3 places over 30 minutes or more is travelling with you.'**
  String get trackerHelp2;

  /// No description provided for @trackerHelp3.
  ///
  /// In en, this message translates to:
  /// **'Tap a tracker to find it: walk slowly and follow the number up. In Show all, mark your own trackers as This is mine and they won’t be listed again.'**
  String get trackerHelp3;

  /// No description provided for @trackerHelp4.
  ///
  /// In en, this message translates to:
  /// **'GPS boxes with a SIM card can’t be heard by any phone. Tap Car check: most are held on by a strong magnet, which the Metal detector finds.'**
  String get trackerHelp4;

  /// No description provided for @trackerTip.
  ///
  /// In en, this message translates to:
  /// **'It listens only while open and can’t hear every tracker. A family member’s tracker, or a stranger’s on the same train, can show up too, and one next to its owner is left out. If you think someone is tracking you, contact the police or a support service.'**
  String get trackerTip;

  /// No description provided for @trackerAllowTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow Bluetooth scan'**
  String get trackerAllowTitle;

  /// No description provided for @trackerAllowBody.
  ///
  /// In en, this message translates to:
  /// **'The Tracker check listens for Bluetooth trackers near you. It listens only while this tool is open, never connects to them, and nothing it hears leaves your phone.'**
  String get trackerAllowBody;

  /// No description provided for @trackerAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow Bluetooth'**
  String get trackerAllow;

  /// No description provided for @trackerDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth scan is off'**
  String get trackerDeniedTitle;

  /// No description provided for @trackerDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'Allow Nearby devices for this app in Settings to use the Tracker check.'**
  String get trackerDeniedBody;

  /// No description provided for @trackerBluetoothOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth is off'**
  String get trackerBluetoothOffTitle;

  /// No description provided for @trackerBluetoothOffBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on Bluetooth to listen for trackers. The app never connects to anything.'**
  String get trackerBluetoothOffBody;

  /// No description provided for @trackerLocationOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Location is off'**
  String get trackerLocationOffTitle;

  /// No description provided for @trackerLocationOffBody.
  ///
  /// In en, this message translates to:
  /// **'On this Android version, Bluetooth scanning only works with location turned on. Nothing is located from it.'**
  String get trackerLocationOffBody;

  /// No description provided for @trackerScanHere.
  ///
  /// In en, this message translates to:
  /// **'Scan here'**
  String get trackerScanHere;

  /// No description provided for @trackerCheckMoving.
  ///
  /// In en, this message translates to:
  /// **'Check while I move'**
  String get trackerCheckMoving;

  /// No description provided for @trackerStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get trackerStop;

  /// No description provided for @trackerDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get trackerDone;

  /// No description provided for @trackerLocationNeeded.
  ///
  /// In en, this message translates to:
  /// **'Check while I move notes places with GPS: allow location.'**
  String get trackerLocationNeeded;

  /// No description provided for @trackerSimNote.
  ///
  /// In en, this message translates to:
  /// **'GPS boxes with a SIM card can’t be heard'**
  String get trackerSimNote;

  /// No description provided for @trackerCarCheck.
  ///
  /// In en, this message translates to:
  /// **'Car check'**
  String get trackerCarCheck;

  /// No description provided for @carCheckBody.
  ///
  /// In en, this message translates to:
  /// **'Some trackers are GPS boxes with a SIM card hidden on a car. No phone can hear those, but most are held on by a strong magnet, which the Metal detector finds.'**
  String get carCheckBody;

  /// No description provided for @carSpot1.
  ///
  /// In en, this message translates to:
  /// **'Under the bumpers, front and back'**
  String get carSpot1;

  /// No description provided for @carSpot2.
  ///
  /// In en, this message translates to:
  /// **'Inside the wheel arches'**
  String get carSpot2;

  /// No description provided for @carSpot3.
  ///
  /// In en, this message translates to:
  /// **'Under the seats and in the boot'**
  String get carSpot3;

  /// No description provided for @carSpot4.
  ///
  /// In en, this message translates to:
  /// **'Behind the diagnostic (OBD) port under the dashboard'**
  String get carSpot4;

  /// No description provided for @carCheckTip.
  ///
  /// In en, this message translates to:
  /// **'Sweep the top edge of the phone slowly over each spot. A jump in the reading means metal or a magnet: look closer.'**
  String get carCheckTip;

  /// No description provided for @carOpenMetal.
  ///
  /// In en, this message translates to:
  /// **'Open Metal detector'**
  String get carOpenMetal;

  /// No description provided for @trackerPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused while the app is hidden'**
  String get trackerPaused;

  /// No description provided for @trackerFollowingBanner.
  ///
  /// In en, this message translates to:
  /// **'{name} is travelling with you: heard at {places} places'**
  String trackerFollowingBanner(String name, int places);

  /// No description provided for @trackerMoving.
  ///
  /// In en, this message translates to:
  /// **'Checking for {minutes} min. Places passed: {places}'**
  String trackerMoving(int minutes, int places);

  /// No description provided for @trackerListening.
  ///
  /// In en, this message translates to:
  /// **'Listening for trackers'**
  String get trackerListening;

  /// No description provided for @trackerNothingHeard.
  ///
  /// In en, this message translates to:
  /// **'No trackers away from their owner heard here'**
  String get trackerNothingHeard;

  /// No description provided for @trackerIdle.
  ///
  /// In en, this message translates to:
  /// **'Scan to list trackers near you'**
  String get trackerIdle;

  /// No description provided for @trackerSemantics.
  ///
  /// In en, this message translates to:
  /// **'Following you: {following}. Trackers nearby: {nearby}.'**
  String trackerSemantics(int following, int nearby);

  /// No description provided for @trackerShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all ({count})'**
  String trackerShowAll(int count);

  /// No description provided for @trackerAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Trackers nearby: {count}'**
  String trackerAllTitle(int count);

  /// No description provided for @trackerKindFindMy.
  ///
  /// In en, this message translates to:
  /// **'Find My tag'**
  String get trackerKindFindMy;

  /// No description provided for @trackerKindFindHub.
  ///
  /// In en, this message translates to:
  /// **'Find Hub tag'**
  String get trackerKindFindHub;

  /// No description provided for @trackerKindDult.
  ///
  /// In en, this message translates to:
  /// **'Item tracker'**
  String get trackerKindDult;

  /// No description provided for @trackerClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get trackerClose;

  /// No description provided for @trackerNear.
  ///
  /// In en, this message translates to:
  /// **'Near'**
  String get trackerNear;

  /// No description provided for @trackerFar.
  ///
  /// In en, this message translates to:
  /// **'Far'**
  String get trackerFar;

  /// No description provided for @trackerFollowingYou.
  ///
  /// In en, this message translates to:
  /// **'Following you · places: {places}'**
  String trackerFollowingYou(int places);

  /// No description provided for @trackerPlaces.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Heard at 1 place} other{Heard at {count} places}}'**
  String trackerPlaces(int count);

  /// No description provided for @trackerMine.
  ///
  /// In en, this message translates to:
  /// **'This is mine'**
  String get trackerMine;

  /// No description provided for @trackerNotMine.
  ///
  /// In en, this message translates to:
  /// **'Not mine'**
  String get trackerNotMine;

  /// No description provided for @trackerFollowingLabel.
  ///
  /// In en, this message translates to:
  /// **'following'**
  String get trackerFollowingLabel;

  /// No description provided for @trackerNearby.
  ///
  /// In en, this message translates to:
  /// **'nearby: {count}'**
  String trackerNearby(int count);

  /// No description provided for @trackerFindTitle.
  ///
  /// In en, this message translates to:
  /// **'Find {name}'**
  String trackerFindTitle(String name);

  /// No description provided for @trackerFindHint.
  ///
  /// In en, this message translates to:
  /// **'Walk slowly around the car or bag and follow the number up. The signal gives distance only, not direction.'**
  String get trackerFindHint;

  /// No description provided for @trackerFindLost.
  ///
  /// In en, this message translates to:
  /// **'Not heard: move slowly'**
  String get trackerFindLost;

  /// No description provided for @findFar.
  ///
  /// In en, this message translates to:
  /// **'Far'**
  String get findFar;

  /// No description provided for @findCloser.
  ///
  /// In en, this message translates to:
  /// **'Getting closer'**
  String get findCloser;

  /// No description provided for @findNear.
  ///
  /// In en, this message translates to:
  /// **'Near'**
  String get findNear;

  /// No description provided for @findHere.
  ///
  /// In en, this message translates to:
  /// **'Right here'**
  String get findHere;

  /// No description provided for @trackerAppleSound.
  ///
  /// In en, this message translates to:
  /// **'Apple’s Find My, or the Tracker Detect app on Android, can make an AirTag play a sound.'**
  String get trackerAppleSound;

  /// No description provided for @trackerScanFailed.
  ///
  /// In en, this message translates to:
  /// **'The scan stopped. Check Bluetooth and scan again.'**
  String get trackerScanFailed;

  /// No description provided for @trackerGpsLost.
  ///
  /// In en, this message translates to:
  /// **'No GPS fix: places aren’t being noted'**
  String get trackerGpsLost;

  /// No description provided for @trackerHeardEarlier.
  ///
  /// In en, this message translates to:
  /// **'Heard earlier'**
  String get trackerHeardEarlier;

  /// No description provided for @trackerKindSamsung.
  ///
  /// In en, this message translates to:
  /// **'Samsung tag or device'**
  String get trackerKindSamsung;

  /// No description provided for @trackerKindApple.
  ///
  /// In en, this message translates to:
  /// **'Apple device'**
  String get trackerKindApple;

  /// No description provided for @trackerWhatToDo.
  ///
  /// In en, this message translates to:
  /// **'What to do'**
  String get trackerWhatToDo;

  /// No description provided for @trackerSafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'If a tracker follows you'**
  String get trackerSafetyTitle;

  /// No description provided for @trackerSafety1.
  ///
  /// In en, this message translates to:
  /// **'On a bus, train or plane it may be a stranger’s: check again after you get off.'**
  String get trackerSafety1;

  /// No description provided for @trackerSafety2.
  ///
  /// In en, this message translates to:
  /// **'If you feel unsafe, go somewhere public and call the police.'**
  String get trackerSafety2;

  /// No description provided for @trackerSafety3.
  ///
  /// In en, this message translates to:
  /// **'Find it with Find it. Photograph it, where it was hidden, and its serial number, with the date and time.'**
  String get trackerSafety3;

  /// No description provided for @trackerSafety4.
  ///
  /// In en, this message translates to:
  /// **'Don’t take it home, and don’t contact its owner.'**
  String get trackerSafety4;

  /// No description provided for @trackerSafety5.
  ///
  /// In en, this message translates to:
  /// **'Removing its battery stops it, but its owner can tell. If you live with the person, talk to a support service first.'**
  String get trackerSafety5;

  /// No description provided for @trackerSafety6.
  ///
  /// In en, this message translates to:
  /// **'Turning off your own Bluetooth or location doesn’t stop it reporting where you are.'**
  String get trackerSafety6;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'ja',
    'pt',
    'ru',
    'tr',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
