import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_widget.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/widget/app_outline_button.dart';
import 'package:tutorial/res/string/app_string.dart';
import '../../biometric.src.dart';
part 'biometric_setting_widget.dart';

class BiometricSetting extends AppBaseWidget<BiometricController> {
  const BiometricSetting({super.key});

  @override
  BiometricController get controller => Get.put(BiometricControllerImp());

  @override
  Widget buildWidget() {
    return Obx(() => _buildBiometricSetting());
  }
}
