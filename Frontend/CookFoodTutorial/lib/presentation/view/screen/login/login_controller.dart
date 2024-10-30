import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutorial/common/utils/app_log.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/route/app_route.dart';
import 'package:tutorial/res/string/app_string.dart';

import '../../../../common/utils/app_utils.dart';

class LoginController extends AppBaseController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  RxBool isHidePass = true.obs;
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  RxString firstErrorText = "".obs;
  RxString secondErrorText = "".obs;
  void onPressLogin() {
    AppLog.info("onPressLogin");
    // _validate();
    Get.offAllNamed(AppRoute.homeScreen);
  }

  void onPressShowPassword() {
    AppLog.info("onPressShowPassword");
    isHidePass.value = !isHidePass.value;
  }

  void onPressForgotPass() {
    Get.toNamed(AppRoute.forgotPassScreen);
  }

  void onPressRegister() {
    AppLog.info("onPressRegister");
    Get.toNamed(AppRoute.registerScreen);
  }

  void onPressLoginWithGoogle() async {
    AppLog.info("onPressLoginWithGoogle");
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
    try {
      var user = await googleSignIn.signIn();
      AppLog.info("User info: $user");

      if (user != null) {
        Get.offAllNamed(AppRoute.homeScreen);
      }
    } catch (e) {
      AppLog.error(e, tag: "onPressLoginWithGoogle");
    }
  }

  bool _validate() {
    firstErrorText.value = validateEmailAndReturnValue(emailTextEditingController.text.trim());
    secondErrorText.value =
        validateValueNotEmpty(passwordTextEditingController.text.trim(), StringConstants.password.tr);

    if (firstErrorText.value.isNotEmpty || secondErrorText.value.isNotEmpty) {
      return false;
    }

    return true;
  }

  void onFirstInputChange(String text) {
    if (firstErrorText.value.isNotEmpty) {
      firstErrorText.value = '';
    }
  }

  void onSecondInputChange(String text) {
    if (secondErrorText.value.isNotEmpty) {
      secondErrorText.value = '';
    }
  }
}
