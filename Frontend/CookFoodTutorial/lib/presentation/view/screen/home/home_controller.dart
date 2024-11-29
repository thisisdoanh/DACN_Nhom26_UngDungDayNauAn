import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/route/app_route.dart';

class HomeController extends AppBaseController {
  void onPressHome() {
    Get.offAllNamed(AppRoute.homeScreen);
  }

  void onPressFavorite() {
    Get.toNamed(AppRoute.favouriteFoodSreen);
  }

  void onPressHistory() {
    // Get.toNamed(AppRoute.favouriteFoodSreen);
  }
  void onPressLogout() {}
}
