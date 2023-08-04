import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferenceHelper? _instance;
  static SharedPreferences? _prefs;

  SharedPreferenceHelper._internal();

  static Future<SharedPreferenceHelper> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferenceHelper._internal();
      await _initPreference();
    }
    return _instance!;
  }

  static Future<void> _initPreference() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ============================== KEYS
  static const String _keyLoggedIn = "logged_in";

  static Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(_keyLoggedIn, value);
  }

  static Future<bool> getLoggedIn() async {
    return _prefs?.getBool(_keyLoggedIn) ?? false;
  }
}
