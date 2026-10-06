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
  String get tools => 'Ferramentas';

  @override
  String get listView => 'Lista';

  @override
  String get gridView => 'Grade';

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
  String get toolVibrationSubtitle => 'Medidor de vibração com gráfico ao vivo';

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
      'Deite o celular numa superfície para ver a inclinação, ou apoie-o de lado contra uma rampa, corrimão ou cano: o número grande é o ângulo da borda longa; o da curta aparece embaixo.';

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
      'Ele alterna sozinho entre deitado e de lado. Para fixar um, toque no ícone de deitado ou de lado no topo; o primeiro ícone volta ao automático.';

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
  String get longEdgeFromLevel => 'De lado · borda longa em relação ao nível';

  @override
  String shortEdge(String value) {
    return 'Borda curta $value';
  }

  @override
  String edgeAngleSemantics(String long, String short) {
    return 'Borda longa $long em relação ao nível, borda curta $short';
  }

  @override
  String get angleModeAuto => 'Automático';

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
      'Ela aponta para o norte magnético, que pode diferir alguns graus do norte do mapa. Se parecer errada, mova o celular desenhando um 8 algumas vezes.';

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
      '\"Metal por perto\" indica uma mudança pequena e \"Metal detectado\", uma forte: o centro fica laranja e o celular vibra se a vibração estiver ligada.';

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
      'Deite o celular sobre a superfície ou máquina que você quer verificar e tire as mãos.';

  @override
  String get vibrationHelp2 =>
      'O mostrador indica a vibração agora em m/s². O gráfico mostra os últimos segundos.';

  @override
  String get vibrationHelp3 =>
      'Pico é o momento mais forte. Média é o nível no último segundo.';

  @override
  String get vibrationHelp4 => 'Toque em Zerar pico antes de cada novo teste.';

  @override
  String get vibrationTip =>
      '\"Parado\" é abaixo de 0,3 m/s² e \"Vibração forte\", acima de 2 m/s². Use as leituras para comparar; sensores de celular não são instrumentos de laboratório.';

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
  String get peak => 'Pico';

  @override
  String get average => 'Média';

  @override
  String get resetPeak => 'Zerar pico';

  @override
  String get vibrationGraph => 'Gráfico de vibração';

  @override
  String get altimeterHelp1 =>
      'O mostrador indica a pressão do ar em hPa, e a altitude é estimada a partir dela.';

  @override
  String get altimeterHelp2 =>
      'Para medir uma mudança de altura, como escadas ou andares, toque em Zerar aqui onde você começa.';

  @override
  String get altimeterHelp3 =>
      'Suba ou desça. O centro mostra os metros a partir do seu zero.';

  @override
  String get altimeterHelp4 => 'Toque em Limpar zero para voltar.';

  @override
  String get altimeterTip =>
      'O clima muda a pressão do ar, então a altitude pode errar em dezenas de metros. A altura a partir do seu zero é precisa por curtos períodos. Esta ferramenta precisa de um celular com barômetro.';

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
      'Veja os lux e para que serve essa luz: 300–750 lx é bom para ler e trabalhar na mesa.';

  @override
  String get lightHelp4 =>
      'Toque em Travar para manter uma leitura enquanto afasta o celular.';

  @override
  String get lightTip =>
      'Os sensores de luz variam entre celulares, então as leituras podem errar 10–20%: bom para comparar lugares, não é um luxímetro calibrado. Não cubra o topo da tela.';

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
      'O número grande é o nível agora, com média de cerca de um segundo.';

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
      'Os microfones variam entre celulares, então as leituras podem errar cerca de 5 dB: bom para comparar, não é um decibelímetro certificado. Sons muito altos (acima de uns 110 dB) podem aparecer mais baixos.';

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
}
