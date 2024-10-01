import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_utils.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/view/screen/forgot_password/forgot_pass_screen/input_otp_screen.dart';
import 'package:tutorial/presentation/view/screen/forgot_password/forgot_pass_screen/verify_acc_success_screen.dart';
import 'package:tutorial/presentation/view/screen/login/login_screen.dart';
import 'package:tutorial/res/string/app_string.dart';

class ForgotPassController extends AppBaseController {
  final TextEditingController emailTextEditingController =
      TextEditingController();

  RxString emailErrorText = "".obs;

  RxList<String> otpValues = RxList(List.generate(4, (index) => ''));

  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  RxBool isShowPass = false.obs;
  RxBool isShowVerifyPass = false.obs;
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController verifyPasswordCtrl = TextEditingController();
  RxString passwordError = "".obs;
  RxString verifyPassError = "".obs;

  void onEmailInputChange(String text) {
    if (emailErrorText.value.isNotEmpty) {
      emailErrorText.value = '';
    }
  }

  bool _validateEmail() {
    bool isValid = true;
    if (emailTextEditingController.text.trim().isEmpty) {
      emailErrorText.value = StringConstants.valueRequire.tr.trParams({
        "value": StringConstants.email.tr,
      });
      isValid = false;
    } else {
      if (!checkValidEmail(emailTextEditingController.text.trim())) {
        emailErrorText.value = StringConstants.emailNotCorrectFormat.tr;
        isValid = false;
      }
    }
    return isValid;
  }

  bool _validatePass() {
    bool isValid = true;
    if (passwordCtrl.text.trim().isEmpty) {
      passwordError.value = StringConstants.valueRequire.tr.trParams({
        "value": StringConstants.password.tr,
      });
      isValid = false;
    }
    if (passwordCtrl.text.trim() != verifyPasswordCtrl.text.trim()) {
      verifyPassError.value = StringConstants.errorVerifyPass.tr;
      isValid = false;
    }
    return isValid;
  }

  void forgotPass() {
    if (!_validateEmail()) {
      Get.to(const InputOtpScreen());
    }
  }

  forgotPassSuccess() {
    if (_validatePass()) {
      Get.to(const LoginScreen());
    }
  }

  void verifyAccount() {
    Get.to(const VerifyAccSuccessScreen());
  }

  void updateOtpValue(int index, String value) {
    otpValues[index] = value;

    if (value.isNotEmpty) {
      if (index < otpValues.length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        showAboutDialog(
          context: context,
        );
      }
    }
  }

  void onChangePass(String text) {
    if (passwordError.value.isNotEmpty) {
      passwordError.value = '';
    }
  }

  void onChangeVerifyPass(String text) {
    if (verifyPassError.value.isNotEmpty) {
      verifyPassError.value = '';
    }
  }
}
