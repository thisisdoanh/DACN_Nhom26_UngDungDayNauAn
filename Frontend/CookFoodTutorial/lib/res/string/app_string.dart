import 'package:get/get.dart';

import 'english_string.dart';
import 'vi_string.dart';

class AppString extends Translations {
  static const String localeCodeEn = 'en_US';
  static const String localeCodeVi = 'vi_VN';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeEn: englishString,
        localeCodeVi: viString,
      };

  static String getString(String key) {
    Map<String, String> selectedLanguage = _getMapString();
    String text = key;
    if (selectedLanguage.containsKey(key) && selectedLanguage[key] != null) {
      text = selectedLanguage[key] ?? key;
    }

    return text;
  }

  static Map<String, String> _getMapString() {
    switch (Get.locale.toString()) {
      case localeCodeEn:
        return englishString;

      default:
        return viString;
    }
  }
}

class StringConstants {
  static const String deliciousCooking = "delicious_cooking";
  static const String cookingIsEasy = "cooking_is_easy";
  static const String login = "login";
  static const String register = "register";
  static const String email = "email";
  static const String password = "password";
  static const String rePassword = "re_password";
  static const String username = "username";
}
