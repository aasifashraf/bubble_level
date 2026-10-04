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
  String get tools => 'الأدوات';

  @override
  String get listView => 'عرض القائمة';

  @override
  String get gridView => 'عرض الشبكة';

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
  String get toolVibrationSubtitle => 'مقياس اهتزاز مع رسم بياني مباشر';

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
      'يُظهر القرص مقدار ميل الهاتف عن الوضع المسطح: 0° مسطحًا و90° قائمًا.';

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
  String get angleTip =>
      'ألصق الهاتف مسطحًا على جسم، مثل لوح أو باب أو منحدر، لقياس زاويته.';

  @override
  String movedFromZero(String value) {
    return 'التحرك من الصفر $value';
  }

  @override
  String get measuringFromZero => 'القياس من نقطة الصفر';

  @override
  String get angleFromEarth => 'الزاوية بالنسبة إلى الأرض';

  @override
  String get clearZero => 'مسح الصفر';

  @override
  String get setZeroHere => 'اجعل هنا صفرًا';

  @override
  String get compassHelp1 =>
      'أمسك الهاتف أفقيًا أمامك، بعيدًا عن المعادن والمغناطيس والأجهزة الإلكترونية.';

  @override
  String get compassHelp2 => 'وجّه أعلى الهاتف نحو الاتجاه الذي تريد معرفته.';

  @override
  String get compassHelp3 =>
      'الرقم هو اتجاهك بالدرجات والحروف هي الجهة. وتحددها الكرة البرتقالية على الحلقة.';

  @override
  String get compassTip =>
      'تشير البوصلة إلى الشمال المغناطيسي، وقد يختلف بضع درجات عن شمال الخريطة. إذا بدت القراءة خاطئة فحرّك الهاتف على شكل الرقم 8 عدة مرات.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'الاتجاه المغناطيسي $heading درجة، $direction';
  }

  @override
  String get magneticInterference => 'تشويش مغناطيسي · ابتعد عن المعادن';

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
  String get calibrateCard => 'معايرة';

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
  String get rotateToCalibrate => 'أدِر الهاتف رأسيًا للمعايرة';

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
      '«معدن قريب» يعني تغيرًا صغيرًا و«تم اكتشاف معدن» يعني تغيرًا قويًا: يتحول المنتصف إلى البرتقالي ويهتز الهاتف إذا كان الاهتزاز مفعّلًا.';

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
      'ضع الهاتف مسطحًا على السطح أو الآلة التي تريد فحصها وارفع يديك عنه.';

  @override
  String get vibrationHelp2 =>
      'يُظهر القرص الاهتزاز الحالي بوحدة m/s². ويُظهر الرسم البياني الثواني الأخيرة.';

  @override
  String get vibrationHelp3 =>
      'الذروة هي أقوى لحظة، والمتوسط هو المستوى خلال الثانية الأخيرة.';

  @override
  String get vibrationHelp4 => 'اضغط إعادة ضبط الذروة قبل كل اختبار جديد.';

  @override
  String get vibrationTip =>
      '«ثابت» يعني أقل من 0.3 m/s² و«اهتزاز قوي» يعني أكثر من 2 m/s². استخدم القراءات للمقارنة؛ فمستشعرات الهاتف ليست أجهزة مختبر.';

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
  String get peak => 'الذروة';

  @override
  String get average => 'المتوسط';

  @override
  String get resetPeak => 'إعادة ضبط الذروة';

  @override
  String get vibrationGraph => 'رسم الاهتزاز البياني';

  @override
  String get altimeterHelp1 =>
      'يُظهر القرص ضغط الهواء بوحدة hPa، ويُقدَّر الارتفاع منه.';

  @override
  String get altimeterHelp2 =>
      'لقياس تغيّر في الارتفاع، مثل الدرج أو الطوابق، اضغط اجعل هنا صفرًا عند نقطة البداية.';

  @override
  String get altimeterHelp3 =>
      'اصعد أو انزل. يُظهر المنتصف الأمتار من نقطة الصفر.';

  @override
  String get altimeterHelp4 => 'اضغط مسح الصفر للعودة.';

  @override
  String get altimeterTip =>
      'يغيّر الطقس ضغط الهواء، لذا قد يخطئ الارتفاع بعشرات الأمتار. أما الارتفاع من نقطة الصفر فدقيق لفترات قصيرة. تحتاج هذه الأداة إلى هاتف به بارومتر.';

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
      'اقرأ قيمة اللوكس وما يناسبه الضوء: 300–500 لوكس مناسبة للقراءة والعمل على المكتب.';

  @override
  String get lightHelp4 => 'اضغط قفل للاحتفاظ بالقراءة أثناء إبعاد الهاتف.';

  @override
  String get lightTip =>
      'تختلف مستشعرات الضوء من هاتف لآخر، لذا قد تنحرف القراءات بنسبة 10–20%: مفيدة لمقارنة الأماكن، لكنها ليست مقياس لوكس معايَرًا. لا تغطِّ أعلى الشاشة.';

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
  String get soundAverage => 'المتوسط';

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
  String get soundHelp2 => 'الرقم الكبير هو المستوى الآن، بمتوسط نحو ثانية.';

  @override
  String get soundHelp3 =>
      'يُحسب المتوسط والأقصى منذ فتح الأداة. اضغط إعادة الضبط للبدء من جديد.';

  @override
  String get soundHelp4 =>
      'ابتداءً من 85 ديسيبل قد يضر التعرض الطويل بالسمع: يتحول سطر الحالة إلى الأصفر.';

  @override
  String get soundTip =>
      'تختلف ميكروفونات الهواتف، لذا قد تنحرف القراءات بنحو 5 ديسيبل: مفيدة للمقارنة، لكنها ليست مقياس صوت معتمدًا. قد تظهر الأصوات العالية جدًا (فوق نحو 110 ديسيبل) أقل من حقيقتها.';

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
  String get vibrateWhenLevel => 'الاهتزاز عند الاستواء';

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
      'سيؤدي هذا إلى إزالة الصفر الذي ضبطته في ميزان الماء وحجم الشاشة الذي ضبطته في المسطرة، ليعود كلاهما إلى إعدادات المصنع. تبقى إعداداتك الأخرى كما هي، ويمكنك المعايرة من جديد في أي وقت.';

  @override
  String get notCalibrated => 'غير مُعايَر';

  @override
  String get language => 'اللغة';

  @override
  String get languageSystem => 'لغة الهاتف';
}
