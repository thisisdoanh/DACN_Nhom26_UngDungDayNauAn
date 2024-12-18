import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';

import '../biometric.src.dart';

abstract class BiometricController extends AppBaseController {
  final RxBool checkSetBiometric = RxBool(false);
  final RxBool wrongPassword = RxBool(false);
  final Rx<SupportState> supportState = Rx(SupportState.unknown);
  final Rxn<List<BiometricType>> availableBiometrics = Rxn();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FocusNode passwordFocus = FocusNode();
  final Rx<Biometric> biometric = Rx(Biometric.fingerprint);

  Future<void> authCheck({required Widget child});

  Future<void> checkPassword();

  void showPopupBiometricSupport({required VoidCallback func});
}
