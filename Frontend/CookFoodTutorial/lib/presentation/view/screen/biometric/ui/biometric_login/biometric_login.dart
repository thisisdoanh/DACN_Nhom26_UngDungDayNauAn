import 'package:flutter/material.dart';
import 'package:sds_core/core_src.dart';
import 'package:sds_shared_dep/sds_shared_dep.dart';
import '../../../account_src.dart';

class BiometricLogin extends BaseGetWidget<BiometricController> {
  final VoidCallback func;
  const BiometricLogin({required this.func, super.key});

  @override
  BiometricController get controller => Get.put(BiometricControllerImp());

  @override
  Widget buildWidgets() {
    return Obx(
      () {
        return SDSElevatedButton(
          '',
          () => controller.showPopupBiometricSupport(func: func),
          childBtn: SvgPicture.asset(
            controller.biometric.value.iconSvg,
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            width: AppDimens.sizeImageSmall,
          ),
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(ShareDimens.radius4),
          ),
          width: ShareDimens.btnMedium,
        );
      },
    );
  }
}
