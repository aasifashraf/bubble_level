// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'ببل لیول اور زاویہ پیما';

  @override
  String get homeTitle => 'ببل لیول';

  @override
  String get settings => 'ترتیبات';

  @override
  String get homeTopTools => 'آپ کے خاص ٹولز';

  @override
  String get homeMoreTools => 'مزید ٹولز';

  @override
  String get homeArrange => 'ترتیب';

  @override
  String get arrangeTitle => 'ٹولز کی ترتیب';

  @override
  String get arrangeHint =>
      'ترتیب بدلنے کے لیے کھینچیں۔ پہلے تین آپ کے خاص ٹولز ہوں گے۔';

  @override
  String get arrangeStar => 'خاص ٹول بنائیں';

  @override
  String get arrangeUnstar => 'خاص ٹولز سے ہٹائیں';

  @override
  String get arrangeReset => 'مقبول ترتیب';

  @override
  String get arrangeDone => 'ہو گیا';

  @override
  String get back => 'واپس';

  @override
  String get lightMode => 'لائٹ موڈ';

  @override
  String get darkMode => 'ڈارک موڈ';

  @override
  String get toolLevel => 'لیول';

  @override
  String get toolLevelSubtitle => 'ببل لیول اور اسپرٹ لیول';

  @override
  String get toolAngle => 'زاویہ';

  @override
  String get toolAngleSubtitle => 'ہموار سطح یا آپ کے صفر سے زاویہ';

  @override
  String get toolCompass => 'قطب نما';

  @override
  String get toolCompassSubtitle => 'رخ اور سمت';

  @override
  String get toolProtractor => 'زاویہ پیما';

  @override
  String get toolProtractorSubtitle => 'اسکرین پر زاویے ناپیں';

  @override
  String get toolRuler => 'رولر';

  @override
  String get toolRulerSubtitle => 'اسکرین پر لمبائی ناپیں';

  @override
  String get toolMetal => 'میٹل ڈیٹیکٹر';

  @override
  String get toolMetalSubtitle => 'لوہا، اسٹیل اور مقناطیس تلاش کریں';

  @override
  String get toolVibration => 'ارتعاش';

  @override
  String get toolVibrationSubtitle => 'ارتعاش کی طاقت اور رفتار (RPM)';

  @override
  String get toolSound => 'ساؤنڈ میٹر';

  @override
  String get toolSoundSubtitle => 'ڈیسیبل میں شور';

  @override
  String get toolAltimeter => 'بلندی پیما';

  @override
  String get toolAltimeterSubtitle => 'ہوا کا دباؤ اور اونچائی';

  @override
  String get toolLight => 'لائٹ میٹر';

  @override
  String get toolLightSubtitle => 'لکس میں روشنی';

  @override
  String get notAvailableOnPhone => 'اس فون پر دستیاب نہیں';

  @override
  String get notOnPhone => 'دستیاب نہیں';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool، اس فون پر دستیاب نہیں';
  }

  @override
  String get howToUse => 'استعمال کا طریقہ';

  @override
  String get rotateLandscape => 'افقی رخ پر گھمائیں';

  @override
  String get rotatePortrait => 'عمودی رخ پر گھمائیں';

  @override
  String howToUseTool(String tool) {
    return '$tool کیسے استعمال کریں';
  }

  @override
  String get gotIt => 'سمجھ گیا';

  @override
  String get goodToKnow => 'جاننے کی بات: ';

  @override
  String get ok => 'ٹھیک ہے';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool دستیاب نہیں';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ایسے سینسر چاہییں',
      one: 'ایک ایسا سینسر چاہیے',
    );
    return '$tool کو $_temp0 جو اس فون میں نہیں ہے: $sensors۔';
  }

  @override
  String get listSeparator => '، ';

  @override
  String get hardwareLimitTip =>
      'یہ فون کے ہارڈویئر کی حد ہے، ایپ کی خرابی نہیں۔ باقی تمام ٹولز معمول کے مطابق کام کرتے ہیں۔';

  @override
  String get sensorAccelerometer => 'ایکسلرومیٹر';

  @override
  String get sensorMagnetometer => 'میگنیٹومیٹر (قطب نما کا سینسر)';

  @override
  String get sensorBarometer => 'بیرومیٹر (ہوا کے دباؤ کا سینسر)';

  @override
  String get sensorLight => 'لائٹ سینسر';

  @override
  String get sensorMicrophone => 'مائیکروفون';

  @override
  String get sensorCamera => 'پچھلا کیمرہ';

  @override
  String get sensorGps => 'GPS';

  @override
  String get noAccelerometer =>
      'اس فون میں ایکسلرومیٹر نہیں ہے، اس لیے یہ ٹول یہاں کچھ نہیں ناپ سکتا۔ جن ٹولز کو اس کی ضرورت نہیں، وہ کام کرتے رہیں گے۔';

  @override
  String get noMagnetometer =>
      'اس فون میں میگنیٹومیٹر (قطب نما کا سینسر) نہیں ہے، اس لیے یہ ٹول یہاں کام نہیں کر سکتا۔ جن ٹولز کو اس کی ضرورت نہیں، وہ کام کرتے رہیں گے۔';

  @override
  String get noReadings =>
      'سینسر سے ابھی تک کوئی ریڈنگ نہیں آئی۔ واپس جا کر ٹول دوبارہ کھولیں؛ اگر ایسا ہوتا رہے تو فون ری اسٹارٹ کریں۔ کچھ فون یہ ٹول سپورٹ نہیں کرتے۔';

  @override
  String get waitingForSensors => 'سینسرز کا انتظار…';

  @override
  String get levelHelp1 =>
      'فون کو سطح پر سیدھا لٹائیں، یا اس کے کسی کنارے پر کھڑا کریں۔';

  @override
  String get levelHelp2 =>
      'لٹا کر: بلبلے کو درمیان میں لائیں۔ X بائیں/دائیں جھکاؤ ہے، Y آگے/پیچھے۔ کنارے پر کھڑا کرنے سے زاویہ اور ڈھلوان نظر آتی ہے۔';

  @override
  String get levelHelp3 =>
      'اسکرین کی ہدایت (مثلاً «دایاں حصہ اونچا») پر عمل کریں یہاں تک کہ «ہموار» دکھائی دے: ریڈنگ نارنجی ہو جاتی ہے اور فون آواز اور وائبریشن کرتا ہے (ترتیبات سے بند کر سکتے ہیں)۔';

  @override
  String get levelHelp4 =>
      'ریڈنگ روکنے کے لیے لاک کریں دبائیں، اور دوبارہ لائیو ناپنے کے لیے ان لاک کریں۔';

  @override
  String get levelHelp5 =>
      'روایتی اسپرٹ لیول پسند ہے؟ سوئچ میں ٹیوب کا آئیکن دبائیں؛ گول آئیکن ڈائل واپس لاتا ہے۔';

  @override
  String get levelTip =>
      'اگر آپ جانتے ہیں کہ کوئی سطح ہموار ہے مگر 0° نہیں دکھاتی، تو فون اس پر رکھ کر کیلیبریٹ دبائیں۔ اسے واپس لینے کے لیے دوبارہ کیلیبریٹ دبائیں اور کیلیبریشن ری سیٹ کریں چنیں۔';

  @override
  String get statusLevel => 'ہموار';

  @override
  String get leftEndLow => 'بایاں سرا نیچا';

  @override
  String get rightEndLow => 'دایاں سرا نیچا';

  @override
  String get rightSideHigh => 'دایاں حصہ اونچا';

  @override
  String get leftSideHigh => 'بایاں حصہ اونچا';

  @override
  String get topEdgeHigh => 'اوپری کنارہ اونچا';

  @override
  String get bottomEdgeHigh => 'نچلا کنارہ اونچا';

  @override
  String get calibrated => 'کیلیبریٹ ہو گیا۔ یہ حالت اب 0° دکھاتی ہے۔';

  @override
  String get tooFarToCalibrate =>
      'کیلیبریٹ کرنے کے لیے بہت زیادہ جھکا ہوا ہے۔ پہلے فون کو ہموار سطح پر رکھیں۔';

  @override
  String get dialView => 'ڈائل کی شکل';

  @override
  String get tubeView => 'ٹیوب کی شکل';

  @override
  String get levelTube => 'لیول ٹیوب';

  @override
  String get leftRightTube => 'بائیں دائیں کی ٹیوب';

  @override
  String get forwardBackTube => 'آگے پیچھے کی ٹیوب';

  @override
  String tiltFromLevel(String value) {
    return 'ہموار سے جھکاؤ $value';
  }

  @override
  String fromLevel(String value) {
    return 'ہموار سے فرق $value';
  }

  @override
  String get xLeftRight => 'X · بائیں / دائیں';

  @override
  String get yForwardBack => 'Y · آگے / پیچھے';

  @override
  String get angle => 'زاویہ';

  @override
  String get slope => 'ڈھلوان';

  @override
  String get lock => 'لاک کریں';

  @override
  String get unlock => 'ان لاک کریں';

  @override
  String locked(String status) {
    return 'لاک · $status';
  }

  @override
  String get lockReading => 'ریڈنگ لاک کریں';

  @override
  String get lockHandles => 'ہینڈلز لاک کریں';

  @override
  String get handlesLocked => 'ہینڈلز لاک ہیں · تبدیل کرنے کے لیے تالا دبائیں';

  @override
  String get calibrate => 'کیلیبریٹ';

  @override
  String get angleHelp1 =>
      'جھکاؤ پڑھنے کے لیے فون کو کسی سطح پر رکھیں، یا اسے کسی ڈھلوان، ریلنگ یا پائپ کے ساتھ کنارے پر کھڑا کریں: بڑا عدد نارنجی چمکتے کنارے کا زاویہ ہے، نچلے کنارے کا زاویہ اس کے نیچے ہے۔';

  @override
  String get angleHelp2 =>
      'تبدیلی ناپنے کے لیے فون کو شروع کی حالت میں پکڑیں اور یہاں صفر کریں دبائیں۔';

  @override
  String get angleHelp3 =>
      'فون کو جھکائیں یا ہلائیں۔ ڈائل دکھاتا ہے کہ وہ آپ کے صفر سے کتنے درجے ہلا۔';

  @override
  String get angleHelp4 =>
      'لیٹی حالت سے زاویے پر واپس جانے کے لیے صفر ہٹائیں دبائیں۔';

  @override
  String get angleHelp5 =>
      'جو زاویہ نظر نہ آئے اسے پڑھنے کے لیے فون کو چیز کے ساتھ لگائیں، تالا دبائیں، پھر فون ہٹا کر پڑھیں۔';

  @override
  String get angleHelp6 =>
      'اوپر والے سوئچ سے موڈ چنیں: سطح پر سیدھا، یا کنارے پر کھڑا۔ کنارے پر اسکرین ایسے پانی سے بھر جاتی ہے جو سطح پر رہتا ہے، اور جس کنارے کی آپ پیمائش کر رہے ہیں، یعنی نچلی طرف، نارنجی چمکتا ہے۔';

  @override
  String get angleTip =>
      'ڈھلوان پڑھنے کے لیے فون کا لمبا کنارہ ریمپ، سیڑھی کی ریلنگ یا چھت پر رکھیں، یا جھکاؤ ناپنے کے لیے اسکرین کو تختے یا دروازے سے لگا دیں۔';

  @override
  String movedFromZero(String value) {
    return 'صفر سے تبدیلی $value';
  }

  @override
  String get measuringFromZero => 'آپ کے صفر سے پیمائش';

  @override
  String get angleFlatStatus => 'سیدھا لٹایا · زمین کے لحاظ سے زاویہ';

  @override
  String get measuringRightEdge => 'دائیں کنارے کی پیمائش';

  @override
  String get measuringLeftEdge => 'بائیں کنارے کی پیمائش';

  @override
  String bottomEdge(String value) {
    return 'نچلا کنارہ $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: سطح سے $value۔ نچلا کنارہ $other';
  }

  @override
  String get angleModeFlat => 'سطح پر سیدھا لٹایا';

  @override
  String get angleModeEdge => 'کنارے پر';

  @override
  String get standOnEdge => 'فون کو اس کے کسی کنارے پر کھڑا کریں';

  @override
  String get clearZero => 'صفر ہٹائیں';

  @override
  String get setZeroHere => 'یہاں صفر کریں';

  @override
  String get compassHelp1 =>
      'فون کو اپنے سامنے ہموار پکڑیں، دھات، مقناطیس اور الیکٹرانکس سے دور۔';

  @override
  String get compassHelp2 =>
      'فون کا اوپری حصہ اس سمت میں کریں جو آپ جاننا چاہتے ہیں۔ سیدھا پکڑنے پر یہ پچھلے کیمرے کی سمت دکھاتا ہے۔';

  @override
  String get compassHelp3 =>
      'عدد درجوں میں آپ کا رخ ہے اور الفاظ سمت بتاتے ہیں۔ ڈائل گھومتا ہے تاکہ اس کا N ہمیشہ شمال کی طرف رہے؛ اوپر والی نارنجی گیند بتاتی ہے کہ آپ کا فون کس طرف ہے۔';

  @override
  String get compassTip =>
      'یہ مقناطیسی شمال دکھاتا ہے، جو کچھ جگہوں پر نقشے کے شمال سے 10 درجے یا اس سے زیادہ مختلف ہو سکتا ہے۔ غلط لگے تو فون کو چند بار 8 کی شکل میں گھمائیں۔';

  @override
  String compassSemantics(int heading, String direction) {
    return 'مقناطیسی رخ $heading درجے، $direction';
  }

  @override
  String get magneticInterference =>
      'مقناطیسی مداخلت · دھات سے دور ہٹیں، پھر فون کو 8 کی شکل میں گھمائیں';

  @override
  String get compassCalibrate =>
      'کمپاس کیلیبریٹ کرنے کے لیے فون کو 8 کی شکل میں گھمائیں';

  @override
  String get dirN => 'شمال';

  @override
  String get dirNE => 'شمال مشرق';

  @override
  String get dirE => 'مشرق';

  @override
  String get dirSE => 'جنوب مشرق';

  @override
  String get dirS => 'جنوب';

  @override
  String get dirSW => 'جنوب مغرب';

  @override
  String get dirW => 'مغرب';

  @override
  String get dirNW => 'شمال مغرب';

  @override
  String get protractorHelp1 =>
      'فون کو لٹائیں اور چیز کو اسکرین پر اس طرح رکھیں کہ اس کا کونا درمیان میں ہو۔';

  @override
  String get protractorHelp2 =>
      'ہر نارنجی ہینڈل کو کھینچیں تاکہ اس کی لکیر زاویے کے ایک کنارے پر آ جائے۔';

  @override
  String get protractorHelp3 =>
      'زاویہ درمیان میں پڑھیں۔ منعکس زاویہ دوسری طرف کا ہے (360° میں سے زاویہ نکال کر)۔';

  @override
  String get protractorHelp4 => 'دوبارہ شروع کرنے کے لیے ری سیٹ دبائیں۔';

  @override
  String get protractorHelp5 =>
      'چیز کو ہلاتے وقت ہینڈلز اپنی جگہ رکھنے کے لیے تالا دبائیں۔';

  @override
  String armsSemantics(String value) {
    return 'بازوؤں کے درمیان زاویہ $value';
  }

  @override
  String get reflex => 'منعکس زاویہ';

  @override
  String get dragHandles => 'نارنجی ہینڈلز کو کناروں پر کھینچیں';

  @override
  String get reset => 'ری سیٹ';

  @override
  String get rulerHelp1 =>
      'چیز کو اسکرین پر رکھیں، یا فون کو اس کے ساتھ لگائیں۔';

  @override
  String get rulerHelp2 =>
      'نارنجی لکیروں کو چیز کے دونوں سروں تک کھینچیں۔ اکائی چننے کے لیے mm، cm یا in دبائیں؛ دوسرا نظام نیچے دکھائی دیتا ہے۔';

  @override
  String get rulerHelp3 =>
      'بہترین درستگی کے لیے ایک بار کیلیبریٹ دبائیں اور کارڈ، رولر یا اسکرین کا سائز استعمال کریں۔';

  @override
  String get rulerHelp4 =>
      'چیز کو ہلاتے وقت لکیریں اپنی جگہ رکھنے کے لیے تالا دبائیں۔';

  @override
  String get rulerTip =>
      'یہ اسکرین کی لمبائی تک ناپتا ہے۔ کور اور مڑے ہوئے کنارے پہلے چند ملی میٹر چھپا دیتے ہیں، اس لیے فون کے کنارے سے نہیں، لکیروں کے درمیان ناپیں۔';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'لمبائی $mm ملی میٹر، $inches انچ';
  }

  @override
  String get rulerCalibrated => 'کارڈ سے کیلیبریٹ · ±0.5 ملی میٹر';

  @override
  String get rulerReported =>
      'فون سے اسکرین کا سائز · ±0.5 ملی میٹر کے لیے کیلیبریٹ کریں';

  @override
  String get unitMillimetres => 'ملی میٹر';

  @override
  String get unitCentimetres => 'سینٹی میٹر';

  @override
  String get unitInches => 'انچ';

  @override
  String get rulerEstimated => 'کیلیبریٹ نہیں · لمبائی 10% تک غلط ہو سکتی ہے';

  @override
  String get cardLongEdge =>
      'کوئی بھی بینک یا شناختی کارڈ اسکرین پر رکھیں، لمبا کنارہ رولر کے ساتھ اور ایک سرا گہری لکیر پر۔ نارنجی لکیر کو کارڈ کے دوسرے سرے تک کھینچیں۔';

  @override
  String get cardShortEdge =>
      'کوئی بھی بینک یا شناختی کارڈ اسکرین پر رکھیں، چھوٹا کنارہ رولر کے ساتھ اور ایک سرا گہری لکیر پر۔ نارنجی لکیر کو کارڈ کے دوسرے سرے تک کھینچیں۔';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get usePhoneDefault => 'فون کا اسکرین سائز استعمال کریں';

  @override
  String get usePhoneDefaultInfo => 'یہ کیلیبریشن ختم کریں';

  @override
  String get cardMismatch =>
      'یہ کارڈ کے سائز سے میل نہیں کھاتا۔ اسے گہری لکیر سے ملا کر دوبارہ کوشش کریں۔';

  @override
  String get rotateToCalibrate => 'کیلیبریٹ کرنے کے لیے عمودی رخ پر گھمائیں';

  @override
  String get calibrateHow => 'کس سے کیلیبریٹ کریں';

  @override
  String get methodCard => 'بینک کارڈ';

  @override
  String get methodCardInfo => 'کوئی بھی بینک یا شناختی کارڈ · ±0.5 ملی میٹر';

  @override
  String get methodRuler => 'رولر';

  @override
  String get methodRulerInfo => 'سب سے درست · رولر یا ناپنے کا فیتہ';

  @override
  String get methodScreen => 'اسکرین کا سائز';

  @override
  String get methodScreenInfo => 'کچھ نہیں چاہیے · تقریباً 1%';

  @override
  String rulerInstructions(String mark) {
    return 'رولر کو اسکرین پر رکھیں، اس کا 0 گہری لکیر پر۔ نارنجی لکیر کو $mark کے نشان تک کھینچیں۔';
  }

  @override
  String rulerMismatch(String mark) {
    return 'یہ $mark سے میل نہیں کھاتا۔ رولر کا 0 گہری لکیر پر رکھ کر دوبارہ کوشش کریں۔';
  }

  @override
  String get screenSizeInstructions =>
      'فون کی تفصیلات سے اسکرین کا سائز انچ میں لکھیں۔ معلوم نہیں؟ اپنا ماڈل اور “اسکرین سائز” تلاش کریں۔';

  @override
  String get screenSizeMismatch =>
      'یہ سائز اس اسکرین سے میل نہیں کھاتا۔ فون کی تفصیلات دیکھ کر دوبارہ کوشش کریں۔';

  @override
  String get rulerCalibratedRuler => 'رولر سے کیلیبریٹ · ±0.5 ملی میٹر';

  @override
  String rulerCalibratedScreen(String size) {
    return '$size انچ اسکرین پر سیٹ · تقریباً 1%';
  }

  @override
  String get metalHelp1 =>
      'ٹول کو دھات سے دور کھولیں۔ پہلی ریڈنگ «کوئی دھات نہیں» مانی جاتی ہے۔';

  @override
  String get metalHelp2 =>
      'فون کو جگہ کے اوپر آہستہ آہستہ گھمائیں۔ سینسر عموماً فون کے اوپری حصے میں ہوتا ہے۔ دھات جتنی قریب ہو، بیپ اتنی تیز ہوتی ہے؛ آواز بند کرنے کے لیے اسپیکر دبائیں۔';

  @override
  String get metalHelp3 =>
      '“قریب دھات” کا مطلب چھوٹی تبدیلی ہے، “دھات ملی” کا مطلب بڑی۔ ٹھنڈا گرم کھیل کی طرح، قریب آنے پر اسکرین ٹھنڈے نیلے سے دہکتے سرخ میں بدلتی ہے، اور وائبریشن آن ہو تو ملنے پر فون کانپتا ہے۔';

  @override
  String get metalHelp4 =>
      'چند سیکنڈ ساکن رکھنے پر یہ خود صفر ہو جاتا ہے، اور غلط ریڈنگ ختم ہو جاتی ہے۔ کسی جگہ کو دوبارہ جانچنے کے لیے فون ہٹا کر واپس لائیں۔ بنیاد مقرر کریں فوراً صفر کر دیتا ہے۔';

  @override
  String get metalTip =>
      'یہ صرف لوہا، اسٹیل اور مقناطیس پہچانتا ہے، ایلومینیم، تانبا، سونا یا چاندی نہیں۔ مقناطیس والے فون کور اس پر اثر ڈالتے ہیں۔';

  @override
  String metalSemantics(int value) {
    return 'مقناطیسی میدان $value مائیکرو ٹیسلا';
  }

  @override
  String get noMetal => 'قریب کوئی دھات نہیں';

  @override
  String get metalNearby => 'قریب دھات ہے';

  @override
  String get metalDetected => 'دھات مل گئی';

  @override
  String get heatCold => 'ٹھنڈا';

  @override
  String get heatCool => 'خنک';

  @override
  String get heatWarm => 'نیم گرم';

  @override
  String get heatWarmer => 'اور گرم';

  @override
  String get heatHot => 'گرم';

  @override
  String get heatBurning => 'جل رہا';

  @override
  String get baseline => 'بنیاد';

  @override
  String get field => 'میدان';

  @override
  String get change => 'تبدیلی';

  @override
  String get findsIronSteel => 'لوہا، اسٹیل اور مقناطیس پہچانتا ہے';

  @override
  String get setBaseline => 'بنیاد مقرر کریں';

  @override
  String get muteSound => 'آواز بند کریں';

  @override
  String get turnSoundOn => 'آواز چلائیں';

  @override
  String get vibrationHelp1 =>
      'فون کو چلتی مشین پر سیدھا رکھیں اور ہاتھ ہٹا لیں۔ چھوٹی مشین پر اسے مضبوطی سے دبا کر رکھیں۔';

  @override
  String get vibrationHelp2 =>
      'سوئی سب سے تیز ارتعاش کی رفتار RPM میں دکھاتی ہے، نیچے ہرٹز میں (RPM، ہرٹز × 60 ہوتا ہے)۔ ڈائل کے اندر ہلکی چمک پورا اسپیکٹرم ہے؛ سوئی اس کے سب سے روشن حصے کی طرف اشارہ کرتی ہے۔';

  @override
  String get vibrationHelp3 =>
      'طاقت بتاتی ہے کہ کتنا زور سے ہل رہا ہے، m/s² میں: 0.3 سے کم ساکن ہے، 2 سے زیادہ تیز ہے۔';

  @override
  String get vibrationHelp4 =>
      'ریڈنگ روکنے کے لیے لاک دبائیں، اور اگلی مشین سے پہلے ری سیٹ بٹن دبائیں۔';

  @override
  String get vibrationTip =>
      'زیادہ تر فون 100 Hz (6000 RPM) تک ناپتے ہیں، کچھ کم؛ ڈائل آپ کے فون کی حد دکھاتا ہے۔ اس سے تیز ارتعاش غلط، کم رفتار کے طور پر دکھ سکتا ہے۔ سب سے تیز ارتعاش اکثر شافٹ کی رفتار ہوتا ہے، مگر اس کا دگنا بھی ہو سکتا ہے۔ فون کے سینسر لیب کے آلات نہیں ہیں۔';

  @override
  String get still => 'ساکن';

  @override
  String get lightVibration => 'ہلکا ارتعاش';

  @override
  String get strongVibration => 'تیز ارتعاش';

  @override
  String get noAccelerometerVibration =>
      'اس فون میں ایکسلرومیٹر نہیں ہے، اس لیے یہاں ارتعاش نہیں ناپا جا سکتا۔ جن ٹولز کو اس کی ضرورت نہیں، وہ کام کرتے رہیں گے۔';

  @override
  String vibrationSemantics(String value) {
    return 'ارتعاش $value میٹر فی سیکنڈ مربع';
  }

  @override
  String get frequency => 'فریکوئنسی';

  @override
  String get rpm => 'RPM';

  @override
  String get strength => 'طاقت';

  @override
  String vibratingAt(String value) {
    return '$value Hz پر ارتعاش';
  }

  @override
  String get noClearFrequency => 'کوئی واضح فریکوئنسی نہیں';

  @override
  String get findingFrequency => 'فریکوئنسی تلاش ہو رہی ہے…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm چکر فی منٹ، $value ہرٹز';
  }

  @override
  String get peak => 'زیادہ سے زیادہ';

  @override
  String get average => 'اوسط';

  @override
  String get resetPeak => 'زیادہ سے زیادہ ری سیٹ کریں';

  @override
  String get altimeterHelp1 =>
      'آپ کی بلندی بدلنے کے ساتھ کوہ پیما پہاڑ پر اوپر یا نیچے جاتا ہے۔ آسمان دن کے وقت اور موسم کے ساتھ بدلتا ہے؛ خود چننے کے لیے موسم کا بٹن دبائیں۔';

  @override
  String get altimeterHelp2 =>
      'اونچائی کی تبدیلی ناپنے کے لیے، جیسے سیڑھیاں یا منزلیں، شروع کی جگہ پر یہاں صفر کریں دبائیں۔';

  @override
  String get altimeterHelp3 =>
      'اوپر یا نیچے جائیں: کوہ پیما آپ کے ساتھ چلتا ہے اور جھنڈا آپ کا سب سے اونچا مقام دکھاتا ہے۔ پینل صفر سے میٹر، ہوا کا دباؤ اور اندازاً بلندی دکھاتا ہے۔';

  @override
  String get altimeterHelp4 =>
      'صفر سے ناپنا بند کرنے کے لیے صفر ہٹائیں دبائیں: صفر سے والی ریڈنگ پھر خالی ہو جاتی ہے۔';

  @override
  String get altimeterTip =>
      'موسم ہوا کا دباؤ مسلسل بدلتا رہتا ہے، اس لیے شروع کی اونچائی معلوم نہ ہو تو اونچائی سو میٹر یا اس سے زیادہ غلط ہو سکتی ہے۔ کم وقت میں یہاں صفر کریں سے اونچائی کی تبدیلی پر بھروسا کریں۔ اس ٹول کے لیے بیرومیٹر والا فون چاہیے۔';

  @override
  String get weather => 'موسم';

  @override
  String get weatherAuto => 'خودکار (دن کا وقت اور موسم)';

  @override
  String get weatherSunny => 'دھوپ';

  @override
  String get weatherCloudy => 'ابر آلود';

  @override
  String get weatherRain => 'بارش';

  @override
  String get weatherStorm => 'طوفان';

  @override
  String get weatherSnow => 'برف';

  @override
  String get fromZero => 'صفر سے';

  @override
  String get altitudeShort => 'بلندی';

  @override
  String get barometerIos =>
      'بیرومیٹر نہیں پڑھا جا سکا۔ ترتیبات › رازداری اور سیکیورٹی میں اس ایپ کے لیے موشن اور فٹنس آن کریں، پھر بلندی پیما دوبارہ کھولیں۔';

  @override
  String get noBarometer =>
      'اس فون میں بیرومیٹر (ہوا کے دباؤ کا سینسر) نہیں ہے، اس لیے بلندی پیما یہاں کام نہیں کر سکتا۔ باقی ٹولز کام کرتے رہیں گے۔';

  @override
  String get noLightSensor =>
      'اس فون میں لائٹ سینسر نہیں ہے، اس لیے لائٹ میٹر یہاں کام نہیں کر سکتا۔ باقی ٹولز کام کرتے رہیں گے۔';

  @override
  String lightSemantics(String value) {
    return 'روشنی $value لکس';
  }

  @override
  String get illuminance => 'روشنی';

  @override
  String get footCandles => 'فٹ کینڈل';

  @override
  String get lightDark => 'اندھیرا';

  @override
  String get lightDim => 'مدھم روشنی';

  @override
  String get lightLivingRoom => 'بیٹھک جیسی روشنی';

  @override
  String get lightReading => 'پڑھنے اور میز پر کام کے لیے اچھی';

  @override
  String get lightBright => 'تیز اندرونی روشنی';

  @override
  String get lightOvercast => 'ابر آلود دن کی روشنی';

  @override
  String get lightDaylight => 'دن کی روشنی';

  @override
  String get lightSun => 'براہِ راست دھوپ';

  @override
  String get lightHelp1 =>
      'لائٹ سینسر اسکرین کے اوپر، سامنے والے کیمرے کے پاس ہوتا ہے۔';

  @override
  String get lightHelp2 =>
      'فون کو وہاں رکھیں جہاں ناپنا ہو، اسکرین روشنی کی طرف۔';

  @override
  String get lightHelp3 =>
      'آسمان روشنی کے ساتھ بدلتا ہے: اندھیرے میں رات، مدھم کمرے میں صبح، اور روشنی بڑھنے پر سورج اوپر چڑھتا ہے۔ لکس اور یہ روشنی کس کام کی ہے، پڑھیں: 300 سے 750 lx پڑھنے اور میز پر کام کے لیے موزوں ہے۔';

  @override
  String get lightHelp4 =>
      'فون ہٹاتے وقت ریڈنگ برقرار رکھنے کے لیے لاک کریں دبائیں۔';

  @override
  String get lightTip =>
      'فون کے لائٹ سینسر کیلیبریٹڈ نہیں ہوتے، اس لیے ہر فون میں ریڈنگ کافی مختلف ہو سکتی ہے۔ اسے ایک ہی فون سے ایک ہی جگہ کی روشنی کا موازنہ کرنے کے لیے استعمال کریں، کیلیبریٹڈ لکس میٹر کی طرح نہیں۔ اسکرین کا اوپری حصہ نہ ڈھانپیں۔';

  @override
  String get noMicrophone =>
      'مائیکروفون استعمال نہیں ہو پا رہا۔ شاید کوئی اور ایپ اسے استعمال کر رہی ہے: اسے بند کریں، پھر ساؤنڈ میٹر دوبارہ کھولیں۔';

  @override
  String soundSemantics(String value) {
    return 'آواز کی سطح تقریباً $value ڈیسیبل';
  }

  @override
  String get decibelsApprox => 'dB (تقریباً)';

  @override
  String get soundMax => 'زیادہ سے زیادہ';

  @override
  String get soundVeryQuiet => 'بہت خاموش';

  @override
  String get soundQuiet => 'خاموش، لائبریری جیسا';

  @override
  String get soundModerate => 'درمیانہ، بات چیت جیسا';

  @override
  String get soundLoud => 'تیز، بھاری ٹریفک جیسا';

  @override
  String get soundVeryLoud =>
      'بہت تیز: دیر تک سننے سے سماعت کو نقصان ہو سکتا ہے';

  @override
  String get soundDangerous => 'خطرناک: اپنے کان بچائیں';

  @override
  String get micTitle => 'مائیکروفون کی اجازت دیں';

  @override
  String get micBody =>
      'ساؤنڈ میٹر آواز کتنی تیز ہے یہ ناپنے کے لیے مائیکروفون سے سنتا ہے۔ آواز صرف آپ کے فون پر ناپی جاتی ہے، کبھی ریکارڈ، محفوظ یا بھیجی نہیں جاتی۔';

  @override
  String get micAllow => 'مائیکروفون کی اجازت دیں';

  @override
  String get micDeniedTitle => 'مائیکروفون کی رسائی بند ہے';

  @override
  String get micDeniedBody =>
      'ساؤنڈ میٹر استعمال کرنے کے لیے سیٹنگز میں اس ایپ کے لیے مائیکروفون آن کریں۔ آواز کبھی ریکارڈ، محفوظ یا بھیجی نہیں جاتی۔';

  @override
  String get openSettings => 'سیٹنگز کھولیں';

  @override
  String get tryAgain => 'دوبارہ کوشش کریں';

  @override
  String get soundHelp1 =>
      'مائیکروفون (نیچے والے کنارے پر) کھلا رکھیں اور فون کو آواز کی طرف کریں۔';

  @override
  String get soundHelp2 =>
      'بڑا عدد ابھی کی سطح ہے، تقریباً ایک سیکنڈ کی اوسط۔ اس سے لہریں پھیلتی ہیں، آواز جتنی تیز ہو اتنی زیادہ اور دور تک: خاموشی میں سبز، پھر پیلی، نارنجی، سرخ اور گہری سرخ۔ نیچے کی پٹیاں پچھلے تین سیکنڈ دکھاتی ہیں۔';

  @override
  String get soundHelp3 =>
      'اوسط اور زیادہ سے زیادہ ٹول کھولنے کے وقت سے گنے جاتے ہیں۔ دوبارہ شروع کرنے کے لیے ری سیٹ دبائیں۔';

  @override
  String get soundHelp4 =>
      '70 dB سے اسٹیٹس لائن پیلی ہو جاتی ہے؛ 85 dB سے، جہاں دیر تک سننے سے سماعت کو نقصان ہو سکتا ہے، سرخ ہو جاتی ہے۔';

  @override
  String get soundHelp5 =>
      'فون ہلاتے وقت ریڈنگ اسکرین پر برقرار رکھنے کے لیے تالا دبائیں۔';

  @override
  String get soundTip =>
      'فون کے مائیکروفون کیلیبریٹڈ ساؤنڈ میٹر نہیں ہوتے اور ہر ماڈل میں مختلف ہوتے ہیں، اس لیے ریڈنگ اندازاً ہے (اکثر تقریباً 5 سے 10 dB تک مختلف) اور بہت تیز آوازیں کم دکھ سکتی ہیں۔ کسی بھی سرکاری پیمائش کے لیے کیلیبریٹڈ ساؤنڈ میٹر چاہیے۔';

  @override
  String get metresFromZero => 'م صفر سے';

  @override
  String pressureSemantics(String value) {
    return 'ہوا کا دباؤ $value ہیکٹو پاسکل';
  }

  @override
  String heightSemantics(String value) {
    return 'صفر سے اونچائی $value';
  }

  @override
  String get pressure => 'دباؤ';

  @override
  String get altitudeApprox => 'اونچائی (تقریباً)';

  @override
  String get measuringHeight => 'آپ کے صفر سے اونچائی کی پیمائش';

  @override
  String get airPressureAltitude => 'ہوا کا دباؤ اور اونچائی';

  @override
  String get appearance => 'ظاہری شکل';

  @override
  String get themeSystem => 'سسٹم';

  @override
  String get themeLight => 'لائٹ';

  @override
  String get themeDark => 'ڈارک';

  @override
  String get levelUnits => 'لیول کی اکائی';

  @override
  String get unitDegrees => 'ڈگری';

  @override
  String get unitPercent => 'فیصد ڈھلوان';

  @override
  String get unitRoofPitch => 'چھت کی ڈھلوان (12 پر اونچائی)';

  @override
  String get vibrateWhenLevel => 'وائبریشن';

  @override
  String get sounds => 'آوازیں';

  @override
  String get resetCalibration => 'کیلیبریشن ری سیٹ کریں';

  @override
  String get resetCalibrationHint => 'سینسر کا فیکٹری صفر دوبارہ استعمال کریں';

  @override
  String get calibrateHere => 'یہاں کیلیبریٹ کریں';

  @override
  String get calibrateHereInfo => 'ایسی سطح پر جو یقیناً ہموار ہو';

  @override
  String get calibrationRemoved =>
      'کیلیبریشن ہٹا دی گئی۔ لیول دوبارہ سینسر کا فیکٹری صفر استعمال کرتا ہے۔';

  @override
  String get resetAllCalibrations => 'تمام کیلیبریشن ری سیٹ کریں';

  @override
  String get resetAllCalibrationsHint => 'لیول اور رولر فیکٹری سیٹنگ پر';

  @override
  String get resetAllTitle => 'تمام کیلیبریشن ری سیٹ کریں؟';

  @override
  String get resetAllBody =>
      'اس سے لیول (جسے زاویہ پیما بھی استعمال کرتا ہے) اور رولر میں کی گئی کیلیبریشن ہٹ جائے گی۔ دونوں فیکٹری سیٹنگ پر لوٹ آئیں گے۔ آپ کی باقی سیٹنگز ویسی ہی رہیں گی، اور آپ کسی بھی وقت دوبارہ کیلیبریٹ کر سکتے ہیں۔';

  @override
  String get notCalibrated => 'کیلیبریٹ نہیں ہوا';

  @override
  String get language => 'زبان';

  @override
  String get licenses => 'اوپن سورس لائسنس';

  @override
  String get languageSystem => 'فون کی زبان';

  @override
  String get toolHeight => 'اونچائی';

  @override
  String get toolHeightSubtitle => 'نشانہ لگا کر اونچائی اور فاصلہ';

  @override
  String get heightHelp1 =>
      'ایسی جگہ کھڑے ہوں جہاں سے چیز کا نچلا اور اوپری سرا نظر آئے۔ فون کو اسکرین اوپر کر کے پکڑیں اور اس کے اوپری کنارے کے ساتھ دیکھیں۔';

  @override
  String get heightHelp2 =>
      'اوپری کنارے کو چیز کے نچلے سرے پر لگائیں اور نچلا سرا لاک کریں پر ٹیپ کریں: اس سے فاصلہ ملتا ہے۔';

  @override
  String get heightHelp3 =>
      'اوپری کنارے کو اوپری سرے پر لگائیں اور اوپری سرا لاک کریں پر ٹیپ کریں: اونچائی نظر آئے گی۔';

  @override
  String get heightHelp4 =>
      'فاصلہ معلوم ہے؟ فاصلہ پر ٹیپ کر کے لکھیں، پھر صرف اوپری سرے پر نشانہ لگائیں۔ اپنی آنکھوں کی اونچائی سیٹ کرنے کے لیے آنکھوں کی اونچائی پر ٹیپ کریں۔';

  @override
  String get heightTip =>
      'ہموار زمین پر درست آنکھوں کی اونچائی (آپ کا قد منفی تقریباً 10 cm) کے ساتھ تقریباً ±5%۔ اتنا پیچھے ہٹیں کہ اوپری سرا 70° سے کم اور نچلا سرا افق سے کم از کم 3° نیچے ہو۔ ڈھلوان پر فاصلہ لکھیں۔';

  @override
  String get lockBase => 'نچلا سرا لاک کریں';

  @override
  String get lockTop => 'اوپری سرا لاک کریں';

  @override
  String get measureAgain => 'دوبارہ ناپیں';

  @override
  String get distance => 'فاصلہ';

  @override
  String get objectHeight => 'اونچائی';

  @override
  String get eyeHeight => 'آنکھوں کی اونچائی';

  @override
  String get sightAngle => 'نشانے کا زاویہ';

  @override
  String get heightAimBase => 'اوپری کنارے کو نچلے سرے پر لگائیں';

  @override
  String get heightAimTop => 'اب اوپری کنارے کو اوپری سرے پر لگائیں';

  @override
  String get heightDone => 'ہو گیا · دوسری کے لیے دوبارہ ناپیں پر ٹیپ کریں';

  @override
  String get heightHoldFlatter =>
      'فون کو مزید سیدھا لٹائیں اور اوپری کنارے کے ساتھ نشانہ لگائیں';

  @override
  String get heightTooFar =>
      'نچلا سرا افق کے بہت قریب ہے: قریب جائیں یا فاصلہ لکھیں';

  @override
  String get heightStepBack => 'بہت ڈھلوان: مستحکم پیمائش کے لیے پیچھے ہٹیں';

  @override
  String get knownDistance => 'نچلے سرے تک فاصلہ';

  @override
  String get knownDistanceHint =>
      'زمین کے ساتھ چیز کے نچلے سرے تک فاصلہ۔ نشانے سے ناپنے کے لیے اسے صاف کریں۔';

  @override
  String get eyeHeightHint =>
      'زمین سے آپ کی آنکھیں کتنی اونچی ہیں: تقریباً آپ کا قد منفی 10 cm۔';

  @override
  String get clear => 'صاف کریں';

  @override
  String get toolCamera => 'کیمرا لیول';

  @override
  String get toolCameraSubtitle =>
      'کیمرے پر سیدھی لکیریں، کوئی بھی کنارہ ناپیں';

  @override
  String get cameraHelp1 =>
      'پچھلا کیمرا دیوار، تصویر، شیلف یا دروازے کی طرف کریں۔ فون کو سیدھا اور دیوار کے بالکل سامنے رکھیں۔';

  @override
  String get cameraHelp2 =>
      'ٹھوس لکیریں کششِ ثقل کے ساتھ چلتی ہیں: وہ ہمیشہ بالکل افقی اور عمودی رہتی ہیں۔ نقطہ دار لکیریں فون سے جڑی ہیں، اور ان کے درمیان چھوٹی قوس بتاتی ہے کہ فون کتنا جھکا ہے۔ فون سیدھا ہونے پر اصلی لکیریں نارنجی ہو جاتی ہیں۔';

  @override
  String get cameraHelp3 =>
      'کسی چیز کو جانچنے کے لیے فریز دبائیں، پھر دونوں نارنجی ہینڈل اس کے کسی کنارے پر کھینچیں، جیسے فریم کا اوپری کنارہ۔ ہاتھ سیدھا نہ ہونے پر بھی دکھے گا کہ وہ کنارہ کتنا ٹیڑھا ہے اور کون سی طرف اٹھانی ہے۔ عمودی کنارہ جانچنے کے لیے لکیر کو کھڑا کریں۔';

  @override
  String get cameraHelp4 =>
      'اوپر کے دو بٹن فون کی لکیریں اور اصلی لکیریں دکھاتے یا چھپاتے ہیں۔ روشنی اندھیرے کونوں میں مدد کرتی ہے؛ جاری رکھیں سے لائیو تصویر واپس آتی ہے۔';

  @override
  String get cameraTip =>
      'کنارہ درست ناپنے کے لیے فون کو دیوار کے بالکل سامنے رکھیں (آگے/پیچھے 5° سے کم) اور تصویر کے بیچ کے قریب ناپیں، جہاں لینز لکیروں کو سب سے کم موڑتا ہے۔ لیول کی کنارے والی کیلیبریشن استعمال ہوتی ہے۔ تصویر کبھی ریکارڈ، محفوظ یا بھیجی نہیں جاتی۔';

  @override
  String get cameraAllowTitle => 'کیمرے کی اجازت دیں';

  @override
  String get cameraAllowBody =>
      'کیمرا لیول کیمرے کی تصویر پر سیدھی لکیریں بناتا ہے اور اس میں کنارے ناپتا ہے۔ تصویر آپ کے فون پر ہی رہتی ہے اور کبھی ریکارڈ، محفوظ یا بھیجی نہیں جاتی۔';

  @override
  String get cameraAllow => 'کیمرے کی اجازت دیں';

  @override
  String get cameraDeniedTitle => 'کیمرے کی اجازت بند ہے';

  @override
  String get cameraDeniedBody =>
      'کیمرا لیول استعمال کرنے کے لیے سیٹنگز میں اس ایپ کا کیمرا آن کریں۔ تصویر کبھی ریکارڈ، محفوظ یا بھیجی نہیں جاتی۔';

  @override
  String get noCamera =>
      'کیمرا استعمال نہیں ہو پا رہا۔ شاید کوئی دوسری ایپ اسے استعمال کر رہی ہے یا فون میں کیمرا نہیں: دوسری کیمرا ایپس بند کر کے کیمرا لیول دوبارہ کھولیں۔';

  @override
  String get tilt => 'جھکاؤ';

  @override
  String get forwardBack => 'آگے/پیچھے';

  @override
  String get cameraLevel => 'سیدھا';

  @override
  String cameraTilted(String value) {
    return '$value° جھکا';
  }

  @override
  String get cameraHoldUpright => 'فون سیدھا رکھیں، کیمرا دیوار کی طرف';

  @override
  String get freeze => 'فریز';

  @override
  String get resume => 'جاری رکھیں';

  @override
  String get torch => 'روشنی';

  @override
  String cameraSemantics(String value) {
    return 'سیدھی لکیروں والا کیمرا منظر، $value ڈگری جھکا';
  }

  @override
  String get cameraPhoneLines => 'فون کی لکیریں';

  @override
  String get cameraTrueLines => 'اصلی لکیریں';

  @override
  String get cameraFrozen => 'فریز ہے';

  @override
  String get cameraDragHandles => 'ہینڈل کسی کنارے پر کھینچیں';

  @override
  String get cameraFaceWall => 'فون دیوار کے بالکل سامنے رکھیں';

  @override
  String get edgeLevel => 'یہ کنارہ سیدھا ہے';

  @override
  String get edgePlumb => 'یہ کنارہ عمودی ہے';

  @override
  String edgeLiftRight(String value) {
    return 'کنارہ $value° ٹیڑھا، دائیں طرف اٹھائیں';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'کنارہ $value° ٹیڑھا، بائیں طرف اٹھائیں';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'کنارہ عمودی سے $value° ہٹا';
  }

  @override
  String get cameraHandle => 'کنارے کا ہینڈل';

  @override
  String get toolGForce => 'G فورس';

  @override
  String get toolGForceSubtitle => 'بریک، رفتار بڑھانا اور موڑ، g میں';

  @override
  String get gHelp1 =>
      'فون کو کار ماؤنٹ میں لگائیں، اسکرین آپ کی طرف۔ گاڑی کھڑی ہو تو صفر دبائیں: میٹر سیکھ لیتا ہے کہ نیچے اور آگے کس طرف ہے۔';

  @override
  String get gHelp2 =>
      'گاڑی چلائیں: گاڑی کی وہ طرف چمکتی ہے جدھر آپ دھکیلے جاتے ہیں۔ بریک لگانے پر آگے، رفتار بڑھانے پر پیچھے اور موڑ پر باہر کی طرف۔ سبز ہلکا، نارنجی زوردار، سرخ سخت۔';

  @override
  String get gHelp3 =>
      'پینل صفر کے بعد سب سے زیادہ رفتار بڑھانا، بریک اور موڑ یاد رکھتا ہے، اور کنارے کے نقطے ہر سمت کا سب سے زوردار دھکا یاد رکھتے ہیں۔ ری سیٹ بٹن انہیں مٹا دیتا ہے۔';

  @override
  String get gHelp4 =>
      'نظر سڑک پر رکھیں: کسی مسافر سے پڑھوائیں، یا رکنے کے بعد زیادہ سے زیادہ قدریں دیکھیں۔';

  @override
  String get gTip =>
      'ریڈنگ ایکسلرومیٹر سے آتی ہے اور اندازاً ہے: یہ مضبوط ماؤنٹ اور رکی ہوئی گاڑی میں دبائے گئے صفر پر منحصر ہے، اور خراب سڑک پر تھوڑی زیادہ غیر مستحکم ہوتی ہے۔ اگر ماؤنٹ ہل جائے تو رکیں اور دوبارہ صفر دبائیں۔ عام گاڑی کے لیے 0.5 g سے زیادہ کا مطلب زور کی بریک یا تیز موڑ ہے۔';

  @override
  String get gZero => 'صفر';

  @override
  String get gResetPeaks => 'زیادہ سے زیادہ ری سیٹ کریں';

  @override
  String get gSpeedUp => 'رفتار بڑھانا';

  @override
  String get gBrake => 'بریک';

  @override
  String get gCorner => 'موڑ';

  @override
  String get gSteady => 'مستحکم';

  @override
  String gBraking(String value) {
    return 'بریک $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'رفتار بڑھ رہی ہے $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'بایاں موڑ $value g';
  }

  @override
  String gRightBend(String value) {
    return 'دایاں موڑ $value g';
  }

  @override
  String gSemantics(String value) {
    return 'G فورس $value g';
  }

  @override
  String get gZeroed => 'صفر ہو گیا: آگے اور نیچے کی سمت سیکھ لی';

  @override
  String get noAccelerometerG =>
      'اس فون میں ایکسلرومیٹر نہیں ہے، اس لیے یہاں G فورس نہیں ناپی جا سکتی۔ باقی ٹولز کام کرتے رہیں گے۔';

  @override
  String get toolSpeed => 'اسپیڈومیٹر';

  @override
  String get toolSpeedSubtitle => 'رفتار، سفر اور GPS بلندی';

  @override
  String get speedHelp1 =>
      'لوکیشن کی اجازت دیں، پھر فون ایسی جگہ رکھیں جہاں سے آسمان نظر آئے، جیسے ڈیش بورڈ پر یا ونڈ اسکرین ماؤنٹ میں۔ باہر پہلی بار جگہ معلوم کرنے میں چند سیکنڈ لگتے ہیں۔';

  @override
  String get speedHelp2 =>
      'ڈیش بورڈ پر میٹر GPS سے آپ کی رفتار دکھاتا ہے، اور اس کے دونوں طرف سفر کا فاصلہ اور بلندی۔ پینل پچھلی بار ری سیٹ کرنے کے بعد کا فاصلہ، سب سے تیز اور اوسط رفتار رکھتا ہے۔';

  @override
  String get speedHelp3 =>
      'کاپی کرنے کے لیے کوآرڈینیٹس پر ٹیپ کریں۔ یونٹ بٹن km/h اور mph کے درمیان بدلتا ہے، اور سفر ری سیٹ کریں فاصلہ، سب سے تیز اور اوسط دوبارہ شروع کرتا ہے۔';

  @override
  String get speedHelp4 =>
      'نظر سڑک پر رکھیں: کسی مسافر سے پڑھوائیں، یا رکنے کے بعد سفر دیکھیں۔';

  @override
  String get speedTip =>
      'رفتار سیٹلائٹ سے آتی ہے اور کھلی سڑک پر عموماً تقریباً 1 km/h کے اندر درست ہوتی ہے؛ سرنگ میں، اونچی عمارتوں کے درمیان یا گھر کے اندر یہ پیچھے رہ سکتی ہے یا رک سکتی ہے۔ GPS بلندی 10 سے 50 میٹر تک غلط ہو سکتی ہے، اس لیے اونچائی کی تبدیلی کے لیے بلندی پیما استعمال کریں۔ لوکیشن صرف تب استعمال ہوتی ہے جب یہ ٹول کھلا ہو، اور کبھی آپ کے فون سے باہر نہیں جاتی۔';

  @override
  String get speedAllowTitle => 'لوکیشن کی اجازت دیں';

  @override
  String get speedAllowBody =>
      'اسپیڈومیٹر GPS سے آپ کی رفتار، فاصلہ اور بلندی ناپتا ہے۔ لوکیشن صرف تب استعمال ہوتی ہے جب یہ ٹول اسکرین پر کھلا ہو، کبھی بیک گراؤنڈ میں نہیں، اور کبھی آپ کے فون سے باہر نہیں جاتی۔';

  @override
  String get speedAllow => 'لوکیشن کی اجازت دیں';

  @override
  String get speedDeniedTitle => 'لوکیشن کی اجازت بند ہے';

  @override
  String get speedDeniedBody =>
      'اسپیڈومیٹر استعمال کرنے کے لیے سیٹنگز میں اس ایپ کے لیے لوکیشن آن کریں۔ یہ صرف ٹول کھلا ہونے پر استعمال ہوتی ہے اور کبھی آپ کے فون سے باہر نہیں جاتی۔';

  @override
  String get speedServiceOffTitle => 'لوکیشن بند ہے';

  @override
  String get speedServiceOffBody =>
      'اسپیڈومیٹر استعمال کرنے کے لیے فون کی سیٹنگز میں لوکیشن آن کریں۔';

  @override
  String get speedDistance => 'فاصلہ';

  @override
  String get speedTop => 'سب سے تیز';

  @override
  String get speedAverage => 'اوسط';

  @override
  String get speedTrip => 'سفر';

  @override
  String get speedAltitude => 'بلندی';

  @override
  String get speedResetTrip => 'سفر ری سیٹ کریں';

  @override
  String get speedFinding => 'سیٹلائٹ تلاش ہو رہے ہیں…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value m';
  }

  @override
  String get speedWeak => 'کمزور GPS: رفتار پیچھے رہ سکتی ہے';

  @override
  String get speedApproximate =>
      'درست مقام بند ہے: مستحکم رفتار کے لیے اسے آن کریں';

  @override
  String get speedStill => 'رکے ہوئے';

  @override
  String get speedCopied => 'کوآرڈینیٹس کاپی ہو گئے';

  @override
  String get speedUnitTooltip => 'km/h اور mph کے درمیان بدلیں';

  @override
  String get speedKmh => 'km/h';

  @override
  String get speedMph => 'mph';

  @override
  String speedSemantics(String value) {
    return 'رفتار $value';
  }

  @override
  String get speedCoordinates => 'کوآرڈینیٹس، کاپی کرنے کے لیے ٹیپ کریں';

  @override
  String get noGps =>
      'اس فون میں GPS نہیں ہے، اس لیے یہاں رفتار نہیں ناپی جا سکتی۔ باقی ٹولز کام کرتے رہیں گے۔';

  @override
  String get speedSceneHelp =>
      'آسمان دن کے وقت کے ساتھ بدلتا ہے۔ موسم کا بٹن منظر چنتا ہے: آٹو موسم کے مطابق چلتا ہے، یا دھوپ، بادل، بارش، طوفان یا برف چنیں۔ یہ صرف منظر ہے، موسم کی پیش گوئی نہیں۔';

  @override
  String get supportTitle => 'مفت، اشتہارات کے بغیر';

  @override
  String get supportBody =>
      'اسے ایک شخص نے اپنے فارغ وقت میں بنایا ہے۔ اگر یہ آپ کے کام آئے تو آپ اس کی مدد کر سکتے ہیں۔';

  @override
  String get supportButton => 'GitHub پر مدد کریں';

  @override
  String get linkCopied => 'لنک کاپی ہو گیا';

  @override
  String madeBy(String name) {
    return 'ڈیزائن اور تیاری: $name';
  }

  @override
  String testFeedbackTitle(String app) {
    return '$app کو بہتر بنانے میں مدد کریں';
  }

  @override
  String get testFeedbackBody =>
      'کوئی مسئلہ ملا یا کوئی خیال ہے؟ ہر پیغام پڑھا جاتا ہے۔';

  @override
  String get testEmailMe => 'مجھے ای میل کریں';

  @override
  String testEmailSubject(String app) {
    return '$app کے بارے میں رائے';
  }

  @override
  String get testEmailCopied => 'ای میل پتہ کاپی ہو گیا';

  @override
  String get testEndedTitle => 'یہ ٹیسٹ ورژن ختم ہو گیا ہے';

  @override
  String get testEndedBody =>
      'ٹیسٹ کرنے کا شکریہ! براہ کرم نیا ورژن حاصل کریں۔ اسے حاصل کرنے کے لیے مجھے لکھیں:';
}
