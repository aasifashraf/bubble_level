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
  String get toolVibrationSubtitle => 'लाइव ग्राफ़ के साथ कंपन मीटर';

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
      'फ़ोन को जाँचने वाली सतह या मशीन पर लिटाएँ और हाथ हटा लें।';

  @override
  String get vibrationHelp2 =>
      'संख्या अभी का कंपन है, m/s² में। एक सुई हर छह सेकंड में घूमती है और इसे संख्या के चारों ओर लहर की तरह बनाती है: स्थिर होने पर हरा, हल्के कंपन में नारंगी, तेज़ में लाल। छोटा निशान शिखर दिखाता है।';

  @override
  String get vibrationHelp3 =>
      'अधिकतम सबसे तेज़ पल है। औसत पिछले एक सेकंड का स्तर है।';

  @override
  String get vibrationHelp4 => 'हर नए टेस्ट से पहले अधिकतम रीसेट करें दबाएँ।';

  @override
  String get vibrationTip =>
      '\"स्थिर\" का मतलब 0.3 m/s² से कम और \"तेज़ कंपन\" का मतलब 2 m/s² से ज़्यादा है। इन रीडिंग का इस्तेमाल तुलना के लिए करें; फ़ोन के सेंसर लैब के उपकरण नहीं हैं।';

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
      'आसमान रोशनी के साथ बदलता है: अंधेरे में रात, कम रोशनी वाले कमरे में सुबह, और जैसे-जैसे रोशनी बढ़ती है सूरज ऊपर चढ़ता है। लक्स और रोशनी किस काम की है, पढ़ें: 300–750 lx पढ़ने और डेस्क के काम के लिए ठीक है।';

  @override
  String get lightHelp4 =>
      'फ़ोन हटाते समय रीडिंग बनाए रखने के लिए लॉक करें दबाएँ।';

  @override
  String get lightTip =>
      'हर फ़ोन का लाइट सेंसर अलग होता है, इसलिए रीडिंग 10–20% तक अलग हो सकती है: जगहों की तुलना के लिए ठीक, पर कैलिब्रेटेड लक्स मीटर नहीं। स्क्रीन का ऊपरी हिस्सा न ढकें।';

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
}
