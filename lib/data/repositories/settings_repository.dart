import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/angles.dart';

enum AngleUnit { degrees, percent }

/// How the home screen shows the tools.
enum HomeLayout { list, grid }

/// How the Level tool draws its instrument: the round dial or a classic
/// spirit-level tube.
enum LevelStyle { dial, tube }

/// User preferences and level calibration, persisted across launches.
class SettingsRepository extends ChangeNotifier {
  SettingsRepository._(this._prefs)
    : _flatRef = _readVec(_prefs) ?? Vec3.up,
      _edgeOffset = _prefs.getDouble(_kEdgeOffset) ?? 0,
      _haptics = _prefs.getBool(_kHaptics) ?? true,
      _unit =
          AngleUnit.values.asNameMap()[_prefs.getString(_kUnit)] ??
          AngleUnit.degrees,
      _themeMode =
          ThemeMode.values.asNameMap()[_prefs.getString(_kThemeMode)] ??
          ThemeMode.system,
      _homeLayout =
          HomeLayout.values.asNameMap()[_prefs.getString(_kHomeLayout)] ??
          HomeLayout.list,
      _levelStyle =
          LevelStyle.values.asNameMap()[_prefs.getString(_kLevelStyle)] ??
          LevelStyle.dial;

  static Future<SettingsRepository> load() async =>
      SettingsRepository._(await SharedPreferences.getInstance());

  static const _kFlatRef = 'flatRef';
  static const _kEdgeOffset = 'edgeOffset';
  static const _kHaptics = 'haptics';
  static const _kUnit = 'unit';
  static const _kThemeMode = 'themeMode';
  static const _kHomeLayout = 'homeLayout';
  static const _kLevelStyle = 'levelStyle';

  final SharedPreferences _prefs;
  Vec3 _flatRef;
  double _edgeOffset;
  bool _haptics;
  AngleUnit _unit;
  ThemeMode _themeMode;
  HomeLayout _homeLayout;
  LevelStyle _levelStyle;

  /// Gravity direction (device frame) measured on a known-flat surface.
  Vec3 get flatRef => _flatRef;

  /// Edge-mode deviation measured on a known-level surface.
  double get edgeOffset => _edgeOffset;
  bool get haptics => _haptics;
  AngleUnit get unit => _unit;

  /// Follow the system, or force light / dark.
  ThemeMode get themeMode => _themeMode;

  /// List (the default) or grid on the home screen.
  HomeLayout get homeLayout => _homeLayout;

  /// Dial (the default) or tube in the Level tool.
  LevelStyle get levelStyle => _levelStyle;
  bool get isCalibrated => !identical(_flatRef, Vec3.up) || _edgeOffset != 0;

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

  Future<void> resetCalibration() async {
    _flatRef = Vec3.up;
    _edgeOffset = 0;
    notifyListeners();
    await _prefs.remove(_kFlatRef);
    await _prefs.remove(_kEdgeOffset);
  }

  Future<void> setHaptics(bool v) async {
    _haptics = v;
    notifyListeners();
    await _prefs.setBool(_kHaptics, v);
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

  Future<void> setLevelStyle(LevelStyle v) async {
    _levelStyle = v;
    notifyListeners();
    await _prefs.setString(_kLevelStyle, v.name);
  }
}
