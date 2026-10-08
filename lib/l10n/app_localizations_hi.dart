// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'बबल लेवल और एंगल फ़ाइंडर';

  @override
  String get homeTitle => 'बबल लेवल';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get tools => 'टूल';

  @override
  String get listView => 'सूची दृश्य';

  @override
  String get gridView => 'ग्रिड दृश्य';

  @override
  String get back => 'वापस';

  @override
  String get lightMode => 'लाइट मोड';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get toolLevel => 'लेवल';

  @override
  String get toolLevelSubtitle => 'बबल लेवल और स्पिरिट लेवल';

  @override
  String get toolAngle => 'कोण';

  @override
  String get toolAngleSubtitle => 'समतल से या आपके शून्य से कोण';

  @override
  String get toolCompass => 'कंपास';

  @override
  String get toolCompassSubtitle => 'दिशा और कोर्स';

  @override
  String get toolProtractor => 'चांदा';

  @override
  String get toolProtractorSubtitle => 'स्क्रीन पर कोण मापें';

  @override
  String get toolRuler => 'रूलर';

  @override
  String get toolRulerSubtitle => 'स्क्रीन पर लंबाई मापें';

  @override
  String get toolMetal => 'मेटल डिटेक्टर';

  @override
  String get toolMetalSubtitle => 'लोहा, स्टील और चुंबक खोजें';

  @override
  String get toolVibration => 'कंपन';

  @override
  String get toolVibrationSubtitle => 'कंपन की ताकत और गति (RPM)';

  @override
  String get toolSound => 'साउंड मीटर';

  @override
  String get toolSoundSubtitle => 'डेसिबल में शोर';

  @override
  String get toolAltimeter => 'अल्टीमीटर';

  @override
  String get toolAltimeterSubtitle => 'हवा का दबाव और ऊँचाई';

  @override
  String get toolLight => 'लाइट मीटर';

  @override
  String get toolLightSubtitle => 'लक्स में रोशनी';

  @override
  String get notAvailableOnPhone => 'इस फ़ोन पर उपलब्ध नहीं';

  @override
  String get notOnPhone => 'उपलब्ध नहीं';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, इस फ़ोन पर उपलब्ध नहीं';
  }

  @override
  String get howToUse => 'इस्तेमाल का तरीका';

  @override
  String get rotateLandscape => 'लैंडस्केप में घुमाएँ';

  @override
  String get rotatePortrait => 'पोर्ट्रेट में घुमाएँ';

  @override
  String howToUseTool(String tool) {
    return '$tool कैसे इस्तेमाल करें';
  }

  @override
  String get gotIt => 'समझ गया';

  @override
  String get goodToKnow => 'जानने लायक: ';

  @override
  String get ok => 'ठीक है';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool उपलब्ध नहीं है';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ऐसे सेंसर चाहिए',
      one: 'एक ऐसा सेंसर चाहिए',
    );
    return '$tool को $_temp0 जो इस फ़ोन में नहीं है: $sensors।';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'यह फ़ोन के हार्डवेयर की सीमा है, ऐप की गलती नहीं। बाकी सभी टूल सामान्य रूप से काम करते हैं।';

  @override
  String get sensorAccelerometer => 'एक्सेलेरोमीटर';

  @override
  String get sensorMagnetometer => 'मैग्नेटोमीटर (कंपास सेंसर)';

  @override
  String get sensorBarometer => 'बैरोमीटर (हवा के दबाव का सेंसर)';

  @override
  String get sensorLight => 'लाइट सेंसर';

  @override
  String get sensorMicrophone => 'माइक्रोफ़ोन';

  @override
  String get noAccelerometer =>
      'इस फ़ोन में एक्सेलेरोमीटर नहीं है, इसलिए यह टूल यहाँ कुछ नहीं माप सकता। जिन टूल को इसकी ज़रूरत नहीं, वे काम करते रहेंगे।';

  @override
  String get noMagnetometer =>
      'इस फ़ोन में मैग्नेटोमीटर (कंपास सेंसर) नहीं है, इसलिए यह टूल यहाँ काम नहीं कर सकता। जिन टूल को इसकी ज़रूरत नहीं, वे काम करते रहेंगे।';

  @override
  String get noReadings =>
      'सेंसर से अभी तक कोई रीडिंग नहीं मिली। वापस जाकर टूल फिर से खोलें; अगर ऐसा होता रहे तो फ़ोन रीस्टार्ट करें। कुछ फ़ोन यह टूल सपोर्ट नहीं करते।';

  @override
  String get waitingForSensors => 'सेंसर का इंतज़ार…';

  @override
  String get levelHelp1 =>
      'फ़ोन को सतह पर सीधा लिटाएँ, या उसके किसी किनारे पर खड़ा करें।';

  @override
  String get levelHelp2 =>
      'लिटाकर: बुलबुले को बीच में लाएँ। X बाएँ/दाएँ झुकाव है, Y आगे/पीछे। किनारे पर खड़ा करने पर आपको कोण और ढलान दिखेगा।';

  @override
  String get levelHelp3 =>
      'स्क्रीन के संकेत (जैसे \"दायाँ हिस्सा ऊँचा\") को तब तक मानें जब तक \"समतल\" न दिखे: रीडिंग नारंगी हो जाती है और फ़ोन आवाज़ करता और वाइब्रेट होता है (सेटिंग्स में बंद कर सकते हैं)।';

  @override
  String get levelHelp4 =>
      'रीडिंग रोकने के लिए लॉक करें दबाएँ, और फिर से लाइव मापने के लिए अनलॉक करें।';

  @override
  String get levelHelp5 =>
      'क्लासिक स्पिरिट लेवल पसंद है? स्विच में ट्यूब आइकन दबाएँ; गोल आइकन डायल वापस लाता है।';

  @override
  String get levelTip =>
      'अगर आपको पता है कि कोई सतह समतल है पर 0° नहीं दिखता, तो फ़ोन उस पर रखें और कैलिब्रेट करें दबाएँ। इसे वापस लेने के लिए फिर से कैलिब्रेट करें दबाएँ और कैलिब्रेशन रीसेट करें चुनें।';

  @override
  String get statusLevel => 'समतल';

  @override
  String get leftEndLow => 'बायाँ सिरा नीचा';

  @override
  String get rightEndLow => 'दायाँ सिरा नीचा';

  @override
  String get rightSideHigh => 'दायाँ हिस्सा ऊँचा';

  @override
  String get leftSideHigh => 'बायाँ हिस्सा ऊँचा';

  @override
  String get topEdgeHigh => 'ऊपरी किनारा ऊँचा';

  @override
  String get bottomEdgeHigh => 'निचला किनारा ऊँचा';

  @override
  String get calibrated => 'कैलिब्रेट हो गया। यह स्थिति अब 0° दिखाती है।';

  @override
  String get tooFarToCalibrate =>
      'कैलिब्रेट करने के लिए बहुत झुका है। पहले फ़ोन को समतल सतह पर रखें।';

  @override
  String get dialView => 'डायल दृश्य';

  @override
  String get tubeView => 'ट्यूब दृश्य';

  @override
  String get levelTube => 'लेवल ट्यूब';

  @override
  String get leftRightTube => 'बाएँ-दाएँ की ट्यूब';

  @override
  String get forwardBackTube => 'आगे-पीछे की ट्यूब';

  @override
  String tiltFromLevel(String value) {
    return 'समतल से झुकाव $value';
  }

  @override
  String fromLevel(String value) {
    return 'समतल से अंतर $value';
  }

  @override
  String get xLeftRight => 'X · बाएँ / दाएँ';

  @override
  String get yForwardBack => 'Y · आगे / पीछे';

  @override
  String get angle => 'कोण';

  @override
  String get slope => 'ढलान';

  @override
  String get lock => 'लॉक करें';

  @override
  String get unlock => 'अनलॉक करें';

  @override
  String locked(String status) {
    return 'लॉक · $status';
  }

  @override
  String get lockReading => 'रीडिंग लॉक करें';

  @override
  String get lockHandles => 'हैंडल लॉक करें';

  @override
  String get handlesLocked => 'हैंडल लॉक हैं · बदलने के लिए ताला दबाएँ';

  @override
  String get calibrate => 'कैलिब्रेट करें';

  @override
  String get angleHelp1 =>
      'झुकाव पढ़ने के लिए फ़ोन को किसी सतह पर रखें, या उसे किसी ढलान, रेलिंग या पाइप से सटाकर किनारे पर खड़ा करें: बड़ी संख्या नारंगी चमकते किनारे का कोण है, निचले किनारे का कोण उसके नीचे है।';

  @override
  String get angleHelp2 =>
      'बदलाव मापने के लिए फ़ोन को शुरुआती स्थिति में पकड़ें और यहाँ शून्य करें दबाएँ।';

  @override
  String get angleHelp3 =>
      'फ़ोन को झुकाएँ या हिलाएँ। डायल दिखाता है कि वह आपके शून्य से कितने डिग्री हिला।';

  @override
  String get angleHelp4 =>
      'लेटी स्थिति से कोण पर लौटने के लिए शून्य हटाएँ दबाएँ।';

  @override
  String get angleHelp5 =>
      'जो कोण दिख न रहा हो उसे पढ़ने के लिए फ़ोन को चीज़ से सटाएँ, ताला दबाएँ, फिर फ़ोन हटाकर पढ़ें।';

  @override
  String get angleHelp6 =>
      'ऊपर के स्विच से मोड चुनें: सतह पर सपाट, या किनारे पर खड़ा। किनारे पर स्क्रीन पानी से भर जाती है जो समतल रहता है, और जो किनारा आप माप रहे हैं, यानी नीचे वाला हिस्सा, नारंगी चमकता है।';

  @override
  String get angleTip =>
      'ढलान पढ़ने के लिए फ़ोन का लंबा किनारा रैंप, सीढ़ी की रेलिंग या छत पर रखें, या झुकाव मापने के लिए स्क्रीन को तख्ते या दरवाज़े से सटा दें।';

  @override
  String movedFromZero(String value) {
    return 'शून्य से बदलाव $value';
  }

  @override
  String get measuringFromZero => 'आपके शून्य से माप';

  @override
  String get angleFlatStatus => 'सीधा लिटाया · पृथ्वी से कोण';

  @override
  String get measuringRightEdge => 'दायाँ किनारा माप रहे हैं';

  @override
  String get measuringLeftEdge => 'बायाँ किनारा माप रहे हैं';

  @override
  String bottomEdge(String value) {
    return 'निचला किनारा $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: समतल से $value। निचला किनारा $other';
  }

  @override
  String get angleModeFlat => 'सतह पर सीधा लिटाया';

  @override
  String get angleModeEdge => 'किनारे पर';

  @override
  String get standOnEdge => 'फ़ोन को उसके किसी किनारे पर खड़ा करें';

  @override
  String get clearZero => 'शून्य हटाएँ';

  @override
  String get setZeroHere => 'यहाँ शून्य करें';

  @override
  String get compassHelp1 =>
      'फ़ोन को अपने सामने समतल पकड़ें, धातु, चुंबक और इलेक्ट्रॉनिक चीज़ों से दूर।';

  @override
  String get compassHelp2 =>
      'फ़ोन का ऊपरी हिस्सा उस दिशा में करें जिसे आप जानना चाहते हैं। सीधा पकड़ने पर यह पीछे वाले कैमरे की दिशा दिखाता है।';

  @override
  String get compassHelp3 =>
      'संख्या डिग्री में आपकी दिशा है और अक्षर दिशा का नाम हैं। डायल घूमता है ताकि उसका N हमेशा उत्तर की ओर रहे; ऊपर की नारंगी गेंद दिखाती है कि आपका फ़ोन किधर है।';

  @override
  String get compassTip =>
      'यह चुंबकीय उत्तर दिखाता है, जो नक्शे के उत्तर से कुछ डिग्री अलग हो सकता है। गलत लगे तो फ़ोन को कुछ बार 8 के आकार में घुमाएँ।';

  @override
  String compassSemantics(int heading, String direction) {
    return 'चुंबकीय दिशा $heading डिग्री, $direction';
  }

  @override
  String get magneticInterference =>
      'चुंबकीय रुकावट · धातु से दूर जाएँ, फिर फ़ोन को 8 के आकार में घुमाएँ';

  @override
  String get compassCalibrate =>
      'कंपास कैलिब्रेट करने के लिए फ़ोन को 8 के आकार में घुमाएँ';

  @override
  String get dirN => 'उ';

  @override
  String get dirNE => 'उपू';

  @override
  String get dirE => 'पू';

  @override
  String get dirSE => 'दपू';

  @override
  String get dirS => 'द';

  @override
  String get dirSW => 'दप';

  @override
  String get dirW => 'प';

  @override
  String get dirNW => 'उप';

  @override
  String get protractorHelp1 =>
      'फ़ोन को लिटाएँ और चीज़ को स्क्रीन पर इस तरह रखें कि उसका कोना बीच में हो।';

  @override
  String get protractorHelp2 =>
      'हर नारंगी हैंडल को खींचें ताकि उसकी रेखा कोण के एक किनारे पर आ जाए।';

  @override
  String get protractorHelp3 =>
      'कोण बीच में पढ़ें। वृहत् कोण दूसरी तरफ़ का है (360° में से कोण घटाकर)।';

  @override
  String get protractorHelp4 => 'फिर से शुरू करने के लिए रीसेट दबाएँ।';

  @override
  String get protractorHelp5 =>
      'चीज़ को खिसकाते समय हैंडल अपनी जगह रखने के लिए ताला दबाएँ।';

  @override
  String armsSemantics(String value) {
    return 'भुजाओं के बीच कोण $value';
  }

  @override
  String get reflex => 'वृहत् कोण';

  @override
  String get dragHandles => 'नारंगी हैंडल को किनारों पर खींचें';

  @override
  String get reset => 'रीसेट';

  @override
  String get rulerHelp1 => 'चीज़ को स्क्रीन पर रखें, या फ़ोन को उससे सटाएँ।';

  @override
  String get rulerHelp2 =>
      'नारंगी रेखाओं को चीज़ के दोनों सिरों तक खींचें। इकाई चुनने के लिए mm, cm या in दबाएँ; दूसरी प्रणाली नीचे दिखती है।';

  @override
  String get rulerHelp3 =>
      'सबसे सटीक माप के लिए एक बार कैलिब्रेट करें दबाएँ और कार्ड, रूलर या स्क्रीन का साइज़ इस्तेमाल करें।';

  @override
  String get rulerHelp4 =>
      'चीज़ खिसकाते समय रेखाएँ अपनी जगह रखने के लिए ताला दबाएँ।';

  @override
  String get rulerTip =>
      'यह स्क्रीन की लंबाई तक मापता है। कवर और मुड़े किनारे शुरुआती मिलीमीटर छिपा देते हैं, इसलिए फ़ोन के किनारे से नहीं, रेखाओं के बीच मापें।';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'लंबाई $mm मिलीमीटर, $inches इंच';
  }

  @override
  String get rulerCalibrated => 'कार्ड से कैलिब्रेट · ±0.5 मिमी';

  @override
  String get rulerReported =>
      'फ़ोन से स्क्रीन का आकार · ±0.5 मिमी के लिए कैलिब्रेट करें';

  @override
  String get unitMillimetres => 'मिलीमीटर';

  @override
  String get unitCentimetres => 'सेंटीमीटर';

  @override
  String get unitInches => 'इंच';

  @override
  String get rulerEstimated => 'कैलिब्रेट नहीं · माप 10% तक गलत हो सकता है';

  @override
  String get cardLongEdge =>
      'कोई भी बैंक या आईडी कार्ड स्क्रीन पर रखें, लंबा किनारा रूलर के साथ और एक सिरा गहरी रेखा पर। नारंगी रेखा को कार्ड के दूसरे सिरे तक खींचें।';

  @override
  String get cardShortEdge =>
      'कोई भी बैंक या आईडी कार्ड स्क्रीन पर रखें, छोटा किनारा रूलर के साथ और एक सिरा गहरी रेखा पर। नारंगी रेखा को कार्ड के दूसरे सिरे तक खींचें।';

  @override
  String get save => 'सेव करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get usePhoneDefault => 'फ़ोन का स्क्रीन आकार इस्तेमाल करें';

  @override
  String get usePhoneDefaultInfo => 'यह कैलिब्रेशन हटाएँ';

  @override
  String get cardMismatch =>
      'यह कार्ड के आकार से मेल नहीं खाता। उसे गहरी रेखा से मिलाकर फिर से कोशिश करें।';

  @override
  String get rotateToCalibrate => 'कैलिब्रेट करने के लिए पोर्ट्रेट में घुमाएँ';

  @override
  String get calibrateHow => 'किससे कैलिब्रेट करें';

  @override
  String get methodCard => 'बैंक कार्ड';

  @override
  String get methodCardInfo => 'कोई भी बैंक या आईडी कार्ड · ±0.5 मिमी';

  @override
  String get methodRuler => 'रूलर';

  @override
  String get methodRulerInfo => 'सबसे सटीक · रूलर या इंचीटेप';

  @override
  String get methodScreen => 'स्क्रीन का साइज़';

  @override
  String get methodScreenInfo => 'कुछ नहीं चाहिए · लगभग 1%';

  @override
  String rulerInstructions(String mark) {
    return 'रूलर को स्क्रीन पर रखें, उसका 0 गहरी रेखा पर। नारंगी रेखा को $mark के निशान तक खींचें।';
  }

  @override
  String rulerMismatch(String mark) {
    return 'यह $mark से मेल नहीं खाता। रूलर का 0 गहरी रेखा पर रखें और फिर कोशिश करें।';
  }

  @override
  String get screenSizeInstructions =>
      'फ़ोन की स्पेसिफ़िकेशन से स्क्रीन का साइज़ इंच में लिखें। पता नहीं? अपना मॉडल और “स्क्रीन साइज़” सर्च करें।';

  @override
  String get screenSizeMismatch =>
      'यह साइज़ इस स्क्रीन से मेल नहीं खाता। फ़ोन की स्पेसिफ़िकेशन देखें और फिर कोशिश करें।';

  @override
  String get rulerCalibratedRuler => 'रूलर से कैलिब्रेट · ±0.5 मिमी';

  @override
  String rulerCalibratedScreen(String size) {
    return '$size-इंच स्क्रीन पर सेट · लगभग 1%';
  }

  @override
  String get metalHelp1 =>
      'टूल को धातु से दूर खोलें। पहली रीडिंग \"कोई धातु नहीं\" मानी जाती है।';

  @override
  String get metalHelp2 =>
      'फ़ोन को जगह के ऊपर धीरे-धीरे घुमाएँ। सेंसर आमतौर पर फ़ोन के ऊपरी हिस्से में होता है। धातु जितनी पास होगी, बीप उतनी तेज़ होगी; आवाज़ बंद करने के लिए स्पीकर दबाएँ।';

  @override
  String get metalHelp3 =>
      '“पास में धातु” का मतलब छोटा बदलाव है, “धातु मिली” का मतलब बड़ा। ठंडा-गर्म खेल की तरह, पास आने पर स्क्रीन ठंडे नीले से दहकते लाल में बदलती है, और कंपन चालू हो तो मिलने पर फ़ोन कांपता है।';

  @override
  String get metalHelp4 =>
      'कुछ सेकंड स्थिर रखने पर यह खुद शून्य हो जाता है, जिससे गलत रीडिंग हट जाती है। किसी जगह को फिर जाँचने के लिए फ़ोन को हटाकर वापस लाएँ। बेसलाइन सेट करें तुरंत शून्य कर देता है।';

  @override
  String get metalTip =>
      'यह सिर्फ़ लोहा, स्टील और चुंबक पहचानता है, एल्युमिनियम, तांबा, सोना या चांदी नहीं। चुंबक वाले फ़ोन कवर इसे प्रभावित करते हैं।';

  @override
  String metalSemantics(int value) {
    return 'चुंबकीय क्षेत्र $value माइक्रोटेस्ला';
  }

  @override
  String get noMetal => 'पास में कोई धातु नहीं';

  @override
  String get metalNearby => 'पास में धातु';

  @override
  String get metalDetected => 'धातु मिली';

  @override
  String get heatCold => 'ठंडा';

  @override
  String get heatCool => 'ठंडक';

  @override
  String get heatWarm => 'गुनगुना';

  @override
  String get heatWarmer => 'और गर्म';

  @override
  String get heatHot => 'गर्म';

  @override
  String get heatBurning => 'जल रहा';

  @override
  String get baseline => 'आधार';

  @override
  String get field => 'क्षेत्र';

  @override
  String get change => 'बदलाव';

  @override
  String get findsIronSteel => 'लोहा, स्टील और चुंबक पहचानता है';

  @override
  String get setBaseline => 'बेसलाइन सेट करें';

  @override
  String get muteSound => 'आवाज़ बंद करें';

  @override
  String get turnSoundOn => 'आवाज़ चालू करें';

  @override
  String get vibrationHelp1 =>
      'फ़ोन को चलती मशीन पर सपाट रखें और हाथ हटा लें। छोटी मशीन पर इसे मज़बूती से दबाकर रखें।';

  @override
  String get vibrationHelp2 =>
      'सुई सबसे तेज़ कंपन की गति RPM में दिखाती है, नीचे हर्ट्ज़ में (RPM, हर्ट्ज़ × 60 होता है)। डायल के अंदर की हल्की चमक पूरा स्पेक्ट्रम है; सुई उसके सबसे चमकीले हिस्से की ओर इशारा करती है।';

  @override
  String get vibrationHelp3 =>
      'ताकत बताती है कि कितना ज़ोर से हिल रहा है, m/s² में: 0.3 से कम स्थिर है, 2 से ज़्यादा तेज़ है।';

  @override
  String get vibrationHelp4 =>
      'रीडिंग रोकने के लिए लॉक दबाएँ, और अगली मशीन से पहले रीसेट बटन दबाएँ।';

  @override
  String get vibrationTip =>
      'ज़्यादातर फ़ोन 100 Hz (6000 RPM) तक मापते हैं, कुछ कम; डायल आपके फ़ोन की सीमा दिखाता है। इससे तेज़ कंपन गलत, कम गति के रूप में दिख सकता है। सबसे तेज़ कंपन अक्सर शाफ़्ट की गति होता है, पर उसका दोगुना भी हो सकता है। फ़ोन के सेंसर लैब के उपकरण नहीं हैं।';

  @override
  String get still => 'स्थिर';

  @override
  String get lightVibration => 'हल्का कंपन';

  @override
  String get strongVibration => 'तेज़ कंपन';

  @override
  String get noAccelerometerVibration =>
      'इस फ़ोन में एक्सेलेरोमीटर नहीं है, इसलिए यहाँ कंपन नहीं मापा जा सकता। जिन टूल को इसकी ज़रूरत नहीं, वे काम करते रहेंगे।';

  @override
  String vibrationSemantics(String value) {
    return 'कंपन $value मीटर प्रति सेकंड वर्ग';
  }

  @override
  String get frequency => 'आवृत्ति';

  @override
  String get rpm => 'RPM';

  @override
  String get strength => 'ताकत';

  @override
  String vibratingAt(String value) {
    return '$value Hz पर कंपन';
  }

  @override
  String get noClearFrequency => 'कोई साफ़ आवृत्ति नहीं';

  @override
  String get findingFrequency => 'आवृत्ति ढूँढी जा रही है…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm चक्कर प्रति मिनट, $value हर्ट्ज़';
  }

  @override
  String get peak => 'अधिकतम';

  @override
  String get average => 'औसत';

  @override
  String get resetPeak => 'अधिकतम रीसेट करें';

  @override
  String get altimeterHelp1 =>
      'एक पर्वतारोही आपकी ऊँचाई के साथ पहाड़ चढ़ता है। आसमान दिन के समय और मौसम के साथ बदलता है; ख़ुद चुनने के लिए मौसम बटन दबाएँ।';

  @override
  String get altimeterHelp2 =>
      'ऊँचाई का बदलाव मापने के लिए, जैसे सीढ़ियाँ या मंज़िलें, शुरुआत की जगह पर यहाँ शून्य करें दबाएँ।';

  @override
  String get altimeterHelp3 =>
      'ऊपर या नीचे जाएँ: पर्वतारोही साथ चलता है और झंडा आपका सबसे ऊँचा बिंदु दिखाता है। पैनल शून्य से मीटर, वायुदाब और अनुमानित ऊँचाई दिखाता है।';

  @override
  String get altimeterHelp4 => 'वापस जाने के लिए शून्य हटाएँ दबाएँ।';

  @override
  String get altimeterTip =>
      'मौसम हवा का दबाव बदलता है, इसलिए ऊँचाई दसियों मीटर तक गलत हो सकती है। आपके शून्य से ऊँचाई कम समय के लिए सटीक रहती है। इस टूल के लिए बैरोमीटर वाला फ़ोन चाहिए।';

  @override
  String get weather => 'मौसम';

  @override
  String get weatherAuto => 'स्वचालित (दिन का समय और मौसम)';

  @override
  String get weatherSunny => 'धूप';

  @override
  String get weatherCloudy => 'बादल';

  @override
  String get weatherRain => 'बारिश';

  @override
  String get weatherStorm => 'तूफ़ान';

  @override
  String get weatherSnow => 'बर्फ़';

  @override
  String get fromZero => 'शून्य से';

  @override
  String get altitudeShort => 'ऊँचाई';

  @override
  String get barometerIos =>
      'बैरोमीटर नहीं पढ़ा जा सका। सेटिंग्स › गोपनीयता और सुरक्षा में इस ऐप के लिए मोशन और फ़िटनेस चालू करें, फिर अल्टीमीटर दोबारा खोलें।';

  @override
  String get noBarometer =>
      'इस फ़ोन में बैरोमीटर (हवा के दबाव का सेंसर) नहीं है, इसलिए अल्टीमीटर यहाँ काम नहीं कर सकता। बाकी टूल काम करते रहेंगे।';

  @override
  String get noLightSensor =>
      'इस फ़ोन में लाइट सेंसर नहीं है, इसलिए लाइट मीटर यहाँ काम नहीं कर सकता। बाकी टूल काम करते रहेंगे।';

  @override
  String lightSemantics(String value) {
    return 'रोशनी $value लक्स';
  }

  @override
  String get illuminance => 'रोशनी';

  @override
  String get footCandles => 'फ़ुट-कैंडल';

  @override
  String get lightDark => 'अँधेरा';

  @override
  String get lightDim => 'मंद रोशनी';

  @override
  String get lightLivingRoom => 'बैठक जैसी रोशनी';

  @override
  String get lightReading => 'पढ़ने और डेस्क पर काम के लिए अच्छी';

  @override
  String get lightBright => 'तेज़ घरेलू रोशनी';

  @override
  String get lightOvercast => 'बादल वाले दिन की रोशनी';

  @override
  String get lightDaylight => 'दिन की रोशनी';

  @override
  String get lightSun => 'सीधी धूप';

  @override
  String get lightHelp1 =>
      'लाइट सेंसर स्क्रीन के ऊपर, सामने वाले कैमरे के पास होता है।';

  @override
  String get lightHelp2 =>
      'फ़ोन को वहाँ रखें जहाँ मापना है, स्क्रीन रोशनी की तरफ़।';

  @override
  String get lightHelp3 =>
      'आसमान रोशनी के साथ बदलता है: अंधेरे में रात, कम रोशनी वाले कमरे में सुबह, और जैसे-जैसे रोशनी बढ़ती है सूरज ऊपर चढ़ता है। लक्स और रोशनी किस काम की है, पढ़ें: 300 से 750 lx पढ़ने और डेस्क के काम के लिए ठीक है।';

  @override
  String get lightHelp4 =>
      'फ़ोन हटाते समय रीडिंग बनाए रखने के लिए लॉक करें दबाएँ।';

  @override
  String get lightTip =>
      'हर फ़ोन का लाइट सेंसर अलग होता है, इसलिए रीडिंग 10 से 20% तक अलग हो सकती है: जगहों की तुलना के लिए ठीक, पर कैलिब्रेटेड लक्स मीटर नहीं। स्क्रीन का ऊपरी हिस्सा न ढकें।';

  @override
  String get noMicrophone =>
      'माइक्रोफ़ोन इस्तेमाल नहीं हो पा रहा। शायद कोई दूसरा ऐप इसे इस्तेमाल कर रहा है: उसे बंद करें, फिर साउंड मीटर दोबारा खोलें।';

  @override
  String soundSemantics(String value) {
    return 'आवाज़ का स्तर लगभग $value डेसिबल';
  }

  @override
  String get decibelsApprox => 'dB (लगभग)';

  @override
  String get soundMax => 'अधिकतम';

  @override
  String get soundVeryQuiet => 'बहुत शांत';

  @override
  String get soundQuiet => 'शांत, पुस्तकालय जैसा';

  @override
  String get soundModerate => 'मध्यम, बातचीत जैसा';

  @override
  String get soundLoud => 'तेज़, भारी ट्रैफ़िक जैसा';

  @override
  String get soundVeryLoud =>
      'बहुत तेज़: लंबे समय तक सुनने से सुनने की शक्ति को नुकसान हो सकता है';

  @override
  String get soundDangerous => 'ख़तरनाक: अपने कान बचाएँ';

  @override
  String get micTitle => 'माइक्रोफ़ोन की अनुमति दें';

  @override
  String get micBody =>
      'साउंड मीटर आवाज़ कितनी तेज़ है यह मापने के लिए माइक्रोफ़ोन से सुनता है। आवाज़ सिर्फ़ आपके फ़ोन पर मापी जाती है, कभी रिकॉर्ड, सेव या भेजी नहीं जाती।';

  @override
  String get micAllow => 'माइक्रोफ़ोन की अनुमति दें';

  @override
  String get micDeniedTitle => 'माइक्रोफ़ोन की अनुमति बंद है';

  @override
  String get micDeniedBody =>
      'साउंड मीटर इस्तेमाल करने के लिए सेटिंग्स में इस ऐप के लिए माइक्रोफ़ोन चालू करें। आवाज़ कभी रिकॉर्ड, सेव या भेजी नहीं जाती।';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get tryAgain => 'फिर कोशिश करें';

  @override
  String get soundHelp1 =>
      'माइक्रोफ़ोन (नीचे वाले किनारे पर) खुला रखें और फ़ोन को आवाज़ की तरफ़ करें।';

  @override
  String get soundHelp2 =>
      'बड़ी संख्या अभी का स्तर है, लगभग एक सेकंड का औसत। इससे लहरें फैलती हैं, आवाज़ जितनी तेज़ हो उतनी ज़्यादा और दूर तक: शांत होने पर हरी, फिर पीली, नारंगी, लाल और गहरी लाल। नीचे के बार पिछले तीन सेकंड दिखाते हैं।';

  @override
  String get soundHelp3 =>
      'औसत और अधिकतम टूल खोलने के समय से गिने जाते हैं। फिर से शुरू करने के लिए रीसेट दबाएँ।';

  @override
  String get soundHelp4 =>
      '70 dB से स्टेटस लाइन पीली हो जाती है; 85 dB से, जहाँ लंबे समय तक सुनने से नुकसान हो सकता है, लाल हो जाती है।';

  @override
  String get soundHelp5 =>
      'फ़ोन हिलाते समय रीडिंग स्क्रीन पर बनाए रखने के लिए ताला दबाएँ।';

  @override
  String get soundTip =>
      'हर फ़ोन का माइक्रोफ़ोन अलग होता है, इसलिए रीडिंग लगभग 5 dB अलग हो सकती है: तुलना के लिए ठीक, पर प्रमाणित साउंड मीटर नहीं। बहुत तेज़ आवाज़ें (लगभग 110 dB से ऊपर) कम दिख सकती हैं।';

  @override
  String get metresFromZero => 'मी. शून्य से';

  @override
  String pressureSemantics(String value) {
    return 'हवा का दबाव $value हेक्टोपास्कल';
  }

  @override
  String heightSemantics(String value) {
    return 'शून्य से ऊँचाई $value';
  }

  @override
  String get pressure => 'दबाव';

  @override
  String get altitudeApprox => 'ऊँचाई (लगभग)';

  @override
  String get measuringHeight => 'आपके शून्य से ऊँचाई का माप';

  @override
  String get airPressureAltitude => 'हवा का दबाव और ऊँचाई';

  @override
  String get appearance => 'रूप';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get levelUnits => 'लेवल की इकाई';

  @override
  String get unitDegrees => 'डिग्री';

  @override
  String get unitPercent => 'प्रतिशत ढलान';

  @override
  String get unitRoofPitch => 'छत की ढलान (12 पर ऊँचाई)';

  @override
  String get vibrateWhenLevel => 'वाइब्रेशन';

  @override
  String get sounds => 'आवाज़ें';

  @override
  String get resetCalibration => 'कैलिब्रेशन रीसेट करें';

  @override
  String get resetCalibrationHint =>
      'सेंसर का फ़ैक्ट्री शून्य फिर से इस्तेमाल करें';

  @override
  String get calibrateHere => 'यहाँ कैलिब्रेट करें';

  @override
  String get calibrateHereInfo => 'ऐसी सतह पर जो पक्का समतल हो';

  @override
  String get calibrationRemoved =>
      'कैलिब्रेशन हटा दिया गया। लेवल फिर से सेंसर का फ़ैक्टरी शून्य इस्तेमाल करता है।';

  @override
  String get resetAllCalibrations => 'सभी कैलिब्रेशन रीसेट करें';

  @override
  String get resetAllCalibrationsHint => 'लेवल और रूलर फ़ैक्टरी सेटिंग पर';

  @override
  String get resetAllTitle => 'सभी कैलिब्रेशन रीसेट करें?';

  @override
  String get resetAllBody =>
      'इससे लेवल (जिसे एंगल टूल भी इस्तेमाल करता है) और रूलर में किया गया कैलिब्रेशन हट जाएगा। दोनों फ़ैक्टरी सेटिंग पर लौट आएँगे। आपकी बाकी सेटिंग्स वैसी ही रहेंगी, और आप कभी भी फिर से कैलिब्रेट कर सकते हैं।';

  @override
  String get notCalibrated => 'कैलिब्रेट नहीं किया गया';

  @override
  String get language => 'भाषा';

  @override
  String get licenses => 'ओपन-सोर्स लाइसेंस';

  @override
  String get languageSystem => 'फ़ोन की भाषा';

  @override
  String get toolHeight => 'ऊँचाई';

  @override
  String get toolHeightSubtitle => 'निशाना लगाकर ऊँचाई और दूरी';

  @override
  String get heightHelp1 =>
      'ऐसी जगह खड़े हों जहाँ से चीज़ का निचला सिरा और ऊपरी सिरा दिखे। फ़ोन को स्क्रीन ऊपर करके पकड़ें और उसके ऊपरी किनारे के साथ देखें।';

  @override
  String get heightHelp2 =>
      'ऊपरी किनारे को चीज़ के निचले सिरे पर लगाएँ और नीचा सिरा लॉक करें पर टैप करें: इससे दूरी मिलती है।';

  @override
  String get heightHelp3 =>
      'ऊपरी किनारे को ऊपरी सिरे पर लगाएँ और ऊपरी सिरा लॉक करें पर टैप करें: ऊँचाई दिखेगी।';

  @override
  String get heightHelp4 =>
      'दूरी पता है? दूरी पर टैप करके लिखें, फिर सिर्फ़ ऊपरी सिरे पर निशाना लगाएँ। अपनी आँखों की ऊँचाई सेट करने के लिए आँखों की ऊँचाई पर टैप करें।';

  @override
  String get heightTip =>
      'समतल ज़मीन पर सही आँखों की ऊँचाई (आपकी लंबाई से लगभग 10 cm कम) के साथ लगभग ±5%। इतना पीछे हटें कि ऊपरी सिरा 70° से कम और निचला सिरा समतल से कम से कम 3° नीचे हो। ढलान पर दूरी लिखें।';

  @override
  String get lockBase => 'नीचा सिरा लॉक करें';

  @override
  String get lockTop => 'ऊपरी सिरा लॉक करें';

  @override
  String get measureAgain => 'फिर से मापें';

  @override
  String get distance => 'दूरी';

  @override
  String get objectHeight => 'ऊँचाई';

  @override
  String get eyeHeight => 'आँखों की ऊँचाई';

  @override
  String get sightAngle => 'निशाने का कोण';

  @override
  String get heightAimBase => 'ऊपरी किनारे को निचले सिरे पर लगाएँ';

  @override
  String get heightAimTop => 'अब ऊपरी किनारे को ऊपरी सिरे पर लगाएँ';

  @override
  String get heightDone => 'हो गया · दूसरे के लिए फिर से मापें पर टैप करें';

  @override
  String get heightHoldFlatter =>
      'फ़ोन को और सपाट रखें और ऊपरी किनारे के साथ निशाना लगाएँ';

  @override
  String get heightTooFar =>
      'निचला सिरा समतल के बहुत पास है: पास जाएँ या दूरी लिखें';

  @override
  String get heightStepBack => 'बहुत खड़ा: स्थिर माप के लिए पीछे हटें';

  @override
  String get knownDistance => 'निचले सिरे तक दूरी';

  @override
  String get knownDistanceHint =>
      'ज़मीन के साथ चीज़ के निचले सिरे तक की दूरी। निशाने से मापने के लिए इसे साफ़ करें।';

  @override
  String get eyeHeightHint =>
      'ज़मीन से आपकी आँखें कितनी ऊँची हैं: लगभग आपकी लंबाई से 10 cm कम।';

  @override
  String get clear => 'साफ़ करें';

  @override
  String get toolCamera => 'कैमरा लेवल';

  @override
  String get toolCameraSubtitle => 'कैमरे पर समतल रेखाएँ, कोई भी किनारा मापें';

  @override
  String get cameraHelp1 =>
      'पीछे का कैमरा दीवार, तस्वीर, शेल्फ़ या दरवाज़े की ओर करें। फ़ोन को सीधा और दीवार के ठीक सामने रखें।';

  @override
  String get cameraHelp2 =>
      'ठोस रेखाएँ गुरुत्व के साथ चलती हैं: वे हमेशा ठीक समतल और सीधी खड़ी रहती हैं। बिंदीदार रेखाएँ फ़ोन से जुड़ी हैं, और उनके बीच का छोटा चाप बताता है कि फ़ोन कितना झुका है। फ़ोन समतल होने पर असली रेखाएँ नारंगी हो जाती हैं।';

  @override
  String get cameraHelp3 =>
      'किसी चीज़ को जाँचने के लिए फ़्रीज़ दबाएँ, फिर दोनों नारंगी हैंडल उसके किसी किनारे पर खींचें, जैसे फ़्रेम का ऊपरी किनारा। हाथ सीधा न होने पर भी दिखेगा कि वह किनारा कितना टेढ़ा है और कौन सी तरफ़ उठानी है। खड़ा किनारा जाँचने के लिए रेखा को सीधा खड़ा करें।';

  @override
  String get cameraHelp4 =>
      'ऊपर के दो बटन फ़ोन की रेखाएँ और असली रेखाएँ दिखाते या छिपाते हैं। रोशनी अंधेरे कोनों में मदद करती है; जारी रखें से लाइव तस्वीर लौट आती है।';

  @override
  String get cameraTip =>
      'किनारे को सही मापने के लिए फ़ोन को दीवार के ठीक सामने रखें (आगे/पीछे 5° से कम) और तस्वीर के बीच के पास मापें, जहाँ लेंस रेखाओं को सबसे कम मोड़ता है। लेवल का किनारे वाला कैलिब्रेशन इस्तेमाल होता है। तस्वीर कभी रिकॉर्ड, सेव या भेजी नहीं जाती।';

  @override
  String get cameraAllowTitle => 'कैमरा की अनुमति दें';

  @override
  String get cameraAllowBody =>
      'कैमरा लेवल कैमरे की तस्वीर पर समतल रेखाएँ बनाता है और उसमें किनारे मापता है। तस्वीर आपके फ़ोन पर ही रहती है और कभी रिकॉर्ड, सेव या भेजी नहीं जाती।';

  @override
  String get cameraAllow => 'कैमरा की अनुमति दें';

  @override
  String get cameraDeniedTitle => 'कैमरा की अनुमति बंद है';

  @override
  String get cameraDeniedBody =>
      'कैमरा लेवल इस्तेमाल करने के लिए सेटिंग्स में इस ऐप का कैमरा चालू करें। तस्वीर कभी रिकॉर्ड, सेव या भेजी नहीं जाती।';

  @override
  String get noCamera =>
      'कैमरा इस्तेमाल नहीं हो पा रहा। शायद कोई दूसरा ऐप उसे इस्तेमाल कर रहा है या फ़ोन में कैमरा नहीं है: दूसरे कैमरा ऐप बंद करके कैमरा लेवल फिर खोलें।';

  @override
  String get tilt => 'झुकाव';

  @override
  String get forwardBack => 'आगे/पीछे';

  @override
  String get cameraLevel => 'समतल';

  @override
  String cameraTilted(String value) {
    return '$value° झुका';
  }

  @override
  String get cameraHoldUpright => 'फ़ोन सीधा रखें, कैमरा दीवार की ओर';

  @override
  String get freeze => 'फ़्रीज़';

  @override
  String get resume => 'जारी रखें';

  @override
  String get torch => 'रोशनी';

  @override
  String cameraSemantics(String value) {
    return 'समतल रेखाओं वाला कैमरा दृश्य, $value डिग्री झुका';
  }

  @override
  String get cameraPhoneLines => 'फ़ोन की रेखाएँ';

  @override
  String get cameraTrueLines => 'असली रेखाएँ';

  @override
  String get cameraFrozen => 'फ़्रीज़ है';

  @override
  String get cameraDragHandles => 'हैंडल किसी किनारे पर खींचें';

  @override
  String get cameraFaceWall => 'फ़ोन दीवार के ठीक सामने रखें';

  @override
  String get edgeLevel => 'यह किनारा समतल है';

  @override
  String get edgePlumb => 'यह किनारा सीधा खड़ा है';

  @override
  String edgeLiftRight(String value) {
    return 'किनारा $value° टेढ़ा, दाईं ओर उठाएँ';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'किनारा $value° टेढ़ा, बाईं ओर उठाएँ';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'किनारा खड़ी रेखा से $value° हटा';
  }

  @override
  String get cameraHandle => 'किनारे का हैंडल';

  @override
  String get toolGForce => 'G-फ़ोर्स';

  @override
  String get toolGForceSubtitle => 'ब्रेक, रफ़्तार बढ़ाना और मोड़, g में';

  @override
  String get gHelp1 =>
      'फ़ोन को कार माउंट में लगाएँ, स्क्रीन आपकी ओर। कार खड़ी हो तब शून्य दबाएँ: मीटर सीख लेता है कि नीचे और आगे किस ओर है।';

  @override
  String get gHelp2 =>
      'गाड़ी चलाएँ: कार का वह हिस्सा चमकता है जिधर आप धकेले जाते हैं। ब्रेक लगाने पर आगे का, रफ़्तार बढ़ाने पर पीछे का और मोड़ पर बाहर का हिस्सा। हरा हल्का, नारंगी ज़ोरदार, लाल तेज़।';

  @override
  String get gHelp3 =>
      'पैनल शून्य के बाद की सबसे तेज़ रफ़्तार बढ़त, ब्रेक और मोड़ याद रखता है, और किनारे के बिंदु हर दिशा का सबसे ज़ोरदार धक्का याद रखते हैं। रीसेट बटन इन्हें मिटा देता है।';

  @override
  String get gHelp4 =>
      'नज़र सड़क पर रखें: किसी सवारी से पढ़वाएँ, या रुकने के बाद अधिकतम मान देखें।';

  @override
  String get gTip =>
      'रीडिंग एक्सेलेरोमीटर से आती है: डैश लॉगर के करीब, खराब सड़क पर थोड़ी ज़्यादा अस्थिर। अगर माउंट हिल जाए, तो रुकें और फिर से शून्य दबाएँ। आम कार के लिए 0.5 g से ज़्यादा का मतलब ज़ोर का ब्रेक या तेज़ मोड़ है।';

  @override
  String get gZero => 'शून्य';

  @override
  String get gResetPeaks => 'अधिकतम रीसेट करें';

  @override
  String get gSpeedUp => 'रफ़्तार बढ़ाना';

  @override
  String get gBrake => 'ब्रेक';

  @override
  String get gCorner => 'मोड़';

  @override
  String get gSteady => 'स्थिर';

  @override
  String gBraking(String value) {
    return 'ब्रेक $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'रफ़्तार बढ़ रही $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'बायाँ मोड़ $value g';
  }

  @override
  String gRightBend(String value) {
    return 'दायाँ मोड़ $value g';
  }

  @override
  String gSemantics(String value) {
    return 'G-फ़ोर्स $value g';
  }

  @override
  String get gZeroed => 'शून्य हो गया: आगे और नीचे की दिशा सीख ली';

  @override
  String get noAccelerometerG =>
      'इस फ़ोन में एक्सेलेरोमीटर नहीं है, इसलिए यहाँ G-फ़ोर्स नहीं मापा जा सकता। बाकी टूल काम करते रहेंगे।';

  @override
  String get toolSpeed => 'स्पीडोमीटर';

  @override
  String get toolSpeedSubtitle => 'रफ़्तार, सफ़र और GPS ऊँचाई';

  @override
  String get speedHelp1 =>
      'लोकेशन की अनुमति दें, फिर फ़ोन को ऐसी जगह रखें जहाँ से आसमान दिखे, जैसे डैशबोर्ड पर या विंडस्क्रीन माउंट में। बाहर पहली बार जगह पता करने में कुछ सेकंड लगते हैं।';

  @override
  String get speedHelp2 =>
      'डैशबोर्ड पर लगा मीटर GPS से आपकी रफ़्तार दिखाता है, और उसके दोनों ओर सफ़र की दूरी और ऊँचाई। पैनल पिछली बार रीसेट करने के बाद की दूरी, सबसे तेज़ और औसत रफ़्तार रखता है।';

  @override
  String get speedHelp3 =>
      'कॉपी करने के लिए निर्देशांक पर टैप करें। यूनिट बटन किमी/घं और मील/घं के बीच बदलता है, और सफ़र रीसेट करें दूरी, सबसे तेज़ और औसत को फिर से शुरू करता है।';

  @override
  String get speedHelp4 =>
      'नज़र सड़क पर रखें: किसी सवारी से पढ़वाएँ, या रुकने के बाद सफ़र देखें।';

  @override
  String get speedTip =>
      'रफ़्तार सैटेलाइट से आती है और खुली सड़क पर आम तौर पर लगभग 1 किमी/घं के अंदर सही होती है; सुरंग में, ऊँची इमारतों के बीच या घर के अंदर यह पीछे रह सकती है या रुक सकती है। GPS ऊँचाई 10 से 50 मीटर तक गलत हो सकती है, इसलिए ऊँचाई के बदलाव के लिए अल्टीमीटर इस्तेमाल करें। लोकेशन सिर्फ़ तब इस्तेमाल होती है जब यह टूल खुला हो, और कभी आपके फ़ोन से बाहर नहीं जाती।';

  @override
  String get speedAllowTitle => 'लोकेशन की अनुमति दें';

  @override
  String get speedAllowBody =>
      'स्पीडोमीटर GPS से आपकी रफ़्तार, दूरी और ऊँचाई मापता है। लोकेशन सिर्फ़ तब इस्तेमाल होती है जब यह टूल स्क्रीन पर खुला हो, कभी बैकग्राउंड में नहीं, और कभी आपके फ़ोन से बाहर नहीं जाती।';

  @override
  String get speedAllow => 'लोकेशन की अनुमति दें';

  @override
  String get speedDeniedTitle => 'लोकेशन की अनुमति बंद है';

  @override
  String get speedDeniedBody =>
      'स्पीडोमीटर इस्तेमाल करने के लिए सेटिंग्स में इस ऐप के लिए लोकेशन चालू करें। यह सिर्फ़ टूल खुला होने पर इस्तेमाल होती है और कभी आपके फ़ोन से बाहर नहीं जाती।';

  @override
  String get speedServiceOffTitle => 'लोकेशन बंद है';

  @override
  String get speedServiceOffBody =>
      'स्पीडोमीटर इस्तेमाल करने के लिए फ़ोन की सेटिंग्स में लोकेशन चालू करें।';

  @override
  String get speedDistance => 'दूरी';

  @override
  String get speedTop => 'सबसे तेज़';

  @override
  String get speedAverage => 'औसत';

  @override
  String get speedTrip => 'सफ़र';

  @override
  String get speedAltitude => 'ऊँचाई';

  @override
  String get speedResetTrip => 'सफ़र रीसेट करें';

  @override
  String get speedFinding => 'सैटेलाइट खोज रहे हैं…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value m';
  }

  @override
  String get speedWeak => 'कमज़ोर GPS: रफ़्तार पीछे रह सकती है';

  @override
  String get speedStill => 'रुके हुए';

  @override
  String get speedCopied => 'निर्देशांक कॉपी हो गए';

  @override
  String get speedUnitTooltip => 'किमी/घं और मील/घं के बीच बदलें';

  @override
  String get speedKmh => 'किमी/घं';

  @override
  String get speedMph => 'मील/घं';

  @override
  String speedSemantics(String value) {
    return 'रफ़्तार $value';
  }

  @override
  String get speedCoordinates => 'निर्देशांक, कॉपी करने के लिए टैप करें';

  @override
  String get noGps =>
      'इस फ़ोन में GPS नहीं है, इसलिए यहाँ रफ़्तार नहीं मापी जा सकती। बाकी टूल काम करते रहेंगे।';

  @override
  String get speedSceneHelp =>
      'आसमान दिन के समय के साथ बदलता है। मौसम बटन दृश्य चुनता है: ऑटो मौसम के हिसाब से चलता है, या धूप, बादल, बारिश, तूफ़ान या बर्फ़ चुनें। यह सिर्फ़ दृश्य है, मौसम का पूर्वानुमान नहीं।';

  @override
  String get toolTape => 'मेज़रिंग टेप';

  @override
  String get toolTapeSubtitle => 'AR में लंबाई और क्षेत्रफल';

  @override
  String get tapeAllowBody =>
      'मेज़रिंग टेप सतहों पर पॉइंट लगाने के लिए कैमरे की तस्वीर को 3D में फ़ॉलो करता है। तस्वीर आपके फ़ोन पर ही रहती है और कभी रिकॉर्ड, सेव या भेजी नहीं जाती।';

  @override
  String get tapeDeniedBody =>
      'मेज़रिंग टेप इस्तेमाल करने के लिए सेटिंग्स में इस ऐप का कैमरा चालू करें। तस्वीर कभी रिकॉर्ड, सेव या भेजी नहीं जाती।';

  @override
  String get tapeInstallTitle => 'AR सपोर्ट इंस्टॉल करें';

  @override
  String get tapeInstallBody =>
      'मेज़रिंग टेप फ़ोन को 3D में फ़ॉलो करने के लिए Google Play Services for AR (ARCore) इस्तेमाल करता है। इसे Play Store से इंस्टॉल या अपडेट करें, फिर वापस आएँ।';

  @override
  String get tapeInstall => 'इंस्टॉल करें';

  @override
  String get tapeUnsupported =>
      'यह फ़ोन AR (ARCore) सपोर्ट नहीं करता, जिसकी मेज़रिंग टेप को फ़ोन को 3D में फ़ॉलो करने के लिए ज़रूरत है।';

  @override
  String get tapeFailed =>
      'AR शुरू नहीं हो सका। शायद कोई दूसरा ऐप कैमरा इस्तेमाल कर रहा है: उसे बंद करके फिर कोशिश करें।';

  @override
  String get tapeLength => 'लंबाई';

  @override
  String get tapePerimeter => 'परिमाप';

  @override
  String get tapeArea => 'क्षेत्रफल';

  @override
  String get tapePieces => 'हिस्से';

  @override
  String get tapeAdd => 'पॉइंट जोड़ें';

  @override
  String get tapeClose => 'आकार बंद करें';

  @override
  String get tapeUndo => 'वापस लें';

  @override
  String get tapeUnit => 'इकाई: सेंटीमीटर या इंच';

  @override
  String get tapeStarting => 'AR शुरू करने के लिए फ़ोन धीरे से घुमाएँ';

  @override
  String get tapeFind => 'सतह ढूँढने के लिए फ़ोन को उसके ऊपर धीरे से घुमाएँ';

  @override
  String get tapeNoSurface => 'निशाने के नीचे अभी कोई सतह नहीं: धीरे घुमाएँ';

  @override
  String get tapeMissed =>
      'वहाँ अभी कोई सतह नहीं। धीरे घुमाएँ, फिर दोबारा टैप करें';

  @override
  String get tapeFirst => 'पहले कोने पर निशाना लगाएँ और पॉइंट जोड़ें दबाएँ';

  @override
  String get tapeNext => 'अगले कोने पर निशाना लगाएँ और पॉइंट जोड़ें दबाएँ';

  @override
  String get tapeSnap => 'पहले पॉइंट पर: क्षेत्रफल के लिए आकार बंद करें दबाएँ';

  @override
  String get tapeDone => 'लगभग। AR में 1 से 3 cm का फ़र्क हो सकता है';

  @override
  String get tapeDark => 'ट्रैक करने के लिए बहुत अँधेरा: रोशनी बढ़ाएँ';

  @override
  String get tapeFast => 'फ़ोन बहुत तेज़ हिल रहा है: धीरे करें';

  @override
  String get tapePlain =>
      'ट्रैक करने के लिए बहुत सादा: किसी बनावट वाली चीज़ पर निशाना लगाएँ';

  @override
  String get tapeLost =>
      'ट्रैकिंग खो गई: जहाँ थे वहीं वापस निशाना लगाएँ और फ़ोन स्थिर रखें';

  @override
  String tapeSemantics(String total) {
    return 'मापे गए पॉइंट वाली कैमरे की तस्वीर। कुल $total';
  }

  @override
  String get tapeHelp1 =>
      'कैमरा की अनुमति दें, फिर फ़ोन को मेज़, फ़र्श या दीवार के ऊपर धीरे से घुमाएँ जब तक सफ़ेद बिंदु न दिखें और निशाना सतह पर न टिक जाए।';

  @override
  String get tapeHelp2 =>
      'निशाने को किसी कोने पर रखें और पॉइंट जोड़ें दबाएँ। अगले कोने पर जाएँ: लंबाई निशाने के साथ चलती है।';

  @override
  String get tapeHelp3 =>
      'हिस्से जोड़ते जाने के लिए कोनों पर टैप करते रहें; पैनल उन्हें जोड़ देता है। पहले पॉइंट पर वापस निशाना लगाएँ और क्षेत्रफल व परिमाप के लिए आकार बंद करें दबाएँ।';

  @override
  String get tapeHelp4 =>
      'वापस लें आखिरी पॉइंट हटाता है (या बंद आकार को खोलता है); साफ़ करें फिर से शुरू करता है। ऊपर का बटन सेंटीमीटर और इंच के बीच बदलता है।';

  @override
  String get tapeTip =>
      'AR से मापना लगभग होता है: अक्सर एक मीटर पर 1 से 3 cm के अंदर, पर सादी या चमकदार सतहों पर, कम रोशनी में, दूर से (3 m से ज़्यादा) या फ़ोन के तेज़ हिलने पर कम सही। धीरे हिलाएँ और कोनों पर अच्छी रोशनी रखें। तस्वीर कभी रिकॉर्ड, सेव या भेजी नहीं जाती।';
}
