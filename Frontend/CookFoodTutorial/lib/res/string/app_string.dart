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
  //login
  static const String deliciousCooking = "delicious_cooking";
  static const String cookingIsEasy = "cooking_is_easy";
  static const String login = "login";
  static const String register = "register";
  static const String email = "email";
  static const String password = "password";
  static const String rePassword = "re_password";
  static const String name = "name";
  static const String forgotPass = "forgot_pass";
  static const String doNotHaveAccount = "do_not_have_account";
  static const String doYouForgotPass = "do_you_forgot_pass";
  static const String inputEmail = "input_email";
  static const String inputOTP = "input_otp";
  static const String next = "next";
  static const String doYouHaveAccount = "do_you_have_account";
  static const String valueRequire = "value_require";
  static const String emailNotCorrectFormat = "email_not_correct_format";
  static const String rePasswordNotCorrect = "re_password_not_correct";
  static const String inputYourEmail = "input_your_email";
  static const String verifyAccount = "verify_account";
  static const String verifyAccountSuccess = "verify_account_success";
  static const String enterNewPass = "enter_new_pass";
  static const String enterNewPassToLogin = "enter_new_pass_to_login";
  static const String errorVerifyPass = "error_verify_pass";

//home
  static const String searchRecipe = "search_recipe";
  static const String motsFavorite = "mots_favorite";
  static const String hello = "hello";
  static const String whatWantToCook = "what_want_to_cook";
  static const String suggest = "suggest";
  static const String seeAll = "see_all";
  static const String home = "home";
  static const String favorite = "favorite";
  static const String history = "history";
  static const String help = "help";
  static const String logOut = "log_out";
  static const String personalInfo = "personal_info";
}
