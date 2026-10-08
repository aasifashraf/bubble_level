import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/angles.dart';
import '../../domain/ruler.dart';
import '../../domain/scene_weather.dart';

/// How tilt is shown: degrees, slope percent, or roof pitch (rise per 12
/// of run, as US builders say "4/12").
enum AngleUnit { degrees, percent, pitch }

/// How the home screen shows the tools.
enum HomeLayout { list, grid }

/// How the Level tool draws its instrument: the round dial or a classic
/// spirit-level tube.
enum LevelStyle { dial, tube }

/// How the Angle tool is used: lying flat on a surface, or standing on an
/// edge.
enum AngleMode { flat, edge }

/// User preferences and level calibration, persisted across launches.
class SettingsRepository extends ChangeNotifier {
  SettingsRepository._(this._prefs)
    : _flatRef = _readVec(_prefs) ?? Vec3.up,
      _edgeOffset = _prefs.getDouble(_kEdgeOffset) ?? 0,
      _haptics = _prefs.getBool(_kHaptics) ?? true,
      _sounds = _prefs.getBool(_kSounds) ?? true,
      _unit =
          AngleUnit.values.asNameMap()[_prefs.getString(_kUnit)] ??
          AngleUnit.degrees,
      _themeMode =
          ThemeMode.values.asNameMap()[_prefs.getString(_kThemeMode)] ??
          ThemeMode.light,
      _homeLayout =
          HomeLayout.values.asNameMap()[_prefs.getString(_kHomeLayout)] ??
          HomeLayout.grid,
      _levelStyle =
          LevelStyle.values.asNameMap()[_prefs.getString(_kLevelStyle)] ??
          LevelStyle.dial,
      _language = _prefs.getString(_kLanguage);

  static Future<SettingsRepository> load() async =>
      SettingsRepository._(await SharedPreferences.getInstance());

  static const _kFlatRef = 'flatRef';
  static const _kEdgeOffset = 'edgeOffset';
  static const _kHaptics = 'haptics';
  static const _kSounds = 'sounds';
  static const _kUnit = 'unit';
  static const _kThemeMode = 'themeMode';
  static const _kHomeLayout = 'homeLayout';
  static const _kLevelStyle = 'levelStyle';
  static const _kLanguage = 'language';
  static const _kRuler = 'rulerPxPerMm:';
  static const _kRulerMethod = 'rulerMethod:';
  static const _kLandscape = 'landscape:';
  static const _kRulerUnit = 'rulerUnit';
  static const _kAngleMode = 'angleMode';
  static const _kSceneWeather = 'sceneWeather';
  static const _kEyeHeight = 'eyeHeight';
  static const _kCameraAllowed = 'cameraAllowed';

  final SharedPreferences _prefs;
  Vec3 _flatRef;
  double _edgeOffset;
  bool _haptics;
  bool _sounds;
  AngleUnit _unit;
  ThemeMode _themeMode;
  HomeLayout _homeLayout;
  LevelStyle _levelStyle;
  String? _language;

  /// Gravity direction (device frame) measured on a known-flat surface.
  Vec3 get flatRef => _flatRef;

  /// Edge-mode deviation measured on a known-level surface.
  double get edgeOffset => _edgeOffset;
  bool get haptics => _haptics;

  /// The level chime and the metal detector's beep.
  bool get sounds => _sounds;
  AngleUnit get unit => _unit;

  /// Follow the system, or force light / dark.
  ThemeMode get themeMode => _themeMode;

  /// Grid (the default) or list on the home screen.
  HomeLayout get homeLayout => _homeLayout;

  /// Dial (the default) or tube in the Level tool.
  LevelStyle get levelStyle => _levelStyle;

  /// App language code ("de", "ar" …), or null to follow the phone.
  String? get language => _language;

  /// Whether the Level has a calibration of its own.
  bool get isLevelCalibrated =>
      !identical(_flatRef, Vec3.up) || _edgeOffset != 0;

  /// Whether any tool (the Level, or the Ruler on any screen) has a
  /// calibration to reset.
  bool get hasAnyCalibration =>
      isLevelCalibrated || _prefs.getKeys().any((k) => k.startsWith(_kRuler));

  static Vec3? _readVec(SharedPreferences p) {
    final v = p.getStringList(_kFlatRef)?.map(double.tryParse).toList();
    if (v == null || v.length != 3 || v.contains(null)) return null;
    return Vec3(v[0]!, v[1]!, v[2]!);
  }

  Future<void> calibrateFlat(Vec3 gravity) async {
    _flatRef = gravity.normalized();
    notifyListeners();
    await _prefs.setStringList(_kFlatRef, [
      '${_flatRef.x}',
      '${_flatRef.y}',
      '${_flatRef.z}',
    ]);
  }

  Future<void> calibrateEdge(double offset) async {
    _edgeOffset = offset;
    notifyListeners();
    await _prefs.setDouble(_kEdgeOffset, offset);
  }

