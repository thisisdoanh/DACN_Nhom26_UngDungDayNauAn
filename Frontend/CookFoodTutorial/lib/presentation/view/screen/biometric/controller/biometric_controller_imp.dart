import 'dart:io';
import 'dart:js_interop_unsafe';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tutorial/common/utils/app_utils.dart';
import 'package:tutorial/data/share_preference_utils.dart';
import 'package:tutorial/presentation/view/resources/app_key.dart';

import '../biometric.src.dart';
import '../enums/support_state_enum.dart';

class BiometricControllerImp extends BiometricController {
  @override
  void onInit() async {
    await checkBiometricSupport();
    if (supportState.value == SupportState.supported) {
      await checkBiometric();
      await checkAccount();
    }
    super.onInit();
  }

  @override
  void onClose() {
    passwordController.dispose();
    passwordFocus.dispose();
    super.onClose();
  }

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> checkBiometric() async {
    try {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          biometric.value = Biometric.faceId;
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          biometric.value = Biometric.fingerprint;
        } else {
          biometric.value = Biometric.none;
        }
      } else if (Platform.isAndroid) {
        if (availableBiometrics.contains(BiometricType.strong)) {
          biometric.value = Biometric.fingerprint;
        } else if (availableBiometrics.contains(BiometricType.weak)) {
          biometric.value = Biometric.faceId;
        } else {
          biometric.value = Biometric.none;
        }
      } else {
        biometric.value = Biometric.fingerprint;
      }
    } on PlatformException {
      biometric.value = Biometric.none;
    }
  }

  @override
  Future<void> authCheck({required Widget child}) async {
    showPopupBiometricSupport(
        func: () => startBioMetricAuth("chẳng hiểu", child));
  }

  Future<void> checkBiometricSupport() async {
    try {
      bool isSupported = await auth.isDeviceSupported();
      bool canCheckBiometrics = await auth.canCheckBiometrics;

      if (isSupported) {
        if (canCheckBiometrics) {
          supportState.value = SupportState.supported;
        } else {
          supportState.value = SupportState.notSetUp;
        }
      } else {
        supportState.value = SupportState.unsupported;
      }
    } on PlatformException {
      supportState.value = SupportState.unknown;
    }
  }

  Future<void> startBioMetricAuth(String message, Widget child) async {
    try {
      bool didAuthenticate = await auth.authenticate(
          localizedReason: message,
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true));
      if (didAuthenticate) {
        Get.bottomSheet(child);
      } else {
        showToast('Xác thực không thành công!');
      }
    } on PlatformException {
      if (kDebugMode) {
        print("Error!");
        showToast('Xác thực không thành công!');
      }
    }
  }

  @override
  Future<void> checkPassword() async {
    wrongPassword.value = false;
    // await AppInfor.getUsenamePassword(
    //   keyUserName: AppKey.keyLoginUserName,
    //   keyPassword: AppKey.keyLoginPassword,
    // );
    if ('AppInfor.password' == passwordController.text) {
      wrongPassword.value = false;
      //Close Dialog
      Get.back();

      await manageBiometricAccount(newAccount: AppInfor.userName).then((_) {
        checkSetBiometric.value = !checkSetBiometric.value;
      });
    } else {
      wrongPassword.value = true;
    }
    passwordController.clear();
  }

  Future<bool> checkAccount() async {
    // await AppInfor.getUsenamePassword(
    //   keyUserName: AppKey.keyLoginUserName,
    //   keyPassword: AppKey.keyLoginPassword,
    // );
    final savedAccount = PreferenceUtils.getString(AppKey.keyBiometricAccount);
    checkSetBiometric.value =
        savedAccount == PreferenceUtils.getString(AppKey.keyAccount);
    return checkSetBiometric.value;
  }

  Future<void> manageBiometricAccount({required String newAccount}) async {
    final savedAccount =
        PreferenceUtils.getString(AppKey.keyBiometricAccount) ?? "";
    if (savedAccount == newAccount) {
      await PreferenceUtils.remove(AppKey.keyBiometricAccount);
    } else {
      PreferenceUtils.setString(
           AppKey.keyBiometricAccount,  newAccount);
    }
  }

  @override
  void showPopupBiometricSupport({required VoidCallback func}) {
    switch (supportState.value) {
      case SupportState.supported:
        return func();
      case SupportState.notSetUp:
        return ShowPopup.showDialogNotification(
            LocaleKeys.biometric_noBiometric.tr);
      case SupportState.unsupported:
        return ShowPopup.showDialogNotification(
            LocaleKeys.biometric_noSupportBiometric.tr);
      default:
        return ShowPopup.showDialogNotification(
            LocaleKeys.biometric_unknownError.tr);
    }
  }
}
