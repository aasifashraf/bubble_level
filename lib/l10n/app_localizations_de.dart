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
  String get homeTopTools => 'Deine Top-Werkzeuge';

  @override
  String get homeMoreTools => 'Weitere Werkzeuge';

  @override
  String get homeArrange => 'Anordnen';

  @override
  String get arrangeTitle => 'Werkzeuge anordnen';

  @override
  String get arrangeHint =>
      'Ziehen, um die Reihenfolge zu ändern. Die ersten drei sind deine Top-Werkzeuge.';

  @override
  String get arrangeStar => 'Zum Top-Werkzeug machen';

  @override
  String get arrangeUnstar => 'Aus den Top-Werkzeugen entfernen';

  @override
  String get arrangeReset => 'Beliebte Reihenfolge';

  @override
  String get arrangeDone => 'Fertig';

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
  String get toolVibrationSubtitle => 'Vibrationsstärke und Drehzahl (U/min)';

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
  String get sensorCamera => 'Rückkamera';

  @override
  String get sensorGps => 'GPS';

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
      'Leg das Handy auf eine Fläche, um die Neigung zu lesen, oder stell es mit einer Kante an eine Schräge, ein Geländer oder ein Rohr: Die große Zahl ist der Winkel der orange leuchtenden Kante, der der unteren Kante steht darunter.';

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
      'Wähle oben im Umschalter den Modus: flach auf einer Fläche oder auf einer Kante stehend. Auf der Kante füllt sich der Bildschirm mit Wasser, das waagrecht bleibt, und die gemessene Kante, die tiefere Seite, leuchtet orange.';

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
  String get measuringRightEdge => 'Misst die rechte Kante';

  @override
  String get measuringLeftEdge => 'Misst die linke Kante';

  @override
  String bottomEdge(String value) {
    return 'Untere Kante $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: $value zur Waagrechten. Untere Kante $other';
  }

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
      'Er zeigt nach magnetisch Nord, das an manchen Orten um 10 Grad oder mehr von Kartennord abweichen kann. Wirkt er falsch, beweg das Handy ein paar Mal in Form einer 8.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Magnetische Richtung $heading Grad, $direction';
  }

  @override
  String get magneticInterference =>
      'Magnetische Störung · weg von Metall, dann das Handy in einer Acht schwenken';

  @override
  String get compassCalibrate =>
      'Schwenk das Handy in einer Acht, um den Kompass zu kalibrieren';

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
  String get rulerWidthOn => 'Auch die Breite messen';

  @override
  String rulerArea(String value) {
    return 'Fläche $value';
  }

  @override
  String rulerBoxSemantics(String length, String width, String area) {
    return 'Länge $length Millimeter, Breite $width Millimeter, Fläche $area Quadratzentimeter';
  }

  @override
  String get rulerHelp5 =>
      'Tippe oben auf die Kastentaste, um auch die Breite zu messen: Zieh die zwei seitlichen Linien an die Seiten des Objekts, dann siehst du Breite und Fläche. Die Breite reicht höchstens über die Bildschirmbreite.';

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
      '„Metall in der Nähe“ bedeutet eine kleine Änderung, „Metall erkannt“ eine starke. Wie beim Spiel „Heiß oder kalt“ wird der Bildschirm von kühlem Blau zu glühendem Rot, je näher du kommst, und bei einem Fund vibriert das Handy, wenn Vibration an ist.';

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
  String get heatCold => 'Kalt';

  @override
  String get heatCool => 'Kühl';

  @override
  String get heatWarm => 'Warm';

  @override
  String get heatWarmer => 'Wärmer';

  @override
  String get heatHot => 'Heiß';

  @override
  String get heatBurning => 'Glühend';

  @override
  String get baseline => 'Grundwert';

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
      'Leg das Handy flach auf die laufende Maschine und nimm die Hände weg. Auf einer kleinen Maschine halte es fest angedrückt.';

  @override
  String get vibrationHelp2 =>
      'Die Nadel zeigt die Drehzahl der stärksten Vibration in U/min, darunter in Hertz (U/min ist Hertz × 60). Das schwache Leuchten im Zifferblatt ist das ganze Spektrum; die Nadel zeigt in seinen hellsten Teil.';

  @override
  String get vibrationHelp3 =>
      'Stärke ist, wie heftig es rüttelt, in m/s²: unter 0,3 ist ruhig, über 2 ist stark.';

  @override
  String get vibrationHelp4 =>
      'Tippe auf Sperren, um einen Wert zu halten, und vor der nächsten Maschine auf Zurücksetzen.';

  @override
  String get vibrationTip =>
      'Die meisten Handys messen bis 100 Hz (6000 U/min), manche weniger; das Zifferblatt zeigt die Grenze deines Handys. Schnellere Vibration kann als falsche, niedrigere Drehzahl erscheinen. Die stärkste Vibration ist oft die Wellendrehzahl, kann aber das Doppelte sein. Handysensoren sind keine Laborgeräte.';

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
  String get frequency => 'Frequenz';

  @override
  String get rpm => 'U/min';

  @override
  String get strength => 'Stärke';

  @override
  String vibratingAt(String value) {
    return 'Vibriert mit $value Hz';
  }

  @override
  String get noClearFrequency => 'Keine klare Frequenz';

  @override
  String get findingFrequency => 'Frequenz wird gesucht…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm Umdrehungen pro Minute, $value Hertz';
  }

  @override
  String get peak => 'Spitze';

  @override
  String get average => 'Mittel';

  @override
  String get resetPeak => 'Spitze zurücksetzen';

  @override
  String get altimeterHelp1 =>
      'Der Wanderer am Berg geht hinauf und hinunter, wenn sich deine Höhe ändert. Der Himmel folgt Tageszeit und Jahreszeit; tippe auf die Wetter-Taste, um selbst zu wählen.';

  @override
  String get altimeterHelp2 =>
      'Um einen Höhenunterschied zu messen, etwa Treppen oder Stockwerke, tippe am Start auf Hier nullen.';

  @override
  String get altimeterHelp3 =>
      'Geh hinauf oder hinunter: Der Wanderer geht mit, die Fahne markiert deinen höchsten Punkt. Die Leiste zeigt Meter ab deiner Null, Luftdruck und ungefähre Höhe.';

  @override
  String get altimeterHelp4 =>
      'Tippe auf Nullpunkt löschen, um nicht mehr ab deinem Nullpunkt zu messen: Der Wert Ab Null wird wieder leer.';

  @override
  String get altimeterTip =>
      'Das Wetter ändert ständig den Luftdruck, daher kann die Höhe ohne bekannte Ausgangshöhe um hundert Meter oder mehr abweichen. Verlass dich auf die Höhenänderung ab Hier nullen über kurze Zeit. Dieses Werkzeug braucht ein Handy mit Barometer.';

  @override
  String get weather => 'Wetter';

  @override
  String get weatherAuto => 'Automatisch (Tageszeit und Jahreszeit)';

  @override
  String get weatherSunny => 'Sonnig';

  @override
  String get weatherCloudy => 'Bewölkt';

  @override
  String get weatherRain => 'Regen';

  @override
  String get weatherStorm => 'Gewitter';

  @override
  String get weatherSnow => 'Schnee';

  @override
  String get fromZero => 'Ab Null';

  @override
  String get altitudeShort => 'Höhe';

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
      'Der Himmel folgt dem Licht: Nacht im Dunkeln, Morgendämmerung in einem schwach beleuchteten Raum, und die Sonne steigt, je heller es wird. Lies die Lux und wofür das Licht taugt: 300 bis 750 lx eignen sich zum Lesen und für die Schreibtischarbeit.';

  @override
  String get lightHelp4 =>
      'Tippe auf Sperren, um einen Wert zu behalten, während du das Handy wegnimmst.';

  @override
  String get lightTip =>
      'Lichtsensoren in Handys sind nicht geeicht, daher können sich die Werte von Handy zu Handy stark unterscheiden. Vergleiche damit Licht an einem Ort mit demselben Handy; ein geeichtes Luxmeter ist es nicht. Verdecke den oberen Bildschirmrand nicht.';

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
      'Die große Zahl ist der aktuelle Pegel, gemittelt über etwa eine Sekunde. Von ihr breiten sich Wellen aus, je lauter, desto mehr und weiter: grün bei Ruhe, dann gelb, orange, rot und purpurrot. Die Balken darunter zeigen die letzten drei Sekunden.';

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
      'Handymikrofone sind keine geeichten Schallpegelmesser und unterscheiden sich je nach Modell, daher sind die Werte ungefähr (oft auf etwa 5 bis 10 dB genau), und sehr laute Geräusche werden eventuell zu niedrig angezeigt. Für alles Offizielle brauchst du einen geeichten Schallpegelmesser.';

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

  @override
  String get toolHeight => 'Höhe';

  @override
  String get toolHeightSubtitle => 'Höhe und Entfernung durch Anpeilen';

  @override
  String get heightHelp1 =>
      'Stell dich so hin, dass du Fuß und Spitze des Objekts siehst. Halte das Handy mit dem Display nach oben und peile über die obere Kante.';

  @override
  String get heightHelp2 =>
      'Richte die obere Kante auf den Fuß des Objekts und tippe auf Fuß speichern: daraus ergibt sich die Entfernung.';

  @override
  String get heightHelp3 =>
      'Richte die obere Kante auf die Spitze und tippe auf Spitze speichern: die Höhe erscheint.';

  @override
  String get heightHelp4 =>
      'Entfernung bekannt? Tippe auf Entfernung und gib sie ein, dann peile nur die Spitze an. Tippe auf Augenhöhe, um deine einzustellen.';

  @override
  String get heightTip =>
      'Etwa ±5 % auf ebenem Boden mit richtiger Augenhöhe (Körpergröße minus etwa 10 cm). Geh so weit zurück, dass die Spitze unter 70° und der Fuß mindestens 3° unter der Waagerechten liegt. Am Hang die Entfernung eingeben.';

  @override
  String get lockBase => 'Fuß speichern';

  @override
  String get lockTop => 'Spitze speichern';

  @override
  String get measureAgain => 'Neu messen';

  @override
  String get distance => 'Entfernung';

  @override
  String get objectHeight => 'Höhe';

  @override
  String get eyeHeight => 'Augenhöhe';

  @override
  String get sightAngle => 'Peilwinkel';

  @override
  String get heightAimBase => 'Obere Kante auf den Fuß richten';

  @override
  String get heightAimTop => 'Jetzt die obere Kante auf die Spitze richten';

  @override
  String get heightDone => 'Fertig · Neu messen für ein weiteres';

  @override
  String get heightHoldFlatter =>
      'Handy flacher halten und über die obere Kante peilen';

  @override
  String get heightTooFar =>
      'Fuß zu nah an der Waagerechten: näher gehen oder Entfernung eingeben';

  @override
  String get heightStepBack =>
      'Sehr steil: zurückgehen für einen ruhigeren Wert';

  @override
  String get knownDistance => 'Entfernung zum Fuß';

  @override
  String get knownDistanceHint =>
      'Die Entfernung am Boden bis zum Fuß des Objekts. Löschen, um sie durch Anpeilen zu messen.';

  @override
  String get eyeHeightHint =>
      'Wie hoch deine Augen über dem Boden sind: etwa Körpergröße minus 10 cm.';

  @override
  String get clear => 'Löschen';

  @override
  String get toolCamera => 'Kamera-Wasserwaage';

  @override
  String get toolCameraSubtitle =>
      'Waagrechte Linien über dem Kamerabild, jede Kante messen';

  @override
  String get cameraHelp1 =>
      'Richte die Rückkamera auf eine Wand, ein Bild, ein Regal oder eine Tür. Halte das Handy aufrecht und genau zur Wand.';

  @override
  String get cameraHelp2 =>
      'Durchgezogene Linien folgen der Schwerkraft: Sie sind immer genau waagrecht und lotrecht. Gestrichelte Linien sind fest am Handy, und der kleine Bogen dazwischen zeigt, wie weit es geneigt ist. Die echten Linien werden orange, wenn das Handy gerade ist.';

  @override
  String get cameraHelp3 =>
      'Um ein Objekt zu prüfen, tippe auf Einfrieren und zieh die zwei orangen Griffe auf eine seiner Kanten, etwa die Oberkante eines Rahmens. Du siehst, wie weit die Kante schief ist und welche Seite höher muss, auch wenn deine Hand nicht gerade war. Zieh die Linie senkrecht, um eine lotrechte Kante zu prüfen.';

  @override
  String get cameraHelp4 =>
      'Die zwei Schalter oben blenden die Handylinien und die echten Linien ein oder aus. Das Licht hilft in dunklen Ecken; Fortsetzen zeigt wieder das Live-Bild.';

  @override
  String get cameraTip =>
      'Für eine genaue Kantenmessung halte das Handy gerade zur Wand (Vor/zurück unter 5°) und miss nahe der Bildmitte, wo das Objektiv Linien am wenigsten biegt. Nutzt die Kantenkalibrierung der Wasserwaage. Das Bild wird nie aufgenommen, gespeichert oder gesendet.';

  @override
  String get cameraAllowTitle => 'Kamera erlauben';

  @override
  String get cameraAllowBody =>
      'Die Kamera-Wasserwaage zeichnet waagrechte Linien über das Kamerabild und misst Kanten darin. Das Bild bleibt auf deinem Handy und wird nie aufgenommen, gespeichert oder gesendet.';

  @override
  String get cameraAllow => 'Kamera erlauben';

  @override
  String get cameraDeniedTitle => 'Kamerazugriff ist aus';

  @override
  String get cameraDeniedBody =>
      'Erlaube die Kamera für diese App in den Einstellungen, um die Kamera-Wasserwaage zu nutzen. Das Bild wird nie aufgenommen, gespeichert oder gesendet.';

  @override
  String get noCamera =>
      'Die Kamera kann nicht genutzt werden. Vielleicht verwendet sie eine andere App, oder das Handy hat keine: Schließe andere Kamera-Apps und öffne die Kamera-Wasserwaage erneut.';

  @override
  String get tilt => 'Neigung';

  @override
  String get forwardBack => 'Vor/zurück';

  @override
  String get cameraLevel => 'Gerade';

  @override
  String cameraTilted(String value) {
    return 'Geneigt um $value°';
  }

  @override
  String get cameraHoldUpright => 'Handy aufrecht halten, Kamera zur Wand';

  @override
  String get freeze => 'Einfrieren';

  @override
  String get resume => 'Fortsetzen';

  @override
  String get torch => 'Licht';

  @override
  String cameraSemantics(String value) {
    return 'Kamerabild mit waagrechten Linien, um $value Grad geneigt';
  }

  @override
  String get cameraPhoneLines => 'Handylinien';

  @override
  String get cameraTrueLines => 'Echte Linien';

  @override
  String get cameraFrozen => 'Eingefroren';

  @override
  String get cameraDragHandles => 'Zieh die Griffe auf eine Kante';

  @override
  String get cameraFaceWall => 'Halte das Handy gerade zur Wand';

  @override
  String get edgeLevel => 'Diese Kante ist waagrecht';

  @override
  String get edgePlumb => 'Diese Kante ist lotrecht';

  @override
  String edgeLiftRight(String value) {
    return 'Kante $value° schief, rechts anheben';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'Kante $value° schief, links anheben';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'Kante $value° aus dem Lot';
  }

  @override
  String get cameraHandle => 'Kantengriff';

  @override
  String get toolGForce => 'G-Kraft';

  @override
  String get toolGForceSubtitle => 'Bremsen, Beschleunigen und Kurven in g';

  @override
  String get gHelp1 =>
      'Befestige das Handy in einer Autohalterung, den Bildschirm zu dir. Tippe bei stehendem Auto auf Nullen: Das Messgerät lernt, wo unten und wo vorne ist.';

  @override
  String get gHelp2 =>
      'Fahr los: Die Seite des Autos, zu der du gedrückt wirst, leuchtet. Beim Bremsen leuchtet vorne, beim Beschleunigen hinten, in einer Kurve außen. Grün ist sanft, Orange kräftig, Rot hart.';

  @override
  String get gHelp3 =>
      'Die Tafel hält das stärkste Beschleunigen, Bremsen und die stärkste Kurve seit dem Nullen fest, und die Punkte am Rand halten den stärksten Druck in jede Richtung fest. Die Taste zum Zurücksetzen löscht sie.';

  @override
  String get gHelp4 =>
      'Behalte die Straße im Blick: Lass einen Beifahrer ablesen oder sieh dir die Spitzen an, wenn du angehalten hast.';

  @override
  String get gTip =>
      'Die Werte kommen vom Beschleunigungssensor und sind ungefähr: Sie setzen eine feste Halterung und ein Nullen im Stillstand voraus und sind auf holprigen Straßen etwas unruhiger. Verrutscht die Halterung, halte an und tippe erneut auf Nullen. Über 0,5 g ist für ein normales Auto eine Vollbremsung oder eine schnelle Kurve.';

  @override
  String get gZero => 'Nullen';

  @override
  String get gResetPeaks => 'Spitzen zurücksetzen';

  @override
  String get gSpeedUp => 'Beschleunigen';

  @override
  String get gBrake => 'Bremsen';

  @override
  String get gCorner => 'Kurve';

  @override
  String get gSteady => 'Gleichmäßig';

  @override
  String gBraking(String value) {
    return 'Bremsen $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'Beschleunigen $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'Linkskurve $value g';
  }

  @override
  String gRightBend(String value) {
    return 'Rechtskurve $value g';
  }

  @override
  String gSemantics(String value) {
    return 'G-Kraft $value g';
  }

  @override
  String get gZeroed => 'Genullt: vorne und unten gelernt';

  @override
  String get noAccelerometerG =>
      'Dieses Handy hat keinen Beschleunigungssensor, daher lässt sich hier keine G-Kraft messen. Andere Werkzeuge funktionieren weiter.';

  @override
  String get toolSpeed => 'Tacho';

  @override
  String get toolSpeedSubtitle => 'Tempo, Strecke und GPS-Höhe';

  @override
  String get speedHelp1 =>
      'Erlaube den Standort und leg das Handy dorthin, wo es den Himmel sieht, etwa aufs Armaturenbrett oder in eine Halterung an der Windschutzscheibe. Draußen dauert die erste Ortung ein paar Sekunden.';

  @override
  String get speedHelp2 =>
      'Die Anzeige auf dem Armaturenbrett zeigt dein Tempo per GPS, links und rechts davon die Strecke der Fahrt und die Höhe. Das Feld hält Strecke, Spitzentempo und Durchschnitt seit dem letzten Zurücksetzen fest.';

  @override
  String get speedHelp3 =>
      'Tippe auf die Koordinaten, um sie zu kopieren. Die Einheitentaste wechselt zwischen km/h und mph, und Fahrt zurücksetzen startet Strecke, Spitze und Schnitt neu.';

  @override
  String get speedHelp4 =>
      'Behalte die Straße im Blick: Lass einen Beifahrer ablesen oder sieh dir die Fahrt an, wenn du angehalten hast.';

  @override
  String get speedTip =>
      'Das Tempo kommt von den Satelliten und stimmt auf freien Straßen meist auf etwa 1 km/h; in Tunneln, zwischen hohen Gebäuden oder drinnen kann es nachhinken oder aussetzen. Die GPS-Höhe kann 10 bis 50 m danebenliegen, nimm für Höhenänderungen also den Höhenmesser. Der Standort wird nur genutzt, solange dieses Werkzeug offen ist, und verlässt nie dein Handy.';

  @override
  String get speedAllowTitle => 'Standort erlauben';

  @override
  String get speedAllowBody =>
      'Der Tacho misst per GPS dein Tempo, deine Strecke und deine Höhe. Der Standort wird nur genutzt, solange dieses Werkzeug auf dem Bildschirm offen ist, nie im Hintergrund, und verlässt nie dein Handy.';

  @override
  String get speedAllow => 'Standort erlauben';

  @override
  String get speedDeniedTitle => 'Standortzugriff ist aus';

  @override
  String get speedDeniedBody =>
      'Erlaube dieser App in den Einstellungen den Standort, um den Tacho zu nutzen. Er wird nur genutzt, solange das Werkzeug offen ist, und verlässt nie dein Handy.';

  @override
  String get speedServiceOffTitle => 'Standort ist ausgeschaltet';

  @override
  String get speedServiceOffBody =>
      'Schalte den Standort in den Einstellungen des Handys ein, um den Tacho zu nutzen.';

  @override
  String get speedDistance => 'Strecke';

  @override
  String get speedTop => 'Spitze';

  @override
  String get speedAverage => 'Schnitt';

  @override
  String get speedTrip => 'Fahrt';

  @override
  String get speedAltitude => 'Höhe';

  @override
  String get speedResetTrip => 'Fahrt zurücksetzen';

  @override
  String get speedFinding => 'Suche Satelliten…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value m';
  }

  @override
  String get speedWeak => 'Schwaches GPS: Tempo kann nachhinken';

  @override
  String get speedApproximate =>
      'Genauer Standort aus: für stabiles Tempo einschalten';

  @override
  String get speedStill => 'Stillstand';

  @override
  String get speedCopied => 'Koordinaten kopiert';

  @override
  String get speedUnitTooltip => 'Zwischen km/h und mph wechseln';

  @override
  String get speedKmh => 'km/h';

  @override
  String get speedMph => 'mph';

  @override
  String speedSemantics(String value) {
    return 'Tempo $value';
  }

  @override
  String get speedCoordinates => 'Koordinaten, zum Kopieren tippen';

  @override
  String get noGps =>
      'Dieses Handy hat kein GPS, daher lässt sich hier kein Tempo messen. Andere Werkzeuge funktionieren weiter.';

  @override
  String get speedSceneHelp =>
      'Der Himmel folgt der Tageszeit. Der Wetter-Knopf wählt die Szene: Auto folgt der Jahreszeit, oder wähle Sonne, Wolken, Regen, Gewitter oder Schnee. Das ist Kulisse, keine Vorhersage.';

  @override
  String get supportTitle => 'Kostenlos und ohne Werbung';

  @override
  String get supportBody =>
      'Von einer Person in ihrer Freizeit entwickelt. Wenn dir die App hilft, kannst du sie unterstützen.';

  @override
  String get supportButton => 'Auf GitHub unterstützen';

  @override
  String get linkCopied => 'Link kopiert';

  @override
  String madeBy(String name) {
    return 'Entworfen und entwickelt von $name';
  }

  @override
  String testFeedbackTitle(String app) {
    return 'Hilf mit, $app besser zu machen';
  }

  @override
  String get testFeedbackBody =>
      'Ein Problem gefunden oder eine Idee? Ich lese jede Nachricht.';

  @override
  String get testEmailMe => 'Schreib mir';

  @override
  String testEmailSubject(String app) {
    return 'Feedback zu $app';
  }

  @override
  String get testEmailCopied => 'E-Mail-Adresse kopiert';

  @override
  String get testEndedTitle => 'Diese Testversion ist abgelaufen';

  @override
  String get testEndedBody =>
      'Danke fürs Testen! Bitte hol dir die neue Version. Schreib mir dafür:';

  @override
  String get toolTracker => 'Tracker-Check';

  @override
  String get toolTrackerSubtitle => 'Versteckte Tracker, die dir folgen';

  @override
  String get sensorBluetooth => 'Bluetooth';

  @override
  String get trackerHelp1 =>
      'Tippe auf Hier scannen, um Bluetooth-Tracker in deiner Nähe zu sehen, die von ihrem Besitzer getrennt sind: AirTag, Galaxy SmartTag, Tile, Chipolo und Find-Hub-Tags.';

  @override
  String get trackerHelp2 =>
      'Um zu prüfen, ob dir einer folgt, tippe auf Unterwegs prüfen und lass das Werkzeug beim Gehen oder Fahren offen; der Bildschirm bleibt an. Ein Tracker, der an 3 Orten über mindestens 30 Minuten gehört wird, ist mit dir unterwegs.';

  @override
  String get trackerHelp3 =>
      'Tippe auf einen Tracker, um ihn zu finden: Geh langsam und folge der steigenden Zahl. Unter Alle zeigen markierst du eigene Tracker mit Gehört mir, dann erscheinen sie nicht mehr.';

  @override
  String get trackerHelp4 =>
      'GPS-Boxen mit SIM-Karte kann kein Handy hören. Tippe auf Auto-Check: Die meisten halten mit einem starken Magneten, den der Metalldetektor findet.';

  @override
  String get trackerTip =>
      'Es hört nur, solange es offen ist, und nicht jeden Tracker. Auch der Tracker eines Familienmitglieds oder eines Fremden im selben Zug kann erscheinen, und einer neben seinem Besitzer wird ausgelassen. Wenn du glaubst, dass dich jemand verfolgt, wende dich an die Polizei oder eine Beratungsstelle.';

  @override
  String get trackerAllowTitle => 'Bluetooth-Scan erlauben';

  @override
  String get trackerAllowBody =>
      'Der Tracker-Check hört auf Bluetooth-Tracker in deiner Nähe. Er hört nur, solange das Werkzeug offen ist, verbindet sich nie mit ihnen, und nichts davon verlässt dein Handy.';

  @override
  String get trackerAllow => 'Bluetooth erlauben';

  @override
  String get trackerDeniedTitle => 'Bluetooth-Scan ist aus';

  @override
  String get trackerDeniedBody =>
      'Erlaube in den Einstellungen Geräte in der Nähe für diese App, um den Tracker-Check zu nutzen.';

  @override
  String get trackerBluetoothOffTitle => 'Bluetooth ist aus';

  @override
  String get trackerBluetoothOffBody =>
      'Schalte Bluetooth ein, um auf Tracker zu hören. Die App verbindet sich nie mit etwas.';

  @override
  String get trackerLocationOffTitle => 'Standort ist aus';

  @override
  String get trackerLocationOffBody =>
      'Auf dieser Android-Version funktioniert der Bluetooth-Scan nur mit eingeschaltetem Standort. Daraus wird nichts geortet.';

  @override
  String get trackerScanHere => 'Hier scannen';

  @override
  String get trackerCheckMoving => 'Unterwegs prüfen';

  @override
  String get trackerStop => 'Stopp';

  @override
  String get trackerDone => 'Fertig';

  @override
  String get trackerLocationNeeded =>
      'Unterwegs prüfen merkt sich Orte per GPS: Erlaube den Standort.';

  @override
  String get trackerSimNote => 'GPS-Boxen mit SIM-Karte sind nicht hörbar';

  @override
  String get trackerCarCheck => 'Auto-Check';

  @override
  String get carCheckBody =>
      'Manche Tracker sind GPS-Boxen mit SIM-Karte, die an einem Auto versteckt sind. Kein Handy kann sie hören, aber die meisten halten mit einem starken Magneten, den der Metalldetektor findet.';

  @override
  String get carSpot1 => 'Unter den Stoßstangen, vorn und hinten';

  @override
  String get carSpot2 => 'In den Radkästen';

  @override
  String get carSpot3 => 'Unter den Sitzen und im Kofferraum';

  @override
  String get carSpot4 =>
      'Hinter der Diagnosebuchse (OBD) unter dem Armaturenbrett';

  @override
  String get carCheckTip =>
      'Fahre mit der Oberkante des Handys langsam über jede Stelle. Springt die Anzeige, ist dort Metall oder ein Magnet: Sieh genauer hin.';

  @override
  String get carOpenMetal => 'Metalldetektor öffnen';

  @override
  String get trackerPaused => 'Pausiert, solange die App verborgen ist';

  @override
  String trackerFollowingBanner(String name, int places) {
    return '$name ist mit dir unterwegs: an $places Orten gehört';
  }

  @override
  String trackerMoving(int minutes, int places) {
    return 'Prüft seit $minutes Min. Passierte Orte: $places';
  }

  @override
  String get trackerListening => 'Hört auf Tracker';

  @override
  String get trackerNothingHeard => 'Hier kein Tracker ohne Besitzer gehört';

  @override
  String get trackerIdle => 'Scanne, um Tracker in der Nähe zu sehen';

  @override
  String trackerSemantics(int following, int nearby) {
    return 'Folgen dir: $following. Tracker in der Nähe: $nearby.';
  }

  @override
  String trackerShowAll(int count) {
    return 'Alle zeigen ($count)';
  }

  @override
  String trackerAllTitle(int count) {
    return 'Tracker in der Nähe: $count';
  }

  @override
  String get trackerKindFindMy => 'Wo-ist?-Tag';

  @override
  String get trackerKindFindHub => 'Find-Hub-Tag';

  @override
  String get trackerKindDult => 'Gegenstands-Tracker';

  @override
  String get trackerClose => 'Nah';

  @override
  String get trackerNear => 'Mittel';

  @override
  String get trackerFar => 'Fern';

  @override
  String trackerFollowingYou(int places) {
    return 'Folgt dir · Orte: $places';
  }

  @override
  String trackerPlaces(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'An $count Orten gehört',
      one: 'An 1 Ort gehört',
    );
    return '$_temp0';
  }

  @override
  String get trackerMine => 'Gehört mir';

  @override
  String get trackerNotMine => 'Nicht meiner';

  @override
  String get trackerFollowingLabel => 'folgen dir';

  @override
  String trackerNearby(int count) {
    return 'in der Nähe: $count';
  }

  @override
  String trackerFindTitle(String name) {
    return '$name finden';
  }

  @override
  String get trackerFindHint =>
      'Geh langsam um das Auto oder die Tasche und folge der steigenden Zahl. Das Signal zeigt nur die Entfernung, nicht die Richtung.';

  @override
  String get trackerFindLost => 'Nicht gehört: langsam bewegen';

  @override
  String get findFar => 'Fern';

  @override
  String get findCloser => 'Wärmer';

  @override
  String get findNear => 'Nah';

  @override
  String get findHere => 'Genau hier';

  @override
  String get trackerAppleSound =>
      'Apples Wo ist? oder die App Tracker Detect auf Android können einen AirTag einen Ton abspielen lassen.';
}
