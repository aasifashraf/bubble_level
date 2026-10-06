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

  /// Heading above the list of tools on the home screen.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @listView.
  ///
  /// In en, this message translates to:
  /// **'List view'**
  String get listView;

  /// No description provided for @gridView.
  ///
  /// In en, this message translates to:
  /// **'Grid view'**
  String get gridView;

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
  /// **'Vibration meter with live graph'**
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
  /// **'Lay the phone on a surface to read its tilt, or stand it on an edge against a slope, rail or pipe: the big number is the long edge’s angle, the short edge’s is below.'**
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
  /// **'It switches between flat and on-edge by itself. To keep one, tap the flat or edge icon at the top; the first icon goes back to automatic.'**
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

  /// No description provided for @longEdgeFromLevel.
  ///
  /// In en, this message translates to:
  /// **'On edge · long edge from level'**
  String get longEdgeFromLevel;

  /// No description provided for @shortEdge.
  ///
  /// In en, this message translates to:
  /// **'Short edge {value}'**
  String shortEdge(String value);

  /// No description provided for @edgeAngleSemantics.
  ///
  /// In en, this message translates to:
  /// **'Long edge {long} from level, short edge {short}'**
  String edgeAngleSemantics(String long, String short);

  /// No description provided for @angleModeAuto.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get angleModeAuto;

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
  /// **'It points to magnetic north, which can differ a few degrees from map north. If it seems wrong, move the phone in a figure 8 a few times.'**
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
  /// **'“Metal nearby” means a small change. “Metal detected” means a strong one: the centre turns orange and the phone buzzes if vibration is on.'**
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
  /// **'Place the phone flat on the surface or machine you want to check, and keep your hands off it.'**
  String get vibrationHelp1;

  /// No description provided for @vibrationHelp2.
  ///
  /// In en, this message translates to:
  /// **'The dial shows vibration right now in m/s². The graph shows the last few seconds.'**
  String get vibrationHelp2;

  /// No description provided for @vibrationHelp3.
  ///
  /// In en, this message translates to:
  /// **'Peak is the strongest moment. Average is the level over the last second.'**
  String get vibrationHelp3;

  /// No description provided for @vibrationHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Reset peak before each new test.'**
  String get vibrationHelp4;

  /// No description provided for @vibrationTip.
  ///
  /// In en, this message translates to:
  /// **'“Still” is under 0.3 m/s² and “Strong vibration” is over 2 m/s². Use the readings to compare; phone sensors aren’t lab instruments.'**
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

  /// No description provided for @vibrationGraph.
  ///
  /// In en, this message translates to:
  /// **'Vibration graph'**
  String get vibrationGraph;

  /// No description provided for @altimeterHelp1.
  ///
  /// In en, this message translates to:
  /// **'The dial shows air pressure in hPa, and altitude is estimated from it.'**
  String get altimeterHelp1;

  /// No description provided for @altimeterHelp2.
  ///
  /// In en, this message translates to:
  /// **'To measure a height change, like stairs or floors, tap Set zero here where you start.'**
  String get altimeterHelp2;

  /// No description provided for @altimeterHelp3.
  ///
  /// In en, this message translates to:
  /// **'Go up or down. The centre shows the metres from your zero.'**
  String get altimeterHelp3;

  /// No description provided for @altimeterHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Clear zero to show air pressure again.'**
  String get altimeterHelp4;

  /// No description provided for @altimeterTip.
  ///
  /// In en, this message translates to:
  /// **'Weather changes air pressure, so altitude can be off by tens of metres. Height from your zero is accurate over short periods. This tool needs a phone with a barometer.'**
  String get altimeterTip;

  /// No description provided for @barometerIos.
  ///
  /// In en, this message translates to:
  /// **'Can’t read the barometer. Turn on Motion & Fitness for this app in Settings › Privacy & Security, then open the Altimeter again.'**
  String get barometerIos;

  /// No description provided for @noBarometer.
  ///
  /// In en, this message translates to:
  /// **'This phone has no barometer (air pressure sensor), so the altimeter can’t work here. Other tools still work.'**
  String get noBarometer;

  /// No description provided for @noLightSensor.
  ///
  /// In en, this message translates to:
  /// **'This phone has no light sensor, so the light meter can’t work here. Other tools still work.'**
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
  /// **'Read the lux and what the light is good for: 300–750 lx suits reading and desk work.'**
  String get lightHelp3;

  /// No description provided for @lightHelp4.
  ///
  /// In en, this message translates to:
  /// **'Tap Lock to keep a reading while you move the phone away.'**
  String get lightHelp4;

  /// No description provided for @lightTip.
  ///
  /// In en, this message translates to:
  /// **'Light sensors differ between phones, so readings can be 10–20% off: good for comparing places, not a calibrated lux meter. Don’t cover the top of the screen.'**
  String get lightTip;

  /// No description provided for @noMicrophone.
  ///
  /// In en, this message translates to:
  /// **'Can’t use the microphone. Another app may be using it: close that app, then open the sound meter again.'**
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
  /// **'The sound meter listens through the microphone to measure how loud it is. Sound is measured on your phone and never recorded, saved or sent.'**
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
  /// **'Turn on the microphone for this app in Settings to use the sound meter. Sound is never recorded, saved or sent.'**
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
  /// **'The big number is the level now, averaged over about a second.'**
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
  /// **'Phone microphones differ, so readings can be about 5 dB off: good for comparing, not a certified sound level meter. Very loud sounds (above about 110 dB) may read low.'**
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
