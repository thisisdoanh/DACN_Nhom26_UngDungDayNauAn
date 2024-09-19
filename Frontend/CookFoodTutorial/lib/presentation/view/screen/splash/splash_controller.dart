import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tutorial/presentation/route/app_route.dart';

import '../../../base/app_base_controller.dart';

class SplashController extends AppBaseController {
  RxString version = ''.obs;

  @override
  void onReady() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    nextScreen();
    super.onReady();
  }

  void nextScreen() async {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.offAndToNamed(AppRoute.loginScreen);
      },
    );
  }
}
