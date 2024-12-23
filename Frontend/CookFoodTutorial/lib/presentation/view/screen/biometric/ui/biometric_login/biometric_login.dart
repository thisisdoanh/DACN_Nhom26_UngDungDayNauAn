import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_widget.dart';
import 'package:tutorial/presentation/view/screen/biometric/biometric.src.dart';
import 'package:tutorial/presentation/view/widget/app_image_widget.dart';

class BiometricLogin extends AppBaseWidget<BiometricController> {
  final VoidCallback func;
  const BiometricLogin({required this.func, super.key});

  @override
  BiometricController get controller => Get.put(BiometricControllerImp());
  @override
  Widget buildWidget() {
    return Obx(
      () {
        return InkWell(
          onTap: () => controller.showPopupBiometricSupport(func: func),
          child: AppImageWidget.asset(
            path: controller.biometric.value.iconSvg,
            height: 28.sp,
            width: 28.sp,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
