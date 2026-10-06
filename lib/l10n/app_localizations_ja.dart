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
  String get tools => 'ツール';

  @override
  String get listView => 'リスト表示';

  @override
  String get gridView => 'グリッド表示';

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
  String get toolVibrationSubtitle => 'リアルタイムグラフ付き振動計';

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
      '磁北を指すため、地図の北と数度ずれることがあります。おかしい場合は端末を8の字に数回動かしてください。';

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
      '「近くに金属」は小さな変化、「金属を検出」は大きな変化です。中央がオレンジになり、振動がオンなら端末が振動します。';

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
  String get vibrationHelp1 => '調べたい面や機械の上に端末を平らに置き、手を離します。';

  @override
  String get vibrationHelp2 =>
      '数字は現在の振動（m/s²）です。針が6秒ごとに一周し、数字の周りに波として描きます。静止時は緑、軽い振動はオレンジ、強い振動は赤。小さな刻みはピークを示します。';

  @override
  String get vibrationHelp3 => '最大は最も強かった瞬間、平均は直近1秒の値です。';

  @override
  String get vibrationHelp4 => '新しく測る前に「最大をリセット」をタップします。';

  @override
  String get vibrationTip =>
      '「静止」は0.3 m/s²未満、「強い振動」は2 m/s²超です。比較の目安としてお使いください。端末のセンサーは計測機器ではありません。';

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
  String get peak => '最大';

  @override
  String get average => '平均';

  @override
  String get resetPeak => '最大をリセット';

  @override
  String get altimeterHelp1 => '目盛りは気圧をhPaで示し、そこから高度を推定します。';

  @override
  String get altimeterHelp2 => '階段や階など高さの変化を測るには、開始地点で「ここをゼロに」をタップします。';

  @override
  String get altimeterHelp3 => '上がったり下がったりすると、中央にゼロ点からのメートル数が表示されます。';

  @override
  String get altimeterHelp4 => '「ゼロを解除」で元に戻ります。';

  @override
  String get altimeterTip =>
      '天気で気圧が変わるため、高度は数十メートルずれることがあります。ゼロ点からの高さは短時間なら正確です。このツールには気圧センサー付きの端末が必要です。';

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
      '照度センサーは端末ごとに異なるため、10–20% ずれることがあります。場所の比較には便利ですが、校正済みの照度計ではありません。画面上部を覆わないでください。';

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
      'スマートフォンのマイクは機種ごとに異なるため、5 dB ほどずれることがあります。比較には便利ですが、認定された騒音計ではありません。非常に大きな音（約110 dB 以上）は低めに表示されることがあります。';

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
}
