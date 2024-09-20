import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/screen/splash/splash_controller.dart';

class SplashScreen extends AppBaseScreen<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget buildWidget() {
    return AppContainer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AppImageWidget.asset(
            path: AppImage.imgBgFood,
            height: Get.height,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          AppImageWidget.asset(
            path: AppImage.imgLogo,
            width: Get.width / 3,
          ),
          Obx(
            () => Positioned(
              bottom: 16.h,
              child: Text(
                controller.version.value,
                style: AppTextTheme.bodyMedium(
                  AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
