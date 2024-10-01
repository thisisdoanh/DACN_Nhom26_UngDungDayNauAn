import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_controller.dart';

class AppBaseController extends GetxController {
  late BuildContext context;

  RxBool isShowLoading = false.obs;

  final AppController appController = Get.find<AppController>();

  void showLoading() {
    isShowLoading.value = true;
  }

  void hideLoading() {
    isShowLoading.value = false;
  }

  void hideKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}
