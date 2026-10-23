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
  String get homeTopTools => 'Alat utama Anda';

  @override
  String get homeMoreTools => 'Alat lainnya';

  @override
  String get homeArrange => 'Atur';

  @override
  String get arrangeTitle => 'Atur alat';

  @override
  String get arrangeHint =>
      'Seret untuk mengubah urutan. Tiga teratas adalah alat utama Anda.';

  @override
  String get arrangeStar => 'Jadikan alat utama';

  @override
  String get arrangeUnstar => 'Hapus dari alat utama';

  @override
  String get arrangeReset => 'Urutan populer';

  @override
  String get arrangeDone => 'Selesai';

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
  String get sensorCamera => 'kamera belakang';

  @override
  String get sensorGps => 'GPS';

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
      'Kompas menunjuk utara magnetis, yang di beberapa tempat bisa berbeda 10 derajat atau lebih dari utara peta. Jika terlihat salah, gerakkan ponsel membentuk angka 8 beberapa kali.';

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
  String get rulerWidthOn => 'Ukur lebar juga';

  @override
  String rulerArea(String value) {
    return 'Luas $value';
  }

  @override
  String rulerBoxSemantics(String length, String width, String area) {
    return 'Panjang $length milimeter, lebar $width milimeter, luas $area sentimeter persegi';
  }

  @override
  String get rulerHelp5 =>
      'Ketuk tombol persegi panjang di atas untuk mengukur lebar juga: seret dua garis samping ke sisi benda untuk melihat lebar dan luasnya. Lebar paling besar selebar layar.';

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
      'Pendaki di gunung naik dan turun mengikuti perubahan ketinggian Anda. Langit mengikuti waktu dan musim; ketuk tombol cuaca untuk memilih sendiri.';

  @override
  String get altimeterHelp2 =>
      'Untuk mengukur perubahan ketinggian, seperti tangga atau lantai, ketuk Atur nol di sini di titik awal.';

  @override
  String get altimeterHelp3 =>
      'Naik atau turun: pendaki berjalan bersama Anda dan bendera menandai titik tertinggi. Panel menunjukkan meter dari nol, tekanan udara, dan perkiraan ketinggian.';

  @override
  String get altimeterHelp4 =>
      'Ketuk Hapus nol untuk berhenti mengukur dari titik nol Anda: nilai Dari nol kembali kosong.';

  @override
  String get altimeterTip =>
      'Cuaca terus mengubah tekanan udara, jadi tanpa ketinggian awal yang diketahui, ketinggian bisa meleset seratus meter atau lebih. Percayai perubahan ketinggian dari Atur nol di sini dalam waktu singkat. Alat ini memerlukan ponsel dengan barometer.';

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
      'Sensor cahaya ponsel tidak terkalibrasi, jadi bacaan bisa sangat berbeda antar ponsel. Gunakan untuk membandingkan cahaya di satu tempat dengan ponsel yang sama, bukan sebagai pengukur lux yang terkalibrasi. Jangan tutupi bagian atas layar.';

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
      'Mikrofon ponsel bukan pengukur suara yang terkalibrasi dan berbeda tiap model, jadi bacaan hanya perkiraan (sering meleset sekitar 5 sampai 10 dB) dan suara yang sangat keras bisa terbaca lebih rendah. Untuk keperluan resmi, gunakan pengukur suara yang terkalibrasi.';

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
  String get toolCameraSubtitle =>
      'Garis datar di atas kamera, ukur tepi apa pun';

  @override
  String get cameraHelp1 =>
      'Arahkan kamera belakang ke dinding, pigura, rak, atau pintu. Pegang ponsel tegak dan menghadap lurus ke dinding.';

  @override
  String get cameraHelp2 =>
      'Garis utuh mengikuti gravitasi: selalu tepat datar dan tegak lurus. Garis putus-putus menempel pada ponsel, dan busur kecil di antaranya menunjukkan seberapa miring ponsel. Garis sebenarnya berubah oranye saat ponsel datar.';

  @override
  String get cameraHelp3 =>
      'Untuk memeriksa benda, ketuk Bekukan, lalu seret dua pegangan oranye ke salah satu tepinya, misalnya bagian atas pigura. Anda akan melihat seberapa miring tepi itu dan sisi mana yang perlu diangkat, meski tangan Anda tidak datar. Tegakkan garis untuk memeriksa tepi tegak lurus.';

  @override
  String get cameraHelp4 =>
      'Dua tombol di atas menampilkan atau menyembunyikan garis ponsel dan garis sebenarnya. Lampu membantu di sudut gelap; Lanjutkan kembali ke gambar langsung.';

  @override
  String get cameraTip =>
      'Agar tepi terukur tepat, hadapkan ponsel lurus ke dinding (Maju/mundur di bawah 5°) dan ukur di dekat tengah gambar, tempat lensa paling sedikit membengkokkan garis. Memakai kalibrasi sisi dari waterpass. Gambar tidak pernah direkam, disimpan, atau dikirim.';

  @override
  String get cameraAllowTitle => 'Izinkan kamera';

  @override
  String get cameraAllowBody =>
      'Waterpass kamera menggambar garis datar di atas gambar kamera dan mengukur tepi di dalamnya. Gambar tetap di ponsel Anda dan tidak pernah direkam, disimpan, atau dikirim.';

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
  String cameraSemantics(String value) {
    return 'Tampilan kamera dengan garis datar, miring $value derajat';
  }

  @override
  String get cameraPhoneLines => 'Garis ponsel';

  @override
  String get cameraTrueLines => 'Garis sebenarnya';

  @override
  String get cameraFrozen => 'Dibekukan';

  @override
  String get cameraDragHandles => 'Seret pegangan ke sebuah tepi';

  @override
  String get cameraFaceWall => 'Hadapkan ponsel lurus ke dinding';

  @override
  String get edgeLevel => 'Tepi ini datar';

  @override
  String get edgePlumb => 'Tepi ini tegak lurus';

  @override
  String edgeLiftRight(String value) {
    return 'Tepi miring $value°, angkat kanan';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'Tepi miring $value°, angkat kiri';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'Tepi $value° dari tegak lurus';
  }

  @override
  String get cameraHandle => 'Pegangan tepi';

  @override
  String get toolGForce => 'Gaya G';

  @override
  String get toolGForceSubtitle =>
      'Pengereman, akselerasi, dan tikungan dalam g';

  @override
  String get gHelp1 =>
      'Pasang ponsel di dudukan mobil dengan layar menghadap Anda. Saat mobil diam, ketuk Nol: alat ini mempelajari arah bawah dan arah depan.';

  @override
  String get gHelp2 =>
      'Berkendaralah: sisi mobil ke arah Anda terdorong akan menyala. Mengerem menyalakan bagian depan, akselerasi bagian belakang, dan tikungan sisi luar. Hijau berarti ringan, oranye kuat, merah keras.';

  @override
  String get gHelp3 =>
      'Panel menyimpan akselerasi, pengereman, dan tikungan terkuat sejak Nol, dan titik di tepi menyimpan dorongan terkuat ke setiap arah. Tombol reset menghapusnya.';

  @override
  String get gHelp4 =>
      'Tetap fokus ke jalan: biarkan penumpang yang membaca, atau periksa puncaknya setelah Anda berhenti.';

  @override
  String get gTip =>
      'Nilai berasal dari akselerometer dan bersifat perkiraan: bergantung pada dudukan yang kokoh dan Nol yang diatur saat diam, serta sedikit lebih bergejolak di jalan rusak. Jika dudukan bergeser, berhentilah dan ketuk Nol lagi. Di atas 0,5 g berarti pengereman keras atau tikungan cepat untuk mobil biasa.';

  @override
  String get gZero => 'Nol';

  @override
  String get gResetPeaks => 'Reset puncak';

  @override
  String get gSpeedUp => 'Akselerasi';

  @override
  String get gBrake => 'Rem';

  @override
  String get gCorner => 'Tikungan';

  @override
  String get gSteady => 'Stabil';

  @override
  String gBraking(String value) {
    return 'Mengerem $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'Berakselerasi $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'Tikungan kiri $value g';
  }

  @override
  String gRightBend(String value) {
    return 'Tikungan kanan $value g';
  }

  @override
  String gSemantics(String value) {
    return 'Gaya G $value g';
  }

  @override
  String get gZeroed => 'Nol diatur: arah depan dan bawah dipelajari';

  @override
  String get noAccelerometerG =>
      'Ponsel ini tidak punya akselerometer, jadi gaya G tidak bisa diukur di sini. Alat lain tetap berfungsi.';

  @override
  String get toolSpeed => 'Speedometer';

  @override
  String get toolSpeedSubtitle => 'Kecepatan, perjalanan, dan ketinggian GPS';

  @override
  String get speedHelp1 =>
      'Izinkan lokasi, lalu letakkan ponsel di tempat yang bisa melihat langit, seperti di dasbor atau di dudukan kaca depan. Di luar ruangan, posisi pertama butuh beberapa detik.';

  @override
  String get speedHelp2 =>
      'Meteran di dasbor menunjukkan kecepatan Anda dari GPS, dengan jarak perjalanan dan ketinggian di kedua sisinya. Panel menyimpan jarak, kecepatan tertinggi, dan rata-rata sejak terakhir Anda atur ulang.';

  @override
  String get speedHelp3 =>
      'Ketuk koordinat untuk menyalinnya. Tombol satuan beralih antara km/jam dan mil/jam, dan Atur ulang perjalanan memulai lagi jarak, tertinggi, dan rata-rata.';

  @override
  String get speedHelp4 =>
      'Tetap fokus ke jalan: biarkan penumpang yang membaca, atau periksa perjalanan setelah Anda berhenti.';

  @override
  String get speedTip =>
      'Kecepatan berasal dari satelit dan biasanya hanya meleset sekitar 1 km/jam di jalan terbuka; di terowongan, di antara gedung tinggi, atau di dalam ruangan, kecepatan bisa tertinggal atau hilang. Ketinggian GPS bisa meleset 10 sampai 50 m, jadi pakai Altimeter untuk perubahan ketinggian. Lokasi hanya dipakai selama alat ini terbuka dan tidak pernah keluar dari ponsel Anda.';

  @override
  String get speedAllowTitle => 'Izinkan lokasi';

  @override
  String get speedAllowBody =>
      'Speedometer memakai GPS untuk mengukur kecepatan, jarak, dan ketinggian Anda. Lokasi hanya dipakai selama alat ini terbuka di layar, tidak pernah di latar belakang, dan tidak pernah keluar dari ponsel Anda.';

  @override
  String get speedAllow => 'Izinkan lokasi';

  @override
  String get speedDeniedTitle => 'Akses lokasi nonaktif';

  @override
  String get speedDeniedBody =>
      'Aktifkan lokasi untuk aplikasi ini di Setelan agar bisa memakai speedometer. Lokasi hanya dipakai selama alat terbuka dan tidak pernah keluar dari ponsel Anda.';

  @override
  String get speedServiceOffTitle => 'Lokasi dimatikan';

  @override
  String get speedServiceOffBody =>
      'Aktifkan lokasi di setelan ponsel agar bisa memakai speedometer.';

  @override
  String get speedDistance => 'Jarak';

  @override
  String get speedTop => 'Tertinggi';

  @override
  String get speedAverage => 'Rata-rata';

  @override
  String get speedTrip => 'Perjalanan';

  @override
  String get speedAltitude => 'Ketinggian';

  @override
  String get speedResetTrip => 'Atur ulang perjalanan';

  @override
  String get speedFinding => 'Mencari satelit…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value m';
  }

  @override
  String get speedWeak => 'GPS lemah: kecepatan bisa tertinggal';

  @override
  String get speedApproximate =>
      'Lokasi akurat mati: nyalakan agar kecepatan stabil';

  @override
  String get speedStill => 'Diam';

  @override
  String get speedCopied => 'Koordinat disalin';

  @override
  String get speedUnitTooltip => 'Beralih antara km/jam dan mil/jam';

  @override
  String get speedKmh => 'km/jam';

  @override
  String get speedMph => 'mil/jam';

  @override
  String speedSemantics(String value) {
    return 'Kecepatan $value';
  }

  @override
  String get speedCoordinates => 'Koordinat, ketuk untuk menyalin';

  @override
  String get noGps =>
      'Ponsel ini tidak punya GPS, jadi kecepatan tidak bisa diukur di sini. Alat lain tetap berfungsi.';

  @override
  String get speedSceneHelp =>
      'Langit mengikuti waktu. Tombol cuaca memilih pemandangan: Otomatis mengikuti musim, atau pilih cerah, berawan, hujan, badai, atau salju. Ini hanya pemandangan, bukan prakiraan cuaca.';

  @override
  String get supportTitle => 'Gratis, tanpa iklan';

  @override
  String get supportBody =>
      'Dibuat oleh satu orang di waktu luang. Jika aplikasi ini membantu Anda, Anda bisa mendukungnya.';

  @override
  String get supportButton => 'Dukung di GitHub';

  @override
  String get linkCopied => 'Tautan disalin';

  @override
  String madeBy(String name) {
    return 'Dirancang dan dibuat oleh $name';
  }

  @override
  String testFeedbackTitle(String app) {
    return 'Bantu jadikan $app lebih baik';
  }

  @override
  String get testFeedbackBody =>
      'Menemukan masalah atau punya ide? Saya membaca setiap pesan.';

  @override
  String get testEmailMe => 'Email saya';

  @override
  String testEmailSubject(String app) {
    return 'Masukan untuk $app';
  }

  @override
  String get testEmailCopied => 'Alamat email disalin';

  @override
  String get testEndedTitle => 'Versi uji ini sudah berakhir';

  @override
  String get testEndedBody =>
      'Terima kasih sudah menguji! Silakan gunakan versi baru. Untuk mendapatkannya, tulis ke saya:';

  @override
  String get toolTracker => 'Cek pelacak';

  @override
  String get toolTrackerSubtitle => 'Pelacak tersembunyi yang mengikuti Anda';

  @override
  String get sensorBluetooth => 'Bluetooth';

  @override
  String get trackerHelp1 =>
      'Ketuk Pindai di sini untuk melihat pelacak Bluetooth di dekat Anda yang jauh dari pemiliknya: AirTag, Galaxy SmartTag, Tile, Chipolo, dan tag Find Hub.';

  @override
  String get trackerHelp2 =>
      'Untuk tahu apakah ada yang mengikuti Anda, ketuk Periksa saat bergerak dan biarkan alat ini terbuka saat berjalan atau berkendara; layar tetap menyala. Pelacak yang terdengar di 3 tempat selama 30 menit atau lebih ikut bepergian bersama Anda.';

  @override
  String get trackerHelp3 =>
      'Ketuk pelacak untuk mencarinya: berjalanlah perlahan dan ikuti angka yang naik. Di Tampilkan semua, tandai pelacak Anda sebagai Ini milik saya agar tidak muncul lagi.';

  @override
  String get trackerHelp4 =>
      'Kotak GPS dengan kartu SIM tidak bisa didengar ponsel mana pun. Ketuk Cek mobil: sebagian besar ditempel dengan magnet kuat, yang bisa ditemukan detektor logam.';

  @override
  String get trackerTip =>
      'Alat ini hanya mendengar saat terbuka dan tidak bisa mendengar semua pelacak. Pelacak milik keluarga, atau milik orang asing di kereta yang sama, juga bisa muncul, dan pelacak yang dekat pemiliknya tidak ditampilkan. Jika Anda merasa dilacak seseorang, hubungi polisi atau layanan bantuan.';

  @override
  String get trackerAllowTitle => 'Izinkan pemindaian Bluetooth';

  @override
  String get trackerAllowBody =>
      'Cek pelacak mendengarkan pelacak Bluetooth di dekat Anda. Alat ini hanya mendengar saat terbuka, tidak pernah terhubung ke pelacak, dan tidak ada yang didengarnya keluar dari ponsel Anda.';

  @override
  String get trackerAllow => 'Izinkan Bluetooth';

  @override
  String get trackerDeniedTitle => 'Pemindaian Bluetooth nonaktif';

  @override
  String get trackerDeniedBody =>
      'Izinkan Perangkat di sekitar untuk aplikasi ini di Setelan agar dapat memakai Cek pelacak.';

  @override
  String get trackerBluetoothOffTitle => 'Bluetooth nonaktif';

  @override
  String get trackerBluetoothOffBody =>
      'Nyalakan Bluetooth untuk mendengarkan pelacak. Aplikasi tidak pernah terhubung ke apa pun.';

  @override
  String get trackerLocationOffTitle => 'Lokasi nonaktif';

  @override
  String get trackerLocationOffBody =>
      'Pada versi Android ini, pemindaian Bluetooth hanya berfungsi jika lokasi aktif. Tidak ada yang dilacak lokasinya dari situ.';

  @override
  String get trackerScanHere => 'Pindai di sini';

  @override
  String get trackerCheckMoving => 'Periksa saat bergerak';

  @override
  String get trackerStop => 'Berhenti';

  @override
  String get trackerDone => 'Selesai';

  @override
  String get trackerLocationNeeded =>
      'Periksa saat bergerak mencatat tempat dengan GPS: izinkan lokasi.';

  @override
  String get trackerSimNote => 'Kotak GPS ber-SIM tidak bisa didengar';

  @override
  String get trackerCarCheck => 'Cek mobil';

  @override
  String get carCheckBody =>
      'Sebagian pelacak berupa kotak GPS dengan kartu SIM yang disembunyikan di mobil. Tidak ada ponsel yang bisa mendengarnya, tetapi sebagian besar ditempel dengan magnet kuat, yang bisa ditemukan detektor logam.';

  @override
  String get carSpot1 => 'Di bawah bemper, depan dan belakang';

  @override
  String get carSpot2 => 'Di dalam spakbor roda';

  @override
  String get carSpot3 => 'Di bawah jok dan di bagasi';

  @override
  String get carSpot4 => 'Di balik port diagnostik (OBD) di bawah dasbor';

  @override
  String get carCheckTip =>
      'Gerakkan tepi atas ponsel perlahan di atas setiap tempat. Lonjakan angka berarti ada logam atau magnet: periksa lebih dekat.';

  @override
  String get carOpenMetal => 'Buka detektor logam';

  @override
  String get trackerPaused => 'Dijeda saat aplikasi tersembunyi';

  @override
  String trackerFollowingBanner(String name, int places) {
    return '$name bepergian bersama Anda: terdengar di $places tempat';
  }

  @override
  String trackerMoving(int minutes, int places) {
    return 'Memeriksa selama $minutes menit. Tempat dilewati: $places';
  }

  @override
  String get trackerListening => 'Mendengarkan pelacak';

  @override
  String get trackerNothingHeard =>
      'Tidak ada pelacak jauh dari pemiliknya di sini';

  @override
  String get trackerIdle => 'Pindai untuk melihat pelacak di dekat Anda';

  @override
  String trackerSemantics(int following, int nearby) {
    return 'Mengikuti Anda: $following. Pelacak di dekat: $nearby.';
  }

  @override
  String trackerShowAll(int count) {
    return 'Tampilkan semua ($count)';
  }

  @override
  String trackerAllTitle(int count) {
    return 'Pelacak di dekat: $count';
  }

  @override
  String get trackerKindFindMy => 'Tag Lacak';

  @override
  String get trackerKindFindHub => 'Tag Find Hub';

  @override
  String get trackerKindDult => 'Pelacak barang';

  @override
  String get trackerClose => 'Dekat';

  @override
  String get trackerNear => 'Sedang';

  @override
  String get trackerFar => 'Jauh';

  @override
  String trackerFollowingYou(int places) {
    return 'Mengikuti Anda · tempat: $places';
  }

  @override
  String trackerPlaces(int count) {
    return 'Terdengar di $count tempat';
  }

  @override
  String get trackerMine => 'Ini milik saya';

  @override
  String get trackerNotMine => 'Bukan milik saya';

  @override
  String get trackerFollowingLabel => 'mengikuti';

  @override
  String trackerNearby(int count) {
    return 'di dekat: $count';
  }

  @override
  String trackerFindTitle(String name) {
    return 'Cari $name';
  }

  @override
  String get trackerFindHint =>
      'Berjalanlah perlahan mengelilingi mobil atau tas dan ikuti angka yang naik. Sinyal hanya menunjukkan jarak, bukan arah.';

  @override
  String get trackerFindLost => 'Tidak terdengar: bergerak perlahan';

  @override
  String get findFar => 'Jauh';

  @override
  String get findCloser => 'Makin dekat';

  @override
  String get findNear => 'Dekat';

  @override
  String get findHere => 'Tepat di sini';

  @override
  String get trackerAppleSound =>
      'Lacak dari Apple, atau aplikasi Tracker Detect di Android, bisa membuat AirTag berbunyi.';

  @override
  String get trackerScanFailed =>
      'Pemindaian berhenti. Periksa Bluetooth lalu pindai lagi.';

  @override
  String get trackerGpsLost => 'Tidak ada sinyal GPS: tempat tidak dicatat';

  @override
  String get trackerHeardEarlier => 'Terdengar tadi';

  @override
  String get trackerKindSamsung => 'Tag atau perangkat Samsung';

  @override
  String get trackerKindApple => 'Perangkat Apple';

  @override
  String get trackerWhatToDo => 'Apa yang harus dilakukan';

  @override
  String get trackerSafetyTitle => 'Jika pelacak mengikuti Anda';

  @override
  String get trackerSafety1 =>
      'Di bus, kereta, atau pesawat bisa jadi milik orang lain: periksa lagi setelah turun.';

  @override
  String get trackerSafety2 =>
      'Jika merasa tidak aman, pergilah ke tempat ramai dan hubungi polisi.';

  @override
  String get trackerSafety3 =>
      'Temukan dengan Cari. Foto pelacaknya, tempat ia disembunyikan, dan nomor serinya, beserta tanggal dan waktu.';

  @override
  String get trackerSafety4 =>
      'Jangan bawa pulang dan jangan hubungi pemiliknya.';

  @override
  String get trackerSafety5 =>
      'Melepas baterainya akan menghentikannya, tetapi pemiliknya bisa tahu. Jika Anda tinggal bersama orang itu, bicaralah dulu dengan layanan bantuan.';

  @override
  String get trackerSafety6 =>
      'Mematikan Bluetooth atau lokasi Anda sendiri tidak menghentikannya melaporkan posisi Anda.';
}
