// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Уровень и угломер';

  @override
  String get homeTitle => 'Уровень';

  @override
  String get settings => 'Настройки';

  @override
  String get tools => 'Инструменты';

  @override
  String get listView => 'Списком';

  @override
  String get gridView => 'Сеткой';

  @override
  String get back => 'Назад';

  @override
  String get lightMode => 'Светлая тема';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get toolLevel => 'Уровень';

  @override
  String get toolLevelSubtitle => 'Пузырьковый строительный уровень';

  @override
  String get toolAngle => 'Угол';

  @override
  String get toolAngleSubtitle => 'Угол от горизонта или от вашего нуля';

  @override
  String get toolCompass => 'Компас';

  @override
  String get toolCompassSubtitle => 'Курс и направление';

  @override
  String get toolProtractor => 'Транспортир';

  @override
  String get toolProtractorSubtitle => 'Измеряйте углы на экране';

  @override
  String get toolRuler => 'Линейка';

  @override
  String get toolRulerSubtitle => 'Измеряйте длину на экране';

  @override
  String get toolMetal => 'Металлоискатель';

  @override
  String get toolMetalSubtitle => 'Ищет железо, сталь и магниты';

  @override
  String get toolVibration => 'Вибрация';

  @override
  String get toolVibrationSubtitle => 'Виброметр с графиком в реальном времени';

  @override
  String get toolSound => 'Шумомер';

  @override
  String get toolSoundSubtitle => 'Уровень шума в децибелах';

  @override
  String get toolAltimeter => 'Высотомер';

  @override
  String get toolAltimeterSubtitle => 'Давление воздуха и высота';

  @override
  String get toolLight => 'Люксметр';

  @override
  String get toolLightSubtitle => 'Освещённость в люксах';

  @override
  String get notAvailableOnPhone => 'Недоступно на этом телефоне';

  @override
  String get notOnPhone => 'Недоступно';

  @override
  String toolNotAvailableSemantics(String tool) {
    return '$tool, недоступно на этом телефоне';
  }

  @override
  String get howToUse => 'Как пользоваться';

  @override
  String get rotateLandscape => 'Повернуть горизонтально';

  @override
  String get rotatePortrait => 'Повернуть вертикально';

  @override
  String howToUseTool(String tool) {
    return 'Как пользоваться: $tool';
  }

  @override
  String get gotIt => 'Понятно';

  @override
  String get goodToKnow => 'Полезно знать: ';

  @override
  String get ok => 'ОК';

  @override
  String toolUnavailableTitle(String tool) {
    return '$tool: недоступно';
  }

  @override
  String toolUnavailableBody(String tool, int count, String sensors) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'нужны датчики, которых',
      one: 'нужен датчик, которого',
    );
    return 'Для инструмента «$tool» $_temp0 нет в этом телефоне: $sensors.';
  }

  @override
  String get listSeparator => ', ';

  @override
  String get hardwareLimitTip =>
      'Это ограничение оборудования телефона, а не ошибка приложения. Все остальные инструменты работают как обычно.';

  @override
  String get sensorAccelerometer => 'акселерометр';

  @override
  String get sensorMagnetometer => 'магнитометр (датчик компаса)';

  @override
  String get sensorBarometer => 'барометр (датчик давления воздуха)';

  @override
  String get sensorLight => 'датчик освещённости';

  @override
  String get sensorMicrophone => 'микрофон';

  @override
  String get noAccelerometer =>
      'В этом телефоне нет акселерометра, поэтому этот инструмент ничего не может измерить. Инструменты, которым он не нужен, работают.';

  @override
  String get noMagnetometer =>
      'В этом телефоне нет магнитометра (датчика компаса), поэтому этот инструмент не работает. Инструменты, которым он не нужен, работают.';

  @override
  String get noReadings =>
      'Датчик пока не передаёт данные. Вернитесь назад и откройте инструмент снова; если это повторяется, перезагрузите телефон. Некоторые телефоны не поддерживают этот инструмент.';

  @override
  String get waitingForSensors => 'Ожидание датчиков…';

  @override
  String get levelHelp1 =>
      'Положите телефон на поверхность или поставьте его на одну из граней.';

  @override
  String get levelHelp2 =>
      'Лёжа: выведите пузырёк в центр. X — наклон влево/вправо, Y — вперёд/назад. На грани видны угол и уклон.';

  @override
  String get levelHelp3 =>
      'Следуйте подсказке на экране (например, «Правая сторона выше»), пока не появится «Ровно»: показания станут оранжевыми, телефон издаст сигнал и вибрацию (можно отключить в Настройках).';

  @override
  String get levelHelp4 =>
      'Нажмите «Заблокировать», чтобы зафиксировать показания, и «Разблокировать», чтобы снова измерять.';

  @override
  String get levelHelp5 =>
      'Хотите классический уровень? Нажмите значок колбы в переключателе; круглый значок вернёт шкалу.';

  @override
  String get levelTip =>
      'Если заведомо ровная поверхность не показывает 0°, положите на неё телефон и нажмите «Калибровать». Чтобы отменить, снова нажмите «Калибровать» и выберите «Сбросить калибровку».';

  @override
  String get statusLevel => 'Ровно';

  @override
  String get leftEndLow => 'Левый край ниже';

  @override
  String get rightEndLow => 'Правый край ниже';

  @override
  String get rightSideHigh => 'Правая сторона выше';

  @override
  String get leftSideHigh => 'Левая сторона выше';

  @override
  String get topEdgeHigh => 'Верхний край выше';

  @override
  String get bottomEdgeHigh => 'Нижний край выше';

  @override
  String get calibrated => 'Откалибровано. Это положение теперь показывает 0°.';

  @override
  String get tooFarToCalibrate =>
      'Слишком сильный наклон для калибровки. Сначала положите телефон на ровную поверхность.';

  @override
  String get dialView => 'Шкала';

  @override
  String get tubeView => 'Колба';

  @override
  String get levelTube => 'Колба уровня';

  @override
  String get leftRightTube => 'Колба влево-вправо';

  @override
  String get forwardBackTube => 'Колба вперёд-назад';

  @override
  String tiltFromLevel(String value) {
    return 'Наклон от горизонта $value';
  }

  @override
  String fromLevel(String value) {
    return 'Отклонение от горизонта $value';
  }

  @override
  String get xLeftRight => 'X · влево / вправо';

  @override
  String get yForwardBack => 'Y · вперёд / назад';

  @override
  String get angle => 'Угол';

  @override
  String get slope => 'Уклон';

  @override
  String get lock => 'Заблокировать';

  @override
  String get unlock => 'Разблокировать';

  @override
  String locked(String status) {
    return 'Зафиксировано · $status';
  }

  @override
  String get lockReading => 'Зафиксировать показания';

  @override
  String get lockHandles => 'Зафиксировать ручки';

  @override
  String get handlesLocked =>
      'Ручки зафиксированы · нажмите на замок, чтобы изменить';

  @override
  String get calibrate => 'Калибровать';

  @override
  String get angleHelp1 =>
      'Положите телефон на поверхность, чтобы узнать наклон, или поставьте его ребром к уклону, перилам или трубе: крупное число — угол края, подсвеченного оранжевым, угол нижнего края — под ним.';

  @override
  String get angleHelp2 =>
      'Чтобы измерить изменение, держите телефон в начальном положении и нажмите «Ноль здесь».';

  @override
  String get angleHelp3 =>
      'Наклоните или переместите телефон. Шкала покажет, на сколько градусов он сдвинулся от вашего нуля.';

  @override
  String get angleHelp4 =>
      'Нажмите «Сбросить ноль», чтобы снова видеть угол от горизонтали.';

  @override
  String get angleHelp5 =>
      'Чтобы узнать угол, который не видно, прижмите телефон к предмету, нажмите на замок, затем уберите телефон и посмотрите.';

  @override
  String get angleHelp6 =>
      'Выберите режим переключателем вверху: плашмя на поверхности или стоя на ребре. На ребре экран заполняется водой, которая остаётся горизонтальной, а измеряемый край, нижняя сторона, подсвечивается оранжевым.';

  @override
  String get angleTip =>
      'Приложите длинную сторону телефона к пандусу, перилам или крыше, чтобы узнать уклон, или прижмите экран к доске или двери, чтобы измерить её наклон.';

  @override
  String movedFromZero(String value) {
    return 'Отклонение от нуля $value';
  }

  @override
  String get measuringFromZero => 'Измерение от вашего нуля';

  @override
  String get angleFlatStatus => 'Плашмя · угол относительно Земли';

  @override
  String get measuringRightEdge => 'Измеряется правый край';

  @override
  String get measuringLeftEdge => 'Измеряется левый край';

  @override
  String bottomEdge(String value) {
    return 'Нижний край $value';
  }

  @override
  String edgeAngleSemantics(String edge, String value, String other) {
    return '$edge: $value от горизонтали. Нижний край $other';
  }

  @override
  String get angleModeFlat => 'Плашмя на поверхности';

  @override
  String get angleModeEdge => 'На ребре';

  @override
  String get standOnEdge => 'Поставьте телефон на одну из граней';

  @override
  String get clearZero => 'Сбросить ноль';

  @override
  String get setZeroHere => 'Ноль здесь';

  @override
  String get compassHelp1 =>
      'Держите телефон горизонтально перед собой, вдали от металла, магнитов и электроники.';

  @override
  String get compassHelp2 =>
      'Направьте верх телефона в нужную сторону. Если держать телефон вертикально, компас показывает, куда смотрит основная камера.';

  @override
  String get compassHelp3 =>
      'Число — ваш курс в градусах, буквы — направление. Шкала поворачивается так, чтобы её N всегда смотрела на север; оранжевый шарик сверху показывает, куда направлен телефон.';

  @override
  String get compassTip =>
      'Компас показывает магнитный север, который может отличаться от картографического на несколько градусов. Если показания кажутся неверными, несколько раз проведите телефоном восьмёркой.';

  @override
  String compassSemantics(int heading, String direction) {
    return 'Магнитный курс $heading градусов, $direction';
  }

  @override
  String get magneticInterference =>
      'Магнитные помехи · отойдите от металла и поводите телефоном восьмёркой';

  @override
  String get compassCalibrate =>
      'Поводите телефоном восьмёркой, чтобы откалибровать компас';

  @override
  String get dirN => 'С';

  @override
  String get dirNE => 'СВ';

  @override
  String get dirE => 'В';

  @override
  String get dirSE => 'ЮВ';

  @override
  String get dirS => 'Ю';

  @override
  String get dirSW => 'ЮЗ';

  @override
  String get dirW => 'З';

  @override
  String get dirNW => 'СЗ';

  @override
  String get protractorHelp1 =>
      'Положите телефон и поместите предмет на экран, углом в центр.';

  @override
  String get protractorHelp2 =>
      'Перетащите каждую оранжевую ручку так, чтобы её линия шла вдоль стороны угла.';

  @override
  String get protractorHelp3 =>
      'Угол показан в центре. Дополнительный — это другая сторона (360° минус угол).';

  @override
  String get protractorHelp4 => 'Нажмите «Сброс», чтобы начать заново.';

  @override
  String get protractorHelp5 =>
      'Нажмите на замок, чтобы ручки не сдвигались, пока вы перемещаете предмет.';

  @override
  String armsSemantics(String value) {
    return 'Угол между лучами $value';
  }

  @override
  String get reflex => 'Дополнительный';

  @override
  String get dragHandles => 'Перетащите оранжевые ручки вдоль краёв';

  @override
  String get reset => 'Сброс';

  @override
  String get rulerHelp1 =>
      'Положите предмет на экран или приложите к нему телефон.';

  @override
  String get rulerHelp2 =>
      'Перетащите оранжевые линии к двум концам предмета. Нажмите mm, cm или in, чтобы выбрать единицу; другая система показана ниже.';

  @override
  String get rulerHelp3 =>
      'Для наибольшей точности один раз нажмите «Калибровать» и используйте карту, линейку или размер экрана.';

  @override
  String get rulerHelp4 =>
      'Нажмите на замок, чтобы линии не сдвигались, пока вы перемещаете предмет.';

  @override
  String get rulerTip =>
      'Линейка измеряет до длины экрана. Чехлы и изогнутые края скрывают первые миллиметры, поэтому измеряйте между линиями, а не от края телефона.';

  @override
  String rulerSemantics(String mm, String inches) {
    return 'Длина $mm мм, $inches дюйма';
  }

  @override
  String get rulerCalibrated => 'Откалибровано по карте · ±0,5 мм';

  @override
  String get rulerReported =>
      'Размер экрана от телефона · откалибруйте для ±0,5 мм';

  @override
  String get unitMillimetres => 'Миллиметры';

  @override
  String get unitCentimetres => 'Сантиметры';

  @override
  String get unitInches => 'Дюймы';

  @override
  String get rulerEstimated => 'Не откалибровано · ошибка до 10%';

  @override
  String get cardLongEdge =>
      'Положите на экран банковскую карту или удостоверение длинной стороной вдоль линейки, одним концом к тёмной линии. Перетащите оранжевую линию к другому концу карты.';

  @override
  String get cardShortEdge =>
      'Положите на экран банковскую карту или удостоверение короткой стороной вдоль линейки, одним концом к тёмной линии. Перетащите оранжевую линию к другому концу карты.';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get usePhoneDefault => 'Размер экрана от телефона';

  @override
  String get usePhoneDefaultInfo => 'Сбросить калибровку';

  @override
  String get cardMismatch =>
      'Это не похоже на карту. Совместите её с тёмной линией и попробуйте снова.';

  @override
  String get rotateToCalibrate => 'Поверните вертикально для калибровки';

  @override
  String get calibrateHow => 'Калибровать по';

  @override
  String get methodCard => 'Банковской карте';

  @override
  String get methodCardInfo =>
      'Любая банковская карта или удостоверение · ±0,5 мм';

  @override
  String get methodRuler => 'Линейке';

  @override
  String get methodRulerInfo => 'Точнее всего · линейка или рулетка';

  @override
  String get methodScreen => 'Размеру экрана';

  @override
  String get methodScreenInfo => 'Ничего не нужно · около 1%';

  @override
  String rulerInstructions(String mark) {
    return 'Положите линейку на экран, ноль — на тёмную линию. Перетащите оранжевую линию до отметки $mark.';
  }

  @override
  String rulerMismatch(String mark) {
    return 'Это не совпадает с $mark. Совместите ноль линейки с тёмной линией и попробуйте снова.';
  }

  @override
  String get screenSizeInstructions =>
      'Введите диагональ экрана в дюймах из характеристик телефона. Не знаете? Поищите модель и «диагональ экрана».';

  @override
  String get screenSizeMismatch =>
      'Этот размер не подходит для этого экрана. Проверьте характеристики и попробуйте снова.';

  @override
  String get rulerCalibratedRuler => 'Откалибровано по линейке · ±0,5 мм';

  @override
  String rulerCalibratedScreen(String size) {
    return 'Задан экран $size дюйма · около 1%';
  }

  @override
  String get metalHelp1 =>
      'Откройте инструмент вдали от металла. Первое значение считается «нет металла».';

  @override
  String get metalHelp2 =>
      'Медленно ведите телефоном над участком. Датчик обычно находится в верхней части телефона. Чем ближе металл, тем чаще сигнал; нажмите на динамик, чтобы выключить звук.';

  @override
  String get metalHelp3 =>
      '«Металл рядом» — небольшое изменение, «Металл обнаружен» — сильное. Как в игре «холодно — горячо», экран меняется от холодного синего до раскалённого красного по мере приближения, а при находке телефон вибрирует, если вибрация включена.';

  @override
  String get metalHelp4 =>
      'Если держать телефон неподвижно несколько секунд, он сам обнуляется, и ложное показание исчезает. Чтобы проверить место снова, отведите телефон и верните. «Задать базу» обнуляет сразу.';

  @override
  String get metalTip =>
      'Находит только железо, сталь и магниты, но не алюминий, медь, золото или серебро. Магнитные чехлы мешают измерению.';

  @override
  String metalSemantics(int value) {
    return 'Магнитное поле $value микротесла';
  }

  @override
  String get noMetal => 'Металла рядом нет';

  @override
  String get metalNearby => 'Металл рядом';

  @override
  String get metalDetected => 'Металл найден';

  @override
  String get heatCold => 'Холодно';

  @override
  String get heatCool => 'Прохладно';

  @override
  String get heatWarm => 'Тепло';

  @override
  String get heatWarmer => 'Теплее';

  @override
  String get heatHot => 'Горячо';

  @override
  String get heatBurning => 'Обжигает';

  @override
  String get baseline => 'База';

  @override
  String get field => 'Поле';

  @override
  String get change => 'Изменение';

  @override
  String get findsIronSteel => 'Находит железо, сталь и магниты';

  @override
  String get setBaseline => 'Задать базу';

  @override
  String get muteSound => 'Выключить звук';

  @override
  String get turnSoundOn => 'Включить звук';

  @override
  String get vibrationHelp1 =>
      'Положите телефон на поверхность или механизм, который хотите проверить, и уберите руки.';

  @override
  String get vibrationHelp2 =>
      'Число — текущая вибрация в м/с². Стрелка делает оборот каждые шесть секунд и рисует её волной вокруг числа: зелёной в покое, оранжевой при лёгкой вибрации, красной при сильной. Небольшая метка отмечает пик.';

  @override
  String get vibrationHelp3 =>
      'Пик — самый сильный момент. Среднее — уровень за последнюю секунду.';

  @override
  String get vibrationHelp4 =>
      'Нажимайте «Сбросить пик» перед каждым новым измерением.';

  @override
  String get vibrationTip =>
      '«Неподвижно» — меньше 0,3 м/с², «Сильная вибрация» — больше 2 м/с². Используйте показания для сравнения: датчики телефона — не лабораторные приборы.';

  @override
  String get still => 'Неподвижно';

  @override
  String get lightVibration => 'Слабая вибрация';

  @override
  String get strongVibration => 'Сильная вибрация';

  @override
  String get noAccelerometerVibration =>
      'В этом телефоне нет акселерометра, поэтому вибрацию здесь не измерить. Инструменты, которым он не нужен, работают.';

  @override
  String vibrationSemantics(String value) {
    return 'Вибрация $value метров в секунду в квадрате';
  }

  @override
  String get peak => 'Пик';

  @override
  String get average => 'Среднее';

  @override
  String get resetPeak => 'Сбросить пик';

  @override
  String get altimeterHelp1 =>
      'Турист поднимается в гору вместе с вашей высотой. Небо следует времени суток и сезону; нажмите кнопку погоды, чтобы выбрать её самому.';

  @override
  String get altimeterHelp2 =>
      'Чтобы измерить перепад высоты, например лестницу или этажи, нажмите «Ноль здесь» в начальной точке.';

  @override
  String get altimeterHelp3 =>
      'Поднимайтесь или спускайтесь: турист идёт с вами, а флажок отмечает самую высокую точку. Панель показывает метры от нуля, давление и примерную высоту.';

  @override
  String get altimeterHelp4 => 'Нажмите «Сбросить ноль», чтобы вернуться.';

  @override
  String get altimeterTip =>
      'Погода меняет давление воздуха, поэтому высота может ошибаться на десятки метров. Высота от вашего нуля точна на коротком промежутке времени. Нужен телефон с барометром.';

  @override
  String get weather => 'Погода';

  @override
  String get weatherAuto => 'Авто (время суток и сезон)';

  @override
  String get weatherSunny => 'Солнечно';

  @override
  String get weatherCloudy => 'Облачно';

  @override
  String get weatherRain => 'Дождь';

  @override
  String get weatherStorm => 'Гроза';

  @override
  String get weatherSnow => 'Снег';

  @override
  String get fromZero => 'От нуля';

  @override
  String get altitudeShort => 'Высота';

  @override
  String get barometerIos =>
      'Не удаётся прочитать барометр. Включите «Движение и фитнес» для этого приложения в Настройках › Конфиденциальность и безопасность и снова откройте Высотомер.';

  @override
  String get noBarometer =>
      'В этом телефоне нет барометра (датчика давления воздуха), поэтому высотомер не работает. Другие инструменты работают.';

  @override
  String get noLightSensor =>
      'В этом телефоне нет датчика освещённости, поэтому люксметр здесь не работает. Остальные инструменты работают.';

  @override
  String lightSemantics(String value) {
    return 'Освещённость $value люкс';
  }

  @override
  String get illuminance => 'Освещённость';

  @override
  String get footCandles => 'Фут-свечи';

  @override
  String get lightDark => 'Темно';

  @override
  String get lightDim => 'Тусклый свет';

  @override
  String get lightLivingRoom => 'Свет как в гостиной';

  @override
  String get lightReading => 'Подходит для чтения и работы за столом';

  @override
  String get lightBright => 'Яркий свет в помещении';

  @override
  String get lightOvercast => 'Пасмурный день';

  @override
  String get lightDaylight => 'Дневной свет';

  @override
  String get lightSun => 'Прямое солнце';

  @override
  String get lightHelp1 =>
      'Датчик освещённости находится вверху экрана, рядом с фронтальной камерой.';

  @override
  String get lightHelp2 =>
      'Держите телефон там, где хотите измерить, экраном к свету.';

  @override
  String get lightHelp3 =>
      'Небо следует за светом: ночь в темноте, рассвет в тускло освещённой комнате, и солнце поднимается по мере того, как становится светлее. Смотрите люксы и для чего подходит свет: 300–750 лк подходит для чтения и работы за столом.';

  @override
  String get lightHelp4 =>
      'Нажмите «Заблокировать», чтобы сохранить показание, пока убираете телефон.';

  @override
  String get lightTip =>
      'Датчики освещённости у телефонов разные, поэтому показания могут отличаться на 10–20 %: удобно сравнивать места, но это не поверенный люксметр. Не закрывайте верх экрана.';

  @override
  String get noMicrophone =>
      'Не удаётся использовать микрофон. Возможно, его занимает другое приложение: закройте его и снова откройте шумомер.';

  @override
  String soundSemantics(String value) {
    return 'Уровень звука около $value децибел';
  }

  @override
  String get decibelsApprox => 'дБ (прибл.)';

  @override
  String get soundMax => 'Макс.';

  @override
  String get soundVeryQuiet => 'Очень тихо';

  @override
  String get soundQuiet => 'Тихо, как в библиотеке';

  @override
  String get soundModerate => 'Умеренно, как разговор';

  @override
  String get soundLoud => 'Громко, как оживлённая улица';

  @override
  String get soundVeryLoud =>
      'Очень громко: долгое воздействие может повредить слух';

  @override
  String get soundDangerous => 'Опасно: защитите уши';

  @override
  String get micTitle => 'Разрешите доступ к микрофону';

  @override
  String get micBody =>
      'Шумомер слушает через микрофон, чтобы измерить громкость. Звук измеряется на телефоне и никогда не записывается, не сохраняется и не отправляется.';

  @override
  String get micAllow => 'Разрешить микрофон';

  @override
  String get micDeniedTitle => 'Доступ к микрофону выключен';

  @override
  String get micDeniedBody =>
      'Разрешите этому приложению микрофон в Настройках, чтобы пользоваться шумомером. Звук никогда не записывается, не сохраняется и не отправляется.';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get soundHelp1 =>
      'Не закрывайте микрофон (на нижнем торце) и направьте телефон на источник звука.';

  @override
  String get soundHelp2 =>
      'Крупное число — текущий уровень, усреднённый примерно за секунду. От него расходятся волны: чем громче, тем их больше и тем дальше они идут — зелёные в тишине, затем жёлтые, оранжевые, красные и малиновые. Столбики внизу показывают последние три секунды.';

  @override
  String get soundHelp3 =>
      'Среднее и Макс. считаются с момента открытия инструмента. Нажмите «Сброс», чтобы начать заново.';

  @override
  String get soundHelp4 =>
      'От 70 дБ строка состояния становится жёлтой, а от 85 дБ, когда долгое воздействие может повредить слух, — красной.';

  @override
  String get soundHelp5 =>
      'Нажмите на замок, чтобы сохранить показание, пока перемещаете телефон.';

  @override
  String get soundTip =>
      'Микрофоны у телефонов разные, поэтому показания могут отличаться примерно на 5 дБ: удобно для сравнения, но это не сертифицированный шумомер. Очень громкие звуки (выше примерно 110 дБ) могут показываться заниженными.';

  @override
  String get metresFromZero => 'м от нуля';

  @override
  String pressureSemantics(String value) {
    return 'Давление воздуха $value гектопаскалей';
  }

  @override
  String heightSemantics(String value) {
    return 'Высота $value от нуля';
  }

  @override
  String get pressure => 'Давление';

  @override
  String get altitudeApprox => 'Высота (прибл.)';

  @override
  String get measuringHeight => 'Высота от вашего нуля';

  @override
  String get airPressureAltitude => 'Давление воздуха и высота';

  @override
  String get appearance => 'Оформление';

  @override
  String get themeSystem => 'Система';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get levelUnits => 'Единицы уровня';

  @override
  String get unitDegrees => 'Градусы';

  @override
  String get unitPercent => 'Уклон в процентах';

  @override
  String get unitRoofPitch => 'Уклон кровли (подъём на 12)';

  @override
  String get vibrateWhenLevel => 'Вибрация';

  @override
  String get sounds => 'Звуки';

  @override
  String get resetCalibration => 'Сбросить калибровку';

  @override
  String get resetCalibrationHint => 'Вернуть заводской ноль датчика';

  @override
  String get calibrateHere => 'Калибровать здесь';

  @override
  String get calibrateHereInfo => 'На заведомо ровной поверхности';

  @override
  String get calibrationRemoved =>
      'Калибровка удалена. Уровень снова использует заводской ноль датчика.';

  @override
  String get resetAllCalibrations => 'Сбросить все калибровки';

  @override
  String get resetAllCalibrationsHint =>
      'Уровень и линейка — к заводским настройкам';

  @override
  String get resetAllTitle => 'Сбросить все калибровки?';

  @override
  String get resetAllBody =>
      'Будут удалены калибровки уровня (её использует и угломер) и линейки. Оба инструмента вернутся к заводским настройкам. Остальные настройки не изменятся, а откалибровать заново можно в любой момент.';

  @override
  String get notCalibrated => 'Не откалибровано';

  @override
  String get language => 'Язык';

  @override
  String get licenses => 'Лицензии открытого ПО';

  @override
  String get languageSystem => 'Язык телефона';
}
