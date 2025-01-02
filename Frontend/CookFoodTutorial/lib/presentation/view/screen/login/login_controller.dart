import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tutorial/common/utils/app_log.dart';
import 'package:tutorial/data/model/user_token_model.dart';
import 'package:tutorial/data/provider/api_service.dart';
import 'package:tutorial/data/share_preference_utils.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/route/app_route.dart';
import 'package:tutorial/presentation/view/resources/app_key.dart';
import 'package:tutorial/presentation/view/widget/dialog/show_app_dialog.dart';
import 'package:tutorial/res/string/app_string.dart';

import '../../../../common/utils/app_utils.dart';

class LoginController extends AppBaseController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  RxBool isHidePass = true.obs;
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  RxString firstErrorText = "".obs;
  RxString secondErrorText = "".obs;
  final LocalAuthentication auth = LocalAuthentication();
  final RxString biometricAccount = RxString("");
  final passSetBiometricController = TextEditingController();
  bool get hasAccount => PreferenceUtils.getString(AppKey.keyAccount) != null;

  @override
  void onInit() async {
    if (hasAccount) {
      emailTextEditingController.text =
          PreferenceUtils.getString(AppKey.keyAccount) ?? '';
    }
    if (appController.listRecipe.isEmpty &&
        appController.listCategory.isEmpty) {
      // //showLoading();
      // await fetchData();
      // //hideLoading();
    }

    super.onInit();
  }

  Future onPressLogin({bool isBiometric = false}) async {
    AppLog.info("onPressLogin");
    if (_validate()) {
      showLoading();
      UserToken? userToken = await ApiService.getVerifyAccount(
        mail: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      );
      hideLoading();
      saveInfo();

      if (userToken == null || userToken.data == null) {
        if (context.mounted) {
          showAppDialog(
            context,
            "Lỗi",
            "Tài khoản hoặc mật khẩu không đúng, vui lòng thử lại sau",
          );
        }
      } else {
        if (isBiometric) {
          PreferenceUtils.setBool(AppKey.keyCheckBiometric, true);
          showToast('Xác thực sinh trắc học thành công');
        }
        Get.offAllNamed(AppRoute.homeScreen);
      }
    }
  }

  void saveInfo() {
    PreferenceUtils.setString(
      AppKey.keyAccount,
      emailTextEditingController.text.trim(),
    );
    PreferenceUtils.setString(
      AppKey.keyPassword,
      passwordTextEditingController.text.trim(),
    );
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
    firstErrorText.value =
        validateEmailAndReturnValue(emailTextEditingController.text.trim());
    secondErrorText.value = validateValueNotEmpty(
        passwordTextEditingController.text.trim(), StringConstants.password.tr);

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

  Future<void> biometricAuth({required Function func}) async {
    try {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Xác thực',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (didAuthenticate) {
        await func();
      } else {
        showToast('Xác thực sinh trắc học thất bại!');
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error: ${e.message}");
        showToast('Xác thực sinh trắc học thất bại: ${e.message}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
        showToast('Có lỗi xảy ra khi xác thực sinh trắc học');
      }
    }
  }
}
