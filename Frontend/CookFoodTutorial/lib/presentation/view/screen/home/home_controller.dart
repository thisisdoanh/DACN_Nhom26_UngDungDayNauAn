import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_log.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/route/app_route.dart';

import '../../../../data/model/recipe_response_model.dart';

class HomeController extends AppBaseController {
  RxList<RecipeModel> listHighRating = RxList();
  RxList<RecipeModel> listRandom = RxList();

  @override
  void onInit() {
    listHighRating.value = appController.listRecipe
        .toList()
        .sorted(
          (a, b) => (b.rating ?? 5).compareTo(a.rating ?? 5),
        )
        .take(5)
        .toList();
    listRandom.value = (appController.listRecipe.toList()..shuffle()).take(10).toList();
    super.onInit();
  }

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
