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
  String get tools => 'ٹولز';

  @override
  String get listView => 'فہرست کی شکل';

  @override
  String get gridView => 'گرڈ کی شکل';

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
  String get toolVibrationSubtitle => 'لائیو گراف کے ساتھ ارتعاش میٹر';

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
      'جھکاؤ پڑھنے کے لیے فون کو کسی سطح پر لٹائیں، یا ڈھلوان، ریلنگ یا پائپ کے ساتھ کنارے کے بل کھڑا کریں: بڑا نمبر لمبے کنارے کا زاویہ ہے، چھوٹے کنارے کا نیچے دکھتا ہے۔';

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
      'یہ خود ہی لٹائے اور کنارے والے موڈ میں بدلتا ہے۔ کسی ایک کو برقرار رکھنے کے لیے اوپر لٹائے یا کنارے والا آئیکن دبائیں؛ پہلا آئیکن دوبارہ خودکار کر دیتا ہے۔';

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
  String get longEdgeFromLevel => 'کنارے پر · لمبا کنارہ ہموار سے';

  @override
  String shortEdge(String value) {
    return 'چھوٹا کنارہ $value';
  }

  @override
  String edgeAngleSemantics(String long, String short) {
    return 'لمبا کنارہ ہموار سے $long، چھوٹا کنارہ $short';
  }

  @override
  String get angleModeAuto => 'خودکار';

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
      'یہ مقناطیسی شمال دکھاتا ہے، جو نقشے کے شمال سے چند درجے مختلف ہو سکتا ہے۔ غلط لگے تو فون کو چند بار 8 کی شکل میں گھمائیں۔';

  @override
  String compassSemantics(int heading, String direction) {
    return 'مقناطیسی رخ $heading درجے، $direction';
  }

  @override
  String get magneticInterference => 'مقناطیسی مداخلت · دھات سے دور ہٹیں';

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
      '«قریب دھات ہے» کا مطلب چھوٹی تبدیلی اور «دھات مل گئی» کا مطلب بڑی تبدیلی ہے: درمیان نارنجی ہو جاتا ہے اور وائبریشن آن ہو تو فون وائبریٹ کرتا ہے۔';

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
      'فون کو جانچنے والی سطح یا مشین پر لٹائیں اور ہاتھ ہٹا لیں۔';

  @override
  String get vibrationHelp2 =>
      'ڈائل ابھی کا ارتعاش m/s² میں دکھاتا ہے۔ گراف پچھلے چند سیکنڈ دکھاتا ہے۔';

  @override
  String get vibrationHelp3 =>
      'زیادہ سے زیادہ سب سے تیز لمحہ ہے۔ اوسط پچھلے ایک سیکنڈ کی سطح ہے۔';

  @override
  String get vibrationHelp4 =>
      'ہر نئے ٹیسٹ سے پہلے زیادہ سے زیادہ ری سیٹ کریں دبائیں۔';

  @override
  String get vibrationTip =>
      '«ساکن» کا مطلب 0.3 m/s² سے کم اور «تیز ارتعاش» کا مطلب 2 m/s² سے زیادہ ہے۔ ریڈنگز کو موازنے کے لیے استعمال کریں؛ فون کے سینسر لیبارٹری کے آلات نہیں۔';

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
  String get peak => 'زیادہ سے زیادہ';

  @override
  String get average => 'اوسط';

  @override
  String get resetPeak => 'زیادہ سے زیادہ ری سیٹ کریں';

  @override
  String get vibrationGraph => 'ارتعاش کا گراف';

  @override
  String get altimeterHelp1 =>
      'ڈائل ہوا کا دباؤ hPa میں دکھاتا ہے، اور اسی سے اونچائی کا اندازہ لگایا جاتا ہے۔';

  @override
  String get altimeterHelp2 =>
      'اونچائی کی تبدیلی ناپنے کے لیے، جیسے سیڑھیاں یا منزلیں، شروع کی جگہ پر یہاں صفر کریں دبائیں۔';

  @override
  String get altimeterHelp3 =>
      'اوپر یا نیچے جائیں۔ درمیان میں آپ کے صفر سے میٹر نظر آتے ہیں۔';

  @override
  String get altimeterHelp4 => 'واپس جانے کے لیے صفر ہٹائیں دبائیں۔';

  @override
  String get altimeterTip =>
      'موسم ہوا کا دباؤ بدلتا ہے، اس لیے اونچائی دسیوں میٹر تک غلط ہو سکتی ہے۔ آپ کے صفر سے اونچائی کم وقت کے لیے درست رہتی ہے۔ اس ٹول کے لیے بیرومیٹر والا فون چاہیے۔';

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
      'لکس اور روشنی کس کام کے لائق ہے، یہ پڑھیں: پڑھنے اور میز کے کام کے لیے 300–750 lx ٹھیک ہے۔';

  @override
  String get lightHelp4 =>
      'فون ہٹاتے وقت ریڈنگ برقرار رکھنے کے لیے لاک کریں دبائیں۔';

  @override
  String get lightTip =>
      'ہر فون کا لائٹ سینسر مختلف ہوتا ہے، اس لیے ریڈنگ 10–20% تک مختلف ہو سکتی ہے: جگہوں کا موازنہ کرنے کے لیے ٹھیک، مگر کیلیبریٹڈ لکس میٹر نہیں۔ اسکرین کا اوپری حصہ نہ ڈھانپیں۔';

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
      'بڑا نمبر ابھی کی سطح ہے، تقریباً ایک سیکنڈ کا اوسط۔';

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
      'ہر فون کا مائیکروفون مختلف ہوتا ہے، اس لیے ریڈنگ تقریباً 5 dB مختلف ہو سکتی ہے: موازنے کے لیے ٹھیک، مگر مصدقہ ساؤنڈ میٹر نہیں۔ بہت تیز آوازیں (تقریباً 110 dB سے اوپر) کم دکھ سکتی ہیں۔';

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
}
