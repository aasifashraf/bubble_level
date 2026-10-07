// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Nivel de burbuja y medidor de ángulos';

  @override
  String get homeTitle => 'Nivel de burbuja';

  @override
  String get settings => 'Ajustes';

  @override
  String get tools => 'Herramientas';

  @override
  String get listView => 'Vista de lista';

  @override
  String get gridView => 'Vista de cuadrícula';

  @override
  String get back => 'Atrás';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get toolLevel => 'Nivel';

  @override
  String get toolLevelSubtitle => 'Nivel de burbuja y de agua';

  @override
  String get toolAngle => 'Ángulo';

  @override
  String get toolAngleSubtitle => 'Ángulo respecto a la horizontal o a tu cero';

  @override
  String get toolCompass => 'Brújula';

  @override
  String get toolCompassSubtitle => 'Rumbo y dirección';

  @override
  String get toolProtractor => 'Transportador';

  @override
  String get toolProtractorSubtitle => 'Mide ángulos en la pantalla';

  @override
  String get toolRuler => 'Regla';

  @override
  String get toolRulerSubtitle => 'Mide longitudes en la pantalla';

  @override
  String get toolMetal => 'Detector de metales';

  @override
  String get toolMetalSubtitle => 'Encuentra hierro, acero e imanes';

  @override
  String get toolVibration => 'Vibración';

  @override
  String get toolVibrationSubtitle =>
      'Intensidad y velocidad de la vibración (RPM)';

  @override
  String get toolSound => 'Sonómetro';

  @override
  String get toolSoundSubtitle => 'Nivel de ruido en decibelios';

  @override
  String get toolAltimeter => 'Altímetro';

  @override
  String get toolAltimeterSubtitle => 'Presión del aire y altura';

  @override
  String get toolLight => 'Luxómetro';

  @override
  String get toolLightSubtitle => 'Brillo en lux';

  @override
  String get notAvailableOnPhone => 'No disponible en este teléfono';

  @override
  String get notOnPhone => 'No disponible';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, no disponible en este teléfono';
  }

  @override
  String get howToUse => 'Cómo se usa';

  @override
  String get rotateLandscape => 'Girar a horizontal';

  @override
  String get rotatePortrait => 'Girar a vertical';

  @override
  String howToUseTool(String tool) {
    return 'Cómo usar: $tool';
  }

  @override
  String get gotIt => 'Entendido';

  @override
  String get goodToKnow => 'Conviene saber: ';

  @override
  String get ok => 'Aceptar';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool no está disponible';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sensores',
      one: 'un sensor',
    );
    return '$tool necesita $_temp0 que este teléfono no tiene: $sensors.';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'Es un límite del hardware del teléfono, no un fallo de la app. Las demás herramientas funcionan con normalidad.';

  @override
  String get sensorAccelerometer => 'acelerómetro';

  @override
  String get sensorMagnetometer => 'magnetómetro (sensor de brújula)';

  @override
  String get sensorBarometer => 'barómetro (sensor de presión del aire)';

  @override
  String get sensorLight => 'sensor de luz';

  @override
  String get sensorMicrophone => 'micrófono';

  @override
  String get noAccelerometer =>
      'Este teléfono no tiene acelerómetro, así que esta herramienta no puede medir aquí. Las herramientas que no lo necesitan siguen funcionando.';

  @override
  String get noMagnetometer =>
      'Este teléfono no tiene magnetómetro (sensor de brújula), así que esta herramienta no funciona aquí. Las herramientas que no lo necesitan siguen funcionando.';

  @override
  String get noReadings =>
      'Aún no hay lecturas del sensor. Vuelve atrás y abre la herramienta de nuevo; si sigue pasando, reinicia el teléfono. Algunos teléfonos no admiten esta herramienta.';

  @override
  String get waitingForSensors => 'Esperando a los sensores…';

  @override
  String get levelHelp1 =>
      'Pon el teléfono plano sobre la superficie o apóyalo sobre uno de sus bordes.';

  @override
  String get levelHelp2 =>
      'En plano: centra la burbuja. X es la inclinación izquierda/derecha e Y la de adelante/atrás. Sobre un borde verás el ángulo y la pendiente.';

  @override
  String get levelHelp3 =>
      'Sigue la indicación en pantalla (por ejemplo, «Lado derecho alto») hasta que diga «Nivelado»: se pone naranja y el teléfono suena y vibra (puedes desactivarlo en Ajustes).';

  @override
  String get levelHelp4 =>
      'Toca Bloquear para congelar la lectura y Desbloquear para volver a medir en vivo.';

  @override
  String get levelHelp5 =>
      '¿Prefieres un nivel clásico? Toca el icono del tubo en el selector; el icono redondo vuelve a la esfera.';

  @override
  String get levelTip =>
      'Si una superficie que sabes que está nivelada no marca 0°, pon el teléfono encima y toca Calibrar. Para deshacerlo, toca Calibrar otra vez y elige Restablecer calibración.';

  @override
  String get statusLevel => 'Nivelado';

  @override
  String get leftEndLow => 'Extremo izquierdo bajo';

  @override
  String get rightEndLow => 'Extremo derecho bajo';

  @override
  String get rightSideHigh => 'Lado derecho alto';

  @override
  String get leftSideHigh => 'Lado izquierdo alto';

  @override
  String get topEdgeHigh => 'Borde superior alto';

  @override
  String get bottomEdgeHigh => 'Borde inferior alto';

  @override
  String get calibrated => 'Calibrado. Esta posición ahora marca 0°.';

  @override
  String get tooFarToCalibrate =>
      'Demasiado inclinado para calibrar. Pon primero el teléfono en una superficie nivelada.';

  @override
  String get dialView => 'Vista de esfera';

  @override
  String get tubeView => 'Vista de tubo';

  @override
  String get levelTube => 'Tubo de nivel';

  @override
  String get leftRightTube => 'Tubo izquierda y derecha';

  @override
  String get forwardBackTube => 'Tubo adelante y atrás';

  @override
  String tiltFromLevel(String value) {
    return 'Inclinación respecto a la horizontal $value';
  }

  @override
  String fromLevel(String value) {
    return 'Desviación de la horizontal $value';
  }

  @override
  String get xLeftRight => 'X · izquierda / derecha';

  @override
  String get yForwardBack => 'Y · adelante / atrás';

  @override
  String get angle => 'Ángulo';

  @override
  String get slope => 'Pendiente';

  @override
  String get lock => 'Bloquear';

  @override
  String get unlock => 'Desbloquear';

  @override
  String locked(String status) {
    return 'Bloqueado · $status';
  }

  @override
  String get lockReading => 'Bloquear lectura';

  @override
  String get lockHandles => 'Bloquear tiradores';

  @override
  String get handlesLocked =>
      'Tiradores bloqueados · toca el candado para ajustar';

  @override
  String get calibrate => 'Calibrar';

  @override
  String get angleHelp1 =>
      'Apoya el teléfono sobre una superficie para leer su inclinación, o ponlo de canto contra una pendiente, barandilla o tubo: el número grande es el ángulo del borde que brilla en naranja; el del borde inferior aparece debajo.';

  @override
  String get angleHelp2 =>
      'Para medir un cambio, sostén el teléfono en la posición inicial y toca Poner cero aquí.';

  @override
  String get angleHelp3 =>
      'Inclina o mueve el teléfono. La esfera muestra cuántos grados se movió desde tu cero.';

  @override
  String get angleHelp4 =>
      'Toca Quitar cero para volver al ángulo desde la posición plana.';

  @override
  String get angleHelp5 =>
      'Para leer un ángulo que no ves, apoya el teléfono en el objeto, toca el candado y luego levántalo para leer.';

  @override
  String get angleHelp6 =>
      'Elige el modo con el selector de arriba: plano sobre una superficie o de canto. De canto, la pantalla se llena de agua que se mantiene nivelada, y el borde que mides, el lado más bajo, brilla en naranja.';

  @override
  String get angleTip =>
      'Apoya el lado largo del teléfono en una rampa, barandilla o tejado para ver su pendiente, o pega la pantalla a una tabla o puerta para medir su inclinación.';

  @override
  String movedFromZero(String value) {
    return 'Movido desde el cero $value';
  }

  @override
  String get measuringFromZero => 'Midiendo desde tu cero';

  @override
  String get angleFlatStatus => 'Plano · ángulo respecto a la Tierra';

  @override
  String get measuringRightEdge => 'Midiendo el borde derecho';

  @override
  String get measuringLeftEdge => 'Midiendo el borde izquierdo';

  @override
  String bottomEdge(String value) {
    return 'Borde inferior $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: $value respecto a la horizontal. Borde inferior $other';
  }

  @override
  String get angleModeFlat => 'Plano sobre una superficie';

  @override
  String get angleModeEdge => 'De canto';

  @override
  String get standOnEdge => 'Pon el teléfono de canto';

  @override
  String get clearZero => 'Quitar cero';

  @override
  String get setZeroHere => 'Poner cero aquí';

  @override
  String get compassHelp1 =>
      'Sostén el teléfono nivelado frente a ti, lejos de metales, imanes y aparatos electrónicos.';

  @override
  String get compassHelp2 =>
      'Apunta la parte superior del teléfono hacia la dirección que quieres conocer. Si lo sostienes en vertical, indica hacia dónde mira la cámara trasera.';

  @override
  String get compassHelp3 =>
      'El número es tu rumbo en grados y las letras son la dirección. La esfera gira para que su N apunte siempre al norte; la bola naranja de arriba marca hacia dónde apunta tu teléfono.';

  @override
  String get compassTip =>
      'Señala el norte magnético, que puede diferir unos grados del norte del mapa. Si parece incorrecta, mueve el teléfono dibujando un 8 varias veces.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Rumbo magnético $heading grados, $direction';
  }

  @override
  String get magneticInterference =>
      'Interferencia magnética · aléjate del metal y mueve el teléfono haciendo un 8';

  @override
  String get compassCalibrate =>
      'Mueve el teléfono haciendo un 8 para calibrar la brújula';

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
      'Pon el teléfono plano y coloca el objeto sobre la pantalla, con la esquina en el centro.';

  @override
  String get protractorHelp2 =>
      'Arrastra cada tirador naranja para que su línea quede sobre un lado del ángulo.';

  @override
  String get protractorHelp3 =>
      'Lee el ángulo en el centro. Cóncavo es el otro lado (360° menos el ángulo).';

  @override
  String get protractorHelp4 => 'Toca Restablecer para empezar de nuevo.';

  @override
  String get protractorHelp5 =>
      'Toca el candado para que los tiradores no se muevan mientras mueves el objeto.';

  @override
  String armsSemantics(String value) {
    return 'Ángulo entre los brazos $value';
  }

  @override
  String get reflex => 'Cóncavo';

  @override
  String get dragHandles => 'Arrastra los tiradores naranjas por los bordes';

  @override
  String get reset => 'Restablecer';

  @override
  String get rulerHelp1 =>
      'Pon el objeto sobre la pantalla o apoya el teléfono en él.';

  @override
  String get rulerHelp2 =>
      'Arrastra las líneas naranjas a sus dos extremos. Toca mm, cm o in para elegir la unidad; el otro sistema aparece debajo.';

  @override
  String get rulerHelp3 =>
      'Para la mejor precisión, toca Calibrar una vez y usa una tarjeta, una regla o el tamaño de pantalla.';

  @override
  String get rulerHelp4 =>
      'Toca el candado para que las líneas no se muevan mientras mueves el objeto.';

  @override
  String get rulerTip =>
      'Mide hasta el largo de la pantalla. Las fundas y los bordes curvos ocultan los primeros milímetros, así que mide entre las líneas, no desde el borde del teléfono.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'Longitud $mm milímetros, $inches pulgadas';
  }

  @override
  String get rulerCalibrated => 'Calibrada con tarjeta · ±0,5 mm';

  @override
  String get rulerReported =>
      'Tamaño de pantalla del teléfono · calibra para ±0,5 mm';

  @override
  String get unitMillimetres => 'Milímetros';

  @override
  String get unitCentimetres => 'Centímetros';

  @override
  String get unitInches => 'Pulgadas';

  @override
  String get rulerEstimated =>
      'Sin calibrar · las medidas pueden variar un 10 %';

  @override
  String get cardLongEdge =>
      'Pon una tarjeta bancaria o de identidad en la pantalla, con el lado largo junto a la regla y un extremo en la línea oscura. Arrastra la línea naranja al otro extremo.';

  @override
  String get cardShortEdge =>
      'Pon una tarjeta bancaria o de identidad en la pantalla, con el lado corto junto a la regla y un extremo en la línea oscura. Arrastra la línea naranja al otro extremo.';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get usePhoneDefault => 'Usar el tamaño de pantalla del teléfono';

  @override
  String get usePhoneDefaultInfo => 'Olvidar esta calibración';

  @override
  String get cardMismatch =>
      'No coincide con una tarjeta. Alinéala con la línea oscura y vuelve a intentarlo.';

  @override
  String get rotateToCalibrate => 'Gira a vertical para calibrar';

  @override
  String get calibrateHow => 'Calibrar con';

  @override
  String get methodCard => 'Una tarjeta';

  @override
  String get methodCardInfo =>
      'Cualquier tarjeta bancaria o de identidad · ±0,5 mm';

  @override
  String get methodRuler => 'Una regla';

  @override
  String get methodRulerInfo => 'Lo más preciso · regla o cinta métrica';

  @override
  String get methodScreen => 'El tamaño de pantalla';

  @override
  String get methodScreenInfo => 'Sin objetos · aprox. 1 %';

  @override
  String rulerInstructions(String mark) {
    return 'Pon una regla sobre la pantalla con su 0 en la línea oscura. Arrastra la línea naranja hasta la marca de $mark.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'Eso no coincide con $mark. Pon el 0 de la regla en la línea oscura y vuelve a intentarlo.';
  }

  @override
  String get screenSizeInstructions =>
      'Escribe el tamaño de pantalla en pulgadas según las especificaciones del teléfono. ¿No lo sabes? Busca tu modelo y «tamaño de pantalla».';

  @override
  String get screenSizeMismatch =>
      'Ese tamaño no corresponde a esta pantalla. Revisa las especificaciones y vuelve a intentarlo.';

  @override
  String get rulerCalibratedRuler => 'Calibrada con regla · ±0,5 mm';

  @override
  String rulerCalibratedScreen(String size) {
    return 'Ajustada a una pantalla de $size pulgadas · aprox. 1 %';
  }

  @override
  String get metalHelp1 =>
      'Abre la herramienta lejos del metal. Esa primera lectura cuenta como «sin metal».';

  @override
  String get metalHelp2 =>
      'Mueve el teléfono despacio sobre la zona. El sensor suele estar en la parte superior del teléfono. Pita más rápido cuanto más cerca está el metal; toca el altavoz para silenciarlo.';

  @override
  String get metalHelp3 =>
      '«Metal cerca» significa un cambio pequeño; «Metal detectado», uno fuerte. Como en el juego de frío o caliente, la pantalla pasa de azul frío a rojo encendido al acercarte, y el teléfono vibra al encontrarlo si la vibración está activada.';

  @override
  String get metalHelp4 =>
      'Si lo mantienes quieto unos segundos, vuelve a cero solo y una lectura falsa desaparece. Para revisar un punto otra vez, aleja el teléfono y vuelve. Fijar referencia lo pone a cero al instante.';

  @override
  String get metalTip =>
      'Solo detecta hierro, acero e imanes, no aluminio, cobre, oro ni plata. Las fundas magnéticas le afectan.';

  @override
  String metalSemantics(int value) {
    return 'Campo magnético $value microteslas';
  }

  @override
  String get noMetal => 'Sin metal cerca';

  @override
  String get metalNearby => 'Metal cerca';

  @override
  String get metalDetected => 'Metal detectado';

  @override
  String get heatCold => 'Frío';

  @override
  String get heatCool => 'Fresco';

  @override
  String get heatWarm => 'Templado';

  @override
  String get heatWarmer => 'Más caliente';

  @override
  String get heatHot => 'Caliente';

  @override
  String get heatBurning => 'Ardiendo';

  @override
  String get baseline => 'Referencia';

  @override
  String get field => 'Campo';

  @override
  String get change => 'Cambio';

  @override
  String get findsIronSteel => 'Detecta hierro, acero e imanes';

  @override
  String get setBaseline => 'Fijar referencia';

  @override
  String get muteSound => 'Silenciar';

  @override
  String get turnSoundOn => 'Activar sonido';

  @override
  String get vibrationHelp1 =>
      'Coloca el teléfono plano sobre la máquina en marcha y aparta las manos. En una máquina pequeña, sujétalo con firmeza.';

  @override
  String get vibrationHelp2 =>
      'La aguja muestra la velocidad de la vibración más fuerte en RPM, con los hercios debajo (RPM son hercios × 60). El brillo suave dentro del dial es el espectro completo; la aguja apunta a su parte más brillante.';

  @override
  String get vibrationHelp3 =>
      'La intensidad es lo fuerte que vibra, en m/s²: menos de 0,3 es quieto, más de 2 es fuerte.';

  @override
  String get vibrationHelp4 =>
      'Toca Bloquear para fijar una lectura, y el botón de reinicio antes de medir la siguiente máquina.';

  @override
  String get vibrationTip =>
      'La mayoría de los teléfonos miden hasta 100 Hz (6000 RPM), algunos menos; el dial muestra el límite de tu teléfono. Una vibración más rápida puede aparecer como una velocidad menor y errónea. La vibración más fuerte suele ser la velocidad del eje, pero puede ser el doble. Los sensores del teléfono no son instrumentos de laboratorio.';

  @override
  String get still => 'Quieto';

  @override
  String get lightVibration => 'Vibración leve';

  @override
  String get strongVibration => 'Vibración fuerte';

  @override
  String get noAccelerometerVibration =>
      'Este teléfono no tiene acelerómetro, así que aquí no se puede medir la vibración. Las herramientas que no lo necesitan siguen funcionando.';

  @override
  String vibrationSemantics(String value) {
    return 'Vibración $value metros por segundo al cuadrado';
  }

  @override
  String get frequency => 'Frecuencia';

  @override
  String get rpm => 'RPM';

  @override
  String get strength => 'Intensidad';

  @override
  String vibratingAt(String value) {
    return 'Vibra a $value Hz';
  }

  @override
  String get noClearFrequency => 'Sin frecuencia clara';

  @override
  String get findingFrequency => 'Buscando la frecuencia…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm revoluciones por minuto, $value hercios';
  }

  @override
  String get peak => 'Pico';

  @override
  String get average => 'Media';

  @override
  String get resetPeak => 'Reiniciar pico';

  @override
  String get altimeterHelp1 =>
      'Un excursionista sube la montaña con tu altura. El cielo sigue la hora del día y la estación; toca el botón del tiempo para elegirlo tú.';

  @override
  String get altimeterHelp2 =>
      'Para medir un cambio de altura, como escaleras o pisos, toca Poner cero aquí donde empiezas.';

  @override
  String get altimeterHelp3 =>
      'Sube o baja: el excursionista camina contigo y la bandera marca tu punto más alto. El panel muestra los metros desde tu cero, la presión y la altitud aproximada.';

  @override
  String get altimeterHelp4 => 'Toca Quitar cero para volver.';

  @override
  String get altimeterTip =>
      'El clima cambia la presión del aire, así que la altitud puede variar decenas de metros. La altura desde tu cero es precisa en periodos cortos. Esta herramienta necesita un teléfono con barómetro.';

  @override
  String get weather => 'Tiempo';

  @override
  String get weatherAuto => 'Automático (hora del día y estación)';

  @override
  String get weatherSunny => 'Soleado';

  @override
  String get weatherCloudy => 'Nublado';

  @override
  String get weatherRain => 'Lluvia';

  @override
  String get weatherStorm => 'Tormenta';

  @override
  String get weatherSnow => 'Nieve';

  @override
  String get fromZero => 'Desde cero';

  @override
  String get altitudeShort => 'Altitud';

  @override
  String get barometerIos =>
      'No se puede leer el barómetro. Activa Movimiento y forma física para esta app en Ajustes › Privacidad y seguridad y vuelve a abrir el Altímetro.';

  @override
  String get noBarometer =>
      'Este teléfono no tiene barómetro (sensor de presión del aire), así que el altímetro no funciona aquí. Las demás herramientas siguen funcionando.';

  @override
  String get noLightSensor =>
      'Este teléfono no tiene sensor de luz, así que el luxómetro no puede funcionar aquí. Las demás herramientas siguen funcionando.';

  @override
  String lightSemantics(String value) {
    return 'Brillo $value lux';
  }

  @override
  String get illuminance => 'Brillo';

  @override
  String get footCandles => 'Pies-candela';

  @override
  String get lightDark => 'Oscuro';

  @override
  String get lightDim => 'Luz tenue';

  @override
  String get lightLivingRoom => 'Luz de salón';

  @override
  String get lightReading => 'Buena para leer y trabajar en el escritorio';

  @override
  String get lightBright => 'Luz interior intensa';

  @override
  String get lightOvercast => 'Luz de día nublado';

  @override
  String get lightDaylight => 'Luz de día';

  @override
  String get lightSun => 'Luz solar directa';

  @override
  String get lightHelp1 =>
      'El sensor de luz está en la parte superior de la pantalla, junto a la cámara frontal.';

  @override
  String get lightHelp2 =>
      'Sostén el teléfono donde quieras medir, con la pantalla hacia la luz.';

  @override
  String get lightHelp3 =>
      'El cielo sigue a la luz: de noche cuando está oscuro, amanecer en una habitación con poca luz, y el sol sube a medida que hay más luz. Lee los lux y para qué sirve la luz: de 300 a 750 lx es adecuado para leer y trabajar en el escritorio.';

  @override
  String get lightHelp4 =>
      'Toca Bloquear para conservar una lectura mientras apartas el teléfono.';

  @override
  String get lightTip =>
      'Los sensores de luz varían entre teléfonos, así que las lecturas pueden desviarse entre un 10 y un 20 %: sirven para comparar lugares, no son un luxómetro calibrado. No tapes la parte superior de la pantalla.';

  @override
  String get noMicrophone =>
      'No se puede usar el micrófono. Puede que otra app lo esté usando: ciérrala y vuelve a abrir el sonómetro.';

  @override
  String soundSemantics(String value) {
    return 'Nivel de sonido de unos $value decibelios';
  }

  @override
  String get decibelsApprox => 'dB (aprox.)';

  @override
  String get soundMax => 'Máx.';

  @override
  String get soundVeryQuiet => 'Muy silencioso';

  @override
  String get soundQuiet => 'Silencioso, como una biblioteca';

  @override
  String get soundModerate => 'Moderado, como una conversación';

  @override
  String get soundLoud => 'Fuerte, como tráfico intenso';

  @override
  String get soundVeryLoud =>
      'Muy fuerte: la exposición prolongada puede dañar el oído';

  @override
  String get soundDangerous => 'Peligroso: protege tus oídos';

  @override
  String get micTitle => 'Permitir el micrófono';

  @override
  String get micBody =>
      'El sonómetro escucha por el micrófono para medir cuánto ruido hay. El sonido se mide en tu teléfono y nunca se graba, guarda ni envía.';

  @override
  String get micAllow => 'Permitir micrófono';

  @override
  String get micDeniedTitle => 'El acceso al micrófono está desactivado';

  @override
  String get micDeniedBody =>
      'Activa el micrófono para esta app en Ajustes para usar el sonómetro. El sonido nunca se graba, guarda ni envía.';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get tryAgain => 'Reintentar';

  @override
  String get soundHelp1 =>
      'Deja libre el micrófono (en el borde inferior) y apunta el teléfono hacia el sonido.';

  @override
  String get soundHelp2 =>
      'El número grande es el nivel actual, promediado durante un segundo aproximadamente. De él salen ondas, más y más lejos cuanto más alto es el sonido: verdes en silencio, luego amarillas, naranjas, rojas y carmesí. Las barras de abajo muestran los últimos tres segundos.';

  @override
  String get soundHelp3 =>
      'Promedio y Máx. cuentan desde que abriste la herramienta. Toca Restablecer para empezar de nuevo.';

  @override
  String get soundHelp4 =>
      'A partir de 70 dB la línea de estado se pone amarilla; a partir de 85 dB, donde la exposición prolongada puede dañar el oído, se pone roja.';

  @override
  String get soundHelp5 =>
      'Toca el candado para conservar una lectura mientras mueves el teléfono.';

  @override
  String get soundTip =>
      'Los micrófonos varían entre teléfonos, así que las lecturas pueden desviarse unos 5 dB: sirve para comparar, no es un sonómetro certificado. Los sonidos muy fuertes (más de unos 110 dB) pueden leerse más bajos.';

  @override
  String get metresFromZero => 'm desde cero';

  @override
  String pressureSemantics(String value) {
    return 'Presión del aire $value hectopascales';
  }

  @override
  String heightSemantics(String value) {
    return 'Altura $value desde el cero';
  }

  @override
  String get pressure => 'Presión';

  @override
  String get altitudeApprox => 'Altitud (aprox.)';

  @override
  String get measuringHeight => 'Midiendo la altura desde tu cero';

  @override
  String get airPressureAltitude => 'Presión del aire y altitud';

  @override
  String get appearance => 'Apariencia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get levelUnits => 'Unidades del nivel';

  @override
  String get unitDegrees => 'Grados';

  @override
  String get unitPercent => 'Pendiente en porcentaje';

  @override
  String get unitRoofPitch => 'Pendiente de techo (subida por 12)';

  @override
  String get vibrateWhenLevel => 'Vibración';

  @override
  String get sounds => 'Sonidos';

  @override
  String get resetCalibration => 'Restablecer calibración';

  @override
  String get resetCalibrationHint => 'Volver al cero de fábrica del sensor';

  @override
  String get calibrateHere => 'Calibrar aquí';

  @override
  String get calibrateHereInfo =>
      'Sobre una superficie que sabes que está nivelada';

  @override
  String get calibrationRemoved =>
      'Calibración eliminada. El nivel vuelve a usar el cero de fábrica del sensor.';

  @override
  String get resetAllCalibrations => 'Restablecer todas las calibraciones';

  @override
  String get resetAllCalibrationsHint => 'Nivel y regla a valores de fábrica';

  @override
  String get resetAllTitle => '¿Restablecer todas las calibraciones?';

  @override
  String get resetAllBody =>
      'Se eliminarán las calibraciones que hiciste en el nivel (también la usa el medidor de ángulos) y en la regla. Ambos vuelven a los valores de fábrica. El resto de tus ajustes no cambia y puedes volver a calibrar cuando quieras.';

  @override
  String get notCalibrated => 'Sin calibrar';

  @override
  String get language => 'Idioma';

  @override
  String get licenses => 'Licencias de código abierto';

  @override
  String get languageSystem => 'Idioma del teléfono';

  @override
  String get toolHeight => 'Altura';

  @override
  String get toolHeightSubtitle => 'Altura y distancia apuntando';

  @override
  String get heightHelp1 =>
      'Colócate donde veas la base y la cima del objeto. Sujeta el teléfono con la pantalla hacia arriba y mira a lo largo del borde superior.';

  @override
  String get heightHelp2 =>
      'Apunta el borde superior a la base del objeto y toca Fijar base: así se obtiene la distancia.';

  @override
  String get heightHelp3 =>
      'Apunta el borde superior a la cima y toca Fijar cima: aparece la altura.';

  @override
  String get heightHelp4 =>
      '¿Conoces la distancia? Toca Distancia y escríbela; luego apunta solo a la cima. Toca Altura de ojos para ajustar la tuya.';

  @override
  String get heightTip =>
      'Aprox. ±5 % en terreno llano con la altura de ojos correcta (tu estatura menos unos 10 cm). Aléjate para que la cima quede por debajo de 70° y la base al menos 3° por debajo del nivel. En pendiente, escribe la distancia.';

  @override
  String get lockBase => 'Fijar base';

  @override
  String get lockTop => 'Fijar cima';

  @override
  String get measureAgain => 'Medir de nuevo';

  @override
  String get distance => 'Distancia';

  @override
  String get objectHeight => 'Altura';

  @override
  String get eyeHeight => 'Altura de ojos';

  @override
  String get sightAngle => 'Ángulo de mira';

  @override
  String get heightAimBase => 'Apunta el borde superior a la base';

  @override
  String get heightAimTop => 'Ahora apunta el borde superior a la cima';

  @override
  String get heightDone => 'Listo · toca Medir de nuevo para otra';

  @override
  String get heightHoldFlatter =>
      'Inclina menos el teléfono y mira a lo largo del borde superior';

  @override
  String get heightTooFar =>
      'Base demasiado cerca del nivel: acércate o escribe la distancia';

  @override
  String get heightStepBack =>
      'Muy empinado: aléjate para una lectura más estable';

  @override
  String get knownDistance => 'Distancia a la base';

  @override
  String get knownDistanceHint =>
      'La distancia por el suelo hasta la base del objeto. Bórrala para medirla apuntando.';

  @override
  String get eyeHeightHint =>
      'A qué altura están tus ojos del suelo: tu estatura menos unos 10 cm.';

  @override
  String get clear => 'Borrar';
}
