import 'dart:io';

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
        func: () => startBioMetricAuth("Xác thực sinh trắc học", child));
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
        Get.dialog(child);
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

    if (PreferenceUtils.getString(AppKey.keyPassword)?.trim() ==
        passwordController.text.trim()) {
      wrongPassword.value = false;
      haveBiometric.toggle();
      PreferenceUtils.setBool(AppKey.keyCheckBiometric, haveBiometric.value);
      showToast('Thay đổi cấu hình thành công!');
      Get.back();
    } else {
      wrongPassword.value = true;
    }
    passwordController.clear();
  }

  @override
  void showPopupBiometricSupport({required VoidCallback func}) {
    switch (supportState.value) {
      case SupportState.supported:
        return func();

      case SupportState.notSetUp:
        showToast(
            'Thiêt bị chưa cài đặt sinh trăc học, hãy vào cài đặt để bật!');
        break;
      case SupportState.unsupported:
        showToast('Thiết bị không hỗ trợ sinh trắc học');
        break;
      default:
        showToast('Không tìm thấy sinh trắc học');
        break;
    }
  }
}
