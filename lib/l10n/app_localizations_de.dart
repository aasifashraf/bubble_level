// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Wasserwaage & Winkelmesser';

  @override
  String get homeTitle => 'Wasserwaage';

  @override
  String get settings => 'Einstellungen';

  @override
  String get tools => 'Werkzeuge';

  @override
  String get listView => 'Listenansicht';

  @override
  String get gridView => 'Rasteransicht';

  @override
  String get back => 'Zurück';

  @override
  String get lightMode => 'Heller Modus';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get toolLevel => 'Wasserwaage';

  @override
  String get toolLevelSubtitle => 'Libelle und Wasserwaage';

  @override
  String get toolAngle => 'Winkel';

  @override
  String get toolAngleSubtitle =>
      'Winkel zur Waagrechten oder zu deinem Nullpunkt';

  @override
  String get toolCompass => 'Kompass';

  @override
  String get toolCompassSubtitle => 'Richtung und Himmelsrichtung';

  @override
  String get toolProtractor => 'Winkelmesser';

  @override
  String get toolProtractorSubtitle => 'Winkel auf dem Bildschirm messen';

  @override
  String get toolRuler => 'Lineal';

  @override
  String get toolRulerSubtitle => 'Längen auf dem Bildschirm messen';

  @override
  String get toolMetal => 'Metalldetektor';

  @override
  String get toolMetalSubtitle => 'Eisen, Stahl und Magnete finden';

  @override
  String get toolVibration => 'Vibration';

  @override
  String get toolVibrationSubtitle => 'Vibrationsmesser mit Live-Grafik';

  @override
  String get toolSound => 'Schallpegelmesser';

  @override
  String get toolSoundSubtitle => 'Lautstärke in Dezibel';

  @override
  String get toolAltimeter => 'Höhenmesser';

  @override
  String get toolAltimeterSubtitle => 'Luftdruck und Höhe';

  @override
  String get toolLight => 'Belichtungsmesser';

  @override
  String get toolLightSubtitle => 'Helligkeit in Lux';

  @override
  String get notAvailableOnPhone => 'Auf diesem Handy nicht verfügbar';

  @override
  String get notOnPhone => 'Nicht verfügbar';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, auf diesem Handy nicht verfügbar';
  }

  @override
  String get howToUse => 'Anleitung';

  @override
  String get rotateLandscape => 'Ins Querformat drehen';

  @override
  String get rotatePortrait => 'Ins Hochformat drehen';

  @override
  String howToUseTool(String tool) {
    return 'So nutzt du: $tool';
  }

  @override
  String get gotIt => 'Verstanden';

  @override
  String get goodToKnow => 'Gut zu wissen: ';

  @override
  String get ok => 'OK';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool ist nicht verfügbar';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sensoren, die',
      one: 'einen Sensor, den',
    );
    return '$tool braucht $_temp0 dieses Handy nicht hat: $sensors.';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'Das liegt an der Hardware des Handys, nicht an der App. Alle anderen Werkzeuge funktionieren normal.';

  @override
  String get sensorAccelerometer => 'Beschleunigungssensor';

  @override
  String get sensorMagnetometer => 'Magnetometer (Kompasssensor)';

  @override
  String get sensorBarometer => 'Barometer (Luftdrucksensor)';

  @override
  String get sensorLight => 'Lichtsensor';

  @override
  String get sensorMicrophone => 'Mikrofon';

  @override
  String get noAccelerometer =>
      'Dieses Handy hat keinen Beschleunigungssensor, daher kann dieses Werkzeug hier nichts messen. Werkzeuge, die ihn nicht brauchen, funktionieren weiter.';

  @override
  String get noMagnetometer =>
      'Dieses Handy hat kein Magnetometer (Kompasssensor), daher funktioniert dieses Werkzeug hier nicht. Werkzeuge, die es nicht brauchen, funktionieren weiter.';

  @override
  String get noReadings =>
      'Noch keine Werte vom Sensor. Geh zurück und öffne das Werkzeug erneut; wenn es weiter passiert, starte das Handy neu. Manche Handys unterstützen dieses Werkzeug nicht.';

  @override
  String get waitingForSensors => 'Warte auf Sensoren…';

  @override
  String get levelHelp1 =>
      'Leg das Handy flach auf die Fläche oder stell es auf eine seiner Kanten.';

  @override
  String get levelHelp2 =>
      'Flach: Bring die Blase in die Mitte. X ist die Neigung links/rechts, Y vorne/hinten. Auf einer Kante siehst du Winkel und Gefälle.';

  @override
  String get levelHelp3 =>
      'Folge dem Hinweis auf dem Bildschirm (zum Beispiel „Rechte Seite hoch“), bis „Waagrecht“ erscheint: Die Anzeige wird orange, das Handy klingt und vibriert (abschaltbar in den Einstellungen).';

  @override
  String get levelHelp4 =>
      'Tippe auf Sperren, um den Wert einzufrieren, und auf Entsperren, um wieder live zu messen.';

  @override
  String get levelHelp5 =>
      'Lieber eine klassische Wasserwaage? Tippe im Umschalter auf das Röhrchen-Symbol; das runde Symbol bringt die Skala zurück.';

  @override
  String get levelTip =>
      'Zeigt eine Fläche, die sicher waagrecht ist, nicht 0°, leg das Handy darauf und tippe auf Kalibrieren. Zum Rückgängigmachen tippe erneut auf Kalibrieren und wähle Kalibrierung zurücksetzen.';

  @override
  String get statusLevel => 'Waagrecht';

  @override
  String get leftEndLow => 'Linkes Ende tief';

  @override
  String get rightEndLow => 'Rechtes Ende tief';

  @override
  String get rightSideHigh => 'Rechte Seite hoch';

  @override
  String get leftSideHigh => 'Linke Seite hoch';

  @override
  String get topEdgeHigh => 'Obere Kante hoch';

  @override
  String get bottomEdgeHigh => 'Untere Kante hoch';

  @override
  String get calibrated => 'Kalibriert. Diese Lage zeigt jetzt 0°.';

  @override
  String get tooFarToCalibrate =>
      'Zu schief zum Kalibrieren. Leg das Handy zuerst auf eine waagrechte Fläche.';

  @override
  String get dialView => 'Skalenansicht';

  @override
  String get tubeView => 'Libellenansicht';

  @override
  String get levelTube => 'Libelle';

  @override
  String get leftRightTube => 'Libelle links und rechts';

  @override
  String get forwardBackTube => 'Libelle vorne und hinten';

  @override
  String tiltFromLevel(String value) {
    return 'Neigung zur Waagrechten $value';
  }

  @override
  String fromLevel(String value) {
    return 'Abweichung von der Waagrechten $value';
  }

  @override
  String get xLeftRight => 'X · links / rechts';

  @override
  String get yForwardBack => 'Y · vorne / hinten';

  @override
  String get angle => 'Winkel';

  @override
  String get slope => 'Gefälle';

  @override
  String get lock => 'Sperren';

  @override
  String get unlock => 'Entsperren';

  @override
  String locked(String status) {
    return 'Gesperrt · $status';
  }

  @override
  String get lockReading => 'Wert sperren';

  @override
  String get lockHandles => 'Griffe sperren';

  @override
  String get handlesLocked => 'Griffe gesperrt · Schloss tippen zum Ändern';

  @override
  String get calibrate => 'Kalibrieren';

  @override
  String get angleHelp1 =>
      'Leg das Handy auf eine Fläche, um die Neigung zu lesen, oder stell es mit einer Kante an eine Schräge, ein Geländer oder ein Rohr: Die große Zahl ist der Winkel der langen Kante, der der kurzen steht darunter.';

  @override
  String get angleHelp2 =>
      'Um eine Änderung zu messen, halte das Handy in der Startlage und tippe auf Hier nullen.';

  @override
  String get angleHelp3 =>
      'Neige oder bewege das Handy. Die Skala zeigt, um wie viel Grad es sich von deinem Nullpunkt bewegt hat.';

  @override
  String get angleHelp4 =>
      'Tippe auf Nullpunkt löschen, um wieder den Winkel zur flachen Lage zu sehen.';

  @override
  String get angleHelp5 =>
      'Für einen Winkel, den du nicht ablesen kannst: Handy an den Gegenstand halten, auf das Schloss tippen, dann abheben und ablesen.';

  @override
  String get angleHelp6 =>
      'Es wechselt selbst zwischen flach und auf der Kante. Um eins festzuhalten, tippe oben auf das Flach- oder Kanten-Symbol; das erste Symbol schaltet zurück auf automatisch.';

  @override
  String get angleTip =>
      'Leg die lange Seite des Handys an eine Rampe, ein Treppengeländer oder ein Dach, um die Steigung zu lesen, oder drück den Bildschirm flach an ein Brett oder eine Tür, um die Neigung zu messen.';

  @override
  String movedFromZero(String value) {
    return 'Vom Nullpunkt bewegt $value';
  }

  @override
  String get measuringFromZero => 'Gemessen ab deinem Nullpunkt';

  @override
  String get angleFlatStatus => 'Flach · Winkel zur Erde';

  @override
  String get longEdgeFromLevel => 'Auf der Kante · lange Kante zur Waagrechten';

  @override
  String shortEdge(String value) {
    return 'Kurze Kante $value';
  }

  @override
  String edgeAngleSemantics(String long, String short) {
    return 'Lange Kante $long zur Waagrechten, kurze Kante $short';
  }

  @override
  String get angleModeAuto => 'Automatisch';

  @override
  String get angleModeFlat => 'Flach auf einer Fläche';

  @override
  String get angleModeEdge => 'Auf einer Kante';

  @override
  String get standOnEdge => 'Stell das Handy auf eine seiner Kanten';

  @override
  String get clearZero => 'Nullpunkt löschen';

  @override
  String get setZeroHere => 'Hier nullen';

  @override
  String get compassHelp1 =>
      'Halte das Handy waagrecht vor dich, weg von Metall, Magneten und Elektronik.';

  @override
  String get compassHelp2 =>
      'Richte die Oberkante des Handys in die gesuchte Richtung. Hältst du es aufrecht, zeigt er die Richtung, in die die Rückkamera blickt.';

  @override
  String get compassHelp3 =>
      'Die Zahl ist deine Richtung in Grad, die Buchstaben die Himmelsrichtung. Die Skala dreht sich, damit ihr N immer nach Norden zeigt; die orange Kugel oben markiert, wohin dein Handy zeigt.';

  @override
  String get compassTip =>
      'Er zeigt nach magnetisch Nord, das um einige Grad von Kartennord abweichen kann. Wirkt er falsch, beweg das Handy ein paar Mal in Form einer 8.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Magnetische Richtung $heading Grad, $direction';
  }

  @override
  String get magneticInterference => 'Magnetische Störung · weg von Metall';

  @override
  String get dirN => 'N';

  @override
  String get dirNE => 'NO';

  @override
  String get dirE => 'O';

  @override
  String get dirSE => 'SO';

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
      'Leg das Handy flach hin und den Gegenstand auf den Bildschirm, mit der Ecke in der Mitte.';

  @override
  String get protractorHelp2 =>
      'Zieh jeden orangen Griff so, dass seine Linie an einer Kante des Winkels liegt.';

  @override
  String get protractorHelp3 =>
      'Lies den Winkel in der Mitte ab. Überstumpf ist die andere Seite (360° minus Winkel).';

  @override
  String get protractorHelp4 => 'Tippe auf Zurücksetzen, um neu zu beginnen.';

  @override
  String get protractorHelp5 =>
      'Tippe auf das Schloss, damit die Griffe an ihrem Platz bleiben, während du den Gegenstand bewegst.';

  @override
  String armsSemantics(String value) {
    return 'Winkel zwischen den Schenkeln $value';
  }

  @override
  String get reflex => 'Überstumpf';

  @override
  String get dragHandles => 'Zieh die orangen Griffe an die Kanten';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get rulerHelp1 =>
      'Leg den Gegenstand auf den Bildschirm oder halte das Handy daran.';

  @override
  String get rulerHelp2 =>
      'Zieh die orangen Linien an seine beiden Enden. Tippe auf mm, cm oder in, um die Einheit zu wählen; das andere System steht darunter.';

  @override
  String get rulerHelp3 =>
      'Für die beste Genauigkeit tippe einmal auf Kalibrieren und nutze eine Bankkarte, ein Lineal oder die Bildschirmgröße.';

  @override
  String get rulerHelp4 =>
      'Tippe auf das Schloss, damit die Linien bleiben, während du den Gegenstand bewegst.';

  @override
  String get rulerTip =>
      'Es misst bis zur Länge des Bildschirms. Hüllen und gebogene Ränder verdecken die ersten Millimeter, miss also zwischen den Linien, nicht ab dem Rand des Handys.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'Länge $mm Millimeter, $inches Zoll';
  }

  @override
  String get rulerCalibrated => 'Mit Karte kalibriert · ±0,5 mm';

  @override
  String get rulerReported =>
      'Bildschirmgröße vom Handy · kalibrieren für ±0,5 mm';

  @override
  String get unitMillimetres => 'Millimeter';

  @override
  String get unitCentimetres => 'Zentimeter';

  @override
  String get unitInches => 'Zoll';

  @override
  String get rulerEstimated =>
      'Nicht kalibriert · Längen können 10 % abweichen';

  @override
  String get cardLongEdge =>
      'Leg eine Bank- oder Ausweiskarte auf den Bildschirm, lange Seite am Lineal, ein Ende an der dunklen Linie. Zieh die orange Linie ans andere Ende der Karte.';

  @override
  String get cardShortEdge =>
      'Leg eine Bank- oder Ausweiskarte auf den Bildschirm, kurze Seite am Lineal, ein Ende an der dunklen Linie. Zieh die orange Linie ans andere Ende der Karte.';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get usePhoneDefault => 'Bildschirmgröße des Handys nutzen';

  @override
  String get usePhoneDefaultInfo => 'Diese Kalibrierung verwerfen';

  @override
  String get cardMismatch =>
      'Das passt nicht zu einer Karte. Leg sie an die dunkle Linie und versuch es erneut.';

  @override
  String get rotateToCalibrate => 'Zum Kalibrieren ins Hochformat drehen';

  @override
  String get calibrateHow => 'Kalibrieren mit';

  @override
  String get methodCard => 'Einer Bankkarte';

  @override
  String get methodCardInfo => 'Jede Bank- oder Ausweiskarte · ±0,5 mm';

  @override
  String get methodRuler => 'Einem Lineal';

  @override
  String get methodRulerInfo => 'Am genauesten · Lineal oder Maßband';

  @override
  String get methodScreen => 'Der Bildschirmgröße';

  @override
  String get methodScreenInfo => 'Nichts nötig · etwa 1 %';

  @override
  String rulerInstructions(String mark) {
    return 'Leg ein Lineal mit der 0 an die dunkle Linie. Zieh die orange Linie zur Markierung $mark.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'Das passt nicht zu $mark. Leg die 0 des Lineals an die dunkle Linie und versuch es erneut.';
  }

  @override
  String get screenSizeInstructions =>
      'Gib die Bildschirmgröße in Zoll aus den Daten des Handys ein. Unsicher? Such nach deinem Modell und „Bildschirmgröße“.';

  @override
  String get screenSizeMismatch =>
      'Diese Größe passt nicht zu diesem Bildschirm. Prüf die Daten des Handys und versuch es erneut.';

  @override
  String get rulerCalibratedRuler => 'Mit Lineal kalibriert · ±0,5 mm';

  @override
  String rulerCalibratedScreen(String size) {
    return 'Für $size-Zoll-Bildschirm eingestellt · etwa 1 %';
  }

  @override
  String get metalHelp1 =>
      'Öffne das Werkzeug weit weg von Metall. Der erste Wert gilt als „kein Metall“.';

  @override
  String get metalHelp2 =>
      'Beweg das Handy langsam über die Fläche. Der Sensor sitzt meist oben im Handy. Je näher Metall ist, desto schneller piept es; tippe auf den Lautsprecher zum Stummschalten.';

  @override
  String get metalHelp3 =>
      '„Metall in der Nähe“ heißt kleine Änderung, „Metall gefunden“ starke Änderung: Die Mitte wird orange und das Handy vibriert, wenn Vibration an ist.';

  @override
  String get metalHelp4 =>
      'Hältst du das Handy ein paar Sekunden still, stellt es sich selbst auf null, und eine Fehlanzeige verschwindet. Um eine Stelle erneut zu prüfen, bewege das Handy weg und zurück. Grundwert setzen stellt sofort auf null.';

  @override
  String get metalTip =>
      'Er erkennt nur Eisen, Stahl und Magnete, kein Aluminium, Kupfer, Gold oder Silber. Magnetische Handyhüllen stören ihn.';

  @override
  String metalSemantics(int value) {
    return 'Magnetfeld $value Mikrotesla';
  }

  @override
  String get noMetal => 'Kein Metall in der Nähe';

  @override
  String get metalNearby => 'Metall in der Nähe';

  @override
  String get metalDetected => 'Metall gefunden';

  @override
  String get field => 'Feld';

  @override
  String get change => 'Änderung';

  @override
  String get findsIronSteel => 'Findet Eisen, Stahl und Magnete';

  @override
  String get setBaseline => 'Grundwert setzen';

  @override
  String get muteSound => 'Ton aus';

  @override
  String get turnSoundOn => 'Ton an';

  @override
  String get vibrationHelp1 =>
      'Leg das Handy flach auf die Fläche oder Maschine, die du prüfen willst, und nimm die Hände weg.';

  @override
  String get vibrationHelp2 =>
      'Die Skala zeigt die aktuelle Vibration in m/s². Die Grafik zeigt die letzten Sekunden.';

  @override
  String get vibrationHelp3 =>
      'Spitze ist der stärkste Moment, Mittel der Wert über die letzte Sekunde.';

  @override
  String get vibrationHelp4 =>
      'Tippe vor jeder neuen Messung auf Spitze zurücksetzen.';

  @override
  String get vibrationTip =>
      '„Ruhig“ heißt unter 0,3 m/s², „Starke Vibration“ über 2 m/s². Nutze die Werte zum Vergleichen; Handysensoren sind keine Laborgeräte.';

  @override
  String get still => 'Ruhig';

  @override
  String get lightVibration => 'Leichte Vibration';

  @override
  String get strongVibration => 'Starke Vibration';

  @override
  String get noAccelerometerVibration =>
      'Dieses Handy hat keinen Beschleunigungssensor, daher lässt sich hier keine Vibration messen. Werkzeuge, die ihn nicht brauchen, funktionieren weiter.';

  @override
  String vibrationSemantics(String value) {
    return 'Vibration $value Meter pro Sekunde zum Quadrat';
  }

  @override
  String get peak => 'Spitze';

  @override
  String get average => 'Mittel';

  @override
  String get resetPeak => 'Spitze zurücksetzen';

  @override
  String get vibrationGraph => 'Vibrationsgrafik';

  @override
  String get altimeterHelp1 =>
      'Die Skala zeigt den Luftdruck in hPa, daraus wird die Höhe geschätzt.';

  @override
  String get altimeterHelp2 =>
      'Um einen Höhenunterschied zu messen, etwa Treppen oder Stockwerke, tippe am Start auf Hier nullen.';

  @override
  String get altimeterHelp3 =>
      'Geh nach oben oder unten. Die Mitte zeigt die Meter ab deinem Nullpunkt.';

  @override
  String get altimeterHelp4 =>
      'Tippe auf Nullpunkt löschen, um zurückzukehren.';

  @override
  String get altimeterTip =>
      'Das Wetter ändert den Luftdruck, daher kann die Höhe um einige zehn Meter abweichen. Die Höhe ab deinem Nullpunkt ist über kurze Zeit genau. Dieses Werkzeug braucht ein Handy mit Barometer.';

  @override
  String get barometerIos =>
      'Das Barometer kann nicht gelesen werden. Schalte in Einstellungen › Datenschutz & Sicherheit „Bewegung & Fitness“ für diese App ein und öffne den Höhenmesser erneut.';

  @override
  String get noBarometer =>
      'Dieses Handy hat kein Barometer (Luftdrucksensor), daher funktioniert der Höhenmesser hier nicht. Andere Werkzeuge funktionieren weiter.';

  @override
  String get noLightSensor =>
      'Dieses Handy hat keinen Lichtsensor, daher funktioniert der Belichtungsmesser hier nicht. Die anderen Werkzeuge funktionieren weiterhin.';

  @override
  String lightSemantics(String value) {
    return 'Helligkeit $value Lux';
  }

  @override
  String get illuminance => 'Helligkeit';

  @override
  String get footCandles => 'Foot-Candle';

  @override
  String get lightDark => 'Dunkel';

  @override
  String get lightDim => 'Schwaches Licht';

  @override
  String get lightLivingRoom => 'Wohnzimmerlicht';

  @override
  String get lightReading => 'Gut zum Lesen und für den Schreibtisch';

  @override
  String get lightBright => 'Helles Raumlicht';

  @override
  String get lightOvercast => 'Bewölktes Tageslicht';

  @override
  String get lightDaylight => 'Tageslicht';

  @override
  String get lightSun => 'Direktes Sonnenlicht';

  @override
  String get lightHelp1 =>
      'Der Lichtsensor sitzt oben am Bildschirm, neben der Frontkamera.';

  @override
  String get lightHelp2 =>
      'Halte das Handy an die Stelle, die du messen willst, mit dem Bildschirm zum Licht.';

  @override
  String get lightHelp3 =>
      'Lies die Lux und wofür das Licht taugt: 300–750 lx eignen sich zum Lesen und für den Schreibtisch.';

  @override
  String get lightHelp4 =>
      'Tippe auf Sperren, um einen Wert zu behalten, während du das Handy wegnimmst.';

  @override
  String get lightTip =>
      'Lichtsensoren unterscheiden sich je nach Handy, Werte können 10–20 % abweichen: gut zum Vergleichen von Orten, aber kein geeichter Luxmeter. Verdecke den oberen Bildschirmrand nicht.';

  @override
  String get noMicrophone =>
      'Das Mikrofon lässt sich nicht nutzen. Vielleicht verwendet es eine andere App: Schließe sie und öffne den Schallpegelmesser erneut.';

  @override
  String soundSemantics(String value) {
    return 'Lautstärke etwa $value Dezibel';
  }

  @override
  String get decibelsApprox => 'dB (ca.)';

  @override
  String get soundMax => 'Max.';

  @override
  String get soundVeryQuiet => 'Sehr leise';

  @override
  String get soundQuiet => 'Leise, wie in einer Bibliothek';

  @override
  String get soundModerate => 'Mittel, wie ein Gespräch';

  @override
  String get soundLoud => 'Laut, wie dichter Verkehr';

  @override
  String get soundVeryLoud =>
      'Sehr laut: Längeres Zuhören kann das Gehör schädigen';

  @override
  String get soundDangerous => 'Gefährlich: Schütze deine Ohren';

  @override
  String get micTitle => 'Mikrofon erlauben';

  @override
  String get micBody =>
      'Der Schallpegelmesser hört über das Mikrofon, wie laut es ist. Der Ton wird nur auf deinem Handy gemessen und nie aufgenommen, gespeichert oder gesendet.';

  @override
  String get micAllow => 'Mikrofon erlauben';

  @override
  String get micDeniedTitle => 'Mikrofonzugriff ist aus';

  @override
  String get micDeniedBody =>
      'Erlaube dieser App in den Einstellungen das Mikrofon, um den Schallpegelmesser zu nutzen. Ton wird nie aufgenommen, gespeichert oder gesendet.';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get soundHelp1 =>
      'Halte das Mikrofon (an der Unterkante) frei und richte das Handy auf die Schallquelle.';

  @override
  String get soundHelp2 =>
      'Die große Zahl ist der aktuelle Pegel, gemittelt über etwa eine Sekunde.';

  @override
  String get soundHelp3 =>
      'Durchschnitt und Max. zählen ab dem Öffnen des Werkzeugs. Tippe auf Zurücksetzen, um neu zu beginnen.';

  @override
  String get soundHelp4 =>
      'Ab 70 dB wird die Statuszeile gelb; ab 85 dB, wo längeres Zuhören das Gehör schädigen kann, rot.';

  @override
  String get soundHelp5 =>
      'Tippe auf das Schloss, um einen Wert zu behalten, während du das Handy bewegst.';

  @override
  String get soundTip =>
      'Handymikrofone sind unterschiedlich, Werte können etwa 5 dB abweichen: gut zum Vergleichen, aber kein geeichter Schallpegelmesser. Sehr laute Geräusche (über etwa 110 dB) werden eventuell zu niedrig angezeigt.';

  @override
  String get metresFromZero => 'm ab Null';

  @override
  String pressureSemantics(String value) {
    return 'Luftdruck $value Hektopascal';
  }

  @override
  String heightSemantics(String value) {
    return 'Höhe $value ab Nullpunkt';
  }

  @override
  String get pressure => 'Luftdruck';

  @override
  String get altitudeApprox => 'Höhe (ca.)';

  @override
  String get measuringHeight => 'Höhe ab deinem Nullpunkt';

  @override
  String get airPressureAltitude => 'Luftdruck und Höhe';

  @override
  String get appearance => 'Darstellung';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get levelUnits => 'Einheit der Neigung';

  @override
  String get unitDegrees => 'Grad';

  @override
  String get unitPercent => 'Steigung in Prozent';

  @override
  String get unitRoofPitch => 'Dachneigung (Steigung pro 12)';

  @override
  String get vibrateWhenLevel => 'Vibration';

  @override
  String get sounds => 'Töne';

  @override
  String get resetCalibration => 'Kalibrierung zurücksetzen';

  @override
  String get resetCalibrationHint => 'Wieder den Werks-Nullpunkt nutzen';

  @override
  String get calibrateHere => 'Hier kalibrieren';

  @override
  String get calibrateHereInfo => 'Auf einer sicher waagrechten Fläche';

  @override
  String get calibrationRemoved =>
      'Kalibrierung entfernt. Die Wasserwaage nutzt wieder den Werksnullpunkt des Sensors.';

  @override
  String get resetAllCalibrations => 'Alle Kalibrierungen zurücksetzen';

  @override
  String get resetAllCalibrationsHint =>
      'Wasserwaage und Lineal auf Werkseinstellung';

  @override
  String get resetAllTitle => 'Alle Kalibrierungen zurücksetzen?';

  @override
  String get resetAllBody =>
      'Damit werden die Kalibrierungen entfernt, die du in der Wasserwaage (auch vom Winkelmesser genutzt) und im Lineal eingestellt hast. Beide kehren zur Werkseinstellung zurück. Deine anderen Einstellungen bleiben erhalten, und du kannst jederzeit neu kalibrieren.';

  @override
  String get notCalibrated => 'Nicht kalibriert';

  @override
  String get language => 'Sprache';

  @override
  String get licenses => 'Open-Source-Lizenzen';

  @override
  String get languageSystem => 'Sprache des Handys';
}
