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
  String get tools => 'Outils';

  @override
  String get listView => 'Vue en liste';

  @override
  String get gridView => 'Vue en grille';

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
  String get toolVibrationSubtitle => 'Vibromètre avec graphique en direct';

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
      'Elle indique le nord magnétique, qui peut différer de quelques degrés du nord de la carte. Si elle semble fausse, faites plusieurs fois un 8 avec le téléphone.';

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
      'Posez le téléphone à plat sur la surface ou la machine à vérifier et ne le touchez plus.';

  @override
  String get vibrationHelp2 =>
      'Le nombre est la vibration actuelle en m/s². Une aiguille fait le tour toutes les six secondes et la dessine comme une houle autour du nombre : vert au repos, orange pour une vibration légère, rouge pour une forte. La petite encoche marque le pic.';

  @override
  String get vibrationHelp3 =>
      'Crête est le moment le plus fort. Moyenne est le niveau sur la dernière seconde.';

  @override
  String get vibrationHelp4 =>
      'Touchez Remettre la crête à zéro avant chaque nouveau test.';

  @override
  String get vibrationTip =>
      '« Immobile » signifie moins de 0,3 m/s² et « Vibrations fortes », plus de 2 m/s². Utilisez les mesures pour comparer ; les capteurs d’un téléphone ne sont pas des instruments de laboratoire.';

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
  String get peak => 'Crête';

  @override
  String get average => 'Moyenne';

  @override
  String get resetPeak => 'Remettre la crête à zéro';

  @override
  String get altimeterHelp1 =>
      'Un randonneur gravit la montagne avec votre hauteur. Le ciel suit l’heure et la saison ; touchez le bouton météo pour choisir vous-même.';

  @override
  String get altimeterHelp2 =>
      'Pour mesurer un dénivelé, comme des escaliers ou des étages, touchez Zéro ici au départ.';

  @override
  String get altimeterHelp3 =>
      'Montez ou descendez : le randonneur marche avec vous et le drapeau marque votre point le plus haut. Le panneau montre les mètres depuis votre zéro, la pression et l’altitude approximative.';

  @override
  String get altimeterHelp4 => 'Touchez Effacer le zéro pour revenir.';

  @override
  String get altimeterTip =>
      'La météo modifie la pression de l’air : l’altitude peut se tromper de plusieurs dizaines de mètres. La hauteur depuis votre zéro est précise sur de courtes durées. Cet outil nécessite un téléphone équipé d’un baromètre.';

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
      'Les capteurs de lumière varient d’un téléphone à l’autre, les mesures peuvent donc différer de 10 à 20 % : utile pour comparer des lieux, pas un luxmètre étalonné. Ne couvrez pas le haut de l’écran.';

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
      'Les micros varient d’un téléphone à l’autre, les mesures peuvent donc différer d’environ 5 dB : utile pour comparer, pas un sonomètre certifié. Les sons très forts (plus de 110 dB environ) peuvent être sous-estimés.';

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
}
