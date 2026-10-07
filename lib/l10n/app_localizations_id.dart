// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Waterpass & Pengukur Sudut';

  @override
  String get homeTitle => 'Waterpass';

  @override
  String get settings => 'Setelan';

  @override
  String get tools => 'Alat';

  @override
  String get listView => 'Tampilan daftar';

  @override
  String get gridView => 'Tampilan kisi';

  @override
  String get back => 'Kembali';

  @override
  String get lightMode => 'Mode terang';

  @override
  String get darkMode => 'Mode gelap';

  @override
  String get toolLevel => 'Waterpass';

  @override
  String get toolLevelSubtitle => 'Waterpass gelembung dan tabung';

  @override
  String get toolAngle => 'Sudut';

  @override
  String get toolAngleSubtitle => 'Sudut dari datar atau dari titik nol Anda';

  @override
  String get toolCompass => 'Kompas';

  @override
  String get toolCompassSubtitle => 'Arah dan mata angin';

  @override
  String get toolProtractor => 'Busur derajat';

  @override
  String get toolProtractorSubtitle => 'Ukur sudut di layar';

  @override
  String get toolRuler => 'Penggaris';

  @override
  String get toolRulerSubtitle => 'Ukur panjang di layar';

  @override
  String get toolMetal => 'Detektor logam';

  @override
  String get toolMetalSubtitle => 'Temukan besi, baja, dan magnet';

  @override
  String get toolVibration => 'Getaran';

  @override
  String get toolVibrationSubtitle => 'Kekuatan dan kecepatan getaran (RPM)';

  @override
  String get toolSound => 'Pengukur suara';

  @override
  String get toolSoundSubtitle => 'Tingkat kebisingan dalam desibel';

  @override
  String get toolAltimeter => 'Altimeter';

  @override
  String get toolAltimeterSubtitle => 'Tekanan udara dan ketinggian';

  @override
  String get toolLight => 'Pengukur cahaya';

  @override
  String get toolLightSubtitle => 'Kecerahan dalam lux';

  @override
  String get notAvailableOnPhone => 'Tidak tersedia di ponsel ini';

  @override
  String get notOnPhone => 'Tidak tersedia';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, tidak tersedia di ponsel ini';
  }

  @override
  String get howToUse => 'Cara pakai';

  @override
  String get rotateLandscape => 'Putar ke lanskap';

  @override
  String get rotatePortrait => 'Putar ke potret';

  @override
  String howToUseTool(String tool) {
    return 'Cara memakai $tool';
  }

  @override
  String get gotIt => 'Mengerti';

  @override
  String get goodToKnow => 'Perlu diketahui: ';

  @override
  String get ok => 'OK';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool tidak tersedia';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sensor',
      one: 'sensor',
    );
    return '$tool memerlukan $_temp0 yang tidak dimiliki ponsel ini: $sensors.';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'Ini keterbatasan perangkat keras ponsel, bukan kesalahan aplikasi. Semua alat lain berfungsi normal.';

  @override
  String get sensorAccelerometer => 'akselerometer';

  @override
  String get sensorMagnetometer => 'magnetometer (sensor kompas)';

  @override
  String get sensorBarometer => 'barometer (sensor tekanan udara)';

  @override
  String get sensorLight => 'sensor cahaya';

  @override
  String get sensorMicrophone => 'mikrofon';

  @override
  String get noAccelerometer =>
      'Ponsel ini tidak punya akselerometer, jadi alat ini tidak bisa mengukur di sini. Alat yang tidak memerlukannya tetap berfungsi.';

  @override
  String get noMagnetometer =>
      'Ponsel ini tidak punya magnetometer (sensor kompas), jadi alat ini tidak bisa berfungsi di sini. Alat yang tidak memerlukannya tetap berfungsi.';

  @override
  String get noReadings =>
      'Belum ada data dari sensor. Kembali lalu buka alat ini lagi; jika masih terjadi, mulai ulang ponsel. Beberapa ponsel tidak mendukung alat ini.';

  @override
  String get waitingForSensors => 'Menunggu sensor…';

  @override
  String get levelHelp1 =>
      'Letakkan ponsel mendatar di permukaan, atau berdirikan di salah satu sisinya.';

  @override
  String get levelHelp2 =>
      'Mendatar: posisikan gelembung di tengah. X adalah kemiringan kiri/kanan, Y depan/belakang. Pada sisi, Anda melihat sudut dan kemiringan.';

  @override
  String get levelHelp3 =>
      'Ikuti petunjuk di layar (misalnya \"Sisi kanan tinggi\") sampai muncul \"Rata\": tampilan berubah oranye dan ponsel berbunyi serta bergetar (bisa dimatikan di Setelan).';

  @override
  String get levelHelp4 =>
      'Ketuk Kunci untuk membekukan angka, dan Buka kunci untuk mengukur langsung lagi.';

  @override
  String get levelHelp5 =>
      'Lebih suka waterpass klasik? Ketuk ikon tabung pada pengalih; ikon bulat mengembalikan dial.';

  @override
  String get levelTip =>
      'Jika permukaan yang Anda tahu rata tidak menunjukkan 0°, letakkan ponsel di atasnya lalu ketuk Kalibrasi. Untuk membatalkannya, ketuk Kalibrasi lagi dan pilih Atur ulang kalibrasi.';

  @override
  String get statusLevel => 'Rata';

  @override
  String get leftEndLow => 'Ujung kiri rendah';

  @override
  String get rightEndLow => 'Ujung kanan rendah';

  @override
  String get rightSideHigh => 'Sisi kanan tinggi';

  @override
  String get leftSideHigh => 'Sisi kiri tinggi';

  @override
  String get topEdgeHigh => 'Tepi atas tinggi';

  @override
  String get bottomEdgeHigh => 'Tepi bawah tinggi';

  @override
  String get calibrated => 'Terkalibrasi. Posisi ini sekarang menunjukkan 0°.';

  @override
  String get tooFarToCalibrate =>
      'Terlalu miring untuk dikalibrasi. Letakkan ponsel di permukaan rata terlebih dahulu.';

  @override
  String get dialView => 'Tampilan dial';

  @override
  String get tubeView => 'Tampilan tabung';

  @override
  String get levelTube => 'Tabung waterpass';

  @override
  String get leftRightTube => 'Tabung kiri dan kanan';

  @override
  String get forwardBackTube => 'Tabung depan dan belakang';

  @override
  String tiltFromLevel(String value) {
    return 'Kemiringan dari datar $value';
  }

  @override
  String fromLevel(String value) {
    return 'Selisih dari datar $value';
  }

  @override
  String get xLeftRight => 'X · kiri / kanan';

  @override
  String get yForwardBack => 'Y · depan / belakang';

  @override
  String get angle => 'Sudut';

  @override
  String get slope => 'Kemiringan';

  @override
  String get lock => 'Kunci';

  @override
  String get unlock => 'Buka kunci';

  @override
  String locked(String status) {
    return 'Terkunci · $status';
  }

  @override
  String get lockReading => 'Kunci angka';

  @override
  String get lockHandles => 'Kunci pegangan';

  @override
  String get handlesLocked => 'Pegangan terkunci · ketuk gembok untuk mengubah';

  @override
  String get calibrate => 'Kalibrasi';

  @override
  String get angleHelp1 =>
      'Letakkan ponsel di permukaan untuk membaca kemiringannya, atau berdirikan pada tepinya di lereng, pegangan, atau pipa: angka besar adalah sudut tepi yang menyala oranye, sudut tepi bawah ada di bawahnya.';

  @override
  String get angleHelp2 =>
      'Untuk mengukur perubahan, pegang ponsel di posisi awal lalu ketuk Atur nol di sini.';

  @override
  String get angleHelp3 =>
      'Miringkan atau gerakkan ponsel. Dial menunjukkan berapa derajat ponsel bergerak dari titik nol Anda.';

  @override
  String get angleHelp4 =>
      'Ketuk Hapus nol untuk kembali ke sudut dari posisi mendatar.';

  @override
  String get angleHelp5 =>
      'Untuk membaca sudut yang tidak terlihat, tempelkan ponsel ke benda, ketuk gembok, lalu angkat dan baca.';

  @override
  String get angleHelp6 =>
      'Pilih mode dengan sakelar di atas: datar di permukaan, atau berdiri pada tepi. Pada tepi, layar terisi air yang tetap datar, dan tepi yang Anda ukur, sisi yang lebih rendah, menyala oranye.';

  @override
  String get angleTip =>
      'Tempelkan sisi panjang ponsel pada ram, pegangan tangga, atau atap untuk membaca kemiringannya, atau tempelkan layar ke papan atau pintu untuk mengukur kemiringannya.';

  @override
  String movedFromZero(String value) {
    return 'Bergeser dari nol $value';
  }

  @override
  String get measuringFromZero => 'Mengukur dari titik nol Anda';

  @override
  String get angleFlatStatus => 'Mendatar · sudut terhadap Bumi';

  @override
  String get measuringRightEdge => 'Mengukur tepi kanan';

  @override
  String get measuringLeftEdge => 'Mengukur tepi kiri';

  @override
  String bottomEdge(String value) {
    return 'Tepi bawah $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: $value dari datar. Tepi bawah $other';
  }

  @override
  String get angleModeFlat => 'Mendatar di permukaan';

  @override
  String get angleModeEdge => 'Di sisi';

  @override
  String get standOnEdge => 'Berdirikan ponsel pada salah satu sisinya';

  @override
  String get clearZero => 'Hapus nol';

  @override
  String get setZeroHere => 'Atur nol di sini';

  @override
  String get compassHelp1 =>
      'Pegang ponsel mendatar di depan Anda, jauh dari logam, magnet, dan perangkat elektronik.';

  @override
  String get compassHelp2 =>
      'Arahkan bagian atas ponsel ke arah yang ingin Anda ketahui. Jika dipegang tegak, kompas menunjukkan arah kamera belakang.';

  @override
  String get compassHelp3 =>
      'Angka adalah arah Anda dalam derajat dan huruf adalah mata anginnya. Dial berputar agar N selalu menunjuk ke utara; bola oranye di atas menandai arah ponsel Anda.';

  @override
  String get compassTip =>
      'Kompas menunjuk utara magnetis, yang bisa berbeda beberapa derajat dari utara peta. Jika terlihat salah, gerakkan ponsel membentuk angka 8 beberapa kali.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Arah magnetis $heading derajat, $direction';
  }

  @override
  String get magneticInterference =>
      'Gangguan magnetis · jauhi logam, lalu gerakkan ponsel membentuk angka 8';

  @override
  String get compassCalibrate =>
      'Gerakkan ponsel membentuk angka 8 untuk mengkalibrasi kompas';

  @override
  String get dirN => 'U';

  @override
  String get dirNE => 'TL';

  @override
  String get dirE => 'T';

  @override
  String get dirSE => 'TG';

  @override
  String get dirS => 'S';

  @override
  String get dirSW => 'BD';

  @override
  String get dirW => 'B';

  @override
  String get dirNW => 'BL';

  @override
  String get protractorHelp1 =>
      'Letakkan ponsel mendatar dan taruh benda di layar, dengan sudutnya di tengah.';

  @override
  String get protractorHelp2 =>
      'Seret setiap pegangan oranye sehingga garisnya sejajar dengan satu sisi sudut.';

  @override
  String get protractorHelp3 =>
      'Baca sudut di tengah. Refleks adalah sisi lainnya (360° dikurangi sudut).';

  @override
  String get protractorHelp4 => 'Ketuk Atur ulang untuk memulai lagi.';

  @override
  String get protractorHelp5 =>
      'Ketuk gembok agar pegangan tetap di tempat saat Anda menggeser benda.';

  @override
  String armsSemantics(String value) {
    return 'Sudut antara kedua lengan $value';
  }

  @override
  String get reflex => 'Refleks';

  @override
  String get dragHandles => 'Seret pegangan oranye di sepanjang tepi';

  @override
  String get reset => 'Atur ulang';

  @override
  String get rulerHelp1 =>
      'Letakkan benda di layar, atau tempelkan ponsel ke benda.';

  @override
  String get rulerHelp2 =>
      'Seret garis oranye ke kedua ujungnya. Ketuk mm, cm, atau in untuk memilih satuan; sistem lainnya tampil di bawah.';

  @override
  String get rulerHelp3 =>
      'Untuk akurasi terbaik, ketuk Kalibrasi sekali dan gunakan kartu bank, penggaris, atau ukuran layar.';

  @override
  String get rulerHelp4 =>
      'Ketuk gembok agar garis tetap di tempat saat Anda menggeser benda.';

  @override
  String get rulerTip =>
      'Penggaris mengukur hingga sepanjang layar. Casing dan tepi melengkung menutupi milimeter pertama, jadi ukur di antara garis, bukan dari tepi ponsel.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'Panjang $mm milimeter, $inches inci';
  }

  @override
  String get rulerCalibrated => 'Dikalibrasi dengan kartu · ±0,5 mm';

  @override
  String get rulerReported =>
      'Ukuran layar dari ponsel · kalibrasi untuk ±0,5 mm';

  @override
  String get unitMillimetres => 'Milimeter';

  @override
  String get unitCentimetres => 'Sentimeter';

  @override
  String get unitInches => 'Inci';

  @override
  String get rulerEstimated => 'Belum dikalibrasi · panjang bisa meleset 10%';

  @override
  String get cardLongEdge =>
      'Letakkan kartu bank atau identitas di layar, sisi panjang di sepanjang penggaris, satu ujung di garis gelap. Seret garis oranye ke ujung kartu lainnya.';

  @override
  String get cardShortEdge =>
      'Letakkan kartu bank atau identitas di layar, sisi pendek di sepanjang penggaris, satu ujung di garis gelap. Seret garis oranye ke ujung kartu lainnya.';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get usePhoneDefault => 'Gunakan ukuran layar ponsel';

  @override
  String get usePhoneDefaultInfo => 'Lupakan kalibrasi ini';

  @override
  String get cardMismatch =>
      'Itu tidak sesuai dengan ukuran kartu. Sejajarkan dengan garis gelap lalu coba lagi.';

  @override
  String get rotateToCalibrate => 'Putar ke potret untuk kalibrasi';

  @override
  String get calibrateHow => 'Kalibrasi dengan';

  @override
  String get methodCard => 'Kartu bank';

  @override
  String get methodCardInfo => 'Kartu bank atau KTP apa saja · ±0,5 mm';

  @override
  String get methodRuler => 'Penggaris';

  @override
  String get methodRulerInfo => 'Paling akurat · penggaris atau meteran';

  @override
  String get methodScreen => 'Ukuran layar';

  @override
  String get methodScreenInfo => 'Tanpa alat · sekitar 1%';

  @override
  String rulerInstructions(String mark) {
    return 'Letakkan penggaris di layar dengan angka 0 di garis gelap. Seret garis oranye ke tanda $mark.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'Itu tidak cocok dengan $mark. Letakkan angka 0 penggaris di garis gelap lalu coba lagi.';
  }

  @override
  String get screenSizeInstructions =>
      'Ketik ukuran layar dalam inci dari spesifikasi ponsel. Tidak tahu? Cari model ponsel Anda dan “ukuran layar”.';

  @override
  String get screenSizeMismatch =>
      'Ukuran itu tidak cocok dengan layar ini. Periksa spesifikasi ponsel lalu coba lagi.';

  @override
  String get rulerCalibratedRuler => 'Dikalibrasi dengan penggaris · ±0,5 mm';

  @override
  String rulerCalibratedScreen(String size) {
    return 'Diatur untuk layar $size inci · sekitar 1%';
  }

  @override
  String get metalHelp1 =>
      'Buka alat ini jauh dari logam. Bacaan pertama dihitung sebagai \"tanpa logam\".';

  @override
  String get metalHelp2 =>
      'Gerakkan ponsel perlahan di atas area. Sensornya biasanya di bagian atas ponsel. Bunyi bip makin cepat saat makin dekat dengan logam; ketuk speaker untuk membisukan.';

  @override
  String get metalHelp3 =>
      '“Ada logam di dekat” berarti perubahan kecil, “Logam terdeteksi” berarti perubahan kuat. Seperti permainan panas-dingin, layar berubah dari biru sejuk ke merah membara saat Anda mendekat, dan ponsel bergetar saat menemukannya jika getaran aktif.';

  @override
  String get metalHelp4 =>
      'Jika diam beberapa detik, alat ini kembali ke nol sendiri sehingga bacaan palsu hilang. Untuk memeriksa suatu titik lagi, jauhkan ponsel lalu dekatkan kembali. Atur acuan langsung mengembalikan ke nol.';

  @override
  String get metalTip =>
      'Hanya mendeteksi besi, baja, dan magnet, bukan aluminium, tembaga, emas, atau perak. Casing ponsel bermagnet memengaruhinya.';

  @override
  String metalSemantics(int value) {
    return 'Medan magnet $value mikrotesla';
  }

  @override
  String get noMetal => 'Tidak ada logam di dekat';

  @override
  String get metalNearby => 'Logam di dekat';

  @override
  String get metalDetected => 'Logam terdeteksi';

  @override
  String get heatCold => 'Dingin';

  @override
  String get heatCool => 'Sejuk';

  @override
  String get heatWarm => 'Hangat';

  @override
  String get heatWarmer => 'Lebih hangat';

  @override
  String get heatHot => 'Panas';

  @override
  String get heatBurning => 'Membara';

  @override
  String get baseline => 'Acuan';

  @override
  String get field => 'Medan';

  @override
  String get change => 'Perubahan';

  @override
  String get findsIronSteel => 'Mendeteksi besi, baja, dan magnet';

  @override
  String get setBaseline => 'Atur acuan';

  @override
  String get muteSound => 'Bisukan suara';

  @override
  String get turnSoundOn => 'Nyalakan suara';

  @override
  String get vibrationHelp1 =>
      'Letakkan ponsel mendatar di atas mesin yang menyala dan lepaskan tangan. Pada mesin kecil, tekan dengan kuat.';

  @override
  String get vibrationHelp2 =>
      'Jarum menunjukkan kecepatan getaran terkuat dalam RPM, dengan hertz di bawahnya (RPM adalah hertz × 60). Cahaya samar di dalam dial adalah seluruh spektrum; jarum menunjuk ke bagian paling terangnya.';

  @override
  String get vibrationHelp3 =>
      'Kekuatan adalah seberapa keras guncangannya, dalam m/s²: di bawah 0,3 berarti diam, di atas 2 berarti kuat.';

  @override
  String get vibrationHelp4 =>
      'Ketuk Kunci untuk menahan bacaan, dan tombol reset sebelum mengukur mesin berikutnya.';

  @override
  String get vibrationTip =>
      'Sebagian besar ponsel mengukur hingga 100 Hz (6000 RPM), sebagian kurang; dial menunjukkan batas ponsel Anda. Getaran yang lebih cepat bisa tampil sebagai kecepatan yang salah dan lebih rendah. Getaran terkuat sering kali kecepatan poros, tetapi bisa dua kalinya. Sensor ponsel bukan alat laboratorium.';

  @override
  String get still => 'Diam';

  @override
  String get lightVibration => 'Getaran ringan';

  @override
  String get strongVibration => 'Getaran kuat';

  @override
  String get noAccelerometerVibration =>
      'Ponsel ini tidak punya akselerometer, jadi getaran tidak bisa diukur di sini. Alat yang tidak memerlukannya tetap berfungsi.';

  @override
  String vibrationSemantics(String value) {
    return 'Getaran $value meter per detik kuadrat';
  }

  @override
  String get frequency => 'Frekuensi';

  @override
  String get rpm => 'RPM';

  @override
  String get strength => 'Kekuatan';

  @override
  String vibratingAt(String value) {
    return 'Bergetar pada $value Hz';
  }

  @override
  String get noClearFrequency => 'Tidak ada frekuensi yang jelas';

  @override
  String get findingFrequency => 'Mencari frekuensi…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm putaran per menit, $value hertz';
  }

  @override
  String get peak => 'Puncak';

  @override
  String get average => 'Rata-rata';

  @override
  String get resetPeak => 'Reset puncak';

  @override
  String get altimeterHelp1 =>
      'Seorang pendaki mendaki gunung seiring ketinggian Anda. Langit mengikuti waktu dan musim; ketuk tombol cuaca untuk memilih sendiri.';

  @override
  String get altimeterHelp2 =>
      'Untuk mengukur perubahan ketinggian, seperti tangga atau lantai, ketuk Atur nol di sini di titik awal.';

  @override
  String get altimeterHelp3 =>
      'Naik atau turun: pendaki berjalan bersama Anda dan bendera menandai titik tertinggi. Panel menunjukkan meter dari nol, tekanan udara, dan perkiraan ketinggian.';

  @override
  String get altimeterHelp4 => 'Ketuk Hapus nol untuk kembali.';

  @override
  String get altimeterTip =>
      'Cuaca mengubah tekanan udara, jadi ketinggian bisa meleset puluhan meter. Ketinggian dari titik nol Anda akurat untuk waktu singkat. Alat ini memerlukan ponsel dengan barometer.';

  @override
  String get weather => 'Cuaca';

  @override
  String get weatherAuto => 'Otomatis (waktu dan musim)';

  @override
  String get weatherSunny => 'Cerah';

  @override
  String get weatherCloudy => 'Berawan';

  @override
  String get weatherRain => 'Hujan';

  @override
  String get weatherStorm => 'Badai';

  @override
  String get weatherSnow => 'Salju';

  @override
  String get fromZero => 'Dari nol';

  @override
  String get altitudeShort => 'Ketinggian';

  @override
  String get barometerIos =>
      'Barometer tidak bisa dibaca. Aktifkan Gerakan & Kebugaran untuk aplikasi ini di Pengaturan › Privasi & Keamanan, lalu buka Altimeter lagi.';

  @override
  String get noBarometer =>
      'Ponsel ini tidak punya barometer (sensor tekanan udara), jadi altimeter tidak bisa berfungsi di sini. Alat lain tetap berfungsi.';

  @override
  String get noLightSensor =>
      'Ponsel ini tidak punya sensor cahaya, jadi pengukur cahaya tidak bisa berfungsi di sini. Alat lain tetap berfungsi.';

  @override
  String lightSemantics(String value) {
    return 'Kecerahan $value lux';
  }

  @override
  String get illuminance => 'Kecerahan';

  @override
  String get footCandles => 'Foot-candle';

  @override
  String get lightDark => 'Gelap';

  @override
  String get lightDim => 'Cahaya redup';

  @override
  String get lightLivingRoom => 'Cahaya ruang tamu';

  @override
  String get lightReading => 'Cocok untuk membaca dan bekerja di meja';

  @override
  String get lightBright => 'Cahaya dalam ruang terang';

  @override
  String get lightOvercast => 'Siang berawan';

  @override
  String get lightDaylight => 'Cahaya siang';

  @override
  String get lightSun => 'Sinar matahari langsung';

  @override
  String get lightHelp1 =>
      'Sensor cahaya ada di bagian atas layar, dekat kamera depan.';

  @override
  String get lightHelp2 =>
      'Pegang ponsel di tempat yang ingin diukur, dengan layar menghadap cahaya.';

  @override
  String get lightHelp3 =>
      'Langit mengikuti cahaya: malam saat gelap, fajar di ruangan redup, dan matahari naik saat makin terang. Baca lux dan untuk apa cahaya itu cocok: 300 sampai 750 lx cocok untuk membaca dan bekerja di meja.';

  @override
  String get lightHelp4 =>
      'Ketuk Kunci untuk menyimpan bacaan saat Anda menjauhkan ponsel.';

  @override
  String get lightTip =>
      'Sensor cahaya berbeda di tiap ponsel, jadi bacaan bisa meleset 10 sampai 20%: bagus untuk membandingkan tempat, bukan pengukur lux yang terkalibrasi. Jangan tutupi bagian atas layar.';

  @override
  String get noMicrophone =>
      'Mikrofon tidak bisa dipakai. Mungkin aplikasi lain sedang memakainya: tutup aplikasi itu, lalu buka lagi pengukur suara.';

  @override
  String soundSemantics(String value) {
    return 'Tingkat suara sekitar $value desibel';
  }

  @override
  String get decibelsApprox => 'dB (perkiraan)';

  @override
  String get soundMax => 'Maks';

  @override
  String get soundVeryQuiet => 'Sangat sunyi';

  @override
  String get soundQuiet => 'Sunyi, seperti perpustakaan';

  @override
  String get soundModerate => 'Sedang, seperti percakapan';

  @override
  String get soundLoud => 'Keras, seperti lalu lintas padat';

  @override
  String get soundVeryLoud =>
      'Sangat keras: paparan lama bisa merusak pendengaran';

  @override
  String get soundDangerous => 'Berbahaya: lindungi telinga Anda';

  @override
  String get micTitle => 'Izinkan mikrofon';

  @override
  String get micBody =>
      'Pengukur suara mendengarkan lewat mikrofon untuk mengukur seberapa keras suara. Suara diukur di ponsel Anda dan tidak pernah direkam, disimpan, atau dikirim.';

  @override
  String get micAllow => 'Izinkan mikrofon';

  @override
  String get micDeniedTitle => 'Akses mikrofon nonaktif';

  @override
  String get micDeniedBody =>
      'Aktifkan mikrofon untuk aplikasi ini di Setelan agar bisa memakai pengukur suara. Suara tidak pernah direkam, disimpan, atau dikirim.';

  @override
  String get openSettings => 'Buka setelan';

  @override
  String get tryAgain => 'Coba lagi';

  @override
  String get soundHelp1 =>
      'Biarkan mikrofon (di tepi bawah) terbuka dan arahkan ponsel ke sumber suara.';

  @override
  String get soundHelp2 =>
      'Angka besar adalah tingkat suara saat ini, dirata-rata sekitar satu detik. Riak menyebar darinya, makin banyak dan makin jauh saat makin keras: hijau saat sunyi, lalu kuning, oranye, merah, dan merah tua. Batang di bawah menunjukkan tiga detik terakhir.';

  @override
  String get soundHelp3 =>
      'Rata-rata dan Maks dihitung sejak alat dibuka. Ketuk Atur ulang untuk memulai lagi.';

  @override
  String get soundHelp4 =>
      'Mulai 70 dB baris status menjadi kuning; mulai 85 dB, saat paparan lama bisa merusak pendengaran, menjadi merah.';

  @override
  String get soundHelp5 =>
      'Ketuk gembok untuk menahan bacaan di layar saat Anda menggerakkan ponsel.';

  @override
  String get soundTip =>
      'Mikrofon tiap ponsel berbeda, jadi bacaan bisa meleset sekitar 5 dB: bagus untuk membandingkan, bukan pengukur suara bersertifikat. Suara yang sangat keras (di atas sekitar 110 dB) bisa terbaca lebih rendah.';

  @override
  String get metresFromZero => 'm dari nol';

  @override
  String pressureSemantics(String value) {
    return 'Tekanan udara $value hektopascal';
  }

  @override
  String heightSemantics(String value) {
    return 'Ketinggian $value dari nol';
  }

  @override
  String get pressure => 'Tekanan';

  @override
  String get altitudeApprox => 'Ketinggian (perkiraan)';

  @override
  String get measuringHeight => 'Mengukur ketinggian dari titik nol Anda';

  @override
  String get airPressureAltitude => 'Tekanan udara dan ketinggian';

  @override
  String get appearance => 'Tampilan';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get levelUnits => 'Satuan waterpass';

  @override
  String get unitDegrees => 'Derajat';

  @override
  String get unitPercent => 'Kemiringan persen';

  @override
  String get unitRoofPitch => 'Kemiringan atap (naik per 12)';

  @override
  String get vibrateWhenLevel => 'Getaran';

  @override
  String get sounds => 'Suara';

  @override
  String get resetCalibration => 'Atur ulang kalibrasi';

  @override
  String get resetCalibrationHint =>
      'Gunakan lagi titik nol sensor bawaan pabrik';

  @override
  String get calibrateHere => 'Kalibrasi di sini';

  @override
  String get calibrateHereInfo => 'Di permukaan yang Anda tahu rata';

  @override
  String get calibrationRemoved =>
      'Kalibrasi dihapus. Waterpass kembali memakai nol bawaan pabrik sensor.';

  @override
  String get resetAllCalibrations => 'Atur ulang semua kalibrasi';

  @override
  String get resetAllCalibrationsHint =>
      'Waterpass dan penggaris kembali ke setelan pabrik';

  @override
  String get resetAllTitle => 'Atur ulang semua kalibrasi?';

  @override
  String get resetAllBody =>
      'Ini menghapus kalibrasi yang Anda atur di waterpass (juga dipakai pengukur sudut) dan di penggaris. Keduanya kembali ke setelan pabrik. Setelan lain tetap sama, dan Anda bisa mengkalibrasi lagi kapan saja.';

  @override
  String get notCalibrated => 'Belum dikalibrasi';

  @override
  String get language => 'Bahasa';

  @override
  String get licenses => 'Lisensi sumber terbuka';

  @override
  String get languageSystem => 'Bahasa ponsel';

  @override
  String get toolHeight => 'Tinggi';

  @override
  String get toolHeightSubtitle => 'Tinggi dan jarak dengan membidik';

  @override
  String get heightHelp1 =>
      'Berdirilah di tempat Anda bisa melihat dasar dan puncak objek. Pegang ponsel dengan layar menghadap ke atas dan lihat sepanjang tepi atasnya.';

  @override
  String get heightHelp2 =>
      'Arahkan tepi atas ke dasar objek lalu ketuk Kunci dasar: ini memberi jaraknya.';

  @override
  String get heightHelp3 =>
      'Arahkan tepi atas ke puncak lalu ketuk Kunci puncak: tingginya muncul.';

  @override
  String get heightHelp4 =>
      'Tahu jaraknya? Ketuk Jarak dan ketik, lalu bidik puncaknya saja. Ketuk Tinggi mata untuk mengatur milik Anda.';

  @override
  String get heightTip =>
      'Sekitar ±5% di tanah datar dengan tinggi mata yang benar (tinggi badan dikurangi sekitar 10 cm). Mundurlah agar puncak di bawah 70° dan dasar minimal 3° di bawah datar. Di lereng, ketik jaraknya.';

  @override
  String get lockBase => 'Kunci dasar';

  @override
  String get lockTop => 'Kunci puncak';

  @override
  String get measureAgain => 'Ukur lagi';

  @override
  String get distance => 'Jarak';

  @override
  String get objectHeight => 'Tinggi';

  @override
  String get eyeHeight => 'Tinggi mata';

  @override
  String get sightAngle => 'Sudut bidik';

  @override
  String get heightAimBase => 'Arahkan tepi atas ke dasar';

  @override
  String get heightAimTop => 'Sekarang arahkan tepi atas ke puncak';

  @override
  String get heightDone => 'Selesai · ketuk Ukur lagi untuk yang lain';

  @override
  String get heightHoldFlatter =>
      'Pegang ponsel lebih datar dan bidik sepanjang tepi atas';

  @override
  String get heightTooFar =>
      'Dasar terlalu dekat dengan datar: mendekatlah atau ketik jaraknya';

  @override
  String get heightStepBack =>
      'Sangat curam: mundurlah agar bacaan lebih stabil';

  @override
  String get knownDistance => 'Jarak ke dasar';

  @override
  String get knownDistanceHint =>
      'Jarak di sepanjang tanah ke dasar objek. Hapus untuk mengukurnya dengan membidik.';

  @override
  String get eyeHeightHint =>
      'Tinggi mata Anda dari tanah: sekitar tinggi badan dikurangi 10 cm.';

  @override
  String get clear => 'Hapus';

  @override
  String get toolCamera => 'Waterpass kamera';

  @override
  String get toolCameraSubtitle => 'Kisi-kisi datar di atas kamera';

  @override
  String get cameraHelp1 =>
      'Arahkan kamera belakang ke dinding, rak, ubin, atau pigura sambil memegang ponsel tegak.';

  @override
  String get cameraHelp2 =>
      'Kisi-kisi mengikuti gravitasi, bukan layar: garisnya selalu tepat datar dan tegak lurus. Sejajarkan tepi di gambar dengannya; tepi yang miring memotong garis.';

  @override
  String get cameraHelp3 =>
      'Tanda silang di tengah berubah oranye saat ponsel datar. Kemiringan menunjukkan seberapa jauh ponsel berputar, Maju/mundur seberapa jauh ponsel condong ke dinding atau ke arah Anda.';

  @override
  String get cameraHelp4 =>
      'Pilih kotak kecil, sedang, atau besar di atas. Bekukan menahan gambar dan bacaan; lampu membantu di sudut gelap.';

  @override
  String get cameraTip =>
      'Pegang ponsel sejajar dinding untuk gambar paling tepat; garis di dekat tepi layar bisa sedikit melengkung karena lensa. Memakai kalibrasi sisi dari waterpass. Gambar tidak pernah direkam, disimpan, atau dikirim.';

  @override
  String get cameraAllowTitle => 'Izinkan kamera';

  @override
  String get cameraAllowBody =>
      'Waterpass kamera menggambar kisi-kisi datar di atas gambar kamera. Gambar tetap di ponsel Anda dan tidak pernah direkam, disimpan, atau dikirim.';

  @override
  String get cameraAllow => 'Izinkan kamera';

  @override
  String get cameraDeniedTitle => 'Akses kamera nonaktif';

  @override
  String get cameraDeniedBody =>
      'Aktifkan kamera untuk aplikasi ini di Setelan agar bisa memakai waterpass kamera. Gambar tidak pernah direkam, disimpan, atau dikirim.';

  @override
  String get noCamera =>
      'Kamera tidak bisa dipakai. Mungkin aplikasi lain sedang memakainya atau ponsel tidak punya kamera: tutup aplikasi kamera lain, lalu buka lagi waterpass kamera.';

  @override
  String get tilt => 'Kemiringan';

  @override
  String get forwardBack => 'Maju/mundur';

  @override
  String get cameraLevel => 'Datar';

  @override
  String cameraTilted(String value) {
    return 'Miring $value°';
  }

  @override
  String get cameraHoldUpright => 'Pegang ponsel tegak, kamera ke dinding';

  @override
  String get freeze => 'Bekukan';

  @override
  String get resume => 'Lanjutkan';

  @override
  String get torch => 'Lampu';

  @override
  String get gridSmall => 'Kotak kecil';

  @override
  String get gridMedium => 'Kotak sedang';

  @override
  String get gridLarge => 'Kotak besar';

  @override
  String cameraSemantics(String value) {
    return 'Tampilan kamera dengan kisi-kisi datar, miring $value derajat';
  }
}
