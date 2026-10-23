// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ميزان الماء ومقياس الزوايا';

  @override
  String get homeTitle => 'ميزان الماء';

  @override
  String get settings => 'الإعدادات';

  @override
  String get homeTopTools => 'أدواتك المفضلة';

  @override
  String get homeMoreTools => 'أدوات أخرى';

  @override
  String get homeArrange => 'ترتيب';

  @override
  String get arrangeTitle => 'ترتيب الأدوات';

  @override
  String get arrangeHint =>
      'اسحب لتغيير الترتيب. أول ثلاث أدوات هي أدواتك المفضلة.';

  @override
  String get arrangeStar => 'اجعلها مفضلة';

  @override
  String get arrangeUnstar => 'أزلها من المفضلة';

  @override
  String get arrangeReset => 'الترتيب الشائع';

  @override
  String get arrangeDone => 'تم';

  @override
  String get back => 'رجوع';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get toolLevel => 'ميزان الماء';

  @override
  String get toolLevelSubtitle => 'ميزان الفقاعة والميزان الأنبوبي';

  @override
  String get toolAngle => 'الزاوية';

  @override
  String get toolAngleSubtitle => 'الزاوية من الوضع الأفقي أو من نقطة الصفر';

  @override
  String get toolCompass => 'البوصلة';

  @override
  String get toolCompassSubtitle => 'الاتجاه والوجهة';

  @override
  String get toolProtractor => 'المنقلة';

  @override
  String get toolProtractorSubtitle => 'قِس الزوايا على الشاشة';

  @override
  String get toolRuler => 'المسطرة';

  @override
  String get toolRulerSubtitle => 'قِس الأطوال على الشاشة';

  @override
  String get toolMetal => 'كاشف المعادن';

  @override
  String get toolMetalSubtitle => 'اعثر على الحديد والفولاذ والمغناطيس';

  @override
  String get toolVibration => 'الاهتزاز';

  @override
  String get toolVibrationSubtitle => 'قوة الاهتزاز وسرعته (دورة/دقيقة)';

  @override
  String get toolSound => 'مقياس الصوت';

  @override
  String get toolSoundSubtitle => 'مستوى الضوضاء بالديسيبل';

  @override
  String get toolAltimeter => 'مقياس الارتفاع';

  @override
  String get toolAltimeterSubtitle => 'ضغط الهواء والارتفاع';

  @override
  String get toolLight => 'مقياس الضوء';

  @override
  String get toolLightSubtitle => 'السطوع باللوكس';

  @override
  String get notAvailableOnPhone => 'غير متاح على هذا الهاتف';

  @override
  String get notOnPhone => 'غير متاح';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool، غير متاح على هذا الهاتف';
  }

  @override
  String get howToUse => 'طريقة الاستخدام';

  @override
  String get rotateLandscape => 'التدوير إلى الوضع الأفقي';

  @override
  String get rotatePortrait => 'التدوير إلى الوضع الرأسي';

  @override
  String howToUseTool(String tool) {
    return 'طريقة استخدام $tool';
  }

  @override
  String get gotIt => 'فهمت';

  @override
  String get goodToKnow => 'معلومة مفيدة: ';

  @override
  String get ok => 'حسنًا';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool غير متاح';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'مستشعرات',
      one: 'مستشعر',
    );
    return 'تحتاج أداة $tool إلى $_temp0 غير موجودة في هذا الهاتف: $sensors.';
  }

  @override
  String get listSeparator => '، ';

  @override
  String get hardwareLimitTip =>
      'هذا قيد في عتاد الهاتف وليس خطأ في التطبيق. كل الأدوات الأخرى تعمل بشكل طبيعي.';

  @override
  String get sensorAccelerometer => 'مقياس التسارع';

  @override
  String get sensorMagnetometer => 'مقياس المغناطيسية (مستشعر البوصلة)';

  @override
  String get sensorBarometer => 'البارومتر (مستشعر ضغط الهواء)';

  @override
  String get sensorLight => 'مستشعر الضوء';

  @override
  String get sensorMicrophone => 'الميكروفون';

  @override
  String get sensorCamera => 'الكاميرا الخلفية';

  @override
  String get sensorGps => 'GPS';

  @override
  String get noAccelerometer =>
      'لا يحتوي هذا الهاتف على مقياس تسارع، لذا لا تستطيع هذه الأداة القياس هنا. الأدوات التي لا تحتاج إليه تعمل كالمعتاد.';

  @override
  String get noMagnetometer =>
      'لا يحتوي هذا الهاتف على مقياس مغناطيسية (مستشعر البوصلة)، لذا لا تعمل هذه الأداة هنا. الأدوات التي لا تحتاج إليه تعمل كالمعتاد.';

  @override
  String get noReadings =>
      'لم تصل أي قراءات من المستشعر بعد. ارجع وافتح الأداة مرة أخرى، وإذا تكرر ذلك فأعد تشغيل الهاتف. بعض الهواتف لا تدعم هذه الأداة.';

  @override
  String get waitingForSensors => 'في انتظار المستشعرات…';

  @override
  String get levelHelp1 =>
      'ضع الهاتف مسطحًا على السطح، أو أوقفه على إحدى حوافه.';

  @override
  String get levelHelp2 =>
      'مسطحًا: اجعل الفقاعة في المنتصف. X هو الميل يمينًا ويسارًا، وY هو الميل للأمام والخلف. على الحافة تظهر الزاوية والانحدار.';

  @override
  String get levelHelp3 =>
      'اتبع الإرشاد على الشاشة (مثل «الجانب الأيمن مرتفع») حتى يظهر «مستوٍ»: يتحول العرض إلى البرتقالي ويصدر الهاتف صوتًا واهتزازًا (يمكن إيقافهما من الإعدادات).';

  @override
  String get levelHelp4 =>
      'اضغط قفل لتجميد القراءة، وإلغاء القفل للعودة إلى القياس المباشر.';

  @override
  String get levelHelp5 =>
      'تفضّل ميزان الماء التقليدي؟ اضغط رمز الأنبوب في المبدّل، والرمز الدائري يعيد القرص.';

  @override
  String get levelTip =>
      'إذا لم يُظهر سطح تعرف أنه مستوٍ 0°، فضع الهاتف عليه واضغط معايرة. للتراجع، اضغط معايرة مرة أخرى واختر إعادة ضبط المعايرة.';

  @override
  String get statusLevel => 'مستوٍ';

  @override
  String get leftEndLow => 'الطرف الأيسر منخفض';

  @override
  String get rightEndLow => 'الطرف الأيمن منخفض';

  @override
  String get rightSideHigh => 'الجانب الأيمن مرتفع';

  @override
  String get leftSideHigh => 'الجانب الأيسر مرتفع';

  @override
  String get topEdgeHigh => 'الحافة العلوية مرتفعة';

  @override
  String get bottomEdgeHigh => 'الحافة السفلية مرتفعة';

  @override
  String get calibrated => 'تمت المعايرة. هذا الوضع يُظهر الآن 0°.';

  @override
  String get tooFarToCalibrate =>
      'الميل كبير جدًا للمعايرة. ضع الهاتف أولًا على سطح مستوٍ.';

  @override
  String get dialView => 'عرض القرص';

  @override
  String get tubeView => 'عرض الأنبوب';

  @override
  String get levelTube => 'أنبوب الميزان';

  @override
  String get leftRightTube => 'أنبوب اليمين واليسار';

  @override
  String get forwardBackTube => 'أنبوب الأمام والخلف';

  @override
  String tiltFromLevel(String value) {
    return 'الميل عن الوضع الأفقي $value';
  }

  @override
  String fromLevel(String value) {
    return 'الانحراف عن الوضع الأفقي $value';
  }

  @override
  String get xLeftRight => 'X · يسار / يمين';

  @override
  String get yForwardBack => 'Y · أمام / خلف';

  @override
  String get angle => 'الزاوية';

  @override
  String get slope => 'الانحدار';

  @override
  String get lock => 'قفل';

  @override
  String get unlock => 'إلغاء القفل';

  @override
  String locked(String status) {
    return 'مقفل · $status';
  }

  @override
  String get lockReading => 'قفل القراءة';

  @override
  String get lockHandles => 'قفل المقابض';

  @override
  String get handlesLocked => 'المقابض مقفلة · اضغط القفل للتعديل';

  @override
  String get calibrate => 'معايرة';

  @override
  String get angleHelp1 =>
      'ضع الهاتف على سطح لقراءة ميله، أو أوقفه على حافته على منحدر أو درابزين أو أنبوب: الرقم الكبير هو زاوية الحافة المضيئة بالبرتقالي، وزاوية الحافة السفلية تحته.';

  @override
  String get angleHelp2 =>
      'لقياس تغيّر، أمسك الهاتف في وضع البداية واضغط اجعل هنا صفرًا.';

  @override
  String get angleHelp3 =>
      'أمِل الهاتف أو حرّكه. يُظهر القرص عدد الدرجات التي تحركها من نقطة الصفر.';

  @override
  String get angleHelp4 => 'اضغط مسح الصفر للعودة إلى الزاوية من الوضع المسطح.';

  @override
  String get angleHelp5 =>
      'لقراءة زاوية لا تراها، ألصق الهاتف بالجسم واضغط القفل، ثم ارفعه واقرأ.';

  @override
  String get angleHelp6 =>
      'اختر الوضع من المفتاح في الأعلى: مسطحًا على سطح أو واقفًا على حافة. على الحافة تمتلئ الشاشة بماء يبقى مستويًا، وتضيء الحافة التي تقيسها، أي الجانب الأدنى، باللون البرتقالي.';

  @override
  String get angleTip =>
      'ضع الجانب الطويل للهاتف على منحدر أو درابزين أو سقف لقراءة ميله، أو ألصق الشاشة بلوح أو باب لقياس ميله.';

  @override
  String movedFromZero(String value) {
    return 'التحرك من الصفر $value';
  }

  @override
  String get measuringFromZero => 'القياس من نقطة الصفر';

  @override
  String get angleFlatStatus => 'مسطح · الزاوية بالنسبة إلى الأرض';

  @override
  String get measuringRightEdge => 'قياس الحافة اليمنى';

  @override
  String get measuringLeftEdge => 'قياس الحافة اليسرى';

  @override
  String bottomEdge(String value) {
    return 'الحافة السفلية $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: $value عن المستوى. الحافة السفلية $other';
  }

  @override
  String get angleModeFlat => 'مسطح على سطح';

  @override
  String get angleModeEdge => 'على حافة';

  @override
  String get standOnEdge => 'أوقف الهاتف على إحدى حوافه';

  @override
  String get clearZero => 'مسح الصفر';

  @override
  String get setZeroHere => 'اجعل هنا صفرًا';

  @override
  String get compassHelp1 =>
      'أمسك الهاتف أفقيًا أمامك، بعيدًا عن المعادن والمغناطيس والأجهزة الإلكترونية.';

  @override
  String get compassHelp2 =>
      'وجّه أعلى الهاتف نحو الاتجاه الذي تريد معرفته. وعند إمساكه رأسيًا تُظهر الاتجاه الذي تواجهه الكاميرا الخلفية.';

  @override
  String get compassHelp3 =>
      'الرقم هو اتجاهك بالدرجات والحروف هي الجهة. يدور القرص بحيث يشير حرف N دائمًا إلى الشمال، وتحدد الكرة البرتقالية في الأعلى الاتجاه الذي يشير إليه هاتفك.';

  @override
  String get compassTip =>
      'تشير البوصلة إلى الشمال المغناطيسي، وقد يختلف في بعض الأماكن عن شمال الخريطة بمقدار 10 درجات أو أكثر. إذا بدت القراءة خاطئة فحرّك الهاتف على شكل الرقم 8 عدة مرات.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'الاتجاه المغناطيسي $heading درجة، $direction';
  }

  @override
  String get magneticInterference =>
      'تشويش مغناطيسي · ابتعد عن المعادن، ثم حرّك الهاتف على شكل الرقم 8';

  @override
  String get compassCalibrate => 'حرّك الهاتف على شكل الرقم 8 لمعايرة البوصلة';

  @override
  String get dirN => 'ش';

  @override
  String get dirNE => 'ش ق';

  @override
  String get dirE => 'ق';

  @override
  String get dirSE => 'ج ق';

  @override
  String get dirS => 'ج';

  @override
  String get dirSW => 'ج غ';

  @override
  String get dirW => 'غ';

  @override
  String get dirNW => 'ش غ';

  @override
  String get protractorHelp1 =>
      'ضع الهاتف مسطحًا وضع الجسم على الشاشة بحيث تكون زاويته في المنتصف.';

  @override
  String get protractorHelp2 =>
      'اسحب كل مقبض برتقالي حتى يمتد خطه على أحد ضلعي الزاوية.';

  @override
  String get protractorHelp3 =>
      'اقرأ الزاوية في المنتصف. المنعكسة هي الجهة الأخرى (360° ناقص الزاوية).';

  @override
  String get protractorHelp4 => 'اضغط إعادة الضبط للبدء من جديد.';

  @override
  String get protractorHelp5 =>
      'اضغط القفل لتبقى المقابض في مكانها أثناء تحريك الجسم.';

  @override
  String armsSemantics(String value) {
    return 'الزاوية بين الذراعين $value';
  }

  @override
  String get reflex => 'المنعكسة';

  @override
  String get dragHandles => 'اسحب المقابض البرتقالية على الحواف';

  @override
  String get reset => 'إعادة الضبط';

  @override
  String get rulerHelp1 => 'ضع الجسم على الشاشة، أو ألصق الهاتف به.';

  @override
  String get rulerHelp2 =>
      'اسحب الخطين البرتقاليين إلى طرفي الجسم. اضغط mm أو cm أو in لاختيار الوحدة؛ ويظهر النظام الآخر أسفلها.';

  @override
  String get rulerHelp3 =>
      'لأفضل دقة، اضغط معايرة مرة واحدة واستخدم بطاقة بنكية أو مسطرة أو حجم الشاشة.';

  @override
  String get rulerHelp4 =>
      'اضغط القفل ليبقى الخطان في مكانهما أثناء تحريك الجسم.';

  @override
  String get rulerTip =>
      'تقيس المسطرة حتى طول الشاشة. تُخفي الأغطية والحواف المنحنية أول بضعة مليمترات، لذا قِس بين الخطين وليس من حافة الهاتف.';

  @override
  String get rulerWidthOn => 'قِس العرض أيضًا';

  @override
  String rulerArea(String value) {
    return 'المساحة $value';
  }

  @override
  String rulerBoxSemantics(String length, String width, String area) {
    return 'الطول $length مليمتر، العرض $width مليمتر، المساحة $area سنتيمتر مربع';
  }

  @override
  String get rulerHelp5 =>
      'اضغط زر المستطيل في الأعلى لقياس العرض أيضًا: اسحب الخطين الجانبيين إلى طرفي الجسم لترى عرضه ومساحته. أقصى عرض هو عرض الشاشة.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'الطول $mm مليمتر، $inches بوصة';
  }

  @override
  String get rulerCalibrated => 'مُعايَرة ببطاقة · ±0.5 مم';

  @override
  String get rulerReported => 'حجم الشاشة من الهاتف · عايِر للحصول على ±0.5 مم';

  @override
  String get unitMillimetres => 'مليمترات';

  @override
  String get unitCentimetres => 'سنتيمترات';

  @override
  String get unitInches => 'بوصات';

  @override
  String get rulerEstimated => 'غير مُعايَرة · قد تخطئ الأطوال بنسبة 10%';

  @override
  String get cardLongEdge =>
      'ضع أي بطاقة بنكية أو هوية على الشاشة، ضلعها الطويل بمحاذاة المسطرة وأحد طرفيها على الخط الداكن. اسحب الخط البرتقالي إلى طرف البطاقة الآخر.';

  @override
  String get cardShortEdge =>
      'ضع أي بطاقة بنكية أو هوية على الشاشة، ضلعها القصير بمحاذاة المسطرة وأحد طرفيها على الخط الداكن. اسحب الخط البرتقالي إلى طرف البطاقة الآخر.';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get usePhoneDefault => 'استخدام حجم شاشة الهاتف';

  @override
  String get usePhoneDefaultInfo => 'نسيان هذه المعايرة';

  @override
  String get cardMismatch =>
      'هذا لا يطابق حجم بطاقة. حاذِها مع الخط الداكن وحاول مجددًا.';

  @override
  String get rotateToCalibrate => 'دوّر إلى الوضع الرأسي للمعايرة';

  @override
  String get calibrateHow => 'المعايرة باستخدام';

  @override
  String get methodCard => 'بطاقة بنكية';

  @override
  String get methodCardInfo => 'أي بطاقة بنكية أو هوية · ±0.5 مم';

  @override
  String get methodRuler => 'مسطرة';

  @override
  String get methodRulerInfo => 'الأدق · مسطرة أو شريط قياس';

  @override
  String get methodScreen => 'حجم الشاشة';

  @override
  String get methodScreenInfo => 'لا تحتاج إلى شيء · نحو 1%';

  @override
  String rulerInstructions(String mark) {
    return 'ضع مسطرة على الشاشة وصفرها على الخط الداكن. اسحب الخط البرتقالي إلى علامة $mark.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'هذا لا يطابق $mark. ضع صفر المسطرة على الخط الداكن وحاول مجددًا.';
  }

  @override
  String get screenSizeInstructions =>
      'اكتب حجم الشاشة بالبوصة من مواصفات الهاتف. لا تعرفه؟ ابحث عن طراز هاتفك و«حجم الشاشة».';

  @override
  String get screenSizeMismatch =>
      'هذا الحجم لا يناسب هذه الشاشة. راجع مواصفات الهاتف وحاول مجددًا.';

  @override
  String get rulerCalibratedRuler => 'مُعايَرة بمسطرة · ±0.5 مم';

  @override
  String rulerCalibratedScreen(String size) {
    return 'مضبوطة على شاشة $size بوصة · نحو 1%';
  }

  @override
  String get metalHelp1 =>
      'افتح الأداة بعيدًا عن المعادن. تُعدّ القراءة الأولى «لا معدن».';

  @override
  String get metalHelp2 =>
      'حرّك الهاتف ببطء فوق المنطقة. يكون المستشعر عادةً في أعلى الهاتف. يتسارع الصفير كلما اقتربت من المعدن، واضغط السمّاعة لكتم الصوت.';

  @override
  String get metalHelp3 =>
      '«معدن قريب» يعني تغيرًا صغيرًا، و«تم اكتشاف معدن» يعني تغيرًا قويًا. مثل لعبة الحار والبارد، تتحول الشاشة من الأزرق البارد إلى الأحمر المتوهج كلما اقتربت، ويهتز الهاتف عند العثور عليه إذا كان الاهتزاز مفعّلًا.';

  @override
  String get metalHelp4 =>
      'عند إبقائه ثابتًا بضع ثوانٍ يعود إلى الصفر تلقائيًا، فتختفي القراءة الخاطئة. لفحص موضع مرة أخرى، أبعد الهاتف ثم أعده. يعيد «ضبط المرجع» الصفر فورًا.';

  @override
  String get metalTip =>
      'يكتشف الحديد والفولاذ والمغناطيس فقط، وليس الألومنيوم أو النحاس أو الذهب أو الفضة. تؤثر فيه أغطية الهاتف المغناطيسية.';

  @override
  String metalSemantics(int value) {
    return 'المجال المغناطيسي $value ميكروتسلا';
  }

  @override
  String get noMetal => 'لا معدن قريب';

  @override
  String get metalNearby => 'معدن قريب';

  @override
  String get metalDetected => 'تم اكتشاف معدن';

  @override
  String get heatCold => 'بارد';

  @override
  String get heatCool => 'منعش';

  @override
  String get heatWarm => 'دافئ';

  @override
  String get heatWarmer => 'أدفأ';

  @override
  String get heatHot => 'حار';

  @override
  String get heatBurning => 'يحترق';

  @override
  String get baseline => 'المرجع';

  @override
  String get field => 'المجال';

  @override
  String get change => 'التغيّر';

  @override
  String get findsIronSteel => 'يكتشف الحديد والفولاذ والمغناطيس';

  @override
  String get setBaseline => 'ضبط المرجع';

  @override
  String get muteSound => 'كتم الصوت';

  @override
  String get turnSoundOn => 'تشغيل الصوت';

  @override
  String get vibrationHelp1 =>
      'ضع الهاتف مسطحًا على الآلة وهي تعمل وأبعد يديك. على آلة صغيرة، اضغطه بثبات.';

  @override
  String get vibrationHelp2 =>
      'يُظهر المؤشر سرعة أقوى اهتزاز بالدورة في الدقيقة، وتحته بالهرتز (الدورة في الدقيقة تساوي الهرتز × 60). التوهج الخافت داخل القرص هو الطيف كله، والمؤشر يشير إلى أسطع جزء فيه.';

  @override
  String get vibrationHelp3 =>
      'القوة هي مدى شدة الاهتزاز بوحدة m/s²: أقل من 0.3 ثابت، وأكثر من 2 قوي.';

  @override
  String get vibrationHelp4 =>
      'اضغط قفل لتثبيت القراءة، وزر إعادة الضبط قبل قياس الآلة التالية.';

  @override
  String get vibrationTip =>
      'تقيس معظم الهواتف حتى 100 Hz (6000 دورة/دقيقة) وبعضها أقل، ويُظهر القرص حد هاتفك. قد يظهر الاهتزاز الأسرع بسرعة أقل وخاطئة. أقوى اهتزاز غالبًا هو سرعة العمود، لكنه قد يكون ضعفها. مستشعرات الهاتف ليست أجهزة مختبر.';

  @override
  String get still => 'ثابت';

  @override
  String get lightVibration => 'اهتزاز خفيف';

  @override
  String get strongVibration => 'اهتزاز قوي';

  @override
  String get noAccelerometerVibration =>
      'لا يحتوي هذا الهاتف على مقياس تسارع، لذا لا يمكن قياس الاهتزاز هنا. الأدوات التي لا تحتاج إليه تعمل كالمعتاد.';

  @override
  String vibrationSemantics(String value) {
    return 'الاهتزاز $value متر لكل ثانية مربعة';
  }

  @override
  String get frequency => 'التردد';

  @override
  String get rpm => 'دورة/دقيقة';

  @override
  String get strength => 'القوة';

  @override
  String vibratingAt(String value) {
    return 'يهتز عند $value Hz';
  }

  @override
  String get noClearFrequency => 'لا يوجد تردد واضح';

  @override
  String get findingFrequency => 'جارٍ البحث عن التردد…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm دورة في الدقيقة، $value هرتز';
  }

  @override
  String get peak => 'الذروة';

  @override
  String get average => 'المتوسط';

  @override
  String get resetPeak => 'إعادة ضبط الذروة';

  @override
  String get altimeterHelp1 =>
      'يصعد المتنزّه الجبل أو ينزل منه كلما تغيّر ارتفاعك. تتبع السماء وقت اليوم والموسم؛ اضغط زر الطقس لتختار بنفسك.';

  @override
  String get altimeterHelp2 =>
      'لقياس تغيّر في الارتفاع، مثل الدرج أو الطوابق، اضغط اجعل هنا صفرًا عند نقطة البداية.';

  @override
  String get altimeterHelp3 =>
      'اصعد أو انزل: يمشي المتنزّه معك ويحدّد العلم أعلى نقطة بلغتها. تعرض اللوحة الأمتار من الصفر وضغط الهواء والارتفاع التقريبي.';

  @override
  String get altimeterHelp4 =>
      'اضغط مسح الصفر لإيقاف القياس من نقطة الصفر: تعود قراءة من الصفر فارغة.';

  @override
  String get altimeterTip =>
      'يغيّر الطقس ضغط الهواء باستمرار، لذا قد يخطئ الارتفاع بمئة متر أو أكثر إن لم يكن ارتفاع البداية معروفًا. اعتمد على تغيّر الارتفاع من اجعل هنا صفرًا خلال فترة قصيرة. تحتاج هذه الأداة إلى هاتف به بارومتر.';

  @override
  String get weather => 'الطقس';

  @override
  String get weatherAuto => 'تلقائي (الوقت والموسم)';

  @override
  String get weatherSunny => 'مشمس';

  @override
  String get weatherCloudy => 'غائم';

  @override
  String get weatherRain => 'مطر';

  @override
  String get weatherStorm => 'عاصفة';

  @override
  String get weatherSnow => 'ثلج';

  @override
  String get fromZero => 'من الصفر';

  @override
  String get altitudeShort => 'الارتفاع';

  @override
  String get barometerIos =>
      'تعذّرت قراءة البارومتر. فعّل «الحركة واللياقة» لهذا التطبيق من الإعدادات › الخصوصية والأمن، ثم افتح مقياس الارتفاع مرة أخرى.';

  @override
  String get noBarometer =>
      'لا يحتوي هذا الهاتف على بارومتر (مستشعر ضغط الهواء)، لذا لا يعمل مقياس الارتفاع هنا. الأدوات الأخرى تعمل كالمعتاد.';

  @override
  String get noLightSensor =>
      'لا يحتوي هذا الهاتف على مستشعر للضوء، لذا لا يعمل مقياس الضوء هنا. تبقى الأدوات الأخرى تعمل.';

  @override
  String lightSemantics(String value) {
    return 'السطوع $value لوكس';
  }

  @override
  String get illuminance => 'السطوع';

  @override
  String get footCandles => 'شمعة-قدم';

  @override
  String get lightDark => 'مظلم';

  @override
  String get lightDim => 'إضاءة خافتة';

  @override
  String get lightLivingRoom => 'إضاءة غرفة المعيشة';

  @override
  String get lightReading => 'مناسبة للقراءة والعمل على المكتب';

  @override
  String get lightBright => 'إضاءة داخلية ساطعة';

  @override
  String get lightOvercast => 'نهار غائم';

  @override
  String get lightDaylight => 'ضوء النهار';

  @override
  String get lightSun => 'أشعة الشمس المباشرة';

  @override
  String get lightHelp1 =>
      'يقع مستشعر الضوء أعلى الشاشة، قرب الكاميرا الأمامية.';

  @override
  String get lightHelp2 =>
      'أمسك الهاتف حيث تريد القياس، والشاشة متجهة نحو الضوء.';

  @override
  String get lightHelp3 =>
      'تتبع السماء الضوء: ليل في الظلام، وفجر في غرفة خافتة، وتصعد الشمس كلما زاد الضوء. اقرأ اللوكس وما يناسبه الضوء: من 300 إلى 750 لوكس مناسب للقراءة والعمل المكتبي.';

  @override
  String get lightHelp4 => 'اضغط قفل للاحتفاظ بالقراءة أثناء إبعاد الهاتف.';

  @override
  String get lightTip =>
      'مستشعرات الضوء في الهواتف غير معايَرة، لذا قد تختلف القراءات كثيرًا من هاتف لآخر. استخدمها لمقارنة الضوء في مكان واحد بالهاتف نفسه، لا كمقياس لوكس معايَر. لا تغطِّ أعلى الشاشة.';

  @override
  String get noMicrophone =>
      'تعذّر استخدام الميكروفون. ربما يستخدمه تطبيق آخر: أغلقه ثم افتح مقياس الصوت مجددًا.';

  @override
  String soundSemantics(String value) {
    return 'مستوى الصوت نحو $value ديسيبل';
  }

  @override
  String get decibelsApprox => 'dB (تقريبي)';

  @override
  String get soundMax => 'الأقصى';

  @override
  String get soundVeryQuiet => 'هادئ جدًا';

  @override
  String get soundQuiet => 'هادئ، كالمكتبة';

  @override
  String get soundModerate => 'متوسط، كالمحادثة';

  @override
  String get soundLoud => 'مرتفع، كحركة مرور كثيفة';

  @override
  String get soundVeryLoud => 'مرتفع جدًا: التعرض الطويل قد يضر بالسمع';

  @override
  String get soundDangerous => 'خطير: احمِ أذنيك';

  @override
  String get micTitle => 'اسمح باستخدام الميكروفون';

  @override
  String get micBody =>
      'يستمع مقياس الصوت عبر الميكروفون لقياس شدة الصوت. يُقاس الصوت على هاتفك فقط، ولا يُسجَّل أو يُحفظ أو يُرسل أبدًا.';

  @override
  String get micAllow => 'السماح بالميكروفون';

  @override
  String get micDeniedTitle => 'الوصول إلى الميكروفون متوقف';

  @override
  String get micDeniedBody =>
      'فعّل الميكروفون لهذا التطبيق من الإعدادات لاستخدام مقياس الصوت. لا يُسجَّل الصوت أو يُحفظ أو يُرسل أبدًا.';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get tryAgain => 'إعادة المحاولة';

  @override
  String get soundHelp1 =>
      'اترك الميكروفون (في الحافة السفلية) مكشوفًا ووجّه الهاتف نحو الصوت.';

  @override
  String get soundHelp2 =>
      'الرقم الكبير هو المستوى الآن، بمتوسط نحو ثانية. تنتشر منه تموجات، أكثر وأبعد كلما علا الصوت: خضراء في الهدوء، ثم صفراء وبرتقالية وحمراء وقرمزية. تُظهر الأشرطة في الأسفل آخر ثلاث ثوانٍ.';

  @override
  String get soundHelp3 =>
      'يُحسب المتوسط والأقصى منذ فتح الأداة. اضغط إعادة الضبط للبدء من جديد.';

  @override
  String get soundHelp4 =>
      'ابتداءً من 70 ديسيبل يتحول سطر الحالة إلى الأصفر، ومن 85 ديسيبل، حيث قد يضر التعرض الطويل بالسمع، إلى الأحمر.';

  @override
  String get soundHelp5 =>
      'اضغط القفل للاحتفاظ بالقراءة على الشاشة أثناء تحريك الهاتف.';

  @override
  String get soundTip =>
      'ميكروفونات الهواتف ليست مقاييس صوت معايَرة وتختلف من طراز لآخر، لذا القراءات تقريبية (غالبًا في حدود 5 إلى 10 ديسيبل تقريبًا) وقد تظهر الأصوات العالية جدًا أقل من حقيقتها. لأي قياس رسمي تحتاج إلى مقياس صوت معايَر.';

  @override
  String get metresFromZero => 'م من الصفر';

  @override
  String pressureSemantics(String value) {
    return 'ضغط الهواء $value هكتوباسكال';
  }

  @override
  String heightSemantics(String value) {
    return 'الارتفاع $value من الصفر';
  }

  @override
  String get pressure => 'الضغط';

  @override
  String get altitudeApprox => 'الارتفاع (تقريبي)';

  @override
  String get measuringHeight => 'قياس الارتفاع من نقطة الصفر';

  @override
  String get airPressureAltitude => 'ضغط الهواء والارتفاع';

  @override
  String get appearance => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get levelUnits => 'وحدة الميزان';

  @override
  String get unitDegrees => 'درجات';

  @override
  String get unitPercent => 'الميل بالنسبة المئوية';

  @override
  String get unitRoofPitch => 'ميل السقف (الارتفاع لكل 12)';

  @override
  String get vibrateWhenLevel => 'الاهتزاز';

  @override
  String get sounds => 'الأصوات';

  @override
  String get resetCalibration => 'إعادة ضبط المعايرة';

  @override
  String get resetCalibrationHint => 'استخدام صفر المستشعر الأصلي من جديد';

  @override
  String get calibrateHere => 'المعايرة هنا';

  @override
  String get calibrateHereInfo => 'على سطح تعرف أنه مستوٍ';

  @override
  String get calibrationRemoved =>
      'أُزيلت المعايرة. يعود ميزان الماء إلى صفر المستشعر الأصلي.';

  @override
  String get resetAllCalibrations => 'إعادة ضبط كل المعايرات';

  @override
  String get resetAllCalibrationsHint =>
      'ميزان الماء والمسطرة إلى إعدادات المصنع';

  @override
  String get resetAllTitle => 'إعادة ضبط كل المعايرات؟';

  @override
  String get resetAllBody =>
      'سيؤدي هذا إلى إزالة المعايرة التي ضبطتها في ميزان الماء (ويستخدمها مقياس الزوايا أيضًا) وفي المسطرة، ليعود كلاهما إلى إعدادات المصنع. تبقى إعداداتك الأخرى كما هي، ويمكنك المعايرة من جديد في أي وقت.';

  @override
  String get notCalibrated => 'غير مُعايَر';

  @override
  String get language => 'اللغة';

  @override
  String get licenses => 'تراخيص المصادر المفتوحة';

  @override
  String get languageSystem => 'لغة الهاتف';

  @override
  String get toolHeight => 'الارتفاع';

  @override
  String get toolHeightSubtitle => 'الارتفاع والمسافة بالتصويب';

  @override
  String get heightHelp1 =>
      'قف حيث ترى قاعدة الجسم وقمته. أمسك الهاتف والشاشة لأعلى وانظر على امتداد حافته العلوية.';

  @override
  String get heightHelp2 =>
      'صوّب الحافة العلوية نحو قاعدة الجسم واضغط تثبيت القاعدة: هذا يعطي المسافة.';

  @override
  String get heightHelp3 =>
      'صوّب الحافة العلوية نحو القمة واضغط تثبيت القمة: يظهر الارتفاع.';

  @override
  String get heightHelp4 =>
      'تعرف المسافة؟ اضغط المسافة واكتبها، ثم صوّب نحو القمة فقط. اضغط ارتفاع العين لضبط ارتفاعك.';

  @override
  String get heightTip =>
      'نحو ±5٪ على أرض مستوية مع ضبط ارتفاع العين بشكل صحيح (طولك ناقص نحو 10 سم). ابتعد حتى تكون القمة تحت 70° والقاعدة 3° على الأقل تحت المستوى. على المنحدر اكتب المسافة.';

  @override
  String get lockBase => 'تثبيت القاعدة';

  @override
  String get lockTop => 'تثبيت القمة';

  @override
  String get measureAgain => 'قياس من جديد';

  @override
  String get distance => 'المسافة';

  @override
  String get objectHeight => 'الارتفاع';

  @override
  String get eyeHeight => 'ارتفاع العين';

  @override
  String get sightAngle => 'زاوية التصويب';

  @override
  String get heightAimBase => 'صوّب الحافة العلوية نحو القاعدة';

  @override
  String get heightAimTop => 'الآن صوّب الحافة العلوية نحو القمة';

  @override
  String get heightDone => 'تم · اضغط قياس من جديد لقياس آخر';

  @override
  String get heightHoldFlatter =>
      'أمسك الهاتف بشكل أكثر استواءً وصوّب على امتداد حافته العلوية';

  @override
  String get heightTooFar =>
      'القاعدة قريبة جدًا من المستوى: اقترب أو اكتب المسافة';

  @override
  String get heightStepBack => 'شديد الانحدار: ابتعد لقراءة أثبت';

  @override
  String get knownDistance => 'المسافة إلى القاعدة';

  @override
  String get knownDistanceHint =>
      'المسافة على الأرض حتى قاعدة الجسم. امسحها لقياسها بالتصويب.';

  @override
  String get eyeHeightHint => 'ارتفاع عينيك عن الأرض: نحو طولك ناقص 10 سم.';

  @override
  String get clear => 'مسح';

  @override
  String get toolCamera => 'ميزان الكاميرا';

  @override
  String get toolCameraSubtitle => 'خطوط مستوية فوق الكاميرا، وقياس أي حافة';

  @override
  String get cameraHelp1 =>
      'وجّه الكاميرا الخلفية إلى جدار أو لوحة أو رف أو باب. أمسك الهاتف قائمًا ومقابلًا للجدار تمامًا.';

  @override
  String get cameraHelp2 =>
      'الخطوط المتصلة تتبع الجاذبية: فهي دائمًا أفقية وعمودية تمامًا. الخطوط المتقطعة مثبتة على الهاتف، والقوس الصغير بينها يُظهر مقدار ميله. تصبح الخطوط الحقيقية برتقالية عندما يستوي الهاتف.';

  @override
  String get cameraHelp3 =>
      'لفحص شيء ما، اضغط تجميد ثم اسحب المقبضين البرتقاليين إلى إحدى حوافه، مثل أعلى إطار. سترى مقدار ميل تلك الحافة وأي جانب ترفع، حتى لو لم تكن يدك مستوية. اجعل الخط قائمًا لفحص حافة عمودية.';

  @override
  String get cameraHelp4 =>
      'يُظهر الزران في الأعلى خطوط الهاتف والخطوط الحقيقية أو يخفيانها. يساعد الضوء في الزوايا المظلمة، ويعيدك متابعة إلى الصورة المباشرة.';

  @override
  String get cameraTip =>
      'لقياس الحافة بدقة، اجعل الهاتف مقابلًا للجدار تمامًا (للأمام/للخلف أقل من 5°) وقِس قرب منتصف الصورة حيث تحني العدسة الخطوط أقل. يستخدم معايرة الحافة في الميزان. لا تُسجَّل الصورة ولا تُحفظ ولا تُرسل أبدًا.';

  @override
  String get cameraAllowTitle => 'اسمح بالكاميرا';

  @override
  String get cameraAllowBody =>
      'يرسم ميزان الكاميرا خطوطًا مستوية فوق صورة الكاميرا ويقيس الحواف فيها. تبقى الصورة على هاتفك ولا تُسجَّل ولا تُحفظ ولا تُرسل أبدًا.';

  @override
  String get cameraAllow => 'السماح بالكاميرا';

  @override
  String get cameraDeniedTitle => 'الوصول إلى الكاميرا متوقف';

  @override
  String get cameraDeniedBody =>
      'شغّل الكاميرا لهذا التطبيق من الإعدادات لاستخدام ميزان الكاميرا. لا تُسجَّل الصورة ولا تُحفظ ولا تُرسل أبدًا.';

  @override
  String get noCamera =>
      'تعذّر استخدام الكاميرا. ربما يستخدمها تطبيق آخر أو لا توجد كاميرا في الهاتف: أغلق تطبيقات الكاميرا الأخرى ثم افتح ميزان الكاميرا من جديد.';

  @override
  String get tilt => 'الميل';

  @override
  String get forwardBack => 'للأمام/للخلف';

  @override
  String get cameraLevel => 'مستوٍ';

  @override
  String cameraTilted(String value) {
    return 'مائل $value°';
  }

  @override
  String get cameraHoldUpright => 'أمسك الهاتف قائمًا والكاميرا نحو الجدار';

  @override
  String get freeze => 'تجميد';

  @override
  String get resume => 'متابعة';

  @override
  String get torch => 'الضوء';

  @override
  String cameraSemantics(String value) {
    return 'صورة الكاميرا مع خطوط مستوية، مائلة $value درجة';
  }

  @override
  String get cameraPhoneLines => 'خطوط الهاتف';

  @override
  String get cameraTrueLines => 'الخطوط الحقيقية';

  @override
  String get cameraFrozen => 'مجمّد';

  @override
  String get cameraDragHandles => 'اسحب المقبضين إلى حافة';

  @override
  String get cameraFaceWall => 'اجعل الهاتف مقابلًا للجدار تمامًا';

  @override
  String get edgeLevel => 'هذه الحافة مستوية';

  @override
  String get edgePlumb => 'هذه الحافة عمودية';

  @override
  String edgeLiftRight(String value) {
    return 'الحافة مائلة $value°، ارفع اليمين';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'الحافة مائلة $value°، ارفع اليسار';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'الحافة منحرفة $value° عن العمودي';
  }

  @override
  String get cameraHandle => 'مقبض الحافة';

  @override
  String get toolGForce => 'قوة G';

  @override
  String get toolGForceSubtitle => 'الكبح والتسارع والانعطاف بوحدة g';

  @override
  String get gHelp1 =>
      'ثبّت الهاتف في حامل السيارة والشاشة مواجهة لك. والسيارة متوقفة، اضغط صفر: يتعلّم المقياس اتجاه الأسفل واتجاه الأمام.';

  @override
  String get gHelp2 =>
      'انطلق بالسيارة: يضيء جانب السيارة الذي تُدفع نحوه. الكبح يضيء الأمام، والتسارع الخلف، والمنعطف الجانب الخارجي. الأخضر خفيف، والبرتقالي قوي، والأحمر شديد.';

  @override
  String get gHelp3 =>
      'تحتفظ اللوحة بأقوى تسارع وكبح وانعطاف منذ الضغط على صفر، وتحتفظ النقاط على الحافة بأقوى دفعة في كل اتجاه. زر إعادة الضبط يمسحها.';

  @override
  String get gHelp4 =>
      'أبقِ عينيك على الطريق: دع راكبًا يقرؤها، أو راجع القيم القصوى بعد التوقف.';

  @override
  String get gTip =>
      'القراءات من مقياس التسارع وهي تقريبية: تعتمد على حامل ثابت وعلى ضغط صفر والسيارة متوقفة، وتكون أكثر تذبذبًا قليلًا على الطرق الوعرة. إذا تحرّك الحامل، فتوقف واضغط صفر مرة أخرى. ما فوق 0.5 g يعني كبحًا قويًا أو منعطفًا سريعًا لسيارة عادية.';

  @override
  String get gZero => 'صفر';

  @override
  String get gResetPeaks => 'إعادة ضبط القيم القصوى';

  @override
  String get gSpeedUp => 'تسارع';

  @override
  String get gBrake => 'كبح';

  @override
  String get gCorner => 'انعطاف';

  @override
  String get gSteady => 'ثابت';

  @override
  String gBraking(String value) {
    return 'كبح $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'تسارع $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'انعطاف لليسار $value g';
  }

  @override
  String gRightBend(String value) {
    return 'انعطاف لليمين $value g';
  }

  @override
  String gSemantics(String value) {
    return 'قوة G $value g';
  }

  @override
  String get gZeroed => 'تم التصفير: تم تعلّم الأمام والأسفل';

  @override
  String get noAccelerometerG =>
      'لا يحتوي هذا الهاتف على مقياس تسارع، لذا لا يمكن قياس قوة G هنا. الأدوات الأخرى تعمل كالمعتاد.';

  @override
  String get toolSpeed => 'عداد السرعة';

  @override
  String get toolSpeedSubtitle => 'السرعة والرحلة والارتفاع عبر GPS';

  @override
  String get speedHelp1 =>
      'اسمح بالموقع، ثم ضع الهاتف حيث يرى السماء، مثل لوحة القيادة أو حامل على الزجاج الأمامي. في الخارج، يستغرق تحديد الموقع أول مرة بضع ثوانٍ.';

  @override
  String get speedHelp2 =>
      'يعرض العداد على لوحة القيادة سرعتك من GPS، وعلى جانبيه مسافة الرحلة والارتفاع. وتحتفظ اللوحة السفلية بالمسافة وأعلى سرعة والمتوسط منذ آخر إعادة ضبط.';

  @override
  String get speedHelp3 =>
      'اضغط على الإحداثيات لنسخها. يبدّل زر الوحدة بين كم/س وميل/س، وتبدأ إعادة ضبط الرحلة المسافة وأعلى سرعة والمتوسط من جديد.';

  @override
  String get speedHelp4 =>
      'أبقِ عينيك على الطريق: دع راكبًا يقرؤها، أو راجع الرحلة بعد التوقف.';

  @override
  String get speedTip =>
      'تأتي السرعة من الأقمار الصناعية وتكون عادةً ضمن نحو 1 كم/س على الطرق المفتوحة؛ وفي الأنفاق أو بين المباني العالية أو داخل المباني قد تتأخر أو تنقطع. قد يخطئ ارتفاع GPS بما بين 10 و50 م، لذا استخدم مقياس الارتفاع لتغيّرات الارتفاع. لا يُستخدم الموقع إلا أثناء فتح هذه الأداة، ولا يغادر هاتفك أبدًا.';

  @override
  String get speedAllowTitle => 'اسمح بالموقع';

  @override
  String get speedAllowBody =>
      'يستخدم عداد السرعة GPS لقياس سرعتك والمسافة والارتفاع. لا يُستخدم الموقع إلا أثناء فتح هذه الأداة على الشاشة، ولا يُستخدم في الخلفية أبدًا، ولا يغادر هاتفك أبدًا.';

  @override
  String get speedAllow => 'السماح بالموقع';

  @override
  String get speedDeniedTitle => 'الوصول إلى الموقع متوقف';

  @override
  String get speedDeniedBody =>
      'فعّل الموقع لهذا التطبيق من الإعدادات لاستخدام عداد السرعة. لا يُستخدم إلا أثناء فتح الأداة ولا يغادر هاتفك أبدًا.';

  @override
  String get speedServiceOffTitle => 'خدمة الموقع متوقفة';

  @override
  String get speedServiceOffBody =>
      'شغّل الموقع من إعدادات الهاتف لاستخدام عداد السرعة.';

  @override
  String get speedDistance => 'المسافة';

  @override
  String get speedTop => 'الأعلى';

  @override
  String get speedAverage => 'المتوسط';

  @override
  String get speedTrip => 'الرحلة';

  @override
  String get speedAltitude => 'الارتفاع';

  @override
  String get speedResetTrip => 'إعادة ضبط الرحلة';

  @override
  String get speedFinding => 'جارٍ البحث عن الأقمار الصناعية…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value م';
  }

  @override
  String get speedWeak => 'إشارة GPS ضعيفة: قد تتأخر السرعة';

  @override
  String get speedApproximate => 'الموقع الدقيق متوقف: شغّله لسرعة ثابتة';

  @override
  String get speedStill => 'متوقف';

  @override
  String get speedCopied => 'تم نسخ الإحداثيات';

  @override
  String get speedUnitTooltip => 'التبديل بين كم/س وميل/س';

  @override
  String get speedKmh => 'كم/س';

  @override
  String get speedMph => 'ميل/س';

  @override
  String speedSemantics(String value) {
    return 'السرعة $value';
  }

  @override
  String get speedCoordinates => 'الإحداثيات، اضغط للنسخ';

  @override
  String get noGps =>
      'لا يحتوي هذا الهاتف على GPS، لذا لا يمكن قياس السرعة هنا. الأدوات الأخرى تعمل كالمعتاد.';

  @override
  String get speedSceneHelp =>
      'تتبع السماء وقت اليوم. يختار زر الطقس المشهد: تلقائي يتبع الموسم، أو اختر الشمس أو الغيوم أو المطر أو العاصفة أو الثلج. إنه مشهد فقط، وليس توقعًا للطقس.';

  @override
  String get supportTitle => 'مجاني وبلا إعلانات';

  @override
  String get supportBody =>
      'صنعه شخص واحد في وقت فراغه. إن كان يفيدك، يمكنك دعمه.';

  @override
  String get supportButton => 'ادعمه على GitHub';

  @override
  String get linkCopied => 'تم نسخ الرابط';

  @override
  String madeBy(String name) {
    return 'تصميم وتطوير $name';
  }

  @override
  String testFeedbackTitle(String app) {
    return 'ساعدني في تحسين $app';
  }

  @override
  String get testFeedbackBody => 'وجدت مشكلة أو لديك فكرة؟ أقرأ كل رسالة.';

  @override
  String get testEmailMe => 'راسلني';

  @override
  String testEmailSubject(String app) {
    return 'ملاحظات حول $app';
  }

  @override
  String get testEmailCopied => 'تم نسخ عنوان البريد';

  @override
  String get testEndedTitle => 'انتهت هذه النسخة التجريبية';

  @override
  String get testEndedBody =>
      'شكرًا على التجربة! يُرجى الحصول على النسخة الجديدة. للحصول عليها، راسلني على:';

  @override
  String get toolTracker => 'كاشف أجهزة التتبع';

  @override
  String get toolTrackerSubtitle => 'أجهزة تتبع مخفية تلاحقك';

  @override
  String get sensorBluetooth => 'Bluetooth';

  @override
  String get trackerHelp1 =>
      'اضغط افحص هنا لترى أجهزة تتبع البلوتوث القريبة منك والبعيدة عن أصحابها: AirTag وGalaxy SmartTag وTile وChipolo وعلامات Find Hub.';

  @override
  String get trackerHelp2 =>
      'لتعرف إن كان أحدها يلاحقك، اضغط افحص أثناء تنقلي وأبقِ الأداة مفتوحة أثناء المشي أو القيادة؛ تبقى الشاشة مضاءة. جهاز التتبع الذي يُسمع في 3 أماكن خلال 30 دقيقة أو أكثر يتنقل معك.';

  @override
  String get trackerHelp3 =>
      'اضغط جهاز تتبع لتجده: امشِ ببطء واتبع الرقم وهو يرتفع. في عرض الكل، علّم أجهزتك بـ هذا لي فلا تظهر مرة أخرى.';

  @override
  String get trackerHelp4 =>
      'لا يستطيع أي هاتف سماع صناديق GPS ذات شريحة SIM. اضغط فحص السيارة: معظمها مثبت بمغناطيس قوي يجده كاشف المعادن.';

  @override
  String get trackerTip =>
      'تستمع الأداة فقط وهي مفتوحة ولا تسمع كل أجهزة التتبع. قد يظهر جهاز أحد أفراد العائلة أو جهاز غريب في القطار نفسه، ولا يظهر الجهاز القريب من صاحبه. إن ظننت أن أحدًا يتتبعك، فاتصل بالشرطة أو بجهة دعم.';

  @override
  String get trackerAllowTitle => 'اسمح بفحص البلوتوث';

  @override
  String get trackerAllowBody =>
      'يستمع كاشف أجهزة التتبع إلى أجهزة البلوتوث القريبة منك. يستمع فقط والأداة مفتوحة، ولا يتصل بها أبدًا، ولا يغادر هاتفك شيء مما يسمعه.';

  @override
  String get trackerAllow => 'السماح بالبلوتوث';

  @override
  String get trackerDeniedTitle => 'فحص البلوتوث متوقف';

  @override
  String get trackerDeniedBody =>
      'اسمح لهذا التطبيق بالأجهزة القريبة في الإعدادات لاستخدام كاشف أجهزة التتبع.';

  @override
  String get trackerBluetoothOffTitle => 'البلوتوث متوقف';

  @override
  String get trackerBluetoothOffBody =>
      'شغّل البلوتوث للاستماع إلى أجهزة التتبع. لا يتصل التطبيق بأي شيء أبدًا.';

  @override
  String get trackerLocationOffTitle => 'الموقع متوقف';

  @override
  String get trackerLocationOffBody =>
      'في هذا الإصدار من أندرويد، لا يعمل فحص البلوتوث إلا والموقع مُفعّل. لا يُحدَّد أي موقع منه.';

  @override
  String get trackerScanHere => 'افحص هنا';

  @override
  String get trackerCheckMoving => 'افحص أثناء تنقلي';

  @override
  String get trackerStop => 'إيقاف';

  @override
  String get trackerDone => 'تم';

  @override
  String get trackerLocationNeeded =>
      'افحص أثناء تنقلي يسجل الأماكن عبر GPS: اسمح بالموقع.';

  @override
  String get trackerSimNote => 'صناديق GPS ذات الشريحة لا تُسمع';

  @override
  String get trackerCarCheck => 'فحص السيارة';

  @override
  String get carCheckBody =>
      'بعض أجهزة التتبع صناديق GPS بشريحة SIM مخبأة في السيارة. لا يستطيع أي هاتف سماعها، لكن معظمها مثبت بمغناطيس قوي يجده كاشف المعادن.';

  @override
  String get carSpot1 => 'تحت المصدّات، في الأمام والخلف';

  @override
  String get carSpot2 => 'داخل أقواس العجلات';

  @override
  String get carSpot3 => 'تحت المقاعد وفي صندوق السيارة';

  @override
  String get carSpot4 => 'خلف منفذ التشخيص (OBD) تحت لوحة القيادة';

  @override
  String get carCheckTip =>
      'مرّر الحافة العلوية للهاتف ببطء فوق كل مكان. القفزة في القراءة تعني معدنًا أو مغناطيسًا: انظر عن قرب.';

  @override
  String get carOpenMetal => 'افتح كاشف المعادن';

  @override
  String get trackerPaused => 'متوقف مؤقتًا أثناء إخفاء التطبيق';

  @override
  String trackerFollowingBanner(String name, int places) {
    return '$name يتنقل معك: سُمع في $places أماكن';
  }

  @override
  String trackerMoving(int minutes, int places) {
    return 'جارٍ الفحص منذ $minutes دقيقة. الأماكن التي مررت بها: $places';
  }

  @override
  String get trackerListening => 'جارٍ الاستماع لأجهزة التتبع';

  @override
  String get trackerNothingHeard => 'لا أجهزة تتبع بعيدة عن أصحابها هنا';

  @override
  String get trackerIdle => 'افحص لترى أجهزة التتبع القريبة';

  @override
  String trackerSemantics(int following, int nearby) {
    return 'تلاحقك: $following. أجهزة تتبع قريبة: $nearby.';
  }

  @override
  String trackerShowAll(int count) {
    return 'عرض الكل ($count)';
  }

  @override
  String trackerAllTitle(int count) {
    return 'أجهزة تتبع قريبة: $count';
  }

  @override
  String get trackerKindFindMy => 'علامة تحديد الموقع';

  @override
  String get trackerKindFindHub => 'علامة Find Hub';

  @override
  String get trackerKindDult => 'جهاز تتبع أغراض';

  @override
  String get trackerClose => 'قريب';

  @override
  String get trackerNear => 'متوسط';

  @override
  String get trackerFar => 'بعيد';

  @override
  String trackerFollowingYou(int places) {
    return 'يلاحقك · الأماكن: $places';
  }

  @override
  String trackerPlaces(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'سُمع في $count مكانًا',
      few: 'سُمع في $count أماكن',
      two: 'سُمع في مكانين',
      one: 'سُمع في مكان واحد',
    );
    return '$_temp0';
  }

  @override
  String get trackerMine => 'هذا لي';

  @override
  String get trackerNotMine => 'ليس لي';

  @override
  String get trackerFollowingLabel => 'يلاحقك';

  @override
  String trackerNearby(int count) {
    return 'قريبة: $count';
  }

  @override
  String trackerFindTitle(String name) {
    return 'ابحث عن $name';
  }

  @override
  String get trackerFindHint =>
      'امشِ ببطء حول السيارة أو الحقيبة واتبع الرقم وهو يرتفع. الإشارة تعطي المسافة فقط، لا الاتجاه.';

  @override
  String get trackerFindLost => 'لا يُسمع: تحرّك ببطء';

  @override
  String get findFar => 'بعيد';

  @override
  String get findCloser => 'تقترب';

  @override
  String get findNear => 'قريب';

  @override
  String get findHere => 'هنا تمامًا';

  @override
  String get trackerAppleSound =>
      'يمكن لتطبيق تحديد الموقع من Apple، أو تطبيق Tracker Detect على أندرويد، جعل AirTag يصدر صوتًا.';

  @override
  String get trackerScanFailed =>
      'توقف الفحص. تحقق من البلوتوث ثم افحص مرة أخرى.';

  @override
  String get trackerGpsLost => 'لا إشارة GPS: لا تُسجَّل الأماكن';

  @override
  String get trackerHeardEarlier => 'سُمع سابقًا';

  @override
  String get trackerKindSamsung => 'علامة أو جهاز Samsung';

  @override
  String get trackerKindApple => 'جهاز Apple';

  @override
  String get trackerWhatToDo => 'ماذا أفعل';

  @override
  String get trackerSafetyTitle => 'إذا كان جهاز تتبع يلاحقك';

  @override
  String get trackerSafety1 =>
      'في الحافلة أو القطار أو الطائرة قد يكون لشخص غريب: افحص مجددًا بعد النزول.';

  @override
  String get trackerSafety2 =>
      'إن شعرت بعدم الأمان، فاذهب إلى مكان عام واتصل بالشرطة.';

  @override
  String get trackerSafety3 =>
      'اعثر عليه عبر ابحث. صوّره وصوّر مكان إخفائه ورقمه التسلسلي مع التاريخ والوقت.';

  @override
  String get trackerSafety4 => 'لا تأخذه إلى المنزل ولا تتواصل مع صاحبه.';

  @override
  String get trackerSafety5 =>
      'نزع البطارية يوقفه، لكن صاحبه سيلاحظ ذلك. إن كنت تعيش مع ذلك الشخص، فتحدث أولًا إلى جهة دعم.';

  @override
  String get trackerSafety6 =>
      'إيقاف البلوتوث أو الموقع في هاتفك لا يمنعه من الإبلاغ عن مكانك.';
}
