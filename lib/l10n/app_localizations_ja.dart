// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '水平器・角度計';

  @override
  String get homeTitle => '水平器';

  @override
  String get settings => '設定';

  @override
  String get homeTopTools => 'よく使うツール';

  @override
  String get homeMoreTools => 'その他のツール';

  @override
  String get homeArrange => '並べ替え';

  @override
  String get arrangeTitle => 'ツールの並べ替え';

  @override
  String get arrangeHint => 'ドラッグで順番を変えられます。上の3つがよく使うツールになります。';

  @override
  String get arrangeStar => 'よく使うツールにする';

  @override
  String get arrangeUnstar => 'よく使うツールから外す';

  @override
  String get arrangeReset => '人気順';

  @override
  String get arrangeDone => '完了';

  @override
  String get back => '戻る';

  @override
  String get lightMode => 'ライトモード';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get toolLevel => '水平器';

  @override
  String get toolLevelSubtitle => '気泡管・水準器';

  @override
  String get toolAngle => '角度';

  @override
  String get toolAngleSubtitle => '水平またはゼロ点からの角度';

  @override
  String get toolCompass => 'コンパス';

  @override
  String get toolCompassSubtitle => '方位と方角';

  @override
  String get toolProtractor => '分度器';

  @override
  String get toolProtractorSubtitle => '画面上で角度を測定';

  @override
  String get toolRuler => '定規';

  @override
  String get toolRulerSubtitle => '画面上で長さを測定';

  @override
  String get toolMetal => '金属探知機';

  @override
  String get toolMetalSubtitle => '鉄・鋼・磁石を探す';

  @override
  String get toolVibration => '振動計';

  @override
  String get toolVibrationSubtitle => '振動の強さと回転数（rpm）';

  @override
  String get toolSound => '騒音計';

  @override
  String get toolSoundSubtitle => '騒音をデシベルで';

  @override
  String get toolAltimeter => '高度計';

  @override
  String get toolAltimeterSubtitle => '気圧と高さ';

  @override
  String get toolLight => '照度計';

  @override
  String get toolLightSubtitle => '明るさをルクスで';

  @override
  String get notAvailableOnPhone => 'この端末では使用できません';

  @override
  String get notOnPhone => '使用不可';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool、この端末では使用できません';
  }

  @override
  String get howToUse => '使い方';

  @override
  String get rotateLandscape => '横向きにする';

  @override
  String get rotatePortrait => '縦向きにする';

  @override
  String howToUseTool(String tool) {
    return '$toolの使い方';
  }

  @override
  String get gotIt => 'OK';

  @override
  String get goodToKnow => 'ポイント：';

  @override
  String get ok => 'OK';

  @override
  String toolUnavailableTitle(String tool) {
    return '$toolは使用できません';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'センサー',
      one: 'センサー',
    );
    return '$toolには、この端末にない$_temp0が必要です：$sensors。';
  }

  @override
  String get listSeparator => '、';

  @override
  String get hardwareLimitTip =>
      'これは端末のハードウェアによる制限で、アプリの不具合ではありません。ほかのツールは通常どおり使えます。';

  @override
  String get sensorAccelerometer => '加速度センサー';

  @override
  String get sensorMagnetometer => '磁気センサー（コンパス用）';

  @override
  String get sensorBarometer => '気圧センサー';

  @override
  String get sensorLight => '照度センサー';

  @override
  String get sensorMicrophone => 'マイク';

  @override
  String get sensorCamera => '背面カメラ';

  @override
  String get sensorGps => 'GPS';

  @override
  String get noAccelerometer =>
      'この端末には加速度センサーがないため、このツールでは測定できません。加速度センサーを使わないツールは使えます。';

  @override
  String get noMagnetometer =>
      'この端末には磁気センサー（コンパス用）がないため、このツールは使えません。磁気センサーを使わないツールは使えます。';

  @override
  String get noReadings =>
      'センサーからまだ値が届きません。戻ってツールを開き直してください。繰り返す場合は端末を再起動してください。このツールに対応していない端末もあります。';

  @override
  String get waitingForSensors => 'センサーを待っています…';

  @override
  String get levelHelp1 => '端末を面の上に平らに置くか、側面を下にして立てます。';

  @override
  String get levelHelp2 => '平置き：気泡を中央に合わせます。Xは左右、Yは前後の傾きです。立てると角度と勾配が表示されます。';

  @override
  String get levelHelp3 =>
      '画面の案内（例：「右側が高い」）に従い、「水平」になるまで調整します。表示がオレンジになり、音と振動でお知らせします（設定でオフにできます）。';

  @override
  String get levelHelp4 => '「ロック」で値を固定し、「ロック解除」で再び測定します。';

  @override
  String get levelHelp5 => '昔ながらの水平器がお好みなら、切り替えの管アイコンをタップ。丸いアイコンで目盛り表示に戻ります。';

  @override
  String get levelTip =>
      '水平とわかっている面で0°にならない場合は、端末を置いて「補正」をタップします。元に戻すには、もう一度「補正」をタップして「補正をリセット」を選びます。';

  @override
  String get statusLevel => '水平';

  @override
  String get leftEndLow => '左端が低い';

  @override
  String get rightEndLow => '右端が低い';

  @override
  String get rightSideHigh => '右側が高い';

  @override
  String get leftSideHigh => '左側が高い';

  @override
  String get topEdgeHigh => '上端が高い';

  @override
  String get bottomEdgeHigh => '下端が高い';

  @override
  String get calibrated => '補正しました。この位置が0°になりました。';

  @override
  String get tooFarToCalibrate => '傾きが大きすぎて補正できません。先に端末を水平な面に置いてください。';

  @override
  String get dialView => '目盛り表示';

  @override
  String get tubeView => '気泡管表示';

  @override
  String get levelTube => '気泡管';

  @override
  String get leftRightTube => '左右の気泡管';

  @override
  String get forwardBackTube => '前後の気泡管';

  @override
  String tiltFromLevel(String value) {
    return '水平からの傾き $value';
  }

  @override
  String fromLevel(String value) {
    return '水平からのずれ $value';
  }

  @override
  String get xLeftRight => 'X · 左右';

  @override
  String get yForwardBack => 'Y · 前後';

  @override
  String get angle => '角度';

  @override
  String get slope => '勾配';

  @override
  String get lock => 'ロック';

  @override
  String get unlock => 'ロック解除';

  @override
  String locked(String status) {
    return 'ロック中 · $status';
  }

  @override
  String get lockReading => '値をロック';

  @override
  String get lockHandles => 'ハンドルをロック';

  @override
  String get handlesLocked => 'ハンドルをロック中 · 鍵をタップして調整';

  @override
  String get calibrate => '補正';

  @override
  String get angleHelp1 =>
      '端末を面に置くと傾きがわかります。辺を立てて斜面・手すり・パイプに当てると、大きな数字はオレンジに光る辺の角度、その下が下の辺の角度です。';

  @override
  String get angleHelp2 => '変化を測るには、開始位置で端末を持ち「ここをゼロに」をタップします。';

  @override
  String get angleHelp3 => '端末を傾けたり動かしたりすると、ゼロ点から何度動いたかが表示されます。';

  @override
  String get angleHelp4 => '「ゼロを解除」で平置きからの角度表示に戻ります。';

  @override
  String get angleHelp5 => '見えない位置の角度は、端末を物に当てて鍵をタップし、離してから読み取ります。';

  @override
  String get angleHelp6 =>
      '上部のスイッチでモードを選びます：面に平らに置く、または辺で立てる。辺で立てると画面は水平を保つ水で満たされ、測定中の辺（低い側）がオレンジに光ります。';

  @override
  String get angleTip => 'スロープや階段の手すり、屋根に端末の長辺を当てると勾配を、板やドアに画面を平らに当てると傾きを測れます。';

  @override
  String movedFromZero(String value) {
    return 'ゼロからの変化 $value';
  }

  @override
  String get measuringFromZero => 'ゼロ点から測定中';

  @override
  String get angleFlatStatus => '平置き · 地面に対する角度';

  @override
  String get measuringRightEdge => '右の辺を測定中';

  @override
  String get measuringLeftEdge => '左の辺を測定中';

  @override
  String bottomEdge(String value) {
    return '下の辺 $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge：水平から $value。下の辺 $other';
  }

  @override
  String get angleModeFlat => '面に平らに置く';

  @override
  String get angleModeEdge => '辺で立てる';

  @override
  String get standOnEdge => '端末をいずれかの辺で立ててください';

  @override
  String get clearZero => 'ゼロを解除';

  @override
  String get setZeroHere => 'ここをゼロに';

  @override
  String get compassHelp1 => '端末を水平にして体の前で持ちます。金属・磁石・電子機器から離してください。';

  @override
  String get compassHelp2 => '端末の上端を知りたい方向に向けます。立てて持つと、背面カメラが向いている方角を表示します。';

  @override
  String get compassHelp3 =>
      '数字は方位（度）、文字は方角です。目盛りは N が常に北を向くように回転し、上部のオレンジの玉が端末の向いている方向を示します。';

  @override
  String get compassTip =>
      '磁北を指すため、場所によっては地図の北と10度以上ずれることがあります。おかしい場合は端末を8の字に数回動かしてください。';

  @override
  String compassSemantics(int heading, String direction) {
    return '磁方位 $heading度、$direction';
  }

  @override
  String get magneticInterference => '磁気の乱れ · 金属から離れ、端末を8の字に動かしてください';

  @override
  String get compassCalibrate => '端末を8の字に動かしてコンパスを補正してください';

  @override
  String get dirN => '北';

  @override
  String get dirNE => '北東';

  @override
  String get dirE => '東';

  @override
  String get dirSE => '南東';

  @override
  String get dirS => '南';

  @override
  String get dirSW => '南西';

  @override
  String get dirW => '西';

  @override
  String get dirNW => '北西';

  @override
  String get protractorHelp1 => '端末を平らに置き、角が中央に来るように物を画面に載せます。';

  @override
  String get protractorHelp2 => 'オレンジのハンドルをそれぞれドラッグし、線を角の辺に合わせます。';

  @override
  String get protractorHelp3 => '中央の角度を読みます。優角は反対側の角度（360°からその角度を引いた値）です。';

  @override
  String get protractorHelp4 => '「リセット」でやり直せます。';

  @override
  String get protractorHelp5 => '物を動かしてもハンドルがずれないよう、鍵をタップして固定できます。';

  @override
  String armsSemantics(String value) {
    return '2本の腕の間の角度 $value';
  }

  @override
  String get reflex => '優角';

  @override
  String get dragHandles => 'オレンジのハンドルを辺に沿ってドラッグ';

  @override
  String get reset => 'リセット';

  @override
  String get rulerHelp1 => '物を画面に置くか、端末を物に当てます。';

  @override
  String get rulerHelp2 =>
      'オレンジの線を物の両端までドラッグします。mm、cm、in をタップして単位を選べます。もう一方の単位は下に表示されます。';

  @override
  String get rulerHelp3 => 'より正確に測るには、一度「補正」をタップして、カード、定規、または画面サイズを使います。';

  @override
  String get rulerHelp4 => '物を動かしても線がずれないよう、鍵をタップして固定できます。';

  @override
  String get rulerTip =>
      '測れるのは画面の長さまでです。ケースや曲面の縁で最初の数ミリが隠れるため、端末の端からではなく線と線の間で測ってください。';

  @override
  String get rulerWidthOn => '幅も測る';

  @override
  String rulerArea(String value) {
    return '面積 $value';
  }

  @override
  String rulerBoxSemantics(String length, String width, String area) {
    return '長さ $length ミリメートル、幅 $width ミリメートル、面積 $area 平方センチメートル';
  }

  @override
  String get rulerHelp5 =>
      '上の四角いボタンをタップすると幅も測れます。左右の2本の線を物の両端に合わせると、幅と面積が表示されます。幅は画面の幅までです。';

  @override
  String rulerSemantics(String mm, String inches) {
    return '長さ $mmミリ、$inchesインチ';
  }

  @override
  String get rulerCalibrated => 'カードで補正済み · ±0.5 mm';

  @override
  String get rulerReported => '端末の画面サイズを使用 · 補正で±0.5 mm';

  @override
  String get unitMillimetres => 'ミリメートル';

  @override
  String get unitCentimetres => 'センチメートル';

  @override
  String get unitInches => 'インチ';

  @override
  String get rulerEstimated => '未補正 · 長さが10%ずれることがあります';

  @override
  String get cardLongEdge =>
      '銀行カードや身分証を、長い辺を定規に沿わせ、片端を濃い線に合わせて画面に置きます。オレンジの線をカードのもう一方の端までドラッグします。';

  @override
  String get cardShortEdge =>
      '銀行カードや身分証を、短い辺を定規に沿わせ、片端を濃い線に合わせて画面に置きます。オレンジの線をカードのもう一方の端までドラッグします。';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get usePhoneDefault => '端末の画面サイズを使う';

  @override
  String get usePhoneDefaultInfo => 'この補正を消去';

  @override
  String get cardMismatch => 'カードの大きさと合いません。濃い線に合わせてもう一度お試しください。';

  @override
  String get rotateToCalibrate => '補正するには縦向きにしてください';

  @override
  String get calibrateHow => '補正の方法';

  @override
  String get methodCard => 'カード';

  @override
  String get methodCardInfo => '銀行カードや身分証 · ±0.5 mm';

  @override
  String get methodRuler => '定規';

  @override
  String get methodRulerInfo => '最も正確 · 定規やメジャー';

  @override
  String get methodScreen => '画面サイズ';

  @override
  String get methodScreenInfo => '道具不要 · 誤差約1%';

  @override
  String rulerInstructions(String mark) {
    return '定規の0を濃い線に合わせて画面に置き、オレンジの線を$markの目盛りまでドラッグします。';
  }

  @override
  String rulerMismatch(String mark) {
    return '$markと一致しません。定規の0を濃い線に合わせて、もう一度試してください。';
  }

  @override
  String get screenSizeInstructions =>
      'スマートフォンの仕様にある画面サイズをインチで入力します。わからない場合は、機種名と「画面サイズ」で検索してください。';

  @override
  String get screenSizeMismatch => 'このサイズはこの画面と合いません。仕様を確認して、もう一度試してください。';

  @override
  String get rulerCalibratedRuler => '定規で補正済み · ±0.5 mm';

  @override
  String rulerCalibratedScreen(String size) {
    return '$sizeインチの画面に設定 · 誤差約1%';
  }

  @override
  String get metalHelp1 => '金属から離れた場所でツールを開きます。最初の値が「金属なし」の基準になります。';

  @override
  String get metalHelp2 =>
      '端末をゆっくり動かして探します。センサーはたいてい端末の上部にあります。金属に近づくほどビープ音が速くなります。スピーカーをタップすると消音します。';

  @override
  String get metalHelp3 =>
      '「近くに金属」は小さな変化、「金属を検出」は大きな変化です。「あついつめたい」遊びのように、近づくほど画面は冷たい青から赤く輝く色に変わり、バイブがオンなら見つけたときに端末が震えます。';

  @override
  String get metalHelp4 =>
      '数秒間動かさずにいると自動でゼロに戻り、誤った表示は消えます。同じ場所をもう一度調べるには、スマートフォンを離してから戻します。「基準を設定」ですぐにゼロに戻せます。';

  @override
  String get metalTip => '検出できるのは鉄・鋼・磁石だけで、アルミ・銅・金・銀は検出できません。磁石付きのケースは影響します。';

  @override
  String metalSemantics(int value) {
    return '磁場 $valueマイクロテスラ';
  }

  @override
  String get noMetal => '近くに金属なし';

  @override
  String get metalNearby => '近くに金属';

  @override
  String get metalDetected => '金属を検出';

  @override
  String get heatCold => '冷たい';

  @override
  String get heatCool => 'ひんやり';

  @override
  String get heatWarm => 'あたたかい';

  @override
  String get heatWarmer => 'もっとあたたかい';

  @override
  String get heatHot => '熱い';

  @override
  String get heatBurning => '燃えてる';

  @override
  String get baseline => '基準値';

  @override
  String get field => '磁場';

  @override
  String get change => '変化';

  @override
  String get findsIronSteel => '鉄・鋼・磁石を検出';

  @override
  String get setBaseline => '基準を設定';

  @override
  String get muteSound => '消音';

  @override
  String get turnSoundOn => '音を出す';

  @override
  String get vibrationHelp1 =>
      '動いている機械の上にスマホを平らに置き、手を離します。小さな機械ではしっかり押さえてください。';

  @override
  String get vibrationHelp2 =>
      '針はいちばん強い振動の速さを rpm で示し、その下にヘルツを表示します（rpm はヘルツ × 60）。目盛りの内側のかすかな光はスペクトル全体で、針はその最も明るい部分を指します。';

  @override
  String get vibrationHelp3 =>
      '強さは揺れの大きさで、単位は m/s² です。0.3 未満は静止、2 を超えると強い振動です。';

  @override
  String get vibrationHelp4 => 'ロックで値を保持し、次の機械を測る前にリセットボタンを押します。';

  @override
  String get vibrationTip =>
      '多くのスマホは 100 Hz（6000 rpm）まで測れますが、それより低い機種もあり、目盛りはお使いの機種の上限を示します。それより速い振動は、誤った低い速さとして表示されることがあります。最も強い振動は軸の回転数であることが多いですが、その2倍のこともあります。スマホのセンサーは計測機器ではありません。';

  @override
  String get still => '静止';

  @override
  String get lightVibration => '弱い振動';

  @override
  String get strongVibration => '強い振動';

  @override
  String get noAccelerometerVibration =>
      'この端末には加速度センサーがないため、振動を測定できません。加速度センサーを使わないツールは使えます。';

  @override
  String vibrationSemantics(String value) {
    return '振動 毎秒毎秒$valueメートル';
  }

  @override
  String get frequency => '周波数';

  @override
  String get rpm => 'rpm';

  @override
  String get strength => '強さ';

  @override
  String vibratingAt(String value) {
    return '$value Hz で振動';
  }

  @override
  String get noClearFrequency => 'はっきりした周波数なし';

  @override
  String get findingFrequency => '周波数を検出中…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '毎分 $rpm 回転、$value ヘルツ';
  }

  @override
  String get peak => '最大';

  @override
  String get average => '平均';

  @override
  String get resetPeak => '最大をリセット';

  @override
  String get altimeterHelp1 =>
      'ハイカーが高さに合わせて山を登ります。空は時刻と季節に合わせて変わります。天気ボタンで自分で選ぶこともできます。';

  @override
  String get altimeterHelp2 => '階段や階など高さの変化を測るには、開始地点で「ここをゼロに」をタップします。';

  @override
  String get altimeterHelp3 =>
      '上り下りすると、ハイカーも一緒に歩き、旗が最高地点を示します。パネルにはゼロからの高さ、気圧、おおよその標高が表示されます。';

  @override
  String get altimeterHelp4 => '「ゼロを解除」をタップすると、ゼロからの測定を終了し、「ゼロから」の値は空欄に戻ります。';

  @override
  String get altimeterTip =>
      '気圧は天気で常に変わるため、出発地点の高さがわからないと、高度は100メートル以上ずれることがあります。信頼できるのは、短時間での「ここをゼロに」からの高さの変化です。このツールには気圧センサー付きの端末が必要です。';

  @override
  String get weather => '天気';

  @override
  String get weatherAuto => '自動（時刻と季節）';

  @override
  String get weatherSunny => '晴れ';

  @override
  String get weatherCloudy => 'くもり';

  @override
  String get weatherRain => '雨';

  @override
  String get weatherStorm => '嵐';

  @override
  String get weatherSnow => '雪';

  @override
  String get fromZero => 'ゼロから';

  @override
  String get altitudeShort => '標高';

  @override
  String get barometerIos =>
      '気圧センサーを読み取れません。設定 › プライバシーとセキュリティで、このアプリの「モーションとフィットネス」をオンにしてから高度計を開き直してください。';

  @override
  String get noBarometer => 'この端末には気圧センサーがないため、高度計は使えません。ほかのツールは使えます。';

  @override
  String get noLightSensor => 'この端末には照度センサーがないため、照度計は使えません。ほかのツールは引き続き使えます。';

  @override
  String lightSemantics(String value) {
    return '明るさ $value ルクス';
  }

  @override
  String get illuminance => '明るさ';

  @override
  String get footCandles => 'フートカンデラ';

  @override
  String get lightDark => '暗い';

  @override
  String get lightDim => '薄暗い';

  @override
  String get lightLivingRoom => 'リビング程度の明るさ';

  @override
  String get lightReading => '読書やデスク作業に適した明るさ';

  @override
  String get lightBright => '明るい室内';

  @override
  String get lightOvercast => '曇りの日の屋外';

  @override
  String get lightDaylight => '日中の屋外';

  @override
  String get lightSun => '直射日光';

  @override
  String get lightHelp1 => '照度センサーは画面上部、前面カメラの近くにあります。';

  @override
  String get lightHelp2 => '測りたい場所で、画面を光の方に向けて持ちます。';

  @override
  String get lightHelp3 =>
      '空は明るさに合わせて変わります。暗いと夜、薄暗い部屋では夜明け、明るくなるほど太陽が昇ります。ルクスと、その明るさが何に向いているかを確認してください。300〜750 lx は読書やデスクワークに適しています。';

  @override
  String get lightHelp4 => '「ロック」をタップすると、端末を離しても値を保持できます。';

  @override
  String get lightTip =>
      'スマートフォンの照度センサーは校正されておらず、端末によって値が大きく異なることがあります。同じ端末で同じ場所の明るさを比べるのに使ってください。校正済みの照度計ではありません。画面上部を覆わないでください。';

  @override
  String get noMicrophone =>
      'マイクを使えません。ほかのアプリが使用中かもしれません。そのアプリを閉じてから、騒音計を開き直してください。';

  @override
  String soundSemantics(String value) {
    return '音の大きさ 約 $value デシベル';
  }

  @override
  String get decibelsApprox => 'dB（目安）';

  @override
  String get soundMax => '最大';

  @override
  String get soundVeryQuiet => 'とても静か';

  @override
  String get soundQuiet => '静か（図書館程度）';

  @override
  String get soundModerate => '普通（会話程度）';

  @override
  String get soundLoud => 'うるさい（交通量の多い道路程度）';

  @override
  String get soundVeryLoud => 'とてもうるさい：長時間聞くと聴力を損なうおそれがあります';

  @override
  String get soundDangerous => '危険：耳を守ってください';

  @override
  String get micTitle => 'マイクを許可してください';

  @override
  String get micBody => '騒音計はマイクで音を聞いて大きさを測ります。音は端末内で測るだけで、録音・保存・送信は一切しません。';

  @override
  String get micAllow => 'マイクを許可';

  @override
  String get micDeniedTitle => 'マイクへのアクセスがオフです';

  @override
  String get micDeniedBody =>
      '騒音計を使うには、設定でこのアプリのマイクをオンにしてください。音を録音・保存・送信することはありません。';

  @override
  String get openSettings => '設定を開く';

  @override
  String get tryAgain => 'もう一度試す';

  @override
  String get soundHelp1 => 'マイク（下端）をふさがず、端末を音の方に向けます。';

  @override
  String get soundHelp2 =>
      '大きな数字は約1秒間で平均した現在の音量です。そこから波紋が広がり、音が大きいほど数が増えて遠くまで届きます。静かなときは緑、次に黄、オレンジ、赤、深紅。下のバーは直近3秒間を示します。';

  @override
  String get soundHelp3 => '平均と最大はツールを開いてから数えます。「リセット」で最初からやり直せます。';

  @override
  String get soundHelp4 =>
      '70 dB を超えると状態表示が黄色に、長時間聞くと聴力を損なうおそれのある 85 dB を超えると赤になります。';

  @override
  String get soundHelp5 => '鍵をタップすると、端末を動かしても値を保持できます。';

  @override
  String get soundTip =>
      'スマートフォンのマイクは校正された騒音計ではなく、機種ごとに異なるため、値はおおよそです（多くの場合5〜10 dB 程度のずれ）。非常に大きな音は低めに表示されることがあります。公式な測定には校正された騒音計が必要です。';

  @override
  String get metresFromZero => 'm（ゼロから）';

  @override
  String pressureSemantics(String value) {
    return '気圧 $valueヘクトパスカル';
  }

  @override
  String heightSemantics(String value) {
    return 'ゼロからの高さ $value';
  }

  @override
  String get pressure => '気圧';

  @override
  String get altitudeApprox => '高度（目安）';

  @override
  String get measuringHeight => 'ゼロ点からの高さを測定中';

  @override
  String get airPressureAltitude => '気圧と高度';

  @override
  String get appearance => '外観';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get levelUnits => '水平器の単位';

  @override
  String get unitDegrees => '度';

  @override
  String get unitPercent => '勾配（％）';

  @override
  String get unitRoofPitch => '屋根勾配（12あたりの立ち上がり）';

  @override
  String get vibrateWhenLevel => '振動';

  @override
  String get sounds => 'サウンド';

  @override
  String get resetCalibration => '補正をリセット';

  @override
  String get resetCalibrationHint => 'センサーの工場出荷時のゼロに戻す';

  @override
  String get calibrateHere => 'ここで補正';

  @override
  String get calibrateHereInfo => '水平とわかっている面の上で';

  @override
  String get calibrationRemoved => '補正を削除しました。水平器はセンサーの工場出荷時のゼロに戻りました。';

  @override
  String get resetAllCalibrations => 'すべての補正をリセット';

  @override
  String get resetAllCalibrationsHint => '水平器と定規を工場出荷時の設定に戻します';

  @override
  String get resetAllTitle => 'すべての補正をリセットしますか？';

  @override
  String get resetAllBody =>
      '水平器（角度計でも使用）と定規の補正が削除され、どちらも工場出荷時の設定に戻ります。その他の設定はそのままで、いつでも補正し直せます。';

  @override
  String get notCalibrated => '未補正';

  @override
  String get language => '言語';

  @override
  String get licenses => 'オープンソースライセンス';

  @override
  String get languageSystem => '端末の言語';

  @override
  String get toolHeight => '高さ';

  @override
  String get toolHeightSubtitle => '照準で高さと距離を測る';

  @override
  String get heightHelp1 => '対象の根元と頂上が見える場所に立ちます。画面を上にして持ち、上端に沿って見ます。';

  @override
  String get heightHelp2 => '上端を対象の根元に合わせて「根元を固定」をタップ。これで距離が出ます。';

  @override
  String get heightHelp3 => '上端を頂上に合わせて「頂上を固定」をタップ。高さが表示されます。';

  @override
  String get heightHelp4 =>
      '距離がわかる場合は「距離」をタップして入力し、頂上だけを狙います。「目の高さ」をタップして自分の値を設定できます。';

  @override
  String get heightTip =>
      '平らな地面で目の高さが正しければ約±5%（身長から約10 cm引いた値）。頂上が70°未満、根元が水平より3°以上下になるまで離れてください。斜面では距離を入力してください。';

  @override
  String get lockBase => '根元を固定';

  @override
  String get lockTop => '頂上を固定';

  @override
  String get measureAgain => 'もう一度測る';

  @override
  String get distance => '距離';

  @override
  String get objectHeight => '高さ';

  @override
  String get eyeHeight => '目の高さ';

  @override
  String get sightAngle => '照準角';

  @override
  String get heightAimBase => '上端を根元に合わせる';

  @override
  String get heightAimTop => '次に上端を頂上に合わせる';

  @override
  String get heightDone => '完了 · 「もう一度測る」で次へ';

  @override
  String get heightHoldFlatter => 'スマホをもっと水平にして上端に沿って狙う';

  @override
  String get heightTooFar => '根元が水平に近すぎます：近づくか距離を入力';

  @override
  String get heightStepBack => '急すぎます：離れると安定します';

  @override
  String get knownDistance => '根元までの距離';

  @override
  String get knownDistanceHint => '対象の根元までの地面に沿った距離。消去すると照準で測ります。';

  @override
  String get eyeHeightHint => '地面から目までの高さ：身長から約10 cm引いた値。';

  @override
  String get clear => '消去';

  @override
  String get toolCamera => 'カメラ水平器';

  @override
  String get toolCameraSubtitle => 'カメラ映像に水平線、どんな縁も測定';

  @override
  String get cameraHelp1 => '背面カメラを壁や額縁、棚、ドアに向けます。スマホを立て、壁にまっすぐ向けて持ってください。';

  @override
  String get cameraHelp2 =>
      '実線は重力に従うので、常に正確に水平・垂直です。破線はスマホに固定された線で、その間の小さな弧がスマホの傾きを示します。スマホが水平になると実線がオレンジになります。';

  @override
  String get cameraHelp3 =>
      '物を調べるには「停止」をタップし、2つのオレンジのハンドルを額縁の上辺など物の縁にドラッグします。手が水平でなくても、その縁の傾きと、どちらを上げればよいかが表示されます。垂直な縁を調べるときは線を縦にします。';

  @override
  String get cameraHelp4 =>
      '上の2つのボタンで、スマホの線と実際の線の表示を切り替えます。ライトは暗い場所で役立ち、「再開」でライブ映像に戻ります。';

  @override
  String get cameraTip =>
      '縁を正確に測るには、壁にまっすぐ向け（前後 5° 未満）、レンズによる線の曲がりが最も少ない映像の中央付近で測ってください。水平器の側面キャリブレーションを使います。映像が録画・保存・送信されることはありません。';

  @override
  String get cameraAllowTitle => 'カメラを許可';

  @override
  String get cameraAllowBody =>
      'カメラ水平器はカメラ映像の上に水平線を描き、映像内の縁を測ります。映像はスマホ内にとどまり、録画・保存・送信されることはありません。';

  @override
  String get cameraAllow => 'カメラを許可';

  @override
  String get cameraDeniedTitle => 'カメラへのアクセスがオフです';

  @override
  String get cameraDeniedBody =>
      'カメラ水平器を使うには、設定でこのアプリのカメラをオンにしてください。映像が録画・保存・送信されることはありません。';

  @override
  String get noCamera =>
      'カメラを使えません。別のアプリが使用中か、カメラがありません。ほかのカメラアプリを閉じてから、カメラ水平器を開き直してください。';

  @override
  String get tilt => '傾き';

  @override
  String get forwardBack => '前後';

  @override
  String get cameraLevel => '水平';

  @override
  String cameraTilted(String value) {
    return '$value° 傾き';
  }

  @override
  String get cameraHoldUpright => 'スマホを立て、カメラを壁に向けてください';

  @override
  String get freeze => '停止';

  @override
  String get resume => '再開';

  @override
  String get torch => 'ライト';

  @override
  String cameraSemantics(String value) {
    return '水平線付きのカメラ映像、$value 度の傾き';
  }

  @override
  String get cameraPhoneLines => 'スマホの線';

  @override
  String get cameraTrueLines => '実際の線';

  @override
  String get cameraFrozen => '停止中';

  @override
  String get cameraDragHandles => 'ハンドルを縁にドラッグ';

  @override
  String get cameraFaceWall => '壁にまっすぐ向けてください';

  @override
  String get edgeLevel => 'この縁は水平です';

  @override
  String get edgePlumb => 'この縁は垂直です';

  @override
  String edgeLiftRight(String value) {
    return '縁が $value° 傾き、右を上げる';
  }

  @override
  String edgeLiftLeft(String value) {
    return '縁が $value° 傾き、左を上げる';
  }

  @override
  String edgeOffPlumb(String value) {
    return '縁が垂直から $value° ずれ';
  }

  @override
  String get cameraHandle => '縁のハンドル';

  @override
  String get toolGForce => 'Gメーター';

  @override
  String get toolGForceSubtitle => 'ブレーキ、加速、コーナリングをgで表示';

  @override
  String get gHelp1 =>
      'スマホを車載ホルダーに、画面を自分に向けて固定します。停車中に「ゼロ」をタップすると、下と前の向きを覚えます。';

  @override
  String get gHelp2 =>
      '走行中は、体が押される側の車の部分が光ります。ブレーキで前、加速で後ろ、カーブで外側が光ります。緑は穏やか、オレンジはやや強め、赤は強めです。';

  @override
  String get gHelp3 =>
      'パネルには「ゼロ」以降で最も強い加速、ブレーキ、コーナリングが残り、縁の点は各方向で最も強い力を残します。リセットボタンで消去できます。';

  @override
  String get gHelp4 => '視線は道路から離さないでください。同乗者に読んでもらうか、停車してから最大値を確認しましょう。';

  @override
  String get gTip =>
      '値は加速度センサーによるおおよその値で、ホルダーがしっかり固定され、停車中に「ゼロ」を設定していることが前提です。荒れた路面では少しぶれます。ホルダーが動いたら停車して、もう一度「ゼロ」をタップしてください。一般的な乗用車では、0.5 g を超えると急ブレーキや速いコーナリングです。';

  @override
  String get gZero => 'ゼロ';

  @override
  String get gResetPeaks => '最大値をリセット';

  @override
  String get gSpeedUp => '加速';

  @override
  String get gBrake => 'ブレーキ';

  @override
  String get gCorner => 'コーナー';

  @override
  String get gSteady => '一定';

  @override
  String gBraking(String value) {
    return 'ブレーキ $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return '加速 $value g';
  }

  @override
  String gLeftBend(String value) {
    return '左カーブ $value g';
  }

  @override
  String gRightBend(String value) {
    return '右カーブ $value g';
  }

  @override
  String gSemantics(String value) {
    return 'Gフォース $value g';
  }

  @override
  String get gZeroed => 'ゼロ設定完了：下と前の向きを覚えました';

  @override
  String get noAccelerometerG => 'この端末には加速度センサーがないため、Gを測定できません。ほかのツールは使えます。';

  @override
  String get toolSpeed => 'スピードメーター';

  @override
  String get toolSpeedSubtitle => '速度、走行距離、GPS高度';

  @override
  String get speedHelp1 =>
      '位置情報を許可し、ダッシュボードの上やフロントガラスのホルダーなど、空が見える場所にスマホを置きます。屋外では、最初の測位に数秒かかります。';

  @override
  String get speedHelp2 =>
      'ダッシュボード上のメーターがGPSによる速度を表示し、その両側に走行距離と高度を表示します。パネルには、最後にリセットしてからの距離、最高速度、平均速度が残ります。';

  @override
  String get speedHelp3 =>
      '座標をタップするとコピーできます。単位ボタンで km/h と mph を切り替え、「トリップをリセット」で距離、最高、平均を最初からやり直します。';

  @override
  String get speedHelp4 => '視線は道路から離さないでください。同乗者に読んでもらうか、停車してから走行記録を確認しましょう。';

  @override
  String get speedTip =>
      '速度は衛星から得るもので、開けた道路ではふつう誤差約 1 km/h 以内です。トンネル内、高いビルの間、屋内では遅れたり途切れたりすることがあります。GPSの高度は10から50 mほどずれることがあるので、高さの変化には高度計を使ってください。位置情報はこのツールを開いている間だけ使われ、スマホの外に出ることはありません。';

  @override
  String get speedAllowTitle => '位置情報を許可';

  @override
  String get speedAllowBody =>
      'スピードメーターはGPSで速度、距離、高度を測ります。位置情報はこのツールを画面に開いている間だけ使われ、バックグラウンドでは使われず、スマホの外に出ることはありません。';

  @override
  String get speedAllow => '位置情報を許可';

  @override
  String get speedDeniedTitle => '位置情報へのアクセスがオフです';

  @override
  String get speedDeniedBody =>
      'スピードメーターを使うには、設定でこのアプリの位置情報をオンにしてください。位置情報はツールを開いている間だけ使われ、スマホの外に出ることはありません。';

  @override
  String get speedServiceOffTitle => '位置情報がオフです';

  @override
  String get speedServiceOffBody => 'スピードメーターを使うには、スマホの設定で位置情報をオンにしてください。';

  @override
  String get speedDistance => '距離';

  @override
  String get speedTop => '最高';

  @override
  String get speedAverage => '平均';

  @override
  String get speedTrip => 'トリップ';

  @override
  String get speedAltitude => '高度';

  @override
  String get speedResetTrip => 'トリップをリセット';

  @override
  String get speedFinding => '衛星を探しています…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value m';
  }

  @override
  String get speedWeak => 'GPSが弱いため、速度が遅れることがあります';

  @override
  String get speedApproximate => '正確な位置情報がオフです。オンにすると速度が安定します';

  @override
  String get speedStill => '停止中';

  @override
  String get speedCopied => '座標をコピーしました';

  @override
  String get speedUnitTooltip => 'km/h と mph を切り替え';

  @override
  String get speedKmh => 'km/h';

  @override
  String get speedMph => 'mph';

  @override
  String speedSemantics(String value) {
    return '速度 $value';
  }

  @override
  String get speedCoordinates => '座標（タップでコピー）';

  @override
  String get noGps => 'この端末にはGPSがないため、速度を測れません。ほかのツールは使えます。';

  @override
  String get speedSceneHelp =>
      '空は時刻に合わせて変わります。天気ボタンで景色を選べます。「自動」は季節に合わせ、晴れ、くもり、雨、嵐、雪も選べます。景色であって、天気予報ではありません。';

  @override
  String get supportTitle => '無料、広告なし';

  @override
  String get supportBody => '一人の開発者が空き時間に作っています。お役に立てたら、応援していただけると嬉しいです。';

  @override
  String get supportButton => 'GitHubで応援する';

  @override
  String get linkCopied => 'リンクをコピーしました';

  @override
  String madeBy(String name) {
    return 'デザイン・開発：$name';
  }

  @override
  String testFeedbackTitle(String app) {
    return '$appをより良くするためにご協力ください';
  }

  @override
  String get testFeedbackBody => '問題やアイデアがあればお知らせください。すべてのメッセージに目を通しています。';

  @override
  String get testEmailMe => 'メールを送る';

  @override
  String testEmailSubject(String app) {
    return '$appへのフィードバック';
  }

  @override
  String get testEmailCopied => 'メールアドレスをコピーしました';

  @override
  String get testEndedTitle => 'このテスト版は終了しました';

  @override
  String get testEndedBody =>
      'テストにご協力いただきありがとうございます。新しいバージョンをご利用ください。入手するには、こちらへご連絡ください：';

  @override
  String get toolTracker => 'トラッカー検出';

  @override
  String get toolTrackerSubtitle => 'あなたを追う隠れたトラッカー';

  @override
  String get sensorBluetooth => 'Bluetooth';

  @override
  String get trackerHelp1 =>
      '「ここでスキャン」をタップすると、持ち主から離れた近くのBluetoothトラッカー（AirTag、Galaxy SmartTag、Tile、Chipolo、Find Hubタグ）が表示されます。';

  @override
  String get trackerHelp2 =>
      '追跡されているか調べるには「移動しながら確認」をタップし、歩くときや運転中もこのツールを開いたままにします（画面はオンのまま）。30分以上のあいだに3か所で検出されたトラッカーは、あなたと一緒に移動しています。';

  @override
  String get trackerHelp3 =>
      'トラッカーをタップすると探せます。ゆっくり歩き、数字が上がる方へ進みます。「すべて表示」で自分のトラッカーを「自分のもの」にすると、今後は表示されません。';

  @override
  String get trackerHelp4 =>
      'SIMカード入りのGPS端末はどのスマホでも検出できません。「車のチェック」をタップしてください。多くは強い磁石で取り付けられており、金属探知機で見つけられます。';

  @override
  String get trackerTip =>
      '開いている間だけ検出し、すべてのトラッカーを検出できるわけではありません。家族のものや同じ電車の他人のものが表示されることもあり、持ち主のそばにあるものは表示されません。追跡されていると思ったら、警察や相談窓口に連絡してください。';

  @override
  String get trackerAllowTitle => 'Bluetoothスキャンを許可';

  @override
  String get trackerAllowBody =>
      'トラッカー検出は近くのBluetoothトラッカーを検出します。このツールを開いている間だけ動き、トラッカーには接続せず、検出した内容がスマホの外に出ることはありません。';

  @override
  String get trackerAllow => 'Bluetoothを許可';

  @override
  String get trackerDeniedTitle => 'Bluetoothスキャンがオフです';

  @override
  String get trackerDeniedBody => 'トラッカー検出を使うには、設定でこのアプリに「付近のデバイス」を許可してください。';

  @override
  String get trackerBluetoothOffTitle => 'Bluetoothがオフです';

  @override
  String get trackerBluetoothOffBody =>
      'トラッカーを検出するにはBluetoothをオンにしてください。アプリが何かに接続することはありません。';

  @override
  String get trackerLocationOffTitle => '位置情報がオフです';

  @override
  String get trackerLocationOffBody =>
      'このAndroidバージョンでは、位置情報がオンのときだけBluetoothスキャンが動きます。位置の特定には使いません。';

  @override
  String get trackerScanHere => 'ここでスキャン';

  @override
  String get trackerCheckMoving => '移動しながら確認';

  @override
  String get trackerStop => '停止';

  @override
  String get trackerDone => '完了';

  @override
  String get trackerLocationNeeded => '「移動しながら確認」はGPSで場所を記録します。位置情報を許可してください。';

  @override
  String get trackerSimNote => 'SIM入りGPS端末は検出できません';

  @override
  String get trackerCarCheck => '車のチェック';

  @override
  String get carCheckBody =>
      '車に隠されたSIMカード入りのGPS端末もあります。どのスマホでも検出できませんが、多くは強い磁石で取り付けられていて、金属探知機で見つけられます。';

  @override
  String get carSpot1 => '前後のバンパーの下';

  @override
  String get carSpot2 => 'タイヤハウスの内側';

  @override
  String get carSpot3 => 'シートの下とトランクの中';

  @override
  String get carSpot4 => 'ダッシュボード下の診断（OBD）ポートの裏';

  @override
  String get carCheckTip =>
      'スマホの上端を各場所の上でゆっくり動かします。数値が急に上がれば金属か磁石があります。よく見てください。';

  @override
  String get carOpenMetal => '金属探知機を開く';

  @override
  String get trackerPaused => 'アプリが非表示の間は一時停止中';

  @override
  String trackerFollowingBanner(String name, int places) {
    return '$nameがあなたと一緒に移動しています（$placesか所で検出）';
  }

  @override
  String trackerMoving(int minutes, int places) {
    return '$minutes分間確認中。通過した場所：$places';
  }

  @override
  String get trackerListening => 'トラッカーを検出中';

  @override
  String get trackerNothingHeard => 'ここでは持ち主から離れたトラッカーは検出されません';

  @override
  String get trackerIdle => 'スキャンして近くのトラッカーを表示';

  @override
  String trackerSemantics(int following, int nearby) {
    return '追跡中：$following。近くのトラッカー：$nearby。';
  }

  @override
  String trackerShowAll(int count) {
    return 'すべて表示（$count）';
  }

  @override
  String trackerAllTitle(int count) {
    return '近くのトラッカー：$count';
  }

  @override
  String get trackerKindFindMy => '「探す」タグ';

  @override
  String get trackerKindFindHub => 'Find Hubタグ';

  @override
  String get trackerKindDult => '持ち物トラッカー';

  @override
  String get trackerClose => '近い';

  @override
  String get trackerNear => '中くらい';

  @override
  String get trackerFar => '遠い';

  @override
  String trackerFollowingYou(int places) {
    return '追跡中 · 場所：$places';
  }

  @override
  String trackerPlaces(int count) {
    return '$countか所で検出';
  }

  @override
  String get trackerMine => '自分のもの';

  @override
  String get trackerNotMine => '自分のものではない';

  @override
  String get trackerFollowingLabel => '追跡中';

  @override
  String trackerNearby(int count) {
    return '近く：$count';
  }

  @override
  String trackerFindTitle(String name) {
    return '$nameを探す';
  }

  @override
  String get trackerFindHint =>
      '車やバッグの周りをゆっくり歩き、数字が上がる方へ進みます。信号でわかるのは距離だけで、方向はわかりません。';

  @override
  String get trackerFindLost => '検出なし：ゆっくり動いてください';

  @override
  String get findFar => '遠い';

  @override
  String get findCloser => '近づいている';

  @override
  String get findNear => '近い';

  @override
  String get findHere => 'すぐここ';

  @override
  String get trackerAppleSound =>
      'Appleの「探す」アプリ、またはAndroidのTracker Detectアプリで、AirTagの音を鳴らせます。';
}
