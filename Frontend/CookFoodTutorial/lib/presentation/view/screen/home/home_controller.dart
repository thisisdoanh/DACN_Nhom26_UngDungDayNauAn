import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_log.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/route/app_route.dart';

class HomeController extends AppBaseController {
  void onPressHome() {
    Get.offAllNamed(AppRoute.homeScreen);
  }

  void onPressFavorite() {
    AppLog.info(appController.listCategory.toJson(), tag: "listCategory");
    AppLog.info(appController.listRecipe.toJson(), tag: "listRecipe");
    Get.toNamed(AppRoute.favouriteFoodSreen);
  }

  void onPressHistory() {
    // Get.toNamed(AppRoute.favouriteFoodSreen);
  }
  void onPressLogout() {}
}
