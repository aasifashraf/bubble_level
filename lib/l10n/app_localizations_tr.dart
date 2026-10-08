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
  String get homeTopTools => 'En çok kullandıkların';

  @override
  String get homeMoreTools => 'Diğer araçlar';

  @override
  String get homeArrange => 'Düzenle';

  @override
  String get arrangeTitle => 'Araçları düzenle';

  @override
  String get arrangeHint =>
      'Sırayı değiştirmek için sürükle. İlk üçü en çok kullandıkların olur.';

  @override
  String get arrangeStar => 'Öne çıkar';

  @override
  String get arrangeUnstar => 'Öne çıkanlardan kaldır';

  @override
  String get arrangeReset => 'Popüler sıra';

  @override
  String get arrangeDone => 'Bitti';

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
  String get toolVibrationSubtitle => 'Titreşim gücü ve hızı (dev/dk)';

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
  String get sensorCamera => 'arka kamera';

  @override
  String get sensorGps => 'GPS';

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
      'Eğimi okumak için telefonu bir yüzeye koyun ya da bir kenarı üzerinde bir eğime, korkuluğa veya boruya dayayın: büyük sayı turuncu parlayan kenarın açısıdır, alt kenarınki altında yazar.';

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
  String get angleHelp6 =>
      'Modu üstteki anahtarla seçin: bir yüzeyde düz ya da bir kenarı üzerinde dik. Kenarda ekran düz kalan suyla dolar ve ölçtüğünüz kenar, yani alçak taraf, turuncu parlar.';

  @override
  String get angleTip =>
      'Eğimini okumak için telefonun uzun kenarını bir rampaya, merdiven korkuluğuna veya çatıya dayayın ya da eğimini ölçmek için ekranı bir tahtaya veya kapıya düz bastırın.';

  @override
  String movedFromZero(String value) {
    return 'Sıfırdan sapma $value';
  }

  @override
  String get measuringFromZero => 'Sıfır noktanızdan ölçülüyor';

  @override
  String get angleFlatStatus => 'Düz · Dünya’ya göre açı';

  @override
  String get measuringRightEdge => 'Sağ kenar ölçülüyor';

  @override
  String get measuringLeftEdge => 'Sol kenar ölçülüyor';

  @override
  String bottomEdge(String value) {
    return 'Alt kenar $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: yataydan $value. Alt kenar $other';
  }

  @override
  String get angleModeFlat => 'Bir yüzeyde düz';

  @override
  String get angleModeEdge => 'Kenar üstünde';

  @override
  String get standOnEdge => 'Telefonu kenarlarından birinin üstüne koyun';

  @override
  String get clearZero => 'Sıfırı temizle';

  @override
  String get setZeroHere => 'Sıfırı buraya al';

  @override
  String get compassHelp1 =>
      'Telefonu önünüzde yatay tutun; metal, mıknatıs ve elektronik cihazlardan uzak durun.';

  @override
  String get compassHelp2 =>
      'Telefonun üst kısmını öğrenmek istediğiniz yöne çevirin. Dik tutarsanız arka kameranın baktığı yönü gösterir.';

  @override
  String get compassHelp3 =>
      'Sayı derece cinsinden yönünüz, harfler ise yöndür. Kadran, N harfi hep kuzeyi gösterecek şekilde döner; üstteki turuncu top telefonunuzun baktığı yönü işaretler.';

  @override
  String get compassTip =>
      'Manyetik kuzeyi gösterir; bu, bazı yerlerde harita kuzeyinden 10 derece veya daha fazla farklı olabilir. Yanlış görünüyorsa telefonu birkaç kez 8 çizerek hareket ettirin.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Manyetik yön $heading derece, $direction';
  }

  @override
  String get magneticInterference =>
      'Manyetik parazit · metalden uzaklaşın, sonra telefonu 8 çizerek sallayın';

  @override
  String get compassCalibrate =>
      'Pusulayı kalibre etmek için telefonu 8 çizerek sallayın';

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
  String get rotateToCalibrate => 'Kalibrasyon için dikeye çevirin';

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
      '“Yakında metal var” küçük bir değişiklik, “Metal bulundu” güçlü bir değişiklik demektir. Sıcak-soğuk oyunundaki gibi, yaklaştıkça ekran soğuk maviden kızgın kırmızıya döner; titreşim açıksa bulunca telefon titrer.';

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
  String get heatCold => 'Soğuk';

  @override
  String get heatCool => 'Serin';

  @override
  String get heatWarm => 'Ilık';

  @override
  String get heatWarmer => 'Daha sıcak';

  @override
  String get heatHot => 'Sıcak';

  @override
  String get heatBurning => 'Yanıyor';

  @override
  String get baseline => 'Taban';

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
      'Telefonu çalışan makinenin üzerine düz koyun ve elinizi çekin. Küçük bir makinede sıkıca bastırın.';

  @override
  String get vibrationHelp2 =>
      'İbre en güçlü titreşimin hızını dev/dk olarak, altında hertz olarak gösterir (dev/dk, hertz × 60’tır). Kadranın içindeki hafif parıltı spektrumun tamamıdır; ibre en parlak kısmını gösterir.';

  @override
  String get vibrationHelp3 =>
      'Güç, ne kadar sert sarsıldığıdır, m/s² cinsinden: 0,3’ün altı durgun, 2’nin üstü güçlüdür.';

  @override
  String get vibrationHelp4 =>
      'Bir ölçümü tutmak için Kilitle’ye, sonraki makineden önce sıfırlama düğmesine dokunun.';

  @override
  String get vibrationTip =>
      'Çoğu telefon 100 Hz’e (6000 dev/dk) kadar ölçer, bazıları daha az; kadran telefonunuzun sınırını gösterir. Daha hızlı titreşim yanlış, daha düşük bir hız olarak görünebilir. En güçlü titreşim çoğu zaman mil hızıdır ama iki katı da olabilir. Telefon sensörleri laboratuvar cihazı değildir.';

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
  String get frequency => 'Frekans';

  @override
  String get rpm => 'dev/dk';

  @override
  String get strength => 'Güç';

  @override
  String vibratingAt(String value) {
    return '$value Hz ile titreşiyor';
  }

  @override
  String get noClearFrequency => 'Belirgin frekans yok';

  @override
  String get findingFrequency => 'Frekans aranıyor…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return 'Dakikada $rpm devir, $value hertz';
  }

  @override
  String get peak => 'Tepe';

  @override
  String get average => 'Ortalama';

  @override
  String get resetPeak => 'Tepeyi sıfırla';

  @override
  String get altimeterHelp1 =>
      'Dağdaki yürüyüşçü, yüksekliğin değiştikçe iner ya da çıkar. Gökyüzü günün saatine ve mevsime uyar; kendin seçmek için hava düğmesine dokun.';

  @override
  String get altimeterHelp2 =>
      'Merdiven veya kat gibi bir yükseklik farkını ölçmek için başladığınız yerde Sıfırı buraya al\'a dokunun.';

  @override
  String get altimeterHelp3 =>
      'Çık ya da in: yürüyüşçü seninle yürür, bayrak en yüksek noktanı işaretler. Panel sıfırından metreyi, hava basıncını ve yaklaşık rakımı gösterir.';

  @override
  String get altimeterHelp4 =>
      'Sıfırdan ölçmeyi bırakmak için Sıfırı temizle\'ye dokunun: Sıfırdan değeri yeniden boş kalır.';

  @override
  String get altimeterTip =>
      'Hava durumu basıncı sürekli değiştirir, bu yüzden bilinen bir başlangıç yüksekliği olmadan yükseklik yüz metre veya daha fazla sapabilir. Kısa sürelerde Sıfırı buraya al\'dan itibaren yükseklik değişimine güvenin. Bu araç barometreli bir telefon gerektirir.';

  @override
  String get weather => 'Hava';

  @override
  String get weatherAuto => 'Otomatik (günün saati ve mevsim)';

  @override
  String get weatherSunny => 'Güneşli';

  @override
  String get weatherCloudy => 'Bulutlu';

  @override
  String get weatherRain => 'Yağmur';

  @override
  String get weatherStorm => 'Fırtına';

  @override
  String get weatherSnow => 'Kar';

  @override
  String get fromZero => 'Sıfırdan';

  @override
  String get altitudeShort => 'Rakım';

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
      'Gökyüzü ışığı takip eder: karanlıkta gece, loş bir odada şafak; ışık arttıkça güneş yükselir. Lüksü ve ışığın neye uygun olduğunu okuyun: 300 ile 750 lx arası okumaya ve masa başı işe uygundur.';

  @override
  String get lightHelp4 =>
      'Telefonu uzaklaştırırken bir okumayı tutmak için Kilitle’ye dokunun.';

  @override
  String get lightTip =>
      'Telefon ışık sensörleri kalibre edilmemiştir, bu yüzden okumalar telefondan telefona çok farklı olabilir. Aynı yerdeki ışığı aynı telefonla karşılaştırmak için kullanın; kalibre edilmiş bir lüksmetre değildir. Ekranın üstünü kapatmayın.';

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
      'Büyük sayı, yaklaşık bir saniyelik ortalamayla şu anki seviyedir. Ondan dalgalar yayılır; ses yükseldikçe daha çok ve daha uzağa: sessizken yeşil, sonra sarı, turuncu, kırmızı ve koyu kırmızı. Alttaki çubuklar son üç saniyeyi gösterir.';

  @override
  String get soundHelp3 =>
      'Ortalama ve Maks., aracı açtığınızdan beri sayılır. Yeniden başlatmak için Sıfırla’ya dokunun.';

  @override
  String get soundHelp4 =>
      '70 dB’den itibaren durum satırı sarıya, uzun süre maruz kalmanın işitmeye zarar verebileceği 85 dB’den itibaren kırmızıya döner.';

  @override
  String get soundHelp5 =>
      'Telefonu hareket ettirirken bir okumayı ekranda tutmak için kilide dokunun.';

  @override
  String get soundTip =>
      'Telefon mikrofonları kalibre edilmiş ses ölçerler değildir ve modele göre farklıdır, bu yüzden okumalar yaklaşıktır (çoğu zaman yaklaşık 5 ile 10 dB arasında sapar) ve çok yüksek sesler düşük okunabilir. Resmî bir ölçüm için kalibre edilmiş bir ses ölçer gerekir.';

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
  String get unitDegrees => 'Derece';

  @override
  String get unitPercent => 'Yüzde eğim';

  @override
  String get unitRoofPitch => 'Çatı eğimi (12 başına yükselme)';

  @override
  String get vibrateWhenLevel => 'Titreşim';

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
      'Su terazisinde (açı ölçer de kullanır) ve cetvelde yaptığınız kalibrasyonlar kaldırılır. İkisi de fabrika ayarlarına döner. Diğer ayarlarınız olduğu gibi kalır ve istediğiniz zaman yeniden kalibre edebilirsiniz.';

  @override
  String get notCalibrated => 'Kalibre edilmedi';

  @override
  String get language => 'Dil';

  @override
  String get licenses => 'Açık kaynak lisansları';

  @override
  String get languageSystem => 'Telefonun dili';

  @override
  String get toolHeight => 'Yükseklik';

  @override
  String get toolHeightSubtitle => 'Nişan alarak yükseklik ve mesafe';

  @override
  String get heightHelp1 =>
      'Nesnenin dibini ve tepesini görebileceğin bir yerde dur. Telefonu ekranı yukarı bakacak şekilde tut ve üst kenarı boyunca bak.';

  @override
  String get heightHelp2 =>
      'Üst kenarı nesnenin dibine doğrult ve Dibi kilitle’ye dokun: bu mesafeyi verir.';

  @override
  String get heightHelp3 =>
      'Üst kenarı tepeye doğrult ve Tepeyi kilitle’ye dokun: yükseklik görünür.';

  @override
  String get heightHelp4 =>
      'Mesafeyi biliyor musun? Mesafe’ye dokunup yaz, sonra yalnızca tepeye nişan al. Kendi göz yüksekliğin için Göz yüksekliği’ne dokun.';

  @override
  String get heightTip =>
      'Düz zeminde, göz yüksekliği doğru ayarlıyken (boyun eksi yaklaşık 10 cm) yaklaşık ±%5. Tepe 70°’nin altında, dip ise yatayın en az 3° altında olacak kadar geri çekil. Eğimli yerde mesafeyi yaz.';

  @override
  String get lockBase => 'Dibi kilitle';

  @override
  String get lockTop => 'Tepeyi kilitle';

  @override
  String get measureAgain => 'Yeniden ölç';

  @override
  String get distance => 'Mesafe';

  @override
  String get objectHeight => 'Yükseklik';

  @override
  String get eyeHeight => 'Göz yüksekliği';

  @override
  String get sightAngle => 'Nişan açısı';

  @override
  String get heightAimBase => 'Üst kenarı dibe doğrult';

  @override
  String get heightAimTop => 'Şimdi üst kenarı tepeye doğrult';

  @override
  String get heightDone => 'Bitti · başka biri için Yeniden ölç’e dokun';

  @override
  String get heightHoldFlatter =>
      'Telefonu daha düz tut ve üst kenarı boyunca nişan al';

  @override
  String get heightTooFar => 'Dip yataya çok yakın: yaklaş ya da mesafeyi yaz';

  @override
  String get heightStepBack => 'Çok dik: daha sabit bir ölçüm için geri çekil';

  @override
  String get knownDistance => 'Dibe olan mesafe';

  @override
  String get knownDistanceHint =>
      'Nesnenin dibine zemin boyunca mesafe. Nişan alarak ölçmek için temizle.';

  @override
  String get eyeHeightHint =>
      'Gözlerinin yerden yüksekliği: yaklaşık boyun eksi 10 cm.';

  @override
  String get clear => 'Temizle';

  @override
  String get toolCamera => 'Kamera terazisi';

  @override
  String get toolCameraSubtitle =>
      'Kamera üzerinde düz çizgiler, her kenarı ölçün';

  @override
  String get cameraHelp1 =>
      'Arka kamerayı bir duvara, tabloya, rafa ya da kapıya doğrultun. Telefonu dik ve duvara tam karşıdan tutun.';

  @override
  String get cameraHelp2 =>
      'Düz çizgiler yer çekimini izler: her zaman tam yatay ve dikeydir. Kesikli çizgiler telefona sabittir ve aradaki küçük yay telefonun ne kadar eğik olduğunu gösterir. Telefon düz olunca gerçek çizgiler turuncu olur.';

  @override
  String get cameraHelp3 =>
      'Bir nesneyi kontrol etmek için Dondur’a dokunun, sonra iki turuncu tutamacı nesnenin bir kenarına, örneğin bir çerçevenin üstüne sürükleyin. Eliniz düz olmasa bile o kenarın ne kadar eğik olduğunu ve hangi tarafın kaldırılacağını görürsünüz. Dikey bir kenarı kontrol etmek için çizgiyi dik tutun.';

  @override
  String get cameraHelp4 =>
      'Üstteki iki düğme telefon çizgilerini ve gerçek çizgileri gösterir ya da gizler. Işık karanlık köşelerde yardımcı olur; Devam canlı görüntüye döner.';

  @override
  String get cameraTip =>
      'Kenarı tam ölçmek için duvara tam karşıdan bakın (İleri/geri 5°’nin altında) ve merceğin çizgileri en az büktüğü görüntünün ortasına yakın ölçün. Terazinin kenar kalibrasyonunu kullanır. Görüntü asla kaydedilmez, saklanmaz ya da gönderilmez.';

  @override
  String get cameraAllowTitle => 'Kameraya izin verin';

  @override
  String get cameraAllowBody =>
      'Kamera terazisi, kamera görüntüsünün üzerine düz çizgiler çizer ve içindeki kenarları ölçer. Görüntü telefonunuzda kalır; asla kaydedilmez, saklanmaz ya da gönderilmez.';

  @override
  String get cameraAllow => 'Kameraya izin ver';

  @override
  String get cameraDeniedTitle => 'Kamera erişimi kapalı';

  @override
  String get cameraDeniedBody =>
      'Kamera terazisini kullanmak için Ayarlar’da bu uygulamaya kamera izni verin. Görüntü asla kaydedilmez, saklanmaz ya da gönderilmez.';

  @override
  String get noCamera =>
      'Kamera kullanılamıyor. Başka bir uygulama kullanıyor olabilir ya da telefonda kamera yok: diğer kamera uygulamalarını kapatıp kamera terazisini yeniden açın.';

  @override
  String get tilt => 'Eğim';

  @override
  String get forwardBack => 'İleri/geri';

  @override
  String get cameraLevel => 'Düz';

  @override
  String cameraTilted(String value) {
    return '$value° eğik';
  }

  @override
  String get cameraHoldUpright => 'Telefonu dik tutun, kamera duvara baksın';

  @override
  String get freeze => 'Dondur';

  @override
  String get resume => 'Devam';

  @override
  String get torch => 'Işık';

  @override
  String cameraSemantics(String value) {
    return 'Düz çizgili kamera görüntüsü, $value derece eğik';
  }

  @override
  String get cameraPhoneLines => 'Telefon çizgileri';

  @override
  String get cameraTrueLines => 'Gerçek çizgiler';

  @override
  String get cameraFrozen => 'Donduruldu';

  @override
  String get cameraDragHandles => 'Tutamaçları bir kenara sürükleyin';

  @override
  String get cameraFaceWall => 'Duvara tam karşıdan tutun';

  @override
  String get edgeLevel => 'Bu kenar düz';

  @override
  String get edgePlumb => 'Bu kenar dikey';

  @override
  String edgeLiftRight(String value) {
    return 'Kenar $value° eğik, sağı kaldırın';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'Kenar $value° eğik, solu kaldırın';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'Kenar dikeyden $value° sapmış';
  }

  @override
  String get cameraHandle => 'Kenar tutamacı';

  @override
  String get toolGForce => 'G kuvveti';

  @override
  String get toolGForceSubtitle => 'Fren, hızlanma ve virajlar g cinsinden';

  @override
  String get gHelp1 =>
      'Telefonu ekranı size dönük şekilde bir araç tutucusuna sabitleyin. Araç dururken Sıfırla’ya dokunun: ölçer aşağının ve ilerinin hangi yönde olduğunu öğrenir.';

  @override
  String get gHelp2 =>
      'Sürün: aracın, itildiğiniz tarafı parlar. Fren önü, hızlanma arkayı, viraj dış tarafı yakar. Yeşil yumuşak, turuncu belirgin, kırmızı sert demektir.';

  @override
  String get gHelp3 =>
      'Panel, Sıfırla’dan bu yana en güçlü hızlanmayı, freni ve virajı tutar; kenardaki noktalar da her yöndeki en güçlü itmeyi tutar. Tepeleri temizle düğmesi bunları siler.';

  @override
  String get gHelp4 =>
      'Gözünüz yolda olsun: bir yolcu okusun ya da durduktan sonra tepelere bakın.';

  @override
  String get gTip =>
      'Değerler ivmeölçerden gelir ve yaklaşıktır: sağlam bir tutucuya ve araç dururken alınan Sıfırla’ya bağlıdır, bozuk yollarda biraz daha oynaktır. Tutucu kayarsa durun ve yeniden Sıfırla’ya dokunun. Sıradan bir araç için 0,5 g üzeri sert bir fren ya da hızlı bir viraj demektir.';

  @override
  String get gZero => 'Sıfırla';

  @override
  String get gResetPeaks => 'Tepeleri temizle';

  @override
  String get gSpeedUp => 'Hızlanma';

  @override
  String get gBrake => 'Fren';

  @override
  String get gCorner => 'Viraj';

  @override
  String get gSteady => 'Sabit';

  @override
  String gBraking(String value) {
    return 'Fren $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'Hızlanma $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'Sol viraj $value g';
  }

  @override
  String gRightBend(String value) {
    return 'Sağ viraj $value g';
  }

  @override
  String gSemantics(String value) {
    return 'G kuvveti $value g';
  }

  @override
  String get gZeroed => 'Sıfırlandı: ileri ve aşağı öğrenildi';

  @override
  String get noAccelerometerG =>
      'Bu telefonda ivmeölçer yok, bu yüzden burada g kuvveti ölçülemez. Diğer araçlar çalışmaya devam eder.';

  @override
  String get toolSpeed => 'Hız göstergesi';

  @override
  String get toolSpeedSubtitle => 'Hız, yolculuk ve GPS rakımı';

  @override
  String get speedHelp1 =>
      'Konuma izin verin, sonra telefonu gökyüzünü görebileceği bir yere koyun; örneğin gösterge panelinin üstüne ya da ön cam tutucusuna. Açık havada ilk konum birkaç saniye sürer.';

  @override
  String get speedHelp2 =>
      'Gösterge panelindeki kadran GPS’ten hızınızı gösterir; iki yanında yolculuk mesafesi ve rakım yer alır. Panel, son sıfırlamadan beri mesafeyi, en yüksek ve ortalama hızı tutar.';

  @override
  String get speedHelp3 =>
      'Kopyalamak için koordinatlara dokunun. Birim düğmesi km/sa ile mil/sa arasında geçiş yapar, Yolculuğu sıfırla ise mesafeyi, en yüksek ve ortalama hızı yeniden başlatır.';

  @override
  String get speedHelp4 =>
      'Gözünüz yolda olsun: bir yolcu okusun ya da durduktan sonra yolculuğa bakın.';

  @override
  String get speedTip =>
      'Hız uydulardan gelir ve açık yollarda genellikle yaklaşık 1 km/sa içinde doğrudur; tünellerde, yüksek binalar arasında ya da kapalı alanlarda gecikebilir veya kesilebilir. GPS rakımı 10 ila 50 m sapabilir, bu yüzden yükseklik değişimleri için Altimetre’yi kullanın. Konum yalnızca bu araç açıkken kullanılır ve telefonunuzdan asla çıkmaz.';

  @override
  String get speedAllowTitle => 'Konuma izin verin';

  @override
  String get speedAllowBody =>
      'Hız göstergesi, hızınızı, mesafeyi ve rakımı ölçmek için GPS’i kullanır. Konum yalnızca bu araç ekranda açıkken kullanılır, asla arka planda kullanılmaz ve telefonunuzdan asla çıkmaz.';

  @override
  String get speedAllow => 'Konuma izin ver';

  @override
  String get speedDeniedTitle => 'Konum erişimi kapalı';

  @override
  String get speedDeniedBody =>
      'Hız göstergesini kullanmak için Ayarlar’da bu uygulamaya konum izni verin. Konum yalnızca araç açıkken kullanılır ve telefonunuzdan asla çıkmaz.';

  @override
  String get speedServiceOffTitle => 'Konum kapalı';

  @override
  String get speedServiceOffBody =>
      'Hız göstergesini kullanmak için telefonun ayarlarından konumu açın.';

  @override
  String get speedDistance => 'Mesafe';

  @override
  String get speedTop => 'En yüksek';

  @override
  String get speedAverage => 'Ortalama';

  @override
  String get speedTrip => 'Yolculuk';

  @override
  String get speedAltitude => 'Rakım';

  @override
  String get speedResetTrip => 'Yolculuğu sıfırla';

  @override
  String get speedFinding => 'Uydular aranıyor…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value m';
  }

  @override
  String get speedWeak => 'Zayıf GPS: hız gecikebilir';

  @override
  String get speedApproximate => 'Tam konum kapalı: sabit hız için açın';

  @override
  String get speedStill => 'Duruyor';

  @override
  String get speedCopied => 'Koordinatlar kopyalandı';

  @override
  String get speedUnitTooltip => 'km/sa ile mil/sa arasında geç';

  @override
  String get speedKmh => 'km/sa';

  @override
  String get speedMph => 'mil/sa';

  @override
  String speedSemantics(String value) {
    return 'Hız $value';
  }

  @override
  String get speedCoordinates => 'Koordinatlar, kopyalamak için dokunun';

  @override
  String get noGps =>
      'Bu telefonda GPS yok, bu yüzden burada hız ölçülemez. Diğer araçlar çalışmaya devam eder.';

  @override
  String get speedSceneHelp =>
      'Gökyüzü günün saatine uyar. Hava düğmesi sahneyi seçer: Otomatik mevsime uyar, ya da güneş, bulut, yağmur, fırtına veya kar seçin. Bu bir dekor, hava tahmini değil.';
}
