import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/base/app_controller.dart';

import '../biometric.src.dart';
import '../enums/support_state_enum.dart';

abstract class BiometricController extends AppBaseController {
  final RxBool wrongPassword = RxBool(false);
  final Rx<SupportState> supportState = Rx(SupportState.unknown);
  final Rxn<List<BiometricType>> availableBiometrics = Rxn();
  var passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();
  final Rx<Biometric> biometric = Rx(Biometric.fingerprint);
  final RxBool haveBiometric = Get.find<AppController>().haveBiometric;
  final RxBool isHidePass = true.obs;

  Future<void> authCheck({required Widget child});

  Future<void> checkPassword();

  void showPopupBiometricSupport({required VoidCallback func});
}
