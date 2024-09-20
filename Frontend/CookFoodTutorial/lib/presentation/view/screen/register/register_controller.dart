import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_log.dart';

import '../../../../common/utils/app_utils.dart';
import '../../../../res/string/app_string.dart';
import '../../../base/app_base_controller.dart';

class RegisterController extends AppBaseController {
  RxBool isShowPass = false.obs;
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
  }

  void onPressLogin() {
    AppLog.info("onPressLogin");
    Get.back();
  }

  void onPressRegister() {
    AppLog.info("onPressRegister");
  }

  bool _validate() {
    bool isValid = true;

    if (nameTextEditingController.text.trim().isEmpty) {
      firstErrorText.value = StringConstants.valueRequire.tr.trParams({
        "value": StringConstants.name.tr,
      });
      isValid = false;
    }

    if (emailTextEditingController.text.trim().isEmpty) {
      secondErrorText.value = StringConstants.valueRequire.tr.trParams({
        "value": StringConstants.email.tr,
      });
      isValid = false;
    } else {
      if (!checkValidEmail(emailTextEditingController.text.trim())) {
        secondErrorText.value = StringConstants.emailNotCorrectFormat.tr;
        isValid = false;
      }
    }

    if (passwordTextEditingController.text.isEmpty) {
      thirdErrorText.value = StringConstants.valueRequire.tr.trParams({
        "value": StringConstants.password.tr,
      });
      isValid = false;
    }

    if (rePasswordTextEditingController.text.isEmpty) {
      fourthErrorText.value = StringConstants.valueRequire.tr.trParams({
        "value": StringConstants.rePassword.tr,
      });
      isValid = false;
    }

    if (rePasswordTextEditingController.text.trim().isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty &&
        rePasswordTextEditingController.text == passwordTextEditingController.text) {
      fourthErrorText.value = StringConstants.rePasswordNotCorrect.tr;
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
