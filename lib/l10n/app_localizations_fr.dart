// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Niveau à bulle et rapporteur';

  @override
  String get homeTitle => 'Niveau à bulle';

  @override
  String get settings => 'Réglages';

  @override
  String get homeTopTools => 'Vos outils favoris';

  @override
  String get homeMoreTools => 'Autres outils';

  @override
  String get homeArrange => 'Organiser';

  @override
  String get arrangeTitle => 'Organiser les outils';

  @override
  String get arrangeHint =>
      'Faites glisser pour changer l’ordre. Les trois premiers sont vos outils favoris.';

  @override
  String get arrangeStar => 'En faire un favori';

  @override
  String get arrangeUnstar => 'Retirer des favoris';

  @override
  String get arrangeReset => 'Ordre populaire';

  @override
  String get arrangeDone => 'Terminé';

  @override
  String get back => 'Retour';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get toolLevel => 'Niveau';

  @override
  String get toolLevelSubtitle => 'Niveau à bulle et niveau d’eau';

  @override
  String get toolAngle => 'Angle';

  @override
  String get toolAngleSubtitle =>
      'Angle par rapport à l’horizontale ou à votre zéro';

  @override
  String get toolCompass => 'Boussole';

  @override
  String get toolCompassSubtitle => 'Cap et direction';

  @override
  String get toolProtractor => 'Rapporteur';

  @override
  String get toolProtractorSubtitle => 'Mesurez des angles sur l’écran';

  @override
  String get toolRuler => 'Règle';

  @override
  String get toolRulerSubtitle => 'Mesurez des longueurs sur l’écran';

  @override
  String get toolMetal => 'Détecteur de métaux';

  @override
  String get toolMetalSubtitle => 'Trouvez le fer, l’acier et les aimants';

  @override
  String get toolVibration => 'Vibrations';

  @override
  String get toolVibrationSubtitle =>
      'Intensité et vitesse des vibrations (tr/min)';

  @override
  String get toolSound => 'Sonomètre';

  @override
  String get toolSoundSubtitle => 'Niveau de bruit en décibels';

  @override
  String get toolAltimeter => 'Altimètre';

  @override
  String get toolAltimeterSubtitle => 'Pression de l’air et hauteur';

  @override
  String get toolLight => 'Luxmètre';

  @override
  String get toolLightSubtitle => 'Luminosité en lux';

  @override
  String get notAvailableOnPhone => 'Indisponible sur ce téléphone';

  @override
  String get notOnPhone => 'Indisponible';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, indisponible sur ce téléphone';
  }

  @override
  String get howToUse => 'Mode d’emploi';

  @override
  String get rotateLandscape => 'Passer en paysage';

  @override
  String get rotatePortrait => 'Passer en portrait';

  @override
  String howToUseTool(String tool) {
    return 'Utiliser : $tool';
  }

  @override
  String get gotIt => 'Compris';

  @override
  String get goodToKnow => 'Bon à savoir : ';

  @override
  String get ok => 'OK';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool indisponible';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'de capteurs',
      one: 'd’un capteur',
    );
    return '$tool a besoin $_temp0 que ce téléphone n’a pas : $sensors.';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'C’est une limite du matériel du téléphone, pas un défaut de l’application. Tous les autres outils fonctionnent normalement.';

  @override
  String get sensorAccelerometer => 'accéléromètre';

  @override
  String get sensorMagnetometer => 'magnétomètre (capteur de boussole)';

  @override
  String get sensorBarometer => 'baromètre (capteur de pression de l’air)';

  @override
  String get sensorLight => 'capteur de lumière';

  @override
  String get sensorMicrophone => 'micro';

  @override
  String get sensorCamera => 'caméra arrière';

  @override
  String get sensorGps => 'GPS';

  @override
  String get noAccelerometer =>
      'Ce téléphone n’a pas d’accéléromètre : cet outil ne peut rien mesurer ici. Les outils qui n’en ont pas besoin fonctionnent toujours.';

  @override
  String get noMagnetometer =>
      'Ce téléphone n’a pas de magnétomètre (capteur de boussole) : cet outil ne peut pas fonctionner ici. Les outils qui n’en ont pas besoin fonctionnent toujours.';

  @override
  String get noReadings =>
      'Aucune mesure du capteur pour l’instant. Revenez en arrière et rouvrez l’outil ; si cela continue, redémarrez le téléphone. Certains téléphones ne prennent pas en charge cet outil.';

  @override
  String get waitingForSensors => 'En attente des capteurs…';

  @override
  String get levelHelp1 =>
      'Posez le téléphone à plat sur la surface ou sur l’un de ses bords.';

  @override
  String get levelHelp2 =>
      'À plat : centrez la bulle. X est l’inclinaison gauche/droite, Y avant/arrière. Sur un bord, vous voyez l’angle et la pente.';

  @override
  String get levelHelp3 =>
      'Suivez l’indication à l’écran (par exemple « Côté droit haut ») jusqu’à « De niveau » : l’affichage devient orange, le téléphone sonne et vibre (désactivable dans les Réglages).';

  @override
  String get levelHelp4 =>
      'Touchez Verrouiller pour figer la mesure et Déverrouiller pour reprendre la mesure en direct.';

  @override
  String get levelHelp5 =>
      'Vous préférez un niveau classique ? Touchez l’icône de la fiole dans le sélecteur ; l’icône ronde ramène le cadran.';

  @override
  String get levelTip =>
      'Si une surface que vous savez de niveau n’affiche pas 0°, posez le téléphone dessus et touchez Calibrer. Pour annuler, touchez de nouveau Calibrer et choisissez Réinitialiser l’étalonnage.';

  @override
  String get statusLevel => 'De niveau';

  @override
  String get leftEndLow => 'Extrémité gauche basse';

  @override
  String get rightEndLow => 'Extrémité droite basse';

  @override
  String get rightSideHigh => 'Côté droit haut';

  @override
  String get leftSideHigh => 'Côté gauche haut';

  @override
  String get topEdgeHigh => 'Bord du haut haut';

  @override
  String get bottomEdgeHigh => 'Bord du bas haut';

  @override
  String get calibrated => 'Calibré. Cette position affiche maintenant 0°.';

  @override
  String get tooFarToCalibrate =>
      'Trop incliné pour calibrer. Posez d’abord le téléphone sur une surface de niveau.';

  @override
  String get dialView => 'Vue cadran';

  @override
  String get tubeView => 'Vue fiole';

  @override
  String get levelTube => 'Fiole de niveau';

  @override
  String get leftRightTube => 'Fiole gauche-droite';

  @override
  String get forwardBackTube => 'Fiole avant-arrière';

  @override
  String tiltFromLevel(String value) {
    return 'Inclinaison par rapport à l’horizontale $value';
  }

  @override
  String fromLevel(String value) {
    return 'Écart par rapport à l’horizontale $value';
  }

  @override
  String get xLeftRight => 'X · gauche / droite';

  @override
  String get yForwardBack => 'Y · avant / arrière';

  @override
  String get angle => 'Angle';

  @override
  String get slope => 'Pente';

  @override
  String get lock => 'Verrouiller';

  @override
  String get unlock => 'Déverrouiller';

  @override
  String locked(String status) {
    return 'Verrouillé · $status';
  }

  @override
  String get lockReading => 'Verrouiller la mesure';

  @override
  String get lockHandles => 'Verrouiller les poignées';

  @override
  String get handlesLocked =>
      'Poignées verrouillées · touchez le cadenas pour ajuster';

  @override
  String get calibrate => 'Calibrer';

  @override
  String get angleHelp1 =>
      'Posez le téléphone sur une surface pour lire son inclinaison, ou posez-le sur la tranche contre une pente, une rampe ou un tuyau : le grand nombre est l’angle du bord qui s’allume en orange ; celui du bord inférieur est en dessous.';

  @override
  String get angleHelp2 =>
      'Pour mesurer un changement, tenez le téléphone dans la position de départ et touchez Zéro ici.';

  @override
  String get angleHelp3 =>
      'Inclinez ou déplacez le téléphone. Le cadran indique de combien de degrés il a bougé depuis votre zéro.';

  @override
  String get angleHelp4 =>
      'Touchez Effacer le zéro pour revenir à l’angle par rapport à la position à plat.';

  @override
  String get angleHelp5 =>
      'Pour lire un angle que vous ne voyez pas, plaquez le téléphone contre l’objet, touchez le cadenas, puis éloignez-le pour lire.';

  @override
  String get angleHelp6 =>
      'Choisissez le mode avec le sélecteur en haut : à plat sur une surface ou debout sur une tranche. Sur la tranche, l’écran se remplit d’eau qui reste de niveau, et le bord mesuré, le côté le plus bas, s’allume en orange.';

  @override
  String get angleTip =>
      'Posez le grand côté du téléphone le long d’une rampe, d’une main courante ou d’un toit pour lire sa pente, ou plaquez l’écran contre une planche ou une porte pour mesurer son inclinaison.';

  @override
  String movedFromZero(String value) {
    return 'Déplacé depuis le zéro $value';
  }

  @override
  String get measuringFromZero => 'Mesure depuis votre zéro';

  @override
  String get angleFlatStatus => 'À plat · angle par rapport à la Terre';

  @override
  String get measuringRightEdge => 'Mesure du bord droit';

  @override
  String get measuringLeftEdge => 'Mesure du bord gauche';

  @override
  String bottomEdge(String value) {
    return 'Bord inférieur $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge : $value par rapport à l’horizontale. Bord inférieur $other';
  }

  @override
  String get angleModeFlat => 'À plat sur une surface';

  @override
  String get angleModeEdge => 'Sur la tranche';

  @override
  String get standOnEdge => 'Posez le téléphone sur l’une de ses tranches';

  @override
  String get clearZero => 'Effacer le zéro';

  @override
  String get setZeroHere => 'Zéro ici';

  @override
  String get compassHelp1 =>
      'Tenez le téléphone à plat devant vous, loin des métaux, des aimants et des appareils électroniques.';

  @override
  String get compassHelp2 =>
      'Pointez le haut du téléphone dans la direction que vous voulez connaître. Tenu à la verticale, elle indique la direction de la caméra arrière.';

  @override
  String get compassHelp3 =>
      'Le nombre est votre cap en degrés et les lettres indiquent la direction. Le cadran tourne pour que son N pointe toujours vers le nord ; la bille orange en haut marque la direction du téléphone.';

  @override
  String get compassTip =>
      'Elle indique le nord magnétique, qui peut différer du nord de la carte de 10 degrés ou plus à certains endroits. Si elle semble fausse, faites plusieurs fois un 8 avec le téléphone.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Cap magnétique $heading degrés, $direction';
  }

  @override
  String get magneticInterference =>
      'Perturbation magnétique · éloignez-vous du métal, puis décrivez un 8 avec le téléphone';

  @override
  String get compassCalibrate =>
      'Décrivez un 8 avec le téléphone pour calibrer la boussole';

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
  String get dirSW => 'SO';

  @override
  String get dirW => 'O';

  @override
  String get dirNW => 'NO';

  @override
  String get protractorHelp1 =>
      'Posez le téléphone à plat et l’objet sur l’écran, son coin au centre.';

  @override
  String get protractorHelp2 =>
      'Faites glisser chaque poignée orange pour que sa ligne longe un côté de l’angle.';

  @override
  String get protractorHelp3 =>
      'Lisez l’angle au centre. Rentrant est l’autre côté (360° moins l’angle).';

  @override
  String get protractorHelp4 => 'Touchez Réinitialiser pour recommencer.';

  @override
  String get protractorHelp5 =>
      'Touchez le cadenas pour garder les poignées en place pendant que vous déplacez l’objet.';

  @override
  String armsSemantics(String value) {
    return 'Angle entre les bras $value';
  }

  @override
  String get reflex => 'Rentrant';

  @override
  String get dragHandles =>
      'Faites glisser les poignées orange le long des bords';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get rulerHelp1 =>
      'Posez l’objet sur l’écran, ou plaquez le téléphone contre lui.';

  @override
  String get rulerHelp2 =>
      'Faites glisser les lignes orange à ses deux extrémités. Touchez mm, cm ou in pour choisir l’unité ; l’autre système s’affiche en dessous.';

  @override
  String get rulerHelp3 =>
      'Pour la meilleure précision, touchez Calibrer une fois et utilisez une carte bancaire, une règle ou la taille de l’écran.';

  @override
  String get rulerHelp4 =>
      'Touchez le cadenas pour garder les lignes en place pendant que vous déplacez l’objet.';

  @override
  String get rulerTip =>
      'Elle mesure jusqu’à la longueur de l’écran. Les coques et les bords incurvés cachent les premiers millimètres : mesurez entre les lignes, pas depuis le bord du téléphone.';

  @override
  String get rulerWidthOn => 'Mesurer aussi la largeur';

  @override
  String rulerArea(String value) {
    return 'Surface $value';
  }

  @override
  String rulerBoxSemantics(String length, String width, String area) {
    return 'Longueur $length millimètres, largeur $width millimètres, surface $area centimètres carrés';
  }

  @override
  String get rulerHelp5 =>
      'Touchez le bouton rectangle en haut pour mesurer aussi la largeur : faites glisser les deux lignes latérales jusqu’aux côtés de l’objet pour lire sa largeur et sa surface. La largeur est limitée à celle de l’écran.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'Longueur $mm millimètres, $inches pouces';
  }

  @override
  String get rulerCalibrated => 'Calibrée avec une carte · ±0,5 mm';

  @override
  String get rulerReported =>
      'Taille d’écran du téléphone · calibrez pour ±0,5 mm';

  @override
  String get unitMillimetres => 'Millimètres';

  @override
  String get unitCentimetres => 'Centimètres';

  @override
  String get unitInches => 'Pouces';

  @override
  String get rulerEstimated =>
      'Non calibrée · les longueurs peuvent varier de 10 %';

  @override
  String get cardLongEdge =>
      'Posez une carte bancaire ou d’identité sur l’écran, grand côté le long de la règle, une extrémité sur la ligne foncée. Faites glisser la ligne orange à l’autre extrémité.';

  @override
  String get cardShortEdge =>
      'Posez une carte bancaire ou d’identité sur l’écran, petit côté le long de la règle, une extrémité sur la ligne foncée. Faites glisser la ligne orange à l’autre extrémité.';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get usePhoneDefault => 'Utiliser la taille d’écran du téléphone';

  @override
  String get usePhoneDefaultInfo => 'Oublier ce calibrage';

  @override
  String get cardMismatch =>
      'Cela ne correspond pas à une carte. Alignez-la sur la ligne foncée et réessayez.';

  @override
  String get rotateToCalibrate => 'Passez en portrait pour calibrer';

  @override
  String get calibrateHow => 'Calibrer avec';

  @override
  String get methodCard => 'Une carte bancaire';

  @override
  String get methodCardInfo => 'Toute carte bancaire ou d’identité · ±0,5 mm';

  @override
  String get methodRuler => 'Une règle';

  @override
  String get methodRulerInfo => 'Le plus précis · règle ou mètre ruban';

  @override
  String get methodScreen => 'La taille de l’écran';

  @override
  String get methodScreenInfo => 'Rien à prévoir · environ 1 %';

  @override
  String rulerInstructions(String mark) {
    return 'Posez une règle sur l’écran, son 0 sur la ligne foncée. Faites glisser la ligne orange jusqu’à la graduation $mark.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'Cela ne correspond pas à $mark. Placez le 0 de la règle sur la ligne foncée et réessayez.';
  }

  @override
  String get screenSizeInstructions =>
      'Saisissez la taille de l’écran en pouces, d’après la fiche technique du téléphone. Vous ne savez pas ? Cherchez votre modèle et « taille d’écran ».';

  @override
  String get screenSizeMismatch =>
      'Cette taille ne correspond pas à cet écran. Vérifiez la fiche technique et réessayez.';

  @override
  String get rulerCalibratedRuler => 'Calibrée avec une règle · ±0,5 mm';

  @override
  String rulerCalibratedScreen(String size) {
    return 'Réglée pour un écran de $size pouces · environ 1 %';
  }

  @override
  String get metalHelp1 =>
      'Ouvrez l’outil loin de tout métal. Cette première mesure compte comme « pas de métal ».';

  @override
  String get metalHelp2 =>
      'Déplacez lentement le téléphone sur la zone. Le capteur se trouve généralement en haut du téléphone. Il bipe plus vite à mesure que le métal se rapproche ; touchez le haut-parleur pour couper le son.';

  @override
  String get metalHelp3 =>
      '« Métal à proximité » signifie un petit changement, « Métal détecté » un fort. Comme au jeu du chaud et froid, l’écran passe du bleu froid au rouge ardent quand vous approchez, et le téléphone vibre à la découverte si la vibration est activée.';

  @override
  String get metalHelp4 =>
      'Immobile quelques secondes, il se remet à zéro tout seul et une fausse détection disparaît. Pour revérifier un endroit, éloignez le téléphone puis revenez. Définir la référence remet à zéro aussitôt.';

  @override
  String get metalTip =>
      'Il ne détecte que le fer, l’acier et les aimants, pas l’aluminium, le cuivre, l’or ni l’argent. Les coques magnétiques le perturbent.';

  @override
  String metalSemantics(int value) {
    return 'Champ magnétique $value microteslas';
  }

  @override
  String get noMetal => 'Pas de métal à proximité';

  @override
  String get metalNearby => 'Métal à proximité';

  @override
  String get metalDetected => 'Métal détecté';

  @override
  String get heatCold => 'Froid';

  @override
  String get heatCool => 'Frais';

  @override
  String get heatWarm => 'Tiède';

  @override
  String get heatWarmer => 'Plus chaud';

  @override
  String get heatHot => 'Chaud';

  @override
  String get heatBurning => 'Brûlant';

  @override
  String get baseline => 'Référence';

  @override
  String get field => 'Champ';

  @override
  String get change => 'Écart';

  @override
  String get findsIronSteel => 'Détecte le fer, l’acier et les aimants';

  @override
  String get setBaseline => 'Définir la référence';

  @override
  String get muteSound => 'Couper le son';

  @override
  String get turnSoundOn => 'Activer le son';

  @override
  String get vibrationHelp1 =>
      'Posez le téléphone à plat sur la machine en marche et retirez les mains. Sur une petite machine, maintenez‑le fermement.';

  @override
  String get vibrationHelp2 =>
      'L’aiguille indique la vitesse de la vibration la plus forte en tr/min, avec les hertz en dessous (tr/min = hertz × 60). La lueur discrète dans le cadran est le spectre entier ; l’aiguille pointe vers sa partie la plus claire.';

  @override
  String get vibrationHelp3 =>
      'L’intensité indique la force des secousses, en m/s² : sous 0,3 c’est immobile, au‑dessus de 2 c’est fort.';

  @override
  String get vibrationHelp4 =>
      'Touchez Verrouiller pour garder une mesure, et le bouton de remise à zéro avant la machine suivante.';

  @override
  String get vibrationTip =>
      'La plupart des téléphones mesurent jusqu’à 100 Hz (6000 tr/min), certains moins ; le cadran indique la limite du vôtre. Une vibration plus rapide peut apparaître comme une vitesse plus basse et fausse. La vibration la plus forte est souvent la vitesse de l’arbre, mais peut en être le double. Les capteurs d’un téléphone ne sont pas des instruments de laboratoire.';

  @override
  String get still => 'Immobile';

  @override
  String get lightVibration => 'Vibrations légères';

  @override
  String get strongVibration => 'Vibrations fortes';

  @override
  String get noAccelerometerVibration =>
      'Ce téléphone n’a pas d’accéléromètre : les vibrations ne peuvent pas être mesurées ici. Les outils qui n’en ont pas besoin fonctionnent toujours.';

  @override
  String vibrationSemantics(String value) {
    return 'Vibrations $value mètres par seconde carrée';
  }

  @override
  String get frequency => 'Fréquence';

  @override
  String get rpm => 'tr/min';

  @override
  String get strength => 'Intensité';

  @override
  String vibratingAt(String value) {
    return 'Vibre à $value Hz';
  }

  @override
  String get noClearFrequency => 'Pas de fréquence nette';

  @override
  String get findingFrequency => 'Recherche de la fréquence…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm tours par minute, $value hertz';
  }

  @override
  String get peak => 'Crête';

  @override
  String get average => 'Moyenne';

  @override
  String get resetPeak => 'Remettre la crête à zéro';

  @override
  String get altimeterHelp1 =>
      'Le randonneur monte et descend la montagne à mesure que votre hauteur change. Le ciel suit l’heure et la saison ; touchez le bouton météo pour choisir vous-même.';

  @override
  String get altimeterHelp2 =>
      'Pour mesurer un dénivelé, comme des escaliers ou des étages, touchez Zéro ici au départ.';

  @override
  String get altimeterHelp3 =>
      'Montez ou descendez : le randonneur marche avec vous et le drapeau marque votre point le plus haut. Le panneau montre les mètres depuis votre zéro, la pression et l’altitude approximative.';

  @override
  String get altimeterHelp4 =>
      'Touchez Effacer le zéro pour ne plus mesurer depuis votre zéro : la valeur Depuis zéro redevient vide.';

  @override
  String get altimeterTip =>
      'La météo modifie sans cesse la pression de l’air : sans altitude de départ connue, l’altitude peut se tromper d’une centaine de mètres ou plus. Fiez-vous au dénivelé depuis Zéro ici sur de courtes durées. Cet outil nécessite un téléphone équipé d’un baromètre.';

  @override
  String get weather => 'Météo';

  @override
  String get weatherAuto => 'Automatique (heure et saison)';

  @override
  String get weatherSunny => 'Ensoleillé';

  @override
  String get weatherCloudy => 'Nuageux';

  @override
  String get weatherRain => 'Pluie';

  @override
  String get weatherStorm => 'Orage';

  @override
  String get weatherSnow => 'Neige';

  @override
  String get fromZero => 'Depuis zéro';

  @override
  String get altitudeShort => 'Altitude';

  @override
  String get barometerIos =>
      'Impossible de lire le baromètre. Activez Mouvements et forme pour cette app dans Réglages › Confidentialité et sécurité, puis rouvrez l’Altimètre.';

  @override
  String get noBarometer =>
      'Ce téléphone n’a pas de baromètre (capteur de pression de l’air) : l’altimètre ne peut pas fonctionner ici. Les autres outils fonctionnent toujours.';

  @override
  String get noLightSensor =>
      'Ce téléphone n’a pas de capteur de lumière, le luxmètre ne peut donc pas fonctionner ici. Les autres outils fonctionnent toujours.';

  @override
  String lightSemantics(String value) {
    return 'Luminosité $value lux';
  }

  @override
  String get illuminance => 'Luminosité';

  @override
  String get footCandles => 'Pieds-bougies';

  @override
  String get lightDark => 'Sombre';

  @override
  String get lightDim => 'Faible lumière';

  @override
  String get lightLivingRoom => 'Lumière de salon';

  @override
  String get lightReading => 'Bien pour lire et travailler au bureau';

  @override
  String get lightBright => 'Éclairage intérieur vif';

  @override
  String get lightOvercast => 'Jour nuageux';

  @override
  String get lightDaylight => 'Lumière du jour';

  @override
  String get lightSun => 'Plein soleil';

  @override
  String get lightHelp1 =>
      'Le capteur de lumière se trouve en haut de l’écran, près de la caméra avant.';

  @override
  String get lightHelp2 =>
      'Tenez le téléphone à l’endroit à mesurer, écran tourné vers la lumière.';

  @override
  String get lightHelp3 =>
      'Le ciel suit la lumière : la nuit dans le noir, l’aube dans une pièce peu éclairée, et le soleil monte à mesure que la lumière augmente. Lisez les lux et à quoi convient la lumière : de 300 à 750 lx conviennent à la lecture et au travail de bureau.';

  @override
  String get lightHelp4 =>
      'Touchez Verrouiller pour garder une mesure pendant que vous éloignez le téléphone.';

  @override
  String get lightTip =>
      'Les capteurs de lumière des téléphones ne sont pas étalonnés : les mesures peuvent donc beaucoup varier d’un téléphone à l’autre. Utilisez-le pour comparer la lumière à un même endroit avec le même téléphone, pas comme un luxmètre étalonné. Ne couvrez pas le haut de l’écran.';

  @override
  String get noMicrophone =>
      'Impossible d’utiliser le micro. Une autre app l’utilise peut-être : fermez-la, puis rouvrez le sonomètre.';

  @override
  String soundSemantics(String value) {
    return 'Niveau sonore d’environ $value décibels';
  }

  @override
  String get decibelsApprox => 'dB (env.)';

  @override
  String get soundMax => 'Max';

  @override
  String get soundVeryQuiet => 'Très calme';

  @override
  String get soundQuiet => 'Calme, comme une bibliothèque';

  @override
  String get soundModerate => 'Modéré, comme une conversation';

  @override
  String get soundLoud => 'Fort, comme une circulation dense';

  @override
  String get soundVeryLoud =>
      'Très fort : une longue exposition peut abîmer l’audition';

  @override
  String get soundDangerous => 'Dangereux : protégez vos oreilles';

  @override
  String get micTitle => 'Autoriser le micro';

  @override
  String get micBody =>
      'Le sonomètre écoute par le micro pour mesurer le niveau sonore. Le son est mesuré sur votre téléphone et n’est jamais enregistré, conservé ni envoyé.';

  @override
  String get micAllow => 'Autoriser le micro';

  @override
  String get micDeniedTitle => 'L’accès au micro est désactivé';

  @override
  String get micDeniedBody =>
      'Autorisez le micro pour cette app dans les Réglages pour utiliser le sonomètre. Le son n’est jamais enregistré, conservé ni envoyé.';

  @override
  String get openSettings => 'Ouvrir les réglages';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get soundHelp1 =>
      'Laissez le micro (sur le bord inférieur) dégagé et orientez le téléphone vers le bruit.';

  @override
  String get soundHelp2 =>
      'Le grand nombre est le niveau actuel, moyenné sur environ une seconde. Des ondes s’en éloignent, plus nombreuses et plus loin quand c’est fort : vertes au calme, puis jaunes, orange, rouges et cramoisies. Les barres en dessous montrent les trois dernières secondes.';

  @override
  String get soundHelp3 =>
      'Moyenne et Max comptent depuis l’ouverture de l’outil. Touchez Réinitialiser pour recommencer.';

  @override
  String get soundHelp4 =>
      'Dès 70 dB, la ligne d’état passe au jaune ; dès 85 dB, où une longue exposition peut abîmer l’audition, elle passe au rouge.';

  @override
  String get soundHelp5 =>
      'Touchez le cadenas pour garder une mesure à l’écran pendant que vous déplacez le téléphone.';

  @override
  String get soundTip =>
      'Les micros de téléphone ne sont pas des sonomètres étalonnés et varient d’un modèle à l’autre : les mesures sont donc approximatives (souvent à environ 5 à 10 dB près) et les sons très forts peuvent être sous-estimés. Pour toute mesure officielle, il faut un sonomètre étalonné.';

  @override
  String get metresFromZero => 'm depuis zéro';

  @override
  String pressureSemantics(String value) {
    return 'Pression de l’air $value hectopascals';
  }

  @override
  String heightSemantics(String value) {
    return 'Hauteur $value depuis le zéro';
  }

  @override
  String get pressure => 'Pression';

  @override
  String get altitudeApprox => 'Altitude (env.)';

  @override
  String get measuringHeight => 'Hauteur mesurée depuis votre zéro';

  @override
  String get airPressureAltitude => 'Pression de l’air et altitude';

  @override
  String get appearance => 'Apparence';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get levelUnits => 'Unité du niveau';

  @override
  String get unitDegrees => 'Degrés';

  @override
  String get unitPercent => 'Pente en pourcentage';

  @override
  String get unitRoofPitch => 'Pente de toit (montée pour 12)';

  @override
  String get vibrateWhenLevel => 'Vibrations';

  @override
  String get sounds => 'Sons';

  @override
  String get resetCalibration => 'Réinitialiser l’étalonnage';

  @override
  String get resetCalibrationHint => 'Revenir au zéro d’usine du capteur';

  @override
  String get calibrateHere => 'Calibrer ici';

  @override
  String get calibrateHereInfo => 'Sur une surface que vous savez de niveau';

  @override
  String get calibrationRemoved =>
      'Étalonnage supprimé. Le niveau utilise de nouveau le zéro d’usine du capteur.';

  @override
  String get resetAllCalibrations => 'Réinitialiser tous les étalonnages';

  @override
  String get resetAllCalibrationsHint => 'Niveau et règle aux réglages d’usine';

  @override
  String get resetAllTitle => 'Réinitialiser tous les étalonnages ?';

  @override
  String get resetAllBody =>
      'Cela supprime les étalonnages réglés dans le niveau (aussi utilisé par la mesure d’angle) et dans la règle. Les deux reviennent aux réglages d’usine. Vos autres réglages restent inchangés, et vous pouvez recalibrer à tout moment.';

  @override
  String get notCalibrated => 'Non étalonné';

  @override
  String get language => 'Langue';

  @override
  String get licenses => 'Licences open source';

  @override
  String get languageSystem => 'Langue du téléphone';

  @override
  String get toolHeight => 'Hauteur';

  @override
  String get toolHeightSubtitle => 'Hauteur et distance par visée';

  @override
  String get heightHelp1 =>
      'Placez-vous là où vous voyez le pied et le sommet de l’objet. Tenez le téléphone écran vers le haut et visez le long du bord supérieur.';

  @override
  String get heightHelp2 =>
      'Visez le pied de l’objet avec le bord supérieur et touchez Fixer le pied : cela donne la distance.';

  @override
  String get heightHelp3 =>
      'Visez le sommet avec le bord supérieur et touchez Fixer le sommet : la hauteur s’affiche.';

  @override
  String get heightHelp4 =>
      'Vous connaissez la distance ? Touchez Distance et saisissez-la, puis visez seulement le sommet. Touchez Hauteur des yeux pour régler la vôtre.';

  @override
  String get heightTip =>
      'Environ ±5 % sur sol plat avec la bonne hauteur des yeux (votre taille moins 10 cm environ). Reculez pour que le sommet soit sous 70° et le pied au moins 3° sous l’horizontale. En pente, saisissez la distance.';

  @override
  String get lockBase => 'Fixer le pied';

  @override
  String get lockTop => 'Fixer le sommet';

  @override
  String get measureAgain => 'Mesurer à nouveau';

  @override
  String get distance => 'Distance';

  @override
  String get objectHeight => 'Hauteur';

  @override
  String get eyeHeight => 'Hauteur des yeux';

  @override
  String get sightAngle => 'Angle de visée';

  @override
  String get heightAimBase => 'Visez le pied avec le bord supérieur';

  @override
  String get heightAimTop =>
      'Visez maintenant le sommet avec le bord supérieur';

  @override
  String get heightDone => 'Terminé · touchez Mesurer à nouveau pour une autre';

  @override
  String get heightHoldFlatter =>
      'Tenez le téléphone plus à plat et visez le long du bord supérieur';

  @override
  String get heightTooFar =>
      'Pied trop proche de l’horizontale : approchez-vous ou saisissez la distance';

  @override
  String get heightStepBack =>
      'Très raide : reculez pour une mesure plus stable';

  @override
  String get knownDistance => 'Distance jusqu’au pied';

  @override
  String get knownDistanceHint =>
      'La distance au sol jusqu’au pied de l’objet. Effacez-la pour la mesurer par visée.';

  @override
  String get eyeHeightHint =>
      'La hauteur de vos yeux au-dessus du sol : votre taille moins 10 cm environ.';

  @override
  String get clear => 'Effacer';

  @override
  String get toolCamera => 'Niveau caméra';

  @override
  String get toolCameraSubtitle =>
      'Lignes de niveau sur la caméra, mesurez n’importe quel bord';

  @override
  String get cameraHelp1 =>
      'Pointez la caméra arrière vers un mur, un tableau, une étagère ou une porte. Tenez le téléphone droit, bien face au mur.';

  @override
  String get cameraHelp2 =>
      'Les lignes pleines suivent la gravité : elles sont toujours de niveau et d’aplomb. Les lignes pointillées sont fixées au téléphone, et le petit arc entre elles montre de combien il est incliné. Les vraies lignes deviennent orange quand le téléphone est de niveau.';

  @override
  String get cameraHelp3 =>
      'Pour vérifier un objet, touchez Figer, puis faites glisser les deux poignées orange sur l’un de ses bords, comme le haut d’un cadre. Vous voyez de combien ce bord est de travers et quel côté relever, même si votre main n’était pas de niveau. Mettez la ligne debout pour vérifier un bord d’aplomb.';

  @override
  String get cameraHelp4 =>
      'Les deux boutons en haut affichent ou masquent les lignes du téléphone et les vraies lignes. La lumière aide dans les coins sombres ; Reprendre revient à l’image en direct.';

  @override
  String get cameraTip =>
      'Pour mesurer un bord avec précision, tenez‑vous bien face au mur (Avant/arrière sous 5°) et mesurez près du centre de l’image, où l’objectif courbe le moins les lignes. Utilise l’étalonnage sur la tranche du niveau. L’image n’est jamais enregistrée, sauvegardée ni envoyée.';

  @override
  String get cameraAllowTitle => 'Autoriser la caméra';

  @override
  String get cameraAllowBody =>
      'Le niveau caméra trace des lignes de niveau sur l’image de la caméra et y mesure les bords. L’image reste sur votre téléphone et n’est jamais enregistrée, sauvegardée ni envoyée.';

  @override
  String get cameraAllow => 'Autoriser la caméra';

  @override
  String get cameraDeniedTitle => 'L’accès à la caméra est désactivé';

  @override
  String get cameraDeniedBody =>
      'Activez la caméra pour cette app dans les Réglages pour utiliser le niveau caméra. L’image n’est jamais enregistrée, sauvegardée ni envoyée.';

  @override
  String get noCamera =>
      'Impossible d’utiliser la caméra. Une autre app l’utilise peut‑être, ou le téléphone n’en a pas : fermez les autres apps photo, puis rouvrez le niveau caméra.';

  @override
  String get tilt => 'Inclinaison';

  @override
  String get forwardBack => 'Avant/arrière';

  @override
  String get cameraLevel => 'De niveau';

  @override
  String cameraTilted(String value) {
    return 'Incliné de $value°';
  }

  @override
  String get cameraHoldUpright =>
      'Tenez le téléphone droit, caméra vers le mur';

  @override
  String get freeze => 'Figer';

  @override
  String get resume => 'Reprendre';

  @override
  String get torch => 'Lumière';

  @override
  String cameraSemantics(String value) {
    return 'Image de la caméra avec lignes de niveau, inclinée de $value degrés';
  }

  @override
  String get cameraPhoneLines => 'Lignes du téléphone';

  @override
  String get cameraTrueLines => 'Vraies lignes';

  @override
  String get cameraFrozen => 'Figé';

  @override
  String get cameraDragHandles => 'Faites glisser les poignées sur un bord';

  @override
  String get cameraFaceWall => 'Placez-vous bien face au mur';

  @override
  String get edgeLevel => 'Ce bord est de niveau';

  @override
  String get edgePlumb => 'Ce bord est d’aplomb';

  @override
  String edgeLiftRight(String value) {
    return 'Bord de travers de $value°, relevez la droite';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'Bord de travers de $value°, relevez la gauche';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'Bord à $value° de l’aplomb';
  }

  @override
  String get cameraHandle => 'Poignée du bord';

  @override
  String get toolGForce => 'Force G';

  @override
  String get toolGForceSubtitle => 'Freinage, accélération et virages en g';

  @override
  String get gHelp1 =>
      'Fixez le téléphone sur un support voiture, écran face à vous. Voiture à l’arrêt, touchez Zéro : l’appareil apprend où sont le bas et l’avant.';

  @override
  String get gHelp2 =>
      'Roulez : le côté de la voiture vers lequel vous êtes poussé s’allume. Un freinage allume l’avant, une accélération l’arrière, un virage l’extérieur. Vert, c’est doux, orange ferme, rouge fort.';

  @override
  String get gHelp3 =>
      'Le panneau garde l’accélération, le freinage et le virage les plus forts depuis le Zéro, et les points sur le bord gardent la poussée la plus forte dans chaque direction. Le bouton de réinitialisation les efface.';

  @override
  String get gHelp4 =>
      'Gardez les yeux sur la route : laissez un passager lire, ou consultez les crêtes une fois arrêté.';

  @override
  String get gTip =>
      'Les mesures viennent de l’accéléromètre et sont approximatives : elles dépendent d’un support bien fixé et d’un Zéro pris à l’arrêt, et sont un peu plus agitées sur route abîmée. Si le support bouge, arrêtez-vous et touchez de nouveau Zéro. Au-delà de 0,5 g, c’est un freinage appuyé ou un virage rapide pour une voiture ordinaire.';

  @override
  String get gZero => 'Zéro';

  @override
  String get gResetPeaks => 'Remettre les crêtes à zéro';

  @override
  String get gSpeedUp => 'Accélération';

  @override
  String get gBrake => 'Freinage';

  @override
  String get gCorner => 'Virage';

  @override
  String get gSteady => 'Stable';

  @override
  String gBraking(String value) {
    return 'Freinage $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'Accélération $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'Virage à gauche $value g';
  }

  @override
  String gRightBend(String value) {
    return 'Virage à droite $value g';
  }

  @override
  String gSemantics(String value) {
    return 'Force G $value g';
  }

  @override
  String get gZeroed => 'Zéro réglé : l’avant et le bas sont appris';

  @override
  String get noAccelerometerG =>
      'Ce téléphone n’a pas d’accéléromètre : la force G ne peut pas être mesurée ici. Les autres outils fonctionnent toujours.';

  @override
  String get toolSpeed => 'Compteur de vitesse';

  @override
  String get toolSpeedSubtitle => 'Vitesse, trajet et altitude GPS';

  @override
  String get speedHelp1 =>
      'Autorisez la localisation, puis placez le téléphone là où il voit le ciel, par exemple sur le tableau de bord ou sur un support de pare-brise. En extérieur, la première position prend quelques secondes.';

  @override
  String get speedHelp2 =>
      'Le cadran sur le tableau de bord affiche votre vitesse GPS, avec la distance du trajet et l’altitude de chaque côté. Le panneau garde la distance, la vitesse maximale et la moyenne depuis la dernière remise à zéro.';

  @override
  String get speedHelp3 =>
      'Touchez les coordonnées pour les copier. Le bouton d’unité bascule entre km/h et mph, et Réinitialiser le trajet relance la distance, le max et la moyenne.';

  @override
  String get speedHelp4 =>
      'Gardez les yeux sur la route : laissez un passager lire, ou consultez le trajet une fois arrêté.';

  @override
  String get speedTip =>
      'La vitesse vient des satellites et reste en général à environ 1 km/h près sur route dégagée ; dans les tunnels, entre de hauts immeubles ou en intérieur, elle peut prendre du retard ou disparaître. L’altitude GPS peut être fausse de 10 à 50 m : pour les changements de hauteur, utilisez l’Altimètre. La localisation n’est utilisée que lorsque cet outil est ouvert et ne quitte jamais votre téléphone.';

  @override
  String get speedAllowTitle => 'Autoriser la localisation';

  @override
  String get speedAllowBody =>
      'Le compteur de vitesse utilise le GPS pour mesurer votre vitesse, votre distance et votre altitude. La localisation n’est utilisée que lorsque cet outil est ouvert à l’écran, jamais en arrière-plan, et ne quitte jamais votre téléphone.';

  @override
  String get speedAllow => 'Autoriser la localisation';

  @override
  String get speedDeniedTitle => 'L’accès à la localisation est désactivé';

  @override
  String get speedDeniedBody =>
      'Autorisez la localisation pour cette app dans les Réglages pour utiliser le compteur de vitesse. Elle n’est utilisée que lorsque l’outil est ouvert et ne quitte jamais votre téléphone.';

  @override
  String get speedServiceOffTitle => 'La localisation est désactivée';

  @override
  String get speedServiceOffBody =>
      'Activez la localisation dans les réglages du téléphone pour utiliser le compteur de vitesse.';

  @override
  String get speedDistance => 'Distance';

  @override
  String get speedTop => 'Max';

  @override
  String get speedAverage => 'Moyenne';

  @override
  String get speedTrip => 'Trajet';

  @override
  String get speedAltitude => 'Altitude';

  @override
  String get speedResetTrip => 'Réinitialiser le trajet';

  @override
  String get speedFinding => 'Recherche des satellites…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value m';
  }

  @override
  String get speedWeak => 'GPS faible : la vitesse peut être en retard';

  @override
  String get speedApproximate =>
      'Position exacte désactivée : activez-la pour une vitesse stable';

  @override
  String get speedStill => 'À l’arrêt';

  @override
  String get speedCopied => 'Coordonnées copiées';

  @override
  String get speedUnitTooltip => 'Basculer entre km/h et mph';

  @override
  String get speedKmh => 'km/h';

  @override
  String get speedMph => 'mph';

  @override
  String speedSemantics(String value) {
    return 'Vitesse $value';
  }

  @override
  String get speedCoordinates => 'Coordonnées, touchez pour copier';

  @override
  String get noGps =>
      'Ce téléphone n’a pas de GPS : la vitesse ne peut pas être mesurée ici. Les autres outils fonctionnent toujours.';

  @override
  String get speedSceneHelp =>
      'Le ciel suit l’heure de la journée. Le bouton météo choisit la scène : Auto suit la saison, ou choisissez soleil, nuages, pluie, orage ou neige. C’est un décor, pas une prévision.';

  @override
  String get supportTitle => 'Gratuite et sans publicité';

  @override
  String get supportBody =>
      'Créée par une seule personne sur son temps libre. Si elle vous aide, vous pouvez la soutenir.';

  @override
  String get supportButton => 'Soutenir sur GitHub';

  @override
  String get linkCopied => 'Lien copié';

  @override
  String madeBy(String name) {
    return 'Conçu et développé par $name';
  }

  @override
  String testFeedbackTitle(String app) {
    return 'Aidez à améliorer $app';
  }

  @override
  String get testFeedbackBody =>
      'Un problème ou une idée ? Je lis chaque message.';

  @override
  String get testEmailMe => 'Écrivez-moi';

  @override
  String testEmailSubject(String app) {
    return 'Avis sur $app';
  }

  @override
  String get testEmailCopied => 'Adresse e-mail copiée';

  @override
  String get testEndedTitle => 'Cette version de test est terminée';

  @override
  String get testEndedBody =>
      'Merci d’avoir testé ! Procurez-vous la nouvelle version. Pour l’obtenir, écrivez-moi :';

  @override
  String get toolTracker => 'Détecteur de traceurs';

  @override
  String get toolTrackerSubtitle => 'Traceurs cachés qui vous suivent';

  @override
  String get sensorBluetooth => 'Bluetooth';

  @override
  String get trackerHelp1 =>
      'Touchez Scanner ici pour voir les traceurs Bluetooth proches qui sont loin de leur propriétaire : AirTag, Galaxy SmartTag, Tile, Chipolo et balises Find Hub.';

  @override
  String get trackerHelp2 =>
      'Pour savoir si l’un d’eux vous suit, touchez Vérifier en me déplaçant et gardez l’outil ouvert pendant une marche ou un trajet ; l’écran reste allumé. Un traceur entendu à 3 endroits sur 30 minutes ou plus voyage avec vous.';

  @override
  String get trackerHelp3 =>
      'Touchez un traceur pour le trouver : marchez lentement et suivez le chiffre qui monte. Dans Tout voir, marquez les vôtres avec C’est le mien et ils ne s’afficheront plus.';

  @override
  String get trackerHelp4 =>
      'Aucun téléphone ne peut entendre les boîtiers GPS à carte SIM. Touchez Vérifier la voiture : la plupart tiennent par un aimant puissant, que le détecteur de métaux trouve.';

  @override
  String get trackerTip =>
      'Il n’écoute que lorsqu’il est ouvert et n’entend pas tous les traceurs. Celui d’un proche, ou d’un inconnu dans le même train, peut aussi apparaître, et un traceur près de son propriétaire est ignoré. Si vous pensez être suivi, contactez la police ou un service d’aide.';

  @override
  String get trackerAllowTitle => 'Autoriser le scan Bluetooth';

  @override
  String get trackerAllowBody =>
      'Le détecteur écoute les traceurs Bluetooth autour de vous. Il n’écoute que lorsque l’outil est ouvert, ne s’y connecte jamais, et rien de ce qu’il entend ne quitte votre téléphone.';

  @override
  String get trackerAllow => 'Autoriser le Bluetooth';

  @override
  String get trackerDeniedTitle => 'Le scan Bluetooth est désactivé';

  @override
  String get trackerDeniedBody =>
      'Autorisez Appareils à proximité pour cette appli dans les Réglages pour utiliser le détecteur.';

  @override
  String get trackerBluetoothOffTitle => 'Le Bluetooth est désactivé';

  @override
  String get trackerBluetoothOffBody =>
      'Activez le Bluetooth pour écouter les traceurs. L’appli ne se connecte jamais à rien.';

  @override
  String get trackerLocationOffTitle => 'La localisation est désactivée';

  @override
  String get trackerLocationOffBody =>
      'Sur cette version d’Android, le scan Bluetooth ne fonctionne qu’avec la localisation activée. Rien n’est localisé grâce à lui.';

  @override
  String get trackerScanHere => 'Scanner ici';

  @override
  String get trackerCheckMoving => 'Vérifier en me déplaçant';

  @override
  String get trackerStop => 'Arrêter';

  @override
  String get trackerDone => 'Terminé';

  @override
  String get trackerLocationNeeded =>
      'Vérifier en me déplaçant note les lieux par GPS : autorisez la localisation.';

  @override
  String get trackerSimNote => 'Les boîtiers GPS à carte SIM sont inaudibles';

  @override
  String get trackerCarCheck => 'Vérifier la voiture';

  @override
  String get carCheckBody =>
      'Certains traceurs sont des boîtiers GPS à carte SIM cachés sur une voiture. Aucun téléphone ne peut les entendre, mais la plupart tiennent par un aimant puissant, que le détecteur de métaux trouve.';

  @override
  String get carSpot1 => 'Sous les pare-chocs, à l’avant et à l’arrière';

  @override
  String get carSpot2 => 'Dans les passages de roue';

  @override
  String get carSpot3 => 'Sous les sièges et dans le coffre';

  @override
  String get carSpot4 =>
      'Derrière la prise de diagnostic (OBD) sous le tableau de bord';

  @override
  String get carCheckTip =>
      'Passez lentement le bord supérieur du téléphone sur chaque endroit. Un saut de la mesure signale du métal ou un aimant : regardez de plus près.';

  @override
  String get carOpenMetal => 'Ouvrir le détecteur de métaux';

  @override
  String get trackerPaused => 'En pause tant que l’appli est masquée';

  @override
  String trackerFollowingBanner(String name, int places) {
    return '$name voyage avec vous : entendu à $places endroits';
  }

  @override
  String trackerMoving(int minutes, int places) {
    return 'Vérification depuis $minutes min. Lieux traversés : $places';
  }

  @override
  String get trackerListening => 'Écoute des traceurs';

  @override
  String get trackerNothingHeard =>
      'Aucun traceur loin de son propriétaire entendu ici';

  @override
  String get trackerIdle => 'Scannez pour voir les traceurs proches';

  @override
  String trackerSemantics(int following, int nearby) {
    return 'Vous suivent : $following. Traceurs proches : $nearby.';
  }

  @override
  String trackerShowAll(int count) {
    return 'Tout voir ($count)';
  }

  @override
  String trackerAllTitle(int count) {
    return 'Traceurs proches : $count';
  }

  @override
  String get trackerKindFindMy => 'Balise Localiser';

  @override
  String get trackerKindFindHub => 'Balise Find Hub';

  @override
  String get trackerKindDult => 'Traceur d’objet';

  @override
  String get trackerClose => 'Proche';

  @override
  String get trackerNear => 'Moyen';

  @override
  String get trackerFar => 'Loin';

  @override
  String trackerFollowingYou(int places) {
    return 'Vous suit · lieux : $places';
  }

  @override
  String trackerPlaces(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Entendu à $count endroits',
      one: 'Entendu à 1 endroit',
    );
    return '$_temp0';
  }

  @override
  String get trackerMine => 'C’est le mien';

  @override
  String get trackerNotMine => 'Pas le mien';

  @override
  String get trackerFollowingLabel => 'vous suivent';

  @override
  String trackerNearby(int count) {
    return 'proches : $count';
  }

  @override
  String trackerFindTitle(String name) {
    return 'Trouver $name';
  }

  @override
  String get trackerFindHint =>
      'Faites lentement le tour de la voiture ou du sac et suivez le chiffre qui monte. Le signal donne la distance, pas la direction.';

  @override
  String get trackerFindLost => 'Pas entendu : bougez lentement';

  @override
  String get findFar => 'Loin';

  @override
  String get findCloser => 'Plus près';

  @override
  String get findNear => 'Proche';

  @override
  String get findHere => 'Juste ici';

  @override
  String get trackerAppleSound =>
      'Localiser d’Apple, ou l’appli Tracker Detect sur Android, peut faire sonner un AirTag.';

  @override
  String get trackerScanFailed =>
      'Le scan s’est arrêté. Vérifiez le Bluetooth et relancez.';

  @override
  String get trackerGpsLost =>
      'Pas de signal GPS : les lieux ne sont pas notés';

  @override
  String get trackerHeardEarlier => 'Entendu plus tôt';

  @override
  String get trackerKindSamsung => 'Balise ou appareil Samsung';

  @override
  String get trackerKindApple => 'Appareil Apple';

  @override
  String get trackerWhatToDo => 'Que faire';

  @override
  String get trackerSafetyTitle => 'Si un traceur vous suit';

  @override
  String get trackerSafety1 =>
      'Dans un bus, un train ou un avion, il peut appartenir à un inconnu : revérifiez à la descente.';

  @override
  String get trackerSafety2 =>
      'Si vous ne vous sentez pas en sécurité, allez dans un lieu public et appelez la police.';

  @override
  String get trackerSafety3 =>
      'Trouvez-le avec Trouver. Photographiez-le, sa cachette et son numéro de série, avec la date et l’heure.';

  @override
  String get trackerSafety4 =>
      'Ne le rapportez pas chez vous et ne contactez pas son propriétaire.';

  @override
  String get trackerSafety5 =>
      'Retirer la pile l’arrête, mais son propriétaire le remarquera. Si vous vivez avec cette personne, parlez d’abord à un service d’aide.';

  @override
  String get trackerSafety6 =>
      'Désactiver votre Bluetooth ou votre localisation ne l’empêche pas de signaler où vous êtes.';
}
