// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Su Terazisi ve Açı Ölçer';

  @override
  String get homeTitle => 'Su Terazisi';

  @override
  String get settings => 'Ayarlar';

  @override
  String get tools => 'Araçlar';

  @override
  String get listView => 'Liste görünümü';

  @override
  String get gridView => 'Izgara görünümü';

  @override
  String get back => 'Geri';

  @override
  String get lightMode => 'Açık mod';

  @override
  String get darkMode => 'Koyu mod';

  @override
  String get toolLevel => 'Su terazisi';

  @override
  String get toolLevelSubtitle => 'Kabarcıklı ve tüplü su terazisi';

  @override
  String get toolAngle => 'Açı';

  @override
  String get toolAngleSubtitle => 'Yataydan veya sıfır noktanızdan açı';

  @override
  String get toolCompass => 'Pusula';

  @override
  String get toolCompassSubtitle => 'Yön ve rota';

  @override
  String get toolProtractor => 'İletki';

  @override
  String get toolProtractorSubtitle => 'Ekranda açı ölçün';

  @override
  String get toolRuler => 'Cetvel';

  @override
  String get toolRulerSubtitle => 'Ekranda uzunluk ölçün';

  @override
  String get toolMetal => 'Metal dedektörü';

  @override
  String get toolMetalSubtitle => 'Demir, çelik ve mıknatıs bulun';

  @override
  String get toolVibration => 'Titreşim';

  @override
  String get toolVibrationSubtitle => 'Canlı grafikli titreşim ölçer';

  @override
  String get toolSound => 'Ses ölçer';

  @override
  String get toolSoundSubtitle => 'Desibel cinsinden gürültü';

  @override
  String get toolAltimeter => 'Altimetre';

  @override
  String get toolAltimeterSubtitle => 'Hava basıncı ve yükseklik';

  @override
  String get toolLight => 'Işık ölçer';

  @override
  String get toolLightSubtitle => 'Lüks cinsinden parlaklık';

  @override
  String get notAvailableOnPhone => 'Bu telefonda kullanılamaz';

  @override
  String get notOnPhone => 'Kullanılamaz';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, bu telefonda kullanılamaz';
  }

  @override
  String get howToUse => 'Nasıl kullanılır';

  @override
  String get rotateLandscape => 'Yataya çevir';

  @override
  String get rotatePortrait => 'Dikeye çevir';

  @override
  String howToUseTool(String tool) {
    return 'Nasıl kullanılır: $tool';
  }

  @override
  String get gotIt => 'Anladım';

  @override
  String get goodToKnow => 'Bilmekte fayda var: ';

  @override
  String get ok => 'Tamam';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool kullanılamıyor';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sensörlere',
      one: 'bir sensöre',
    );
    return '$tool, bu telefonda olmayan $_temp0 ihtiyaç duyuyor: $sensors.';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'Bu, telefonun donanımından kaynaklanan bir sınır, uygulamanın hatası değil. Diğer tüm araçlar normal çalışır.';

  @override
  String get sensorAccelerometer => 'ivmeölçer';

  @override
  String get sensorMagnetometer => 'manyetometre (pusula sensörü)';

  @override
  String get sensorBarometer => 'barometre (hava basıncı sensörü)';

  @override
  String get sensorLight => 'ışık sensörü';

  @override
  String get sensorMicrophone => 'mikrofon';

  @override
  String get noAccelerometer =>
      'Bu telefonda ivmeölçer yok, bu yüzden bu araç burada ölçüm yapamaz. Ona ihtiyaç duymayan araçlar çalışmaya devam eder.';

  @override
  String get noMagnetometer =>
      'Bu telefonda manyetometre (pusula sensörü) yok, bu yüzden bu araç burada çalışamaz. Ona ihtiyaç duymayan araçlar çalışmaya devam eder.';

  @override
  String get noReadings =>
      'Sensörden henüz veri gelmedi. Geri dönüp aracı yeniden açın; tekrar ederse telefonu yeniden başlatın. Bazı telefonlar bu aracı desteklemez.';

  @override
  String get waitingForSensors => 'Sensörler bekleniyor…';

  @override
  String get levelHelp1 =>
      'Telefonu yüzeye düz yatırın veya kenarlarından birinin üzerine koyun.';

  @override
  String get levelHelp2 =>
      'Düz: kabarcığı ortalayın. X sol/sağ, Y ön/arka eğimdir. Kenar üzerindeyken açıyı ve eğimi görürsünüz.';

  @override
  String get levelHelp3 =>
      'Ekrandaki ipucunu (örneğin \"Sağ taraf yüksek\") \"Düz\" yazana kadar izleyin: değer turuncu olur, telefon ses çıkarır ve titrer (Ayarlar\'dan kapatılabilir).';

  @override
  String get levelHelp4 =>
      'Değeri dondurmak için Kilitle\'ye, yeniden canlı ölçmek için Kilidi aç\'a dokunun.';

  @override
  String get levelHelp5 =>
      'Klasik su terazisini mi tercih edersiniz? Seçicideki tüp simgesine dokunun; yuvarlak simge kadranı geri getirir.';

  @override
  String get levelTip =>
      'Düz olduğunu bildiğiniz bir yüzey 0° göstermiyorsa telefonu üzerine koyup Kalibre et\'e dokunun. Geri almak için Kalibre et\'e yeniden dokunup Kalibrasyonu sıfırla\'yı seçin.';

  @override
  String get statusLevel => 'Düz';

  @override
  String get leftEndLow => 'Sol uç alçak';

  @override
  String get rightEndLow => 'Sağ uç alçak';

  @override
  String get rightSideHigh => 'Sağ taraf yüksek';

  @override
  String get leftSideHigh => 'Sol taraf yüksek';

  @override
  String get topEdgeHigh => 'Üst kenar yüksek';

  @override
  String get bottomEdgeHigh => 'Alt kenar yüksek';

  @override
  String get calibrated => 'Kalibre edildi. Bu konum artık 0° gösteriyor.';

  @override
  String get tooFarToCalibrate =>
      'Kalibrasyon için fazla eğik. Önce telefonu düz bir yüzeye koyun.';

  @override
  String get dialView => 'Kadran görünümü';

  @override
  String get tubeView => 'Tüp görünümü';

  @override
  String get levelTube => 'Terazi tüpü';

  @override
  String get leftRightTube => 'Sol ve sağ tüp';

  @override
  String get forwardBackTube => 'Ön ve arka tüp';

  @override
  String tiltFromLevel(String value) {
    return 'Yataydan eğim $value';
  }

  @override
  String fromLevel(String value) {
    return 'Yataydan sapma $value';
  }

  @override
  String get xLeftRight => 'X · sol / sağ';

  @override
  String get yForwardBack => 'Y · ön / arka';

  @override
  String get angle => 'Açı';

  @override
  String get slope => 'Eğim';

  @override
  String get lock => 'Kilitle';

  @override
  String get unlock => 'Kilidi aç';

  @override
  String locked(String status) {
    return 'Kilitli · $status';
  }

  @override
  String get lockReading => 'Değeri kilitle';

  @override
  String get lockHandles => 'Tutamaçları kilitle';

  @override
  String get handlesLocked =>
      'Tutamaçlar kilitli · ayarlamak için kilide dokunun';

  @override
  String get calibrate => 'Kalibre et';

  @override
  String get angleHelp1 =>
      'Kadran, telefonun düz konumdan ne kadar eğildiğini gösterir: düz 0°, dik 90°.';

  @override
  String get angleHelp2 =>
      'Bir değişimi ölçmek için telefonu başlangıç konumunda tutun ve Sıfırı buraya al\'a dokunun.';

  @override
  String get angleHelp3 =>
      'Telefonu eğin veya hareket ettirin. Kadran, sıfır noktanızdan kaç derece hareket ettiğini gösterir.';

  @override
  String get angleHelp4 =>
      'Düz konuma göre açıya dönmek için Sıfırı temizle\'ye dokunun.';

  @override
  String get angleHelp5 =>
      'Göremediğiniz bir açıyı okumak için telefonu nesneye dayayın, kilide dokunun, sonra kaldırıp okuyun.';

  @override
  String get angleTip =>
      'Açısını ölçmek için telefonu tahta, kapı veya rampa gibi bir nesneye düz bastırın.';

  @override
  String movedFromZero(String value) {
    return 'Sıfırdan sapma $value';
  }

  @override
  String get measuringFromZero => 'Sıfır noktanızdan ölçülüyor';

  @override
  String get angleFromEarth => 'Dünya\'ya göre açı';

  @override
  String get clearZero => 'Sıfırı temizle';

  @override
  String get setZeroHere => 'Sıfırı buraya al';

  @override
  String get compassHelp1 =>
      'Telefonu önünüzde yatay tutun; metal, mıknatıs ve elektronik cihazlardan uzak durun.';

  @override
  String get compassHelp2 =>
      'Telefonun üst kısmını öğrenmek istediğiniz yöne çevirin.';

  @override
  String get compassHelp3 =>
      'Sayı derece cinsinden yönünüz, harfler ise yöndür. Turuncu top bunu halkada işaretler.';

  @override
  String get compassTip =>
      'Manyetik kuzeyi gösterir; bu, harita kuzeyinden birkaç derece farklı olabilir. Yanlış görünüyorsa telefonu birkaç kez 8 çizerek hareket ettirin.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Manyetik yön $heading derece, $direction';
  }

  @override
  String get magneticInterference => 'Manyetik parazit · metalden uzaklaşın';

  @override
  String get dirN => 'K';

  @override
  String get dirNE => 'KD';

  @override
  String get dirE => 'D';

  @override
  String get dirSE => 'GD';

  @override
  String get dirS => 'G';

  @override
  String get dirSW => 'GB';

  @override
  String get dirW => 'B';

  @override
  String get dirNW => 'KB';

  @override
  String get protractorHelp1 =>
      'Telefonu düz koyun ve nesneyi köşesi ortada olacak şekilde ekrana yerleştirin.';

  @override
  String get protractorHelp2 =>
      'Her turuncu tutamacı, çizgisi açının bir kenarı boyunca uzanacak şekilde sürükleyin.';

  @override
  String get protractorHelp3 =>
      'Açıyı ortada okuyun. Yansıma açı diğer taraftır (360° eksi açı).';

  @override
  String get protractorHelp4 => 'Baştan başlamak için Sıfırla\'ya dokunun.';

  @override
  String get protractorHelp5 =>
      'Nesneyi hareket ettirirken tutamaçların yerinde kalması için kilide dokunun.';

  @override
  String armsSemantics(String value) {
    return 'Kollar arasındaki açı $value';
  }

  @override
  String get reflex => 'Yansıma açı';

  @override
  String get dragHandles => 'Turuncu tutamaçları kenarlar boyunca sürükleyin';

  @override
  String get reset => 'Sıfırla';

  @override
  String get rulerHelp1 =>
      'Nesneyi ekrana koyun veya telefonu nesneye dayayın.';

  @override
  String get rulerHelp2 =>
      'Turuncu çizgileri nesnenin iki ucuna sürükleyin. Birimi seçmek için mm, cm veya in’e dokunun; diğer sistem altta görünür.';

  @override
  String get rulerHelp3 =>
      'En iyi doğruluk için bir kez Kalibre et\'e dokunun ve bir kart, cetvel ya da ekran boyutunu kullanın.';

  @override
  String get rulerHelp4 =>
      'Nesneyi hareket ettirirken çizgilerin yerinde kalması için kilide dokunun.';

  @override
  String get rulerTip =>
      'Ekranın uzunluğu kadar ölçer. Kılıflar ve kavisli kenarlar ilk milimetreleri gizler; telefonun kenarından değil, çizgiler arasında ölçün.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'Uzunluk $mm milimetre, $inches inç';
  }

  @override
  String get rulerCalibrated => 'Kartla kalibre edildi · ±0,5 mm';

  @override
  String get rulerReported =>
      'Ekran boyutu telefondan · ±0,5 mm için kalibre edin';

  @override
  String get unitMillimetres => 'Milimetre';

  @override
  String get unitCentimetres => 'Santimetre';

  @override
  String get unitInches => 'İnç';

  @override
  String get rulerEstimated => 'Kalibre edilmedi · ölçüler %10 sapabilir';

  @override
  String get calibrateCard => 'Kalibre et';

  @override
  String get cardLongEdge =>
      'Bir banka veya kimlik kartını uzun kenarı cetvel boyunca, bir ucu koyu çizgide olacak şekilde ekrana koyun. Turuncu çizgiyi kartın diğer ucuna sürükleyin.';

  @override
  String get cardShortEdge =>
      'Bir banka veya kimlik kartını kısa kenarı cetvel boyunca, bir ucu koyu çizgide olacak şekilde ekrana koyun. Turuncu çizgiyi kartın diğer ucuna sürükleyin.';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get usePhoneDefault => 'Telefonun ekran boyutunu kullan';

  @override
  String get usePhoneDefaultInfo => 'Bu kalibrasyonu unut';

  @override
  String get cardMismatch =>
      'Bu bir kartla uyuşmuyor. Kartı koyu çizgiyle hizalayıp yeniden deneyin.';

  @override
  String get rotateToCalibrate => 'Kalibrasyon için telefonu dik çevirin';

  @override
  String get calibrateHow => 'Kalibrasyon yöntemi';

  @override
  String get methodCard => 'Banka kartı';

  @override
  String get methodCardInfo => 'Herhangi bir banka veya kimlik kartı · ±0,5 mm';

  @override
  String get methodRuler => 'Cetvel';

  @override
  String get methodRulerInfo => 'En doğrusu · cetvel veya şerit metre';

  @override
  String get methodScreen => 'Ekran boyutu';

  @override
  String get methodScreenInfo => 'Hiçbir şey gerekmez · yaklaşık %1';

  @override
  String rulerInstructions(String mark) {
    return 'Cetveli 0\'ı koyu çizgide olacak şekilde ekrana koyun. Turuncu çizgiyi $mark işaretine sürükleyin.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'Bu, $mark ile eşleşmiyor. Cetvelin 0\'ını koyu çizgiye koyup tekrar deneyin.';
  }

  @override
  String get screenSizeInstructions =>
      'Telefonun teknik özelliklerindeki ekran boyutunu inç olarak yazın. Bilmiyor musunuz? Modelinizi ve “ekran boyutu”nu arayın.';

  @override
  String get screenSizeMismatch =>
      'Bu boyut bu ekrana uymuyor. Teknik özellikleri kontrol edip tekrar deneyin.';

  @override
  String get rulerCalibratedRuler => 'Cetvelle kalibre edildi · ±0,5 mm';

  @override
  String rulerCalibratedScreen(String size) {
    return '$size inç ekrana ayarlandı · yaklaşık %1';
  }

  @override
  String get metalHelp1 =>
      'Aracı metalden uzakta açın. İlk okuma \"metal yok\" sayılır.';

  @override
  String get metalHelp2 =>
      'Telefonu alanın üzerinde yavaşça gezdirin. Sensör genellikle telefonun üst kısmındadır. Metale yaklaştıkça bip sesi hızlanır; sesi kapatmak için hoparlöre dokunun.';

  @override
  String get metalHelp3 =>
      '\"Yakında metal var\" küçük bir değişim, \"Metal bulundu\" güçlü bir değişim demektir: orta kısım turuncu olur ve titreşim açıksa telefon titrer.';

  @override
  String get metalHelp4 =>
      'Birkaç saniye sabit tutulunca kendini sıfırlar ve yanlış bir okuma kaybolur. Bir noktayı yeniden kontrol etmek için telefonu uzaklaştırıp geri getirin. Referansı ayarla hemen sıfırlar.';

  @override
  String get metalTip =>
      'Yalnızca demir, çelik ve mıknatısları algılar; alüminyum, bakır, altın veya gümüşü algılamaz. Mıknatıslı telefon kılıfları onu etkiler.';

  @override
  String metalSemantics(int value) {
    return 'Manyetik alan $value mikrotesla';
  }

  @override
  String get noMetal => 'Yakında metal yok';

  @override
  String get metalNearby => 'Yakında metal var';

  @override
  String get metalDetected => 'Metal bulundu';

  @override
  String get field => 'Alan';

  @override
  String get change => 'Değişim';

  @override
  String get findsIronSteel => 'Demir, çelik ve mıknatıs bulur';

  @override
  String get setBaseline => 'Referansı ayarla';

  @override
  String get muteSound => 'Sesi kapat';

  @override
  String get turnSoundOn => 'Sesi aç';

  @override
  String get vibrationHelp1 =>
      'Telefonu kontrol etmek istediğiniz yüzeye veya makineye düz koyun ve elinizi çekin.';

  @override
  String get vibrationHelp2 =>
      'Kadran, şu anki titreşimi m/s² cinsinden gösterir. Grafik son birkaç saniyeyi gösterir.';

  @override
  String get vibrationHelp3 =>
      'Tepe en güçlü andır. Ortalama, son bir saniyedeki seviyedir.';

  @override
  String get vibrationHelp4 =>
      'Her yeni testten önce Tepeyi sıfırla\'ya dokunun.';

  @override
  String get vibrationTip =>
      '\"Sabit\" 0,3 m/s² altı, \"Güçlü titreşim\" 2 m/s² üstüdür. Değerleri karşılaştırma için kullanın; telefon sensörleri laboratuvar cihazı değildir.';

  @override
  String get still => 'Sabit';

  @override
  String get lightVibration => 'Hafif titreşim';

  @override
  String get strongVibration => 'Güçlü titreşim';

  @override
  String get noAccelerometerVibration =>
      'Bu telefonda ivmeölçer yok, bu yüzden burada titreşim ölçülemez. Ona ihtiyaç duymayan araçlar çalışmaya devam eder.';

  @override
  String vibrationSemantics(String value) {
    return 'Titreşim saniye kare başına $value metre';
  }

  @override
  String get peak => 'Tepe';

  @override
  String get average => 'Ortalama';

  @override
  String get resetPeak => 'Tepeyi sıfırla';

  @override
  String get vibrationGraph => 'Titreşim grafiği';

  @override
  String get altimeterHelp1 =>
      'Kadran hava basıncını hPa cinsinden gösterir; yükseklik buradan tahmin edilir.';

  @override
  String get altimeterHelp2 =>
      'Merdiven veya kat gibi bir yükseklik farkını ölçmek için başladığınız yerde Sıfırı buraya al\'a dokunun.';

  @override
  String get altimeterHelp3 =>
      'Yukarı veya aşağı gidin. Orta kısım sıfır noktanızdan metreyi gösterir.';

  @override
  String get altimeterHelp4 => 'Geri dönmek için Sıfırı temizle\'ye dokunun.';

  @override
  String get altimeterTip =>
      'Hava durumu basıncı değiştirir, bu yüzden yükseklik onlarca metre sapabilir. Sıfır noktanızdan yükseklik kısa sürelerde doğrudur. Bu araç barometreli bir telefon gerektirir.';

  @override
  String get barometerIos =>
      'Barometre okunamıyor. Ayarlar › Gizlilik ve Güvenlik bölümünden bu uygulama için Hareket ve Fitness\'ı açın, ardından Altimetre\'yi yeniden açın.';

  @override
  String get noBarometer =>
      'Bu telefonda barometre (hava basıncı sensörü) yok, bu yüzden altimetre burada çalışamaz. Diğer araçlar çalışmaya devam eder.';

  @override
  String get noLightSensor =>
      'Bu telefonda ışık sensörü yok, bu yüzden ışık ölçer burada çalışamaz. Diğer araçlar çalışmaya devam eder.';

  @override
  String lightSemantics(String value) {
    return 'Parlaklık $value lüks';
  }

  @override
  String get illuminance => 'Parlaklık';

  @override
  String get footCandles => 'Foot-candle';

  @override
  String get lightDark => 'Karanlık';

  @override
  String get lightDim => 'Loş ışık';

  @override
  String get lightLivingRoom => 'Oturma odası ışığı';

  @override
  String get lightReading => 'Okumak ve masa başı çalışmak için iyi';

  @override
  String get lightBright => 'Parlak iç mekân ışığı';

  @override
  String get lightOvercast => 'Bulutlu gün ışığı';

  @override
  String get lightDaylight => 'Gün ışığı';

  @override
  String get lightSun => 'Doğrudan güneş ışığı';

  @override
  String get lightHelp1 =>
      'Işık sensörü ekranın üstünde, ön kameranın yanındadır.';

  @override
  String get lightHelp2 =>
      'Telefonu ölçmek istediğiniz yerde, ekranı ışığa dönük tutun.';

  @override
  String get lightHelp3 =>
      'Lüks değerini ve ışığın neye uygun olduğunu okuyun: 300–500 lx okumak ve masa başı çalışmak için uygundur.';

  @override
  String get lightHelp4 =>
      'Telefonu uzaklaştırırken bir okumayı tutmak için Kilitle’ye dokunun.';

  @override
  String get lightTip =>
      'Işık sensörleri telefona göre değişir, bu yüzden okumalar %10–20 sapabilir: yerleri karşılaştırmak için iyidir, kalibre edilmiş bir lüksmetre değildir. Ekranın üstünü kapatmayın.';

  @override
  String get noMicrophone =>
      'Mikrofon kullanılamıyor. Başka bir uygulama kullanıyor olabilir: o uygulamayı kapatıp ses ölçeri yeniden açın.';

  @override
  String soundSemantics(String value) {
    return 'Ses seviyesi yaklaşık $value desibel';
  }

  @override
  String get decibelsApprox => 'dB (yakl.)';

  @override
  String get soundAverage => 'Ortalama';

  @override
  String get soundMax => 'Maks.';

  @override
  String get soundVeryQuiet => 'Çok sessiz';

  @override
  String get soundQuiet => 'Sessiz, kütüphane gibi';

  @override
  String get soundModerate => 'Orta, sohbet gibi';

  @override
  String get soundLoud => 'Yüksek, yoğun trafik gibi';

  @override
  String get soundVeryLoud =>
      'Çok yüksek: uzun süre maruz kalmak işitmeye zarar verebilir';

  @override
  String get soundDangerous => 'Tehlikeli: kulaklarınızı koruyun';

  @override
  String get micTitle => 'Mikrofona izin verin';

  @override
  String get micBody =>
      'Ses ölçer, ne kadar gürültü olduğunu ölçmek için mikrofonu dinler. Ses telefonunuzda ölçülür; asla kaydedilmez, saklanmaz veya gönderilmez.';

  @override
  String get micAllow => 'Mikrofona izin ver';

  @override
  String get micDeniedTitle => 'Mikrofon erişimi kapalı';

  @override
  String get micDeniedBody =>
      'Ses ölçeri kullanmak için Ayarlar’da bu uygulamaya mikrofon izni verin. Ses asla kaydedilmez, saklanmaz veya gönderilmez.';

  @override
  String get openSettings => 'Ayarları aç';

  @override
  String get tryAgain => 'Tekrar dene';

  @override
  String get soundHelp1 =>
      'Mikrofonu (alt kenarda) açık bırakın ve telefonu sese doğru tutun.';

  @override
  String get soundHelp2 =>
      'Büyük sayı, yaklaşık bir saniyenin ortalaması olan şu anki seviyedir.';

  @override
  String get soundHelp3 =>
      'Ortalama ve Maks., aracı açtığınızdan beri sayılır. Yeniden başlatmak için Sıfırla’ya dokunun.';

  @override
  String get soundHelp4 =>
      '85 dB’den itibaren uzun süre maruz kalmak işitmeye zarar verebilir: durum satırı sarıya döner.';

  @override
  String get soundTip =>
      'Telefon mikrofonları farklıdır, bu yüzden okumalar yaklaşık 5 dB sapabilir: karşılaştırma için iyidir, sertifikalı bir ses ölçer değildir. Çok yüksek sesler (yaklaşık 110 dB üstü) düşük okunabilir.';

  @override
  String get metresFromZero => 'm sıfırdan';

  @override
  String pressureSemantics(String value) {
    return 'Hava basıncı $value hektopaskal';
  }

  @override
  String heightSemantics(String value) {
    return 'Sıfırdan yükseklik $value';
  }

  @override
  String get pressure => 'Basınç';

  @override
  String get altitudeApprox => 'Yükseklik (yakl.)';

  @override
  String get measuringHeight => 'Yükseklik sıfır noktanızdan ölçülüyor';

  @override
  String get airPressureAltitude => 'Hava basıncı ve yükseklik';

  @override
  String get appearance => 'Görünüm';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get levelUnits => 'Terazi birimi';

  @override
  String get vibrateWhenLevel => 'Düz olunca titret';

  @override
  String get sounds => 'Sesler';

  @override
  String get resetCalibration => 'Kalibrasyonu sıfırla';

  @override
  String get resetCalibrationHint => 'Sensörün fabrika sıfırını yeniden kullan';

  @override
  String get calibrateHere => 'Burada kalibre et';

  @override
  String get calibrateHereInfo => 'Düz olduğunu bildiğiniz bir yüzeyde';

  @override
  String get calibrationRemoved =>
      'Kalibrasyon kaldırıldı. Su terazisi yeniden sensörün fabrika sıfırını kullanıyor.';

  @override
  String get resetAllCalibrations => 'Tüm kalibrasyonları sıfırla';

  @override
  String get resetAllCalibrationsHint =>
      'Su terazisi ve cetvel fabrika ayarlarına döner';

  @override
  String get resetAllTitle => 'Tüm kalibrasyonlar sıfırlansın mı?';

  @override
  String get resetAllBody =>
      'Su terazisinde ayarladığınız sıfır ve cetvelde ayarladığınız ekran boyutu kaldırılır. İkisi de fabrika ayarlarına döner. Diğer ayarlarınız olduğu gibi kalır ve istediğiniz zaman yeniden kalibre edebilirsiniz.';

  @override
  String get notCalibrated => 'Kalibre edilmedi';

  @override
  String get language => 'Dil';

  @override
  String get languageSystem => 'Telefonun dili';
}