  /// Back to the factory sensor zero for the Level.
  Future<void> resetLevelCalibration() async {
    _flatRef = Vec3.up;
    _edgeOffset = 0;
    notifyListeners();
    await _prefs.remove(_kFlatRef);
    await _prefs.remove(_kEdgeOffset);
  }

  /// Removes every tool's calibration: the Level's zero and the Ruler's
  /// screen scale for every screen. Other settings stay.
  Future<void> resetAllCalibrations() async {
    final ruler = _prefs
        .getKeys()
        .where((k) => k.startsWith(_kRuler) || k.startsWith(_kRulerMethod))
        .toList();
    for (final k in ruler) {
      await _prefs.remove(k);
    }
    await resetLevelCalibration();
  }

  Future<void> setHaptics(bool v) async {
    _haptics = v;
    notifyListeners();
    await _prefs.setBool(_kHaptics, v);
  }

  Future<void> setSounds(bool v) async {
    _sounds = v;
    notifyListeners();
    await _prefs.setBool(_kSounds, v);
  }

  Future<void> setUnit(AngleUnit v) async {
    _unit = v;
    notifyListeners();
    await _prefs.setString(_kUnit, v.name);
  }

  Future<void> setThemeMode(ThemeMode v) async {
    _themeMode = v;
    notifyListeners();
    await _prefs.setString(_kThemeMode, v.name);
  }

  Future<void> setHomeLayout(HomeLayout v) async {
    _homeLayout = v;
    notifyListeners();
    await _prefs.setString(_kHomeLayout, v.name);
  }

  /// The ruler's calibration for one physical screen (see `screenKey`), in
  /// physical pixels per millimetre.
  double? rulerPxPerMm(String screen) => _prefs.getDouble('$_kRuler$screen');

  /// How that calibration was made.
  CalibrationMethod rulerMethod(String screen) =>
      CalibrationMethod.values.asNameMap()[_prefs.getString(
        '$_kRulerMethod$screen',
      )] ??
      CalibrationMethod.card;

  /// Saves (or, with null, forgets) one screen's calibration.
  Future<void> setRulerCalibration(
    String screen,
    double? pxPerMm, [
    CalibrationMethod method = CalibrationMethod.card,
  ]) async {
    if (pxPerMm == null) {
      await _prefs.remove('$_kRuler$screen');
      await _prefs.remove('$_kRulerMethod$screen');
    } else {
      await _prefs.setDouble('$_kRuler$screen', pxPerMm);
      await _prefs.setString('$_kRulerMethod$screen', method.name);
    }
    notifyListeners();
  }

  Future<void> setLanguage(String? code) async {
    _language = code;
    notifyListeners();
    if (code == null) {
      await _prefs.remove(_kLanguage);
    } else {
      await _prefs.setString(_kLanguage, code);
    }
  }

  /// The ruler's unit, or null until the user picks one.
  LengthUnit? get rulerUnit =>
      LengthUnit.values.asNameMap()[_prefs.getString(_kRulerUnit)];

  Future<void> setRulerUnit(LengthUnit unit) async {
    await _prefs.setString(_kRulerUnit, unit.name);
    notifyListeners();
  }

  /// Whether [tool] was last turned to landscape with its rotate button.
  bool toolLandscape(String tool) =>
      _prefs.getBool('$_kLandscape$tool') ?? false;

  Future<void> setToolLandscape(String tool, bool landscape) async {
    await _prefs.setBool('$_kLandscape$tool', landscape);
    notifyListeners();
  }

  AngleMode get angleMode =>
      AngleMode.values.asNameMap()[_prefs.getString(_kAngleMode)] ??
      AngleMode.flat;

  Future<void> setAngleMode(AngleMode v) async {
    await _prefs.setString(_kAngleMode, v.name);
    notifyListeners();
  }

  /// The Altimeter scene's weather picked by the user, or null to follow
  /// the time of day and the season.
  SceneWeather? get sceneWeather =>
      SceneWeather.values.asNameMap()[_prefs.getString(_kSceneWeather)];

  Future<void> setSceneWeather(SceneWeather? v) async {
    if (v == null) {
      await _prefs.remove(_kSceneWeather);
    } else {
      await _prefs.setString(_kSceneWeather, v.name);
    }
    notifyListeners();
  }

  /// Whether the camera level has had the camera before: then it starts
  /// the camera straight away rather than explaining first.
  bool get cameraAllowed => _prefs.getBool(_kCameraAllowed) ?? false;

  Future<void> setCameraAllowed(bool allowed) =>
      _prefs.setBool(_kCameraAllowed, allowed);

  /// The user's eye height for the Height tool, metres.
  double get eyeHeight => _prefs.getDouble(_kEyeHeight) ?? defaultEyeHeight;

  /// A typical adult's eye height, metres.
  static const defaultEyeHeight = 1.6;

  Future<void> setEyeHeight(double metres) async {
    await _prefs.setDouble(_kEyeHeight, metres);
    notifyListeners();
  }

  Future<void> setLevelStyle(LevelStyle v) async {
    _levelStyle = v;
    notifyListeners();
    await _prefs.setString(_kLevelStyle, v.name);
  }
}
