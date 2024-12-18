import 'package:flutter/material.dart';
import 'package:sds_core/core_src.dart';
import 'package:sds_shared_dep/sds_shared_dep.dart';

import '../../biometric.src.dart';
part 'biometric_setting_widget.dart';

class BiometricSetting extends BaseGetWidget<BiometricController> {
  const BiometricSetting({super.key});

  @override
  BiometricController get controller => Get.put(BiometricControllerImp());

  @override
  Widget buildWidgets() {
    return Obx(() => _buildBiometricSetting());
  }
}
