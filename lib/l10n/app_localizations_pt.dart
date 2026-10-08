// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Nível de bolha e medidor de ângulo';

  @override
  String get homeTitle => 'Nível de bolha';

  @override
  String get settings => 'Configurações';

  @override
  String get homeTopTools => 'Suas ferramentas favoritas';

  @override
  String get homeMoreTools => 'Mais ferramentas';

  @override
  String get homeArrange => 'Organizar';

  @override
  String get arrangeTitle => 'Organizar ferramentas';

  @override
  String get arrangeHint =>
      'Arraste para mudar a ordem. As três primeiras são suas favoritas.';

  @override
  String get arrangeStar => 'Tornar favorita';

  @override
  String get arrangeUnstar => 'Tirar das favoritas';

  @override
  String get arrangeReset => 'Ordem popular';

  @override
  String get arrangeDone => 'Concluído';

  @override
  String get back => 'Voltar';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get toolLevel => 'Nível';

  @override
  String get toolLevelSubtitle => 'Nível de bolha e de mão';

  @override
  String get toolAngle => 'Ângulo';

  @override
  String get toolAngleSubtitle => 'Ângulo em relação ao nível ou ao seu zero';

  @override
  String get toolCompass => 'Bússola';

  @override
  String get toolCompassSubtitle => 'Rumo e direção';

  @override
  String get toolProtractor => 'Transferidor';

  @override
  String get toolProtractorSubtitle => 'Meça ângulos na tela';

  @override
  String get toolRuler => 'Régua';

  @override
  String get toolRulerSubtitle => 'Meça comprimentos na tela';

  @override
  String get toolMetal => 'Detector de metais';

  @override
  String get toolMetalSubtitle => 'Encontre ferro, aço e ímãs';

  @override
  String get toolVibration => 'Vibração';

  @override
  String get toolVibrationSubtitle =>
      'Intensidade e velocidade da vibração (RPM)';

  @override
  String get toolSound => 'Decibelímetro';

  @override
  String get toolSoundSubtitle => 'Nível de ruído em decibéis';

  @override
  String get toolAltimeter => 'Altímetro';

  @override
  String get toolAltimeterSubtitle => 'Pressão do ar e altura';

  @override
  String get toolLight => 'Luxímetro';

  @override
  String get toolLightSubtitle => 'Brilho em lux';

  @override
  String get notAvailableOnPhone => 'Indisponível neste celular';

  @override
  String get notOnPhone => 'Indisponível';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, indisponível neste celular';
  }

  @override
  String get howToUse => 'Como usar';

  @override
  String get rotateLandscape => 'Girar para paisagem';

  @override
  String get rotatePortrait => 'Girar para retrato';

  @override
  String howToUseTool(String tool) {
    return 'Como usar: $tool';
  }

  @override
  String get gotIt => 'Entendi';

  @override
  String get goodToKnow => 'Bom saber: ';

  @override
  String get ok => 'OK';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool indisponível';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sensores',
      one: 'um sensor',
    );
    return '$tool precisa de $_temp0 que este celular não tem: $sensors.';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'É um limite do hardware do celular, não um erro do app. Todas as outras ferramentas funcionam normalmente.';

  @override
  String get sensorAccelerometer => 'acelerômetro';

  @override
  String get sensorMagnetometer => 'magnetômetro (sensor da bússola)';

  @override
  String get sensorBarometer => 'barômetro (sensor de pressão do ar)';

  @override
  String get sensorLight => 'sensor de luz';

  @override
  String get sensorMicrophone => 'microfone';

  @override
  String get sensorCamera => 'câmera traseira';

  @override
  String get sensorGps => 'GPS';

  @override
  String get sensorAr => 'ARCore (realidade aumentada)';

  @override
  String get noAccelerometer =>
      'Este celular não tem acelerômetro, então esta ferramenta não consegue medir aqui. As ferramentas que não precisam dele continuam funcionando.';

  @override
  String get noMagnetometer =>
      'Este celular não tem magnetômetro (sensor da bússola), então esta ferramenta não funciona aqui. As ferramentas que não precisam dele continuam funcionando.';

  @override
  String get noReadings =>
      'Ainda não há leituras do sensor. Volte e abra a ferramenta de novo; se continuar, reinicie o celular. Alguns celulares não suportam esta ferramenta.';

  @override
  String get waitingForSensors => 'Aguardando os sensores…';

  @override
  String get levelHelp1 =>
      'Deite o celular sobre a superfície ou apoie-o em uma das bordas.';

  @override
  String get levelHelp2 =>
      'Deitado: centralize a bolha. X é a inclinação esquerda/direita e Y a frente/trás. Em uma borda, você vê o ângulo e a inclinação.';

  @override
  String get levelHelp3 =>
      'Siga a dica na tela (por exemplo, \"Lado direito alto\") até aparecer \"Nivelado\": fica laranja e o celular toca e vibra (dá para desligar nas Configurações).';

  @override
  String get levelHelp4 =>
      'Toque em Travar para congelar a leitura e em Destravar para voltar a medir ao vivo.';

  @override
  String get levelHelp5 =>
      'Prefere um nível clássico? Toque no ícone do tubo no seletor; o ícone redondo volta ao mostrador.';

  @override
  String get levelTip =>
      'Se uma superfície que você sabe que está nivelada não marcar 0°, coloque o celular nela e toque em Calibrar. Para desfazer, toque em Calibrar de novo e escolha Redefinir calibração.';

  @override
  String get statusLevel => 'Nivelado';

  @override
  String get leftEndLow => 'Ponta esquerda baixa';

  @override
  String get rightEndLow => 'Ponta direita baixa';

  @override
  String get rightSideHigh => 'Lado direito alto';

  @override
  String get leftSideHigh => 'Lado esquerdo alto';

  @override
  String get topEdgeHigh => 'Borda de cima alta';

  @override
  String get bottomEdgeHigh => 'Borda de baixo alta';

  @override
  String get calibrated => 'Calibrado. Esta posição agora marca 0°.';

  @override
  String get tooFarToCalibrate =>
      'Inclinado demais para calibrar. Coloque o celular em uma superfície nivelada primeiro.';

  @override
  String get dialView => 'Mostrador';

  @override
  String get tubeView => 'Tubo';

  @override
  String get levelTube => 'Tubo de nível';

  @override
  String get leftRightTube => 'Tubo esquerda e direita';

  @override
  String get forwardBackTube => 'Tubo frente e trás';

  @override
  String tiltFromLevel(String value) {
    return 'Inclinação em relação ao nível $value';
  }

  @override
  String fromLevel(String value) {
    return 'Desvio do nível $value';
  }

  @override
  String get xLeftRight => 'X · esquerda / direita';

  @override
  String get yForwardBack => 'Y · frente / trás';

  @override
  String get angle => 'Ângulo';

  @override
  String get slope => 'Inclinação';

  @override
  String get lock => 'Travar';

  @override
  String get unlock => 'Destravar';

  @override
  String locked(String status) {
    return 'Travado · $status';
  }

  @override
  String get lockReading => 'Travar leitura';

  @override
  String get lockHandles => 'Travar alças';

  @override
  String get handlesLocked => 'Alças travadas · toque no cadeado para ajustar';

  @override
  String get calibrate => 'Calibrar';

  @override
  String get angleHelp1 =>
      'Coloque o celular sobre uma superfície para ler a inclinação, ou apoie-o em uma borda contra uma rampa, corrimão ou cano: o número grande é o ângulo da borda que brilha em laranja; o da borda inferior aparece abaixo.';

  @override
  String get angleHelp2 =>
      'Para medir uma mudança, segure o celular na posição inicial e toque em Zerar aqui.';

  @override
  String get angleHelp3 =>
      'Incline ou mova o celular. O mostrador indica quantos graus ele se moveu a partir do seu zero.';

  @override
  String get angleHelp4 =>
      'Toque em Limpar zero para voltar ao ângulo em relação à posição deitada.';

  @override
  String get angleHelp5 =>
      'Para ler um ângulo que você não vê, encoste o celular no objeto, toque no cadeado e depois afaste-o para ler.';

  @override
  String get angleHelp6 =>
      'Escolha o modo no seletor no topo: deitado sobre uma superfície ou apoiado em uma borda. Na borda, a tela se enche de água que fica nivelada, e a borda que você mede, o lado mais baixo, brilha em laranja.';

  @override
  String get angleTip =>
      'Encoste o lado longo do celular numa rampa, corrimão ou telhado para ver a inclinação, ou encoste a tela numa tábua ou porta para medir o quanto ela está inclinada.';

  @override
  String movedFromZero(String value) {
    return 'Movido a partir do zero $value';
  }

  @override
  String get measuringFromZero => 'Medindo a partir do seu zero';

  @override
  String get angleFlatStatus => 'Deitado · ângulo em relação à Terra';

  @override
  String get measuringRightEdge => 'Medindo a borda direita';

  @override
  String get measuringLeftEdge => 'Medindo a borda esquerda';

  @override
  String bottomEdge(String value) {
    return 'Borda inferior $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: $value em relação ao nível. Borda inferior $other';
  }

  @override
  String get angleModeFlat => 'Deitado numa superfície';

  @override
  String get angleModeEdge => 'De lado';

  @override
  String get standOnEdge => 'Apoie o celular em uma das bordas';

  @override
  String get clearZero => 'Limpar zero';

  @override
  String get setZeroHere => 'Zerar aqui';

  @override
  String get compassHelp1 =>
      'Segure o celular nivelado à sua frente, longe de metais, ímãs e eletrônicos.';

  @override
  String get compassHelp2 =>
      'Aponte a parte de cima do celular para a direção que você quer saber. Segurando-o na vertical, mostra para onde a câmera traseira aponta.';

  @override
  String get compassHelp3 =>
      'O número é o seu rumo em graus e as letras são a direção. O mostrador gira para que o N aponte sempre para o norte; a bola laranja no topo marca para onde o celular aponta.';

  @override
  String get compassTip =>
      'Ela aponta para o norte magnético, que em alguns lugares pode diferir 10 graus ou mais do norte do mapa. Se parecer errada, mova o celular desenhando um 8 algumas vezes.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Rumo magnético $heading graus, $direction';
  }

  @override
  String get magneticInterference =>
      'Interferência magnética · afaste-se do metal e mova o celular fazendo um 8';

  @override
  String get compassCalibrate =>
      'Mova o celular fazendo um 8 para calibrar a bússola';

  @override
  String get dirN => 'N';

  @override
  String get dirNE => 'NE';

  @override
  String get dirE => 'L';

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
      'Deite o celular e coloque o objeto sobre a tela, com o canto no centro.';

  @override
  String get protractorHelp2 =>
      'Arraste cada alça laranja para que a linha dela fique sobre um lado do ângulo.';

  @override
  String get protractorHelp3 =>
      'Leia o ângulo no centro. Replementar é o outro lado (360° menos o ângulo).';

  @override
  String get protractorHelp4 => 'Toque em Redefinir para recomeçar.';

  @override
  String get protractorHelp5 =>
      'Toque no cadeado para manter as alças no lugar enquanto move o objeto.';

  @override
  String armsSemantics(String value) {
    return 'Ângulo entre os braços $value';
  }

  @override
  String get reflex => 'Replementar';

  @override
  String get dragHandles => 'Arraste as alças laranja pelas bordas';

  @override
  String get reset => 'Redefinir';

  @override
  String get rulerHelp1 =>
      'Coloque o objeto sobre a tela ou encoste o celular nele.';

  @override
  String get rulerHelp2 =>
      'Arraste as linhas laranja até as duas pontas. Toque em mm, cm ou in para escolher a unidade; o outro sistema aparece embaixo.';

  @override
  String get rulerHelp3 =>
      'Para a melhor precisão, toque em Calibrar uma vez e use um cartão, uma régua ou o tamanho da tela.';

  @override
  String get rulerHelp4 =>
      'Toque no cadeado para manter as linhas no lugar enquanto move o objeto.';

  @override
  String get rulerTip =>
      'Mede até o comprimento da tela. Capinhas e bordas curvas escondem os primeiros milímetros, então meça entre as linhas, não a partir da borda do celular.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'Comprimento $mm milímetros, $inches polegadas';
  }

  @override
  String get rulerCalibrated => 'Calibrada com cartão · ±0,5 mm';

  @override
  String get rulerReported =>
      'Tamanho da tela informado pelo celular · calibre para ±0,5 mm';

  @override
  String get unitMillimetres => 'Milímetros';

  @override
  String get unitCentimetres => 'Centímetros';

  @override
  String get unitInches => 'Polegadas';

  @override
  String get rulerEstimated => 'Não calibrada · medidas podem errar 10%';

  @override
  String get cardLongEdge =>
      'Coloque um cartão bancário ou de identidade na tela, lado maior junto à régua e uma ponta na linha escura. Arraste a linha laranja até a outra ponta.';

  @override
  String get cardShortEdge =>
      'Coloque um cartão bancário ou de identidade na tela, lado menor junto à régua e uma ponta na linha escura. Arraste a linha laranja até a outra ponta.';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get usePhoneDefault => 'Usar o tamanho de tela do celular';

  @override
  String get usePhoneDefaultInfo => 'Esquecer esta calibração';

  @override
  String get cardMismatch =>
      'Isso não corresponde a um cartão. Alinhe-o com a linha escura e tente de novo.';

  @override
  String get rotateToCalibrate => 'Gire para retrato para calibrar';

  @override
  String get calibrateHow => 'Calibrar com';

  @override
  String get methodCard => 'Um cartão';

  @override
  String get methodCardInfo =>
      'Qualquer cartão de banco ou documento · ±0,5 mm';

  @override
  String get methodRuler => 'Uma régua';

  @override
  String get methodRulerInfo => 'Mais preciso · régua ou fita métrica';

  @override
  String get methodScreen => 'O tamanho da tela';

  @override
  String get methodScreenInfo => 'Sem objetos · cerca de 1%';

  @override
  String rulerInstructions(String mark) {
    return 'Coloque uma régua na tela com o 0 na linha escura. Arraste a linha laranja até a marca de $mark.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'Isso não corresponde a $mark. Coloque o 0 da régua na linha escura e tente de novo.';
  }

  @override
  String get screenSizeInstructions =>
      'Digite o tamanho da tela em polegadas, conforme as especificações do celular. Não sabe? Pesquise o modelo e “tamanho da tela”.';

  @override
  String get screenSizeMismatch =>
      'Esse tamanho não corresponde a esta tela. Confira as especificações e tente de novo.';

  @override
  String get rulerCalibratedRuler => 'Calibrada com régua · ±0,5 mm';

  @override
  String rulerCalibratedScreen(String size) {
    return 'Ajustada para tela de $size polegadas · cerca de 1%';
  }

  @override
  String get metalHelp1 =>
      'Abra a ferramenta longe de metais. Essa primeira leitura conta como \"sem metal\".';

  @override
  String get metalHelp2 =>
      'Mova o celular devagar sobre a área. O sensor costuma ficar na parte de cima do celular. Ele apita mais rápido quanto mais perto do metal; toque no alto-falante para silenciar.';

  @override
  String get metalHelp3 =>
      '“Metal por perto” indica uma pequena mudança; “Metal detectado”, uma forte. Como no jogo de quente ou frio, a tela vai do azul frio ao vermelho incandescente conforme você se aproxima, e o celular vibra ao encontrar se a vibração estiver ligada.';

  @override
  String get metalHelp4 =>
      'Parado por alguns segundos, ele volta a zero sozinho e uma leitura falsa some. Para verificar um ponto de novo, afaste o celular e volte. Definir referência zera na hora.';

  @override
  String get metalTip =>
      'Só detecta ferro, aço e ímãs, não alumínio, cobre, ouro ou prata. Capinhas magnéticas interferem.';

  @override
  String metalSemantics(int value) {
    return 'Campo magnético $value microtesla';
  }

  @override
  String get noMetal => 'Nenhum metal por perto';

  @override
  String get metalNearby => 'Metal por perto';

  @override
  String get metalDetected => 'Metal detectado';

  @override
  String get heatCold => 'Frio';

  @override
  String get heatCool => 'Fresco';

  @override
  String get heatWarm => 'Morno';

  @override
  String get heatWarmer => 'Mais quente';

  @override
  String get heatHot => 'Quente';

  @override
  String get heatBurning => 'Pegando fogo';

  @override
  String get baseline => 'Referência';

  @override
  String get field => 'Campo';

  @override
  String get change => 'Mudança';

  @override
  String get findsIronSteel => 'Detecta ferro, aço e ímãs';

  @override
  String get setBaseline => 'Definir referência';

  @override
  String get muteSound => 'Silenciar';

  @override
  String get turnSoundOn => 'Ligar som';

  @override
  String get vibrationHelp1 =>
      'Coloque o celular deitado sobre a máquina ligada e tire as mãos. Numa máquina pequena, segure firme.';

  @override
  String get vibrationHelp2 =>
      'O ponteiro mostra a velocidade da vibração mais forte em RPM, com os hertz embaixo (RPM é hertz × 60). O brilho suave dentro do mostrador é o espectro inteiro; o ponteiro aponta para a parte mais clara.';

  @override
  String get vibrationHelp3 =>
      'Intensidade é o quanto treme, em m/s²: abaixo de 0,3 é parado, acima de 2 é forte.';

  @override
  String get vibrationHelp4 =>
      'Toque em Travar para segurar uma leitura, e no botão de reiniciar antes de medir a próxima máquina.';

  @override
  String get vibrationTip =>
      'A maioria dos celulares mede até 100 Hz (6000 RPM), alguns menos; o mostrador indica o limite do seu. Vibração mais rápida pode aparecer como uma velocidade menor e errada. A vibração mais forte costuma ser a velocidade do eixo, mas pode ser o dobro. Sensores de celular não são instrumentos de laboratório.';

  @override
  String get still => 'Parado';

  @override
  String get lightVibration => 'Vibração leve';

  @override
  String get strongVibration => 'Vibração forte';

  @override
  String get noAccelerometerVibration =>
      'Este celular não tem acelerômetro, então não dá para medir vibração aqui. As ferramentas que não precisam dele continuam funcionando.';

  @override
  String vibrationSemantics(String value) {
    return 'Vibração $value metros por segundo ao quadrado';
  }

  @override
  String get frequency => 'Frequência';

  @override
  String get rpm => 'RPM';

  @override
  String get strength => 'Intensidade';

  @override
  String vibratingAt(String value) {
    return 'Vibrando a $value Hz';
  }

  @override
  String get noClearFrequency => 'Sem frequência clara';

  @override
  String get findingFrequency => 'Procurando a frequência…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm rotações por minuto, $value hertz';
  }

  @override
  String get peak => 'Pico';

  @override
  String get average => 'Média';

  @override
  String get resetPeak => 'Zerar pico';

  @override
  String get altimeterHelp1 =>
      'O caminhante sobe e desce a montanha conforme a sua altura muda. O céu segue a hora do dia e a estação; toque no botão do tempo para escolher.';

  @override
  String get altimeterHelp2 =>
      'Para medir uma mudança de altura, como escadas ou andares, toque em Zerar aqui onde você começa.';

  @override
  String get altimeterHelp3 =>
      'Suba ou desça: o caminhante anda com você e a bandeira marca seu ponto mais alto. O painel mostra os metros desde o zero, a pressão e a altitude aproximada.';

  @override
  String get altimeterHelp4 =>
      'Toque em Limpar zero para parar de medir a partir do seu zero: a leitura Desde o zero volta a ficar vazia.';

  @override
  String get altimeterTip =>
      'O clima muda a pressão do ar o tempo todo, então, sem uma altura inicial conhecida, a altitude pode errar em cem metros ou mais. Confie na mudança de altura a partir de Zerar aqui por curtos períodos. Esta ferramenta precisa de um celular com barômetro.';

  @override
  String get weather => 'Tempo';

  @override
  String get weatherAuto => 'Automático (hora do dia e estação)';

  @override
  String get weatherSunny => 'Ensolarado';

  @override
  String get weatherCloudy => 'Nublado';

  @override
  String get weatherRain => 'Chuva';

  @override
  String get weatherStorm => 'Tempestade';

  @override
  String get weatherSnow => 'Neve';

  @override
  String get fromZero => 'Desde o zero';

  @override
  String get altitudeShort => 'Altitude';

  @override
  String get barometerIos =>
      'Não foi possível ler o barômetro. Ative Movimento e Preparo Físico para este app em Ajustes › Privacidade e Segurança e abra o Altímetro de novo.';

  @override
  String get noBarometer =>
      'Este celular não tem barômetro (sensor de pressão do ar), então o altímetro não funciona aqui. As outras ferramentas continuam funcionando.';

  @override
  String get noLightSensor =>
      'Este celular não tem sensor de luz, então o luxímetro não funciona aqui. As outras ferramentas continuam funcionando.';

  @override
  String lightSemantics(String value) {
    return 'Brilho $value lux';
  }

  @override
  String get illuminance => 'Brilho';

  @override
  String get footCandles => 'Pés-vela';

  @override
  String get lightDark => 'Escuro';

  @override
  String get lightDim => 'Luz fraca';

  @override
  String get lightLivingRoom => 'Luz de sala';

  @override
  String get lightReading => 'Boa para ler e trabalhar na mesa';

  @override
  String get lightBright => 'Luz interna forte';

  @override
  String get lightOvercast => 'Luz do dia nublado';

  @override
  String get lightDaylight => 'Luz do dia';

  @override
  String get lightSun => 'Luz solar direta';

  @override
  String get lightHelp1 =>
      'O sensor de luz fica no topo da tela, perto da câmera frontal.';

  @override
  String get lightHelp2 =>
      'Segure o celular onde quer medir, com a tela voltada para a luz.';

  @override
  String get lightHelp3 =>
      'O céu acompanha a luz: noite quando está escuro, amanhecer num ambiente com pouca luz, e o sol sobe à medida que fica mais claro. Leia os lux e para que a luz serve: de 300 a 750 lx é bom para ler e trabalhar na mesa.';

  @override
  String get lightHelp4 =>
      'Toque em Travar para manter uma leitura enquanto afasta o celular.';

  @override
  String get lightTip =>
      'Os sensores de luz dos celulares não são calibrados, então as leituras podem variar muito entre celulares. Use para comparar a luz em um mesmo lugar com o mesmo celular, não como um luxímetro calibrado. Não cubra o topo da tela.';

  @override
  String get noMicrophone =>
      'Não é possível usar o microfone. Outro app pode estar usando: feche-o e abra o decibelímetro de novo.';

  @override
  String soundSemantics(String value) {
    return 'Nível de som de cerca de $value decibéis';
  }

  @override
  String get decibelsApprox => 'dB (aprox.)';

  @override
  String get soundMax => 'Máx.';

  @override
  String get soundVeryQuiet => 'Muito silencioso';

  @override
  String get soundQuiet => 'Silencioso, como uma biblioteca';

  @override
  String get soundModerate => 'Moderado, como uma conversa';

  @override
  String get soundLoud => 'Alto, como trânsito intenso';

  @override
  String get soundVeryLoud =>
      'Muito alto: exposição longa pode prejudicar a audição';

  @override
  String get soundDangerous => 'Perigoso: proteja seus ouvidos';

  @override
  String get micTitle => 'Permitir o microfone';

  @override
  String get micBody =>
      'O decibelímetro ouve pelo microfone para medir o barulho. O som é medido no seu celular e nunca é gravado, salvo ou enviado.';

  @override
  String get micAllow => 'Permitir microfone';

  @override
  String get micDeniedTitle => 'O acesso ao microfone está desativado';

  @override
  String get micDeniedBody =>
      'Ative o microfone para este app nas Configurações para usar o decibelímetro. O som nunca é gravado, salvo ou enviado.';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get tryAgain => 'Tentar de novo';

  @override
  String get soundHelp1 =>
      'Deixe o microfone (na borda de baixo) livre e aponte o celular para o som.';

  @override
  String get soundHelp2 =>
      'O número grande é o nível atual, com média de cerca de um segundo. Dele saem ondas, mais e mais longe quanto mais alto o som: verdes no silêncio, depois amarelas, laranja, vermelhas e carmim. As barras abaixo mostram os últimos três segundos.';

  @override
  String get soundHelp3 =>
      'Média e Máx. contam desde que você abriu a ferramenta. Toque em Redefinir para recomeçar.';

  @override
  String get soundHelp4 =>
      'A partir de 70 dB a linha de status fica amarela; a partir de 85 dB, quando a exposição longa pode prejudicar a audição, fica vermelha.';

  @override
  String get soundHelp5 =>
      'Toque no cadeado para manter uma leitura na tela enquanto move o celular.';

  @override
  String get soundTip =>
      'Os microfones de celular não são decibelímetros calibrados e variam entre modelos, então as leituras são aproximadas (muitas vezes com margem de uns 5 a 10 dB) e sons muito altos podem aparecer mais baixos. Para qualquer medição oficial, use um decibelímetro calibrado.';

  @override
  String get metresFromZero => 'm desde o zero';

  @override
  String pressureSemantics(String value) {
    return 'Pressão do ar $value hectopascais';
  }

  @override
  String heightSemantics(String value) {
    return 'Altura $value a partir do zero';
  }

  @override
  String get pressure => 'Pressão';

  @override
  String get altitudeApprox => 'Altitude (aprox.)';

  @override
  String get measuringHeight => 'Medindo a altura a partir do seu zero';

  @override
  String get airPressureAltitude => 'Pressão do ar e altitude';

  @override
  String get appearance => 'Aparência';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get levelUnits => 'Unidade do nível';

  @override
  String get unitDegrees => 'Graus';

  @override
  String get unitPercent => 'Inclinação em porcentagem';

  @override
  String get unitRoofPitch => 'Inclinação de telhado (subida por 12)';

  @override
  String get vibrateWhenLevel => 'Vibração';

  @override
  String get sounds => 'Sons';

  @override
  String get resetCalibration => 'Redefinir calibração';

  @override
  String get resetCalibrationHint => 'Usar de novo o zero de fábrica do sensor';

  @override
  String get calibrateHere => 'Calibrar aqui';

  @override
  String get calibrateHereInfo =>
      'Numa superfície que você sabe que está nivelada';

  @override
  String get calibrationRemoved =>
      'Calibração removida. O nível volta a usar o zero de fábrica do sensor.';

  @override
  String get resetAllCalibrations => 'Redefinir todas as calibrações';

  @override
  String get resetAllCalibrationsHint =>
      'Nível e régua voltam ao padrão de fábrica';

  @override
  String get resetAllTitle => 'Redefinir todas as calibrações?';

  @override
  String get resetAllBody =>
      'Isso remove as calibrações que você fez no nível (também usada pelo medidor de ângulo) e na régua. Os dois voltam ao padrão de fábrica. Suas outras configurações continuam iguais, e você pode calibrar de novo quando quiser.';

  @override
  String get notCalibrated => 'Não calibrado';

  @override
  String get language => 'Idioma';

  @override
  String get licenses => 'Licenças de código aberto';

  @override
  String get languageSystem => 'Idioma do celular';

  @override
  String get toolHeight => 'Altura';

  @override
  String get toolHeightSubtitle => 'Altura e distância por mira';

  @override
  String get heightHelp1 =>
      'Fique onde consiga ver a base e o topo do objeto. Segure o telefone com a tela para cima e olhe ao longo da borda superior.';

  @override
  String get heightHelp2 =>
      'Aponte a borda superior para a base do objeto e toque em Fixar base: isso dá a distância.';

  @override
  String get heightHelp3 =>
      'Aponte a borda superior para o topo e toque em Fixar topo: a altura aparece.';

  @override
  String get heightHelp4 =>
      'Sabe a distância? Toque em Distância e digite; depois mire só no topo. Toque em Altura dos olhos para definir a sua.';

  @override
  String get heightTip =>
      'Cerca de ±5% em terreno plano com a altura dos olhos certa (sua altura menos uns 10 cm). Afaste-se para que o topo fique abaixo de 70° e a base pelo menos 3° abaixo do nível. Em declive, digite a distância.';

  @override
  String get lockBase => 'Fixar base';

  @override
  String get lockTop => 'Fixar topo';

  @override
  String get measureAgain => 'Medir de novo';

  @override
  String get distance => 'Distância';

  @override
  String get objectHeight => 'Altura';

  @override
  String get eyeHeight => 'Altura dos olhos';

  @override
  String get sightAngle => 'Ângulo de mira';

  @override
  String get heightAimBase => 'Aponte a borda superior para a base';

  @override
  String get heightAimTop => 'Agora aponte a borda superior para o topo';

  @override
  String get heightDone => 'Pronto · toque em Medir de novo para outra';

  @override
  String get heightHoldFlatter =>
      'Incline menos o telefone e mire pela borda superior';

  @override
  String get heightTooFar =>
      'Base muito perto do nível: aproxime-se ou digite a distância';

  @override
  String get heightStepBack =>
      'Muito íngreme: afaste-se para uma leitura mais estável';

  @override
  String get knownDistance => 'Distância até a base';

  @override
  String get knownDistanceHint =>
      'A distância pelo chão até a base do objeto. Apague para medir por mira.';

  @override
  String get eyeHeightHint =>
      'A altura dos seus olhos acima do chão: sua altura menos uns 10 cm.';

  @override
  String get clear => 'Apagar';

  @override
  String get toolCamera => 'Nível com câmera';

  @override
  String get toolCameraSubtitle =>
      'Linhas niveladas sobre a câmera, meça qualquer borda';

  @override
  String get cameraHelp1 =>
      'Aponte a câmera traseira para uma parede, quadro, prateleira ou porta. Segure o celular em pé, de frente para a parede.';

  @override
  String get cameraHelp2 =>
      'As linhas contínuas seguem a gravidade: estão sempre no nível e no prumo. As tracejadas são fixas ao celular, e o pequeno arco entre elas mostra quanto ele está inclinado. As linhas reais ficam laranja quando o celular está nivelado.';

  @override
  String get cameraHelp3 =>
      'Para conferir um objeto, toque em Congelar e arraste as duas alças laranja para uma das bordas dele, como o topo de um quadro. Você vê quanto essa borda está torta e qual lado levantar, mesmo que sua mão não estivesse nivelada. Deixe a linha em pé para conferir uma borda no prumo.';

  @override
  String get cameraHelp4 =>
      'Os dois botões no topo mostram ou escondem as linhas do celular e as linhas reais. A luz ajuda em cantos escuros; Continuar volta à imagem ao vivo.';

  @override
  String get cameraTip =>
      'Para medir uma borda com precisão, fique de frente para a parede (Frente/trás abaixo de 5°) e meça perto do centro da imagem, onde a lente curva menos as linhas. Usa a calibração de borda do nível. A imagem nunca é gravada, salva ou enviada.';

  @override
  String get cameraAllowTitle => 'Permitir a câmera';

  @override
  String get cameraAllowBody =>
      'O nível com câmera desenha linhas niveladas sobre a imagem da câmera e mede bordas nela. A imagem fica no seu celular e nunca é gravada, salva ou enviada.';

  @override
  String get cameraAllow => 'Permitir câmera';

  @override
  String get cameraDeniedTitle => 'O acesso à câmera está desligado';

  @override
  String get cameraDeniedBody =>
      'Ative a câmera para este app nos Ajustes para usar o nível com câmera. A imagem nunca é gravada, salva ou enviada.';

  @override
  String get noCamera =>
      'Não é possível usar a câmera. Outro app pode estar usando ou o celular não tem uma: feche outros apps de câmera e abra o nível com câmera de novo.';

  @override
  String get tilt => 'Inclinação';

  @override
  String get forwardBack => 'Frente/trás';

  @override
  String get cameraLevel => 'Nivelado';

  @override
  String cameraTilted(String value) {
    return 'Inclinado $value°';
  }

  @override
  String get cameraHoldUpright =>
      'Segure o celular em pé, câmera para a parede';

  @override
  String get freeze => 'Congelar';

  @override
  String get resume => 'Continuar';

  @override
  String get torch => 'Luz';

  @override
  String cameraSemantics(String value) {
    return 'Imagem da câmera com linhas niveladas, inclinada $value graus';
  }

  @override
  String get cameraPhoneLines => 'Linhas do celular';

  @override
  String get cameraTrueLines => 'Linhas reais';

  @override
  String get cameraFrozen => 'Congelado';

  @override
  String get cameraDragHandles => 'Arraste as alças até uma borda';

  @override
  String get cameraFaceWall => 'Fique de frente para a parede';

  @override
  String get edgeLevel => 'Esta borda está nivelada';

  @override
  String get edgePlumb => 'Esta borda está no prumo';

  @override
  String edgeLiftRight(String value) {
    return 'Borda $value° torta, levante a direita';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'Borda $value° torta, levante a esquerda';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'Borda $value° fora do prumo';
  }

  @override
  String get cameraHandle => 'Alça da borda';

  @override
  String get toolGForce => 'Força G';

  @override
  String get toolGForceSubtitle => 'Frenagem, aceleração e curvas em g';

  @override
  String get gHelp1 =>
      'Prenda o celular num suporte veicular, com a tela virada para você. Com o carro parado, toque em Zerar: o medidor aprende onde é para baixo e onde é para frente.';

  @override
  String get gHelp2 =>
      'Dirija: o lado do carro para onde você é empurrado se acende. Frear acende a frente, acelerar a traseira e uma curva o lado de fora. Verde é suave, laranja firme e vermelho forte.';

  @override
  String get gHelp3 =>
      'O painel guarda a aceleração, a frenagem e a curva mais fortes desde que você zerou, e os pontos na borda guardam o maior empurrão em cada direção. O botão de redefinir apaga tudo.';

  @override
  String get gHelp4 =>
      'Mantenha os olhos na estrada: deixe um passageiro ler ou confira os picos depois de parar.';

  @override
  String get gTip =>
      'As leituras vêm do acelerômetro e são aproximadas: dependem de um suporte firme e de tocar em Zerar com o carro parado, e ficam um pouco mais instáveis em vias esburacadas. Se o suporte se mexer, pare e toque em Zerar de novo. Acima de 0,5 g é uma freada forte ou uma curva rápida para um carro comum.';

  @override
  String get gZero => 'Zerar';

  @override
  String get gResetPeaks => 'Redefinir picos';

  @override
  String get gSpeedUp => 'Acelerar';

  @override
  String get gBrake => 'Frear';

  @override
  String get gCorner => 'Curva';

  @override
  String get gSteady => 'Estável';

  @override
  String gBraking(String value) {
    return 'Freando $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'Acelerando $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'Curva à esquerda $value g';
  }

  @override
  String gRightBend(String value) {
    return 'Curva à direita $value g';
  }

  @override
  String gSemantics(String value) {
    return 'Força G $value g';
  }

  @override
  String get gZeroed => 'Zerado: frente e baixo aprendidos';

  @override
  String get noAccelerometerG =>
      'Este celular não tem acelerômetro, então não dá para medir força G aqui. As outras ferramentas continuam funcionando.';

  @override
  String get toolSpeed => 'Velocímetro';

  @override
  String get toolSpeedSubtitle => 'Velocidade, percurso e altitude GPS';

  @override
  String get speedHelp1 =>
      'Permita a localização e coloque o celular onde ele veja o céu, como no painel ou num suporte no para-brisa. Ao ar livre, a primeira localização leva alguns segundos.';

  @override
  String get speedHelp2 =>
      'O mostrador no painel mostra sua velocidade pelo GPS, com a distância do percurso e a altitude de cada lado. O quadro guarda a distância, a velocidade máxima e a média desde a última vez que você zerou.';

  @override
  String get speedHelp3 =>
      'Toque nas coordenadas para copiá-las. O botão de unidade alterna entre km/h e mph, e Zerar percurso recomeça a distância, a máxima e a média.';

  @override
  String get speedHelp4 =>
      'Mantenha os olhos na estrada: deixe um passageiro ler ou confira o percurso depois de parar.';

  @override
  String get speedTip =>
      'A velocidade vem dos satélites e costuma ter precisão de cerca de 1 km/h em estradas abertas; em túneis, entre prédios altos ou em ambientes fechados ela pode atrasar ou sumir. A altitude do GPS pode errar de 10 a 50 m, então use o Altímetro para mudanças de altura. A localização só é usada enquanto esta ferramenta está aberta e nunca sai do seu celular.';

  @override
  String get speedAllowTitle => 'Permitir a localização';

  @override
  String get speedAllowBody =>
      'O velocímetro usa o GPS para medir sua velocidade, distância e altitude. A localização só é usada enquanto esta ferramenta está aberta na tela, nunca em segundo plano, e nunca sai do seu celular.';

  @override
  String get speedAllow => 'Permitir localização';

  @override
  String get speedDeniedTitle => 'O acesso à localização está desativado';

  @override
  String get speedDeniedBody =>
      'Ative a localização para este app nas Configurações para usar o velocímetro. Ela só é usada enquanto a ferramenta está aberta e nunca sai do seu celular.';

  @override
  String get speedServiceOffTitle => 'A localização está desligada';

  @override
  String get speedServiceOffBody =>
      'Ative a localização nas configurações do celular para usar o velocímetro.';

  @override
  String get speedDistance => 'Distância';

  @override
  String get speedTop => 'Máxima';

  @override
  String get speedAverage => 'Média';

  @override
  String get speedTrip => 'Percurso';

  @override
  String get speedAltitude => 'Altitude';

  @override
  String get speedResetTrip => 'Zerar percurso';

  @override
  String get speedFinding => 'Procurando satélites…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value m';
  }

  @override
  String get speedWeak => 'GPS fraco: a velocidade pode atrasar';

  @override
  String get speedApproximate =>
      'Localização precisa desligada: ative para uma velocidade estável';

  @override
  String get speedStill => 'Parado';

  @override
  String get speedCopied => 'Coordenadas copiadas';

  @override
  String get speedUnitTooltip => 'Alternar entre km/h e mph';

  @override
  String get speedKmh => 'km/h';

  @override
  String get speedMph => 'mph';

  @override
  String speedSemantics(String value) {
    return 'Velocidade $value';
  }

  @override
  String get speedCoordinates => 'Coordenadas, toque para copiar';

  @override
  String get noGps =>
      'Este celular não tem GPS, então não dá para medir a velocidade aqui. As outras ferramentas continuam funcionando.';

  @override
  String get speedSceneHelp =>
      'O céu acompanha a hora do dia. O botão do tempo escolhe a cena: Auto segue a estação, ou escolha sol, nuvens, chuva, tempestade ou neve. É cenário, não uma previsão.';

  @override
  String get toolTape => 'Trena';

  @override
  String get toolTapeSubtitle => 'Comprimentos e áreas em AR';

  @override
  String get tapeAllowBody =>
      'A trena acompanha a imagem da câmera em 3D para colocar pontos sobre superfícies. A imagem fica no seu celular e nunca é gravada, salva ou enviada.';

  @override
  String get tapeDeniedBody =>
      'Ative a câmera para este app nos Ajustes para usar a trena. A imagem nunca é gravada, salva ou enviada.';

  @override
  String get tapeInstallTitle => 'Instalar suporte a AR';

  @override
  String get tapeInstallBody =>
      'A trena usa o Google Play Services for AR (ARCore) para acompanhar o celular em 3D. Instale ou atualize pela Play Store e depois volte.';

  @override
  String get tapeInstall => 'Instalar';

  @override
  String get tapeUnsupported =>
      'Este celular não é compatível com AR (ARCore), que a trena precisa para acompanhar o celular em 3D.';

  @override
  String get tapeFailed =>
      'Não foi possível iniciar o AR. Outro app pode estar usando a câmera: feche esse app e tente de novo.';

  @override
  String get tapeLength => 'Comprimento';

  @override
  String get tapePerimeter => 'Perímetro';

  @override
  String get tapeArea => 'Área';

  @override
  String get tapePieces => 'Trechos';

  @override
  String get tapeAdd => 'Adicionar ponto';

  @override
  String get tapeClose => 'Fechar forma';

  @override
  String get tapeUndo => 'Desfazer';

  @override
  String get tapeUnit => 'Unidades: centímetros ou polegadas';

  @override
  String get tapeStarting => 'Mova o celular devagar para iniciar o AR';

  @override
  String get tapeFind =>
      'Mova o celular devagar sobre uma superfície para encontrá-la';

  @override
  String get tapeNoSurface =>
      'Ainda não há superfície sob a mira: mova devagar';

  @override
  String get tapeMissed =>
      'Ainda não há superfície ali. Mova devagar e toque de novo';

  @override
  String get tapeFirst => 'Mire no primeiro canto e toque em Adicionar ponto';

  @override
  String get tapeNext => 'Mire no próximo canto e toque em Adicionar ponto';

  @override
  String get tapeSnap =>
      'No primeiro ponto: toque em Fechar forma para ver a área';

  @override
  String get tapeDone => 'Aprox. O AR pode errar de 1 a 3 cm';

  @override
  String get tapeDark => 'Escuro demais para rastrear: aumente a luz';

  @override
  String get tapeFast => 'Movimento rápido demais: vá mais devagar';

  @override
  String get tapePlain => 'Liso demais para rastrear: mire em algo com textura';

  @override
  String get tapeLost =>
      'Rastreamento perdido: aponte de volta para onde estava e fique parado';

  @override
  String tapeSemantics(String total) {
    return 'Imagem da câmera com os pontos medidos. Total $total';
  }

  @override
  String get tapeHelp1 =>
      'Permita a câmera e mova o celular devagar sobre uma mesa, o chão ou uma parede até aparecerem pontos brancos e a mira se assentar na superfície.';

  @override
  String get tapeHelp2 =>
      'Aponte a mira para um canto e toque em Adicionar ponto. Vá até o próximo canto: o comprimento acompanha a mira.';

  @override
  String get tapeHelp3 =>
      'Continue tocando nos cantos para encadear trechos; o painel soma tudo. Mire de volta no primeiro ponto e toque em Fechar forma para ver a área e o perímetro.';

  @override
  String get tapeHelp4 =>
      'Desfazer remove o último ponto (ou abre uma forma fechada); Apagar recomeça. O botão no topo alterna entre centímetros e polegadas.';

  @override
  String get tapeTip =>
      'A medição com AR é aproximada: costuma ter precisão de 1 a 3 cm por metro, mas piora em superfícies lisas ou brilhantes, com pouca luz, de longe (mais de 3 m) ou quando o celular se move rápido. Mova devagar e mantenha os cantos bem iluminados. A imagem nunca é gravada, salva ou enviada.';
}
