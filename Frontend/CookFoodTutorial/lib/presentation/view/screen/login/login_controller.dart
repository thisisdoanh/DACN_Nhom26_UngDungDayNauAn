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
  RxBool isShowPass = false.obs;
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  RxString firstErrorText = "".obs;
  RxString secondErrorText = "".obs;
  void onPressLogin() {
    AppLog.info("onPressLogin");
    _validate();
  }

  void onPressShowPassword() {
    AppLog.info("onPressShowPassword");
    isShowPass.value = !isShowPass.value;
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
    } catch (e) {
      AppLog.error(e, tag: "onPressLoginWithGoogle");
    }
  }

  bool _validate() {
    bool isValid = true;
    if (emailTextEditingController.text.trim().isEmpty) {
      firstErrorText.value = StringConstants.valueRequire.tr.trParams({
        "value": StringConstants.email.tr,
      });
      isValid = false;
    } else {
      if (!checkValidEmail(emailTextEditingController.text.trim())) {
        firstErrorText.value = StringConstants.emailNotCorrectFormat.tr;
        isValid = false;
      }
    }
    if (passwordTextEditingController.text.trim().isEmpty) {
      secondErrorText.value = StringConstants.valueRequire.tr.trParams({
        "value": StringConstants.password.tr,
      });
      isValid = false;
    }
    return isValid;
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
