import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_utils.dart';
import 'package:tutorial/data/provider/api_service.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/route/app_route.dart';
import 'package:tutorial/presentation/view/screen/forgot_password/ui/input_otp_screen.dart';
import 'package:tutorial/presentation/view/screen/forgot_password/ui/verify_acc_success_screen.dart';
import 'package:tutorial/res/string/app_string.dart';

class ForgotPassController extends AppBaseController {
  final TextEditingController emailTextEditingController =
      TextEditingController();

  final RxString emailErrorText = "".obs;

  RxList<String> otpValues = RxList(List.generate(4, (index) => ''));

  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  final RxBool isHidePass = true.obs;
  final RxBool isHideVerifyPass = true.obs;
  final RxBool isActiveBtnOtp = false.obs;
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController verifyPasswordCtrl = TextEditingController();
  final RxString passwordError = "".obs;
  final RxString verifyPassError = "".obs;

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

  void forgotPass() async {
    if (_validateEmail()) {
      showLoading();
      final isSuccess =
          await ApiService.forgotPass(emailTextEditingController.text.trim());
      hideLoading();
      if (isSuccess) {
        Get.to(const InputOtpScreen());
      } else {
        showToast('Gửi mail thất bại, hãy thử lại sau!');
      }
    }
  }

  void verifyAcc() async {
    if (_validatePass()) {
      showLoading();
      final isSuccess = await ApiService.verifyAcc(
        emailTextEditingController.text.trim(),
        verifyPasswordCtrl.text.trim(),
      );
      hideLoading();
      if (isSuccess) {
        Get.toNamed(AppRoute.homeScreen);
        showToast('Đổi mật khẩu thành công!');
      } else {
        showToast('Có lỗi xảy ra, vui lòng thử lại!');
      }
    }
  }

  void inputOtp() async {
    if (_validateEmail()) {
      showLoading();
      final isSuccess = await ApiService.inputOtp(
        emailTextEditingController.text.trim(),
        otpValues.fold<String>('', (sum, element) => sum + element),
      );
      hideLoading();
      if (isSuccess) {
        Get.to(const VerifyAccSuccessScreen());
      } else {
        showToast('Otp không đúng hoặc đã tồn tại!');
      }
    }
  }

  void updateOtpValue(int index, String value) {
    otpValues[index] = value;

    isActiveBtnOtp.value = !otpValues.any((value) => value.isEmpty);

    if (value.isNotEmpty) {
      if (index < otpValues.length - 1) {
        focusNodes[index + 1].requestFocus();
      }
    } else {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
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
