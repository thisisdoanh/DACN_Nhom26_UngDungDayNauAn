import 'package:shared_preferences/shared_preferences.dart';

import '../common/utils/app_log.dart';

class PreferenceUtils {
  static final PreferenceUtils _instance = PreferenceUtils._internal();

  factory PreferenceUtils() => _instance;

  PreferenceUtils._internal();

  static late final SharedPreferences _sharedPreferences;

  // call this method from iniState() function of mainApp().
  static Future<void> init() async {
    AppLog.info("Share preference init");

    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// sets
  static Future<bool> setBool(String key, bool value) async {
    final answer = await _sharedPreferences.setBool(key, value);

    if (answer) {
      AppLog.debug("set bool success: [$value] -> [$key]", tag: "Shared Preferences");
    } else {
      AppLog.debug("set bool fail", tag: "Shared Preferences");
    }

    return answer;
  }

  static Future<bool> setDouble(String key, double value) async {
    final answer = await _sharedPreferences.setDouble(key, value);

    if (answer) {
      AppLog.debug("set double success: [$value] -> [$key]", tag: "Shared Preferences");
    } else {
      AppLog.debug("set double fail", tag: "Shared Preferences");
    }

    return answer;
  }

  static Future<bool> setInt(String key, int value) async {
    final answer = await _sharedPreferences.setInt(key, value);

    if (answer) {
      AppLog.debug("set int success: [$value] -> [$key]", tag: "Shared Preferences");
    } else {
      AppLog.debug("set int fail", tag: "Shared Preferences");
    }

    return answer;
  }

  static Future<bool> setString(String key, String value) async {
    final answer = await _sharedPreferences.setString(key, value);

    if (answer) {
      AppLog.debug("set string success: [$value] -> [$key]", tag: "Shared Preferences");
    } else {
      AppLog.debug("[$key] -> [$value] fail", tag: "Shared Preferences");
    }

    return answer;
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    final answer = await _sharedPreferences.setStringList(key, value);
    if (answer) {
      AppLog.debug("set list string success: [$value] -> [$key]", tag: "Shared Preferences");
    } else {
      AppLog.debug("set list string [$key] -> [$value] fail", tag: "Shared Preferences");
    }
    return answer;
  }

  /// gets
  static bool? getBool(String key) {
    bool? answer = _sharedPreferences.getBool(key);

    if (answer == null) {
      AppLog.debug("Get bool fails", tag: "Shared Preferences");
    } else {
      AppLog.debug("Get bool: $answer", tag: "Shared Preferences");
    }

    return answer;
  }

  static double? getDouble(String key) {
    double? answer = _sharedPreferences.getDouble(key);

    if (answer == null) {
      AppLog.debug("Get double fails", tag: "Shared Preferences");
    } else {
      AppLog.debug("Get double: $answer", tag: "Shared Preferences");
    }

    return answer;
  }

  static int? getInt(String key) {
    int? answer = _sharedPreferences.getInt(key);

    if (answer == null) {
      AppLog.debug("Get int fails", tag: "Shared Preferences");
    } else {
      AppLog.debug("Get int: $answer", tag: "Shared Preferences");
    }

    return answer;
  }

  static String? getString(String key) {
    String? answer = _sharedPreferences.getString(key);

    if (answer == null) {
      AppLog.debug("Get string fails", tag: "Shared Preferences");
    } else {
      AppLog.debug("Get string: $answer", tag: "Shared Preferences");
    }

    return answer;
  }

  static List<String>? getStringList(String key) => _sharedPreferences.getStringList(key);

  /// delete
  static Future<bool> remove(String key) async => await _sharedPreferences.remove(key);

  static Future<bool> clear() async => await _sharedPreferences.clear();
}
