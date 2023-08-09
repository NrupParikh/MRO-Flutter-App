import 'package:shared_preferences/shared_preferences.dart';

class MroSharedPreference {
  static final MroSharedPreference _instance = MroSharedPreference._internal();

  factory MroSharedPreference() => _instance;

  MroSharedPreference._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ==================== SET

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  // Remove particular preference data
  Future<bool> remove(String key) async => await _prefs.remove(key);

  // Remove All Preference Data
  Future<bool> clear() async => await _prefs.clear();

  // ===================== GET

  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  double getDouble(String key, {double defaultValue = 0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }
}
