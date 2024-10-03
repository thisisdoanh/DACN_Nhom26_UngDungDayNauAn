import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_log.dart';

import '../../../../common/utils/app_utils.dart';
import '../../../../res/string/app_string.dart';
import '../../../base/app_base_controller.dart';

class RegisterController extends AppBaseController {
  RxBool isHidePass = true.obs;
  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  final TextEditingController rePasswordTextEditingController = TextEditingController();
  RxString firstErrorText = "".obs;
  RxString secondErrorText = "".obs;
  RxString thirdErrorText = "".obs;
  RxString fourthErrorText = "".obs;
  void onPressShowPassword() {
    AppLog.info("onPressShowPassword");
    isHidePass.value = !isHidePass.value;
  }

  void onPressLogin() {
    AppLog.info("onPressLogin");
    Get.back();
  }

  void onPressRegister() {
    AppLog.info("onPressRegister");
    _validate();
  }

  bool _validate() {
    firstErrorText.value = validateValueNotEmpty(nameTextEditingController.text.trim(), StringConstants.name.tr);
    secondErrorText.value = validateEmailAndReturnValue(emailTextEditingController.text.trim());
    thirdErrorText.value = validateValueNotEmpty(passwordTextEditingController.text, StringConstants.password.tr);
    fourthErrorText.value = validateValueNotEmpty(rePasswordTextEditingController.text, StringConstants.rePassword.tr);

    if (thirdErrorText.value.isEmpty && fourthErrorText.value.isEmpty) {
      fourthErrorText.value =
          validatePasswordAndRePassword(passwordTextEditingController.text, rePasswordTextEditingController.text);
    }

    if (firstErrorText.value.isNotEmpty ||
        secondErrorText.value.isNotEmpty ||
        thirdErrorText.value.isNotEmpty ||
        fourthErrorText.value.isNotEmpty) {
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

  void onThirdInputChange(String text) {
    if (thirdErrorText.value.isNotEmpty) {
      thirdErrorText.value = '';
    }
  }

  void onFourthInputChange(String text) {
    if (fourthErrorText.value.isNotEmpty) {
      fourthErrorText.value = '';
    }
  }
}
