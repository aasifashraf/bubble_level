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
  String get homeTopTools => 'Главные инструменты';

  @override
  String get homeMoreTools => 'Другие инструменты';

  @override
  String get homeArrange => 'Порядок';

  @override
  String get arrangeTitle => 'Порядок инструментов';

  @override
  String get arrangeHint =>
      'Перетащите, чтобы изменить порядок. Первые три будут главными.';

  @override
  String get arrangeStar => 'Сделать главным';

  @override
  String get arrangeUnstar => 'Убрать из главных';

  @override
  String get arrangeReset => 'Популярный порядок';

  @override
  String get arrangeDone => 'Готово';

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
  String get toolVibrationSubtitle => 'Сила и скорость вибрации (об/мин)';

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
  String get sensorCamera => 'задняя камера';

  @override
  String get sensorGps => 'GPS';

  @override
  String get sensorAr => 'ARCore (дополненная реальность)';

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
      'Лёжа: выведите пузырёк в центр. X показывает наклон влево/вправо, Y вперёд/назад. На грани видны угол и уклон.';

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
      'Положите телефон на поверхность, чтобы узнать наклон, или поставьте его ребром к уклону, перилам или трубе: крупное число показывает угол края, подсвеченного оранжевым, а угол нижнего края указан под ним.';

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
      'Число показывает ваш курс в градусах, буквы показывают направление. Шкала поворачивается так, чтобы её N всегда смотрела на север; оранжевый шарик сверху показывает, куда направлен телефон.';

  @override
  String get compassTip =>
      'Компас показывает магнитный север, который в некоторых местах может отличаться от картографического на 10 градусов и больше. Если показания кажутся неверными, несколько раз проведите телефоном восьмёркой.';

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
      'Угол показан в центре. Дополнительный угол показывает другую сторону (360° минус угол).';

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
    return 'Положите линейку на экран, ноль совместите с тёмной линией. Перетащите оранжевую линию до отметки $mark.';
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
      '«Металл рядом» означает небольшое изменение, «Металл обнаружен» означает сильное. Как в игре «холодно, горячо», экран меняется от холодного синего до раскалённого красного по мере приближения, а при находке телефон вибрирует, если вибрация включена.';

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
      'Положите телефон на работающий механизм и уберите руки. На небольшом механизме прижмите его покрепче.';

  @override
  String get vibrationHelp2 =>
      'Стрелка показывает скорость самой сильной вибрации в об/мин, под ней указаны герцы (об/мин равны герцам × 60). Слабое свечение внутри шкалы показывает весь спектр; стрелка указывает на его самую яркую часть.';

  @override
  String get vibrationHelp3 =>
      'Сила показывает, насколько сильно трясёт, в м/с²: меньше 0,3 означает покой, больше 2 означает сильную вибрацию.';

  @override
  String get vibrationHelp4 =>
      'Нажмите «Заблокировать», чтобы удержать показание, и кнопку сброса перед следующим механизмом.';

  @override
  String get vibrationTip =>
      'Большинство телефонов измеряют до 100 Гц (6000 об/мин), некоторые меньше; шкала показывает предел вашего телефона. Более быстрая вибрация может отображаться как неверная, более низкая скорость. Самая сильная вибрация часто совпадает со скоростью вала, но может быть вдвое выше. Датчики телефона не являются лабораторными приборами.';

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
  String get frequency => 'Частота';

  @override
  String get rpm => 'об/мин';

  @override
  String get strength => 'Сила';

  @override
  String vibratingAt(String value) {
    return 'Вибрация $value Гц';
  }

  @override
  String get noClearFrequency => 'Нет чёткой частоты';

  @override
  String get findingFrequency => 'Поиск частоты…';

  @override
  String vibrationSpeedSemantics(String rpm, String value) {
    return '$rpm оборотов в минуту, $value герц';
  }

  @override
  String get peak => 'Пик';

  @override
  String get average => 'Среднее';

  @override
  String get resetPeak => 'Сбросить пик';

  @override
  String get altimeterHelp1 =>
      'Турист на горе поднимается и спускается, когда меняется ваша высота. Небо следует времени суток и сезону; нажмите кнопку погоды, чтобы выбрать её самому.';

  @override
  String get altimeterHelp2 =>
      'Чтобы измерить перепад высоты, например лестницу или этажи, нажмите «Ноль здесь» в начальной точке.';

  @override
  String get altimeterHelp3 =>
      'Поднимайтесь или спускайтесь: турист идёт с вами, а флажок отмечает самую высокую точку. Панель показывает метры от нуля, давление и примерную высоту.';

  @override
  String get altimeterHelp4 =>
      'Нажмите «Сбросить ноль», чтобы больше не измерять от нуля: значение «От нуля» снова станет пустым.';

  @override
  String get altimeterTip =>
      'Погода постоянно меняет давление воздуха, поэтому без известной начальной высоты высота может ошибаться на сотню метров и больше. Доверяйте изменению высоты от «Ноль здесь» на коротком промежутке времени. Нужен телефон с барометром.';

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
      'Небо следует за светом: ночь в темноте, рассвет в тускло освещённой комнате, и солнце поднимается по мере того, как становится светлее. Смотрите люксы и для чего подходит свет: от 300 до 750 лк подходит для чтения и работы за столом.';

  @override
  String get lightHelp4 =>
      'Нажмите «Заблокировать», чтобы сохранить показание, пока убираете телефон.';

  @override
  String get lightTip =>
      'Датчики освещённости телефонов не поверены, поэтому показания на разных телефонах могут сильно отличаться. Используйте инструмент, чтобы сравнивать освещение в одном месте на одном и том же телефоне, а не как поверенный люксметр. Не закрывайте верх экрана.';

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
      'Крупное число показывает текущий уровень, усреднённый примерно за секунду. От него расходятся волны: чем громче, тем их больше и тем дальше они идут: зелёные в тишине, затем жёлтые, оранжевые, красные и малиновые. Столбики внизу показывают последние три секунды.';

  @override
  String get soundHelp3 =>
      'Среднее и Макс. считаются с момента открытия инструмента. Нажмите «Сброс», чтобы начать заново.';

  @override
  String get soundHelp4 =>
      'От 70 дБ строка состояния становится жёлтой, а от 85 дБ, когда долгое воздействие может повредить слух, красной.';

  @override
  String get soundHelp5 =>
      'Нажмите на замок, чтобы сохранить показание, пока перемещаете телефон.';

  @override
  String get soundTip =>
      'Микрофоны телефонов не являются поверенными шумомерами и различаются у разных моделей, поэтому показания приблизительные (часто с погрешностью от 5 до 10 дБ), а очень громкие звуки могут показываться заниженными. Для официальных измерений нужен поверенный шумомер.';

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
      'Вернуть уровень и линейку к заводским настройкам';

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

  @override
  String get toolHeight => 'Высота';

  @override
  String get toolHeightSubtitle => 'Высота и расстояние визированием';

  @override
  String get heightHelp1 =>
      'Встаньте там, откуда видно основание и верх объекта. Держите телефон экраном вверх и смотрите вдоль верхнего края.';

  @override
  String get heightHelp2 =>
      'Наведите верхний край на основание объекта и нажмите «Основание»: так получается расстояние.';

  @override
  String get heightHelp3 =>
      'Наведите верхний край на верх и нажмите «Верх»: появится высота.';

  @override
  String get heightHelp4 =>
      'Знаете расстояние? Нажмите «Расстояние» и введите его, затем наводите только на верх. Нажмите «Высота глаз», чтобы указать свою.';

  @override
  String get heightTip =>
      'Около ±5% на ровной земле при верной высоте глаз (ваш рост минус около 10 см). Отойдите так, чтобы верх был ниже 70°, а основание хотя бы на 3° ниже горизонта. На склоне введите расстояние.';

  @override
  String get lockBase => 'Основание';

  @override
  String get lockTop => 'Верх';

  @override
  String get measureAgain => 'Измерить снова';

  @override
  String get distance => 'Расстояние';

  @override
  String get objectHeight => 'Высота';

  @override
  String get eyeHeight => 'Высота глаз';

  @override
  String get sightAngle => 'Угол визирования';

  @override
  String get heightAimBase => 'Наведите верхний край на основание';

  @override
  String get heightAimTop => 'Теперь наведите верхний край на верх';

  @override
  String get heightDone => 'Готово · «Измерить снова» для следующего';

  @override
  String get heightHoldFlatter =>
      'Держите телефон более плоско и смотрите вдоль верхнего края';

  @override
  String get heightTooFar =>
      'Основание слишком близко к горизонту: подойдите ближе или введите расстояние';

  @override
  String get heightStepBack =>
      'Очень круто: отойдите для более стабильного значения';

  @override
  String get knownDistance => 'Расстояние до основания';

  @override
  String get knownDistanceHint =>
      'Расстояние по земле до основания объекта. Очистите, чтобы измерить визированием.';

  @override
  String get eyeHeightHint =>
      'На какой высоте ваши глаза над землёй: примерно ваш рост минус 10 см.';

  @override
  String get clear => 'Очистить';

  @override
  String get toolCamera => 'Уровень с камерой';

  @override
  String get toolCameraSubtitle =>
      'Линии уровня поверх камеры, измерение любого края';

  @override
  String get cameraHelp1 =>
      'Наведите заднюю камеру на стену, картину, полку или дверь. Держите телефон вертикально, прямо напротив стены.';

  @override
  String get cameraHelp2 =>
      'Сплошные линии следуют за гравитацией: они всегда строго горизонтальны и вертикальны. Пунктирные линии закреплены за телефоном, а маленькая дуга между ними показывает, насколько он наклонён. Настоящие линии становятся оранжевыми, когда телефон стоит ровно.';

  @override
  String get cameraHelp3 =>
      'Чтобы проверить предмет, нажмите «Заморозить» и перетащите две оранжевые ручки на один из его краёв, например на верх рамы. Вы увидите, насколько этот край перекошен и какую сторону поднять, даже если рука была неровной. Поставьте линию вертикально, чтобы проверить вертикальный край.';

  @override
  String get cameraHelp4 =>
      'Две кнопки вверху показывают или скрывают линии телефона и настоящие линии. Подсветка помогает в тёмных углах; «Продолжить» возвращает живое изображение.';

  @override
  String get cameraTip =>
      'Для точного измерения края держите телефон прямо напротив стены («Вперёд/назад» меньше 5°) и измеряйте ближе к центру изображения, где объектив меньше всего изгибает линии. Используется калибровка уровня на ребре. Изображение никогда не записывается, не сохраняется и не отправляется.';

  @override
  String get cameraAllowTitle => 'Разрешите камеру';

  @override
  String get cameraAllowBody =>
      'Уровень с камерой рисует линии уровня поверх изображения с камеры и измеряет на нём края. Изображение остаётся на вашем телефоне и никогда не записывается, не сохраняется и не отправляется.';

  @override
  String get cameraAllow => 'Разрешить камеру';

  @override
  String get cameraDeniedTitle => 'Доступ к камере выключен';

  @override
  String get cameraDeniedBody =>
      'Включите камеру для этого приложения в настройках, чтобы пользоваться уровнем с камерой. Изображение никогда не записывается, не сохраняется и не отправляется.';

  @override
  String get noCamera =>
      'Не удаётся использовать камеру. Возможно, её занимает другое приложение или камеры нет: закройте другие приложения камеры и снова откройте уровень с камерой.';

  @override
  String get tilt => 'Наклон';

  @override
  String get forwardBack => 'Вперёд/назад';

  @override
  String get cameraLevel => 'Ровно';

  @override
  String cameraTilted(String value) {
    return 'Наклон $value°';
  }

  @override
  String get cameraHoldUpright =>
      'Держите телефон вертикально, камерой к стене';

  @override
  String get freeze => 'Заморозить';

  @override
  String get resume => 'Продолжить';

  @override
  String get torch => 'Подсветка';

  @override
  String cameraSemantics(String value) {
    return 'Изображение с камеры с линиями уровня, наклон $value градусов';
  }

  @override
  String get cameraPhoneLines => 'Линии телефона';

  @override
  String get cameraTrueLines => 'Настоящие линии';

  @override
  String get cameraFrozen => 'Заморожено';

  @override
  String get cameraDragHandles => 'Перетащите ручки на край';

  @override
  String get cameraFaceWall => 'Держите телефон прямо напротив стены';

  @override
  String get edgeLevel => 'Этот край ровный';

  @override
  String get edgePlumb => 'Этот край вертикален';

  @override
  String edgeLiftRight(String value) {
    return 'Край перекошен на $value°, поднимите правую сторону';
  }

  @override
  String edgeLiftLeft(String value) {
    return 'Край перекошен на $value°, поднимите левую сторону';
  }

  @override
  String edgeOffPlumb(String value) {
    return 'Край отклонён от вертикали на $value°';
  }

  @override
  String get cameraHandle => 'Ручка края';

  @override
  String get toolGForce => 'Перегрузка';

  @override
  String get toolGForceSubtitle => 'Торможение, разгон и повороты в g';

  @override
  String get gHelp1 =>
      'Закрепите телефон в автодержателе экраном к себе. Пока машина стоит, нажмите «Ноль»: прибор запомнит, где низ и где перёд.';

  @override
  String get gHelp2 =>
      'Поезжайте: светится та сторона машины, к которой вас прижимает. При торможении светится перёд, при разгоне задняя часть, в повороте внешняя сторона. Зелёный значит мягко, оранжевый ощутимо, красный резко.';

  @override
  String get gHelp3 =>
      'На панели хранятся самые сильные разгон, торможение и поворот с момента обнуления, а точки на ободе хранят самый сильный толчок в каждом направлении. Кнопка сброса их очищает.';

  @override
  String get gHelp4 =>
      'Следите за дорогой: пусть показания читает пассажир, или посмотрите пики после остановки.';

  @override
  String get gTip =>
      'Показания берутся с акселерометра и приблизительны: нужны надёжный держатель и «Ноль», нажатый без движения; на неровной дороге они чуть более шумные. Если держатель сдвинулся, остановитесь и снова нажмите «Ноль». Больше 0,5 g для обычной машины означает резкое торможение или быстрый поворот.';

  @override
  String get gZero => 'Ноль';

  @override
  String get gResetPeaks => 'Сбросить пики';

  @override
  String get gSpeedUp => 'Разгон';

  @override
  String get gBrake => 'Торможение';

  @override
  String get gCorner => 'Поворот';

  @override
  String get gSteady => 'Ровно';

  @override
  String gBraking(String value) {
    return 'Торможение $value g';
  }

  @override
  String gSpeedingUp(String value) {
    return 'Разгон $value g';
  }

  @override
  String gLeftBend(String value) {
    return 'Левый поворот $value g';
  }

  @override
  String gRightBend(String value) {
    return 'Правый поворот $value g';
  }

  @override
  String gSemantics(String value) {
    return 'Перегрузка $value g';
  }

  @override
  String get gZeroed => 'Обнулено: низ и перёд запомнены';

  @override
  String get noAccelerometerG =>
      'В этом телефоне нет акселерометра, поэтому перегрузку здесь не измерить. Другие инструменты работают.';

  @override
  String get toolSpeed => 'Спидометр';

  @override
  String get toolSpeedSubtitle => 'Скорость, поездка и высота по GPS';

  @override
  String get speedHelp1 =>
      'Разрешите доступ к местоположению и положите телефон туда, откуда видно небо, например на приборную панель или в держатель на лобовом стекле. На улице первое определение места занимает несколько секунд.';

  @override
  String get speedHelp2 =>
      'Шкала на приборной панели показывает скорость по GPS, а по бокам от неё расстояние поездки и высоту. Панель хранит расстояние, максимальную и среднюю скорость с последнего сброса.';

  @override
  String get speedHelp3 =>
      'Нажмите на координаты, чтобы скопировать их. Кнопка единиц переключает км/ч и миль/ч, а «Сбросить поездку» обнуляет расстояние, максимум и среднее.';

  @override
  String get speedHelp4 =>
      'Следите за дорогой: пусть показания читает пассажир, или посмотрите поездку после остановки.';

  @override
  String get speedTip =>
      'Скорость берётся со спутников и на открытой дороге обычно точна примерно до 1 км/ч; в туннелях, между высокими домами или в помещении она может запаздывать или пропадать. Высота по GPS может ошибаться на величину от 10 до 50 м, поэтому для перепадов высоты используйте Высотомер. Местоположение используется, только пока этот инструмент открыт, и никогда не покидает ваш телефон.';

  @override
  String get speedAllowTitle => 'Разрешите доступ к местоположению';

  @override
  String get speedAllowBody =>
      'Спидометр с помощью GPS измеряет скорость, расстояние и высоту. Местоположение используется, только пока этот инструмент открыт на экране, никогда в фоне, и никогда не покидает ваш телефон.';

  @override
  String get speedAllow => 'Разрешить местоположение';

  @override
  String get speedDeniedTitle => 'Доступ к местоположению выключен';

  @override
  String get speedDeniedBody =>
      'Включите доступ к местоположению для этого приложения в настройках, чтобы пользоваться спидометром. Оно используется, только пока инструмент открыт, и никогда не покидает ваш телефон.';

  @override
  String get speedServiceOffTitle => 'Геолокация выключена';

  @override
  String get speedServiceOffBody =>
      'Включите геолокацию в настройках телефона, чтобы пользоваться спидометром.';

  @override
  String get speedDistance => 'Расстояние';

  @override
  String get speedTop => 'Максимум';

  @override
  String get speedAverage => 'Среднее';

  @override
  String get speedTrip => 'Поездка';

  @override
  String get speedAltitude => 'Высота';

  @override
  String get speedResetTrip => 'Сбросить поездку';

  @override
  String get speedFinding => 'Поиск спутников…';

  @override
  String speedGps(String value) {
    return 'GPS ±$value м';
  }

  @override
  String get speedWeak => 'Слабый GPS: скорость может запаздывать';

  @override
  String get speedApproximate =>
      'Точное местоположение выключено: включите для стабильной скорости';

  @override
  String get speedStill => 'Без движения';

  @override
  String get speedCopied => 'Координаты скопированы';

  @override
  String get speedUnitTooltip => 'Переключить км/ч и миль/ч';

  @override
  String get speedKmh => 'км/ч';

  @override
  String get speedMph => 'миль/ч';

  @override
  String speedSemantics(String value) {
    return 'Скорость $value';
  }

  @override
  String get speedCoordinates => 'Координаты, нажмите, чтобы скопировать';

  @override
  String get noGps =>
      'В этом телефоне нет GPS, поэтому скорость здесь не измерить. Другие инструменты работают.';

  @override
  String get speedSceneHelp =>
      'Небо меняется со временем суток. Кнопка погоды выбирает сцену: «Авто» следует за сезоном, или выберите солнце, облака, дождь, грозу или снег. Это декорация, а не прогноз.';

  @override
  String get toolTape => 'Рулетка';

  @override
  String get toolTapeSubtitle => 'Длины и площади в AR';

  @override
  String get tapeAllowBody =>
      'Рулетка отслеживает изображение с камеры в 3D, чтобы ставить точки на поверхности. Изображение остаётся на вашем телефоне и никогда не записывается, не сохраняется и не отправляется.';

  @override
  String get tapeDeniedBody =>
      'Включите камеру для этого приложения в настройках, чтобы пользоваться рулеткой. Изображение никогда не записывается, не сохраняется и не отправляется.';

  @override
  String get tapeInstallTitle => 'Установите поддержку AR';

  @override
  String get tapeInstallBody =>
      'Рулетка использует Google Play Services for AR (ARCore), чтобы отслеживать телефон в 3D. Установите или обновите этот компонент в Play Store, затем вернитесь.';

  @override
  String get tapeInstall => 'Установить';

  @override
  String get tapeUnsupported =>
      'Этот телефон не поддерживает AR (ARCore), а без него рулетка не может отслеживать телефон в 3D.';

  @override
  String get tapeFailed =>
      'Не удалось запустить AR. Возможно, камеру занимает другое приложение: закройте его и попробуйте снова.';

  @override
  String get tapeLength => 'Длина';

  @override
  String get tapePerimeter => 'Периметр';

  @override
  String get tapeArea => 'Площадь';

  @override
  String get tapePieces => 'Отрезки';

  @override
  String get tapeAdd => 'Добавить точку';

  @override
  String get tapeClose => 'Замкнуть фигуру';

  @override
  String get tapeUndo => 'Отменить';

  @override
  String get tapeUnit => 'Единицы: сантиметры или дюймы';

  @override
  String get tapeStarting => 'Медленно ведите телефоном, чтобы запустить AR';

  @override
  String get tapeFind =>
      'Медленно ведите телефоном над поверхностью, чтобы найти её';

  @override
  String get tapeNoSurface =>
      'Под прицелом пока нет поверхности: двигайтесь медленно';

  @override
  String get tapeMissed =>
      'Там пока нет поверхности. Двигайтесь медленно, затем нажмите снова';

  @override
  String get tapeFirst =>
      'Наведите прицел на первый угол и нажмите «Добавить точку»';

  @override
  String get tapeNext =>
      'Наведите прицел на следующий угол и нажмите «Добавить точку»';

  @override
  String get tapeSnap =>
      'Прицел на первой точке: нажмите «Замкнуть фигуру», чтобы узнать площадь';

  @override
  String get tapeDone => 'Приблизительно: погрешность AR от 1 до 3 cm';

  @override
  String get tapeDark => 'Слишком темно для отслеживания: добавьте света';

  @override
  String get tapeFast => 'Слишком быстрое движение: двигайтесь медленнее';

  @override
  String get tapePlain =>
      'Слишком однородно для отслеживания: наведите на что-то с текстурой';

  @override
  String get tapeLost =>
      'Отслеживание потеряно: наведите туда, где были, и держите неподвижно';

  @override
  String tapeSemantics(String total) {
    return 'Изображение с камеры с измеренными точками. Всего $total';
  }

  @override
  String get tapeHelp1 =>
      'Разрешите камеру, затем медленно ведите телефоном над столом, полом или стеной, пока не появятся белые точки и прицел не ляжет на поверхность.';

  @override
  String get tapeHelp2 =>
      'Наведите прицел на угол и нажмите «Добавить точку». Перейдите к следующему углу: длина следует за прицелом.';

  @override
  String get tapeHelp3 =>
      'Нажимайте на следующие углы, чтобы соединять отрезки; панель их суммирует. Наведите прицел обратно на первую точку и нажмите «Замкнуть фигуру», чтобы узнать площадь и периметр.';

  @override
  String get tapeHelp4 =>
      '«Отменить» убирает последнюю точку (или размыкает замкнутую фигуру); «Очистить» начинает заново. Кнопка вверху переключает сантиметры и дюймы.';

  @override
  String get tapeTip =>
      'Измерение в AR приблизительное: часто с точностью от 1 до 3 cm на метр, но хуже на однотонных или блестящих поверхностях, при слабом свете, издалека (дальше 3 m) или при быстром движении телефона. Двигайтесь медленно и держите углы хорошо освещёнными. Изображение никогда не записывается, не сохраняется и не отправляется.';
}
