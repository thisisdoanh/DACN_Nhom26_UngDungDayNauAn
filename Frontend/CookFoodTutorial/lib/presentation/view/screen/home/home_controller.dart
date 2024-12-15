import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_utils.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/data/model/user_info_response.dart';
import 'package:tutorial/data/provider/api_service.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/route/app_route.dart';

import '../../../../common/utils/app_log.dart';

class HomeController extends AppBaseController {
  @override
  void onInit() async {
    // await fetchData();

    appController.listRecipeHighRating.value = appController.listRecipe
        .toList()
        .sorted(
          (a, b) => (b.rating ?? 5).compareTo(a.rating ?? 5),
        )
        .toList();

    appController.listRecipeRandom.value = (appController.listRecipe.toList()..shuffle()).toList();
    super.onInit();
  }

  Future fetchData() async {
    await Future.wait([
      getUserInfo(),
      getListRecipe(),
      getListCategory(),
    ]);
  }

  Future getUserInfo() async {
    appController.userInfo = await ApiService.getUserInfo() ?? UserInfo();
    appController.listRecipeUserFavorite.value = await ApiService.getRecipeFavorite(appController.userInfo.id ?? 1);
    AppLog.info(appController.listRecipeUserFavorite.value, tag: "appController.listRecipeUserFavorite.value");
  }

  Future getListRecipe() async {
    final listRecipe = await ApiService.getRecipes();
    appController.listRecipe.assignAll(listRecipe..removeAt(0));
  }

  Future getListCategory() async {
    final listCategory = await ApiService.getCategories();
    appController.listCategory.assignAll(listCategory);
  }

  void onPressHome() {
    Get.offAllNamed(AppRoute.homeScreen);
  }

  void onPressFavorite() {
    Get.toNamed(AppRoute.favouriteFoodSreen);
  }

  void onPressUserFavorite() {
    Get.toNamed(AppRoute.userFavoriteScreen);
  }

  void onPressHistory() {
    Get.toNamed(AppRoute.historyScreen);
  }

  void onPressLogout() {}

  void onPressItemRecipe(RecipeModel? recipeModel) {
    if (recipeModel == null) {
      showToast("Có lỗi khi chọn món ăn. Vui lòng chọn lại!");
      return;
    }
    appController.listRecipeHistory.add(recipeModel);
    Get.toNamed(AppRoute.foodDetailScreen, arguments: {
      "recipe_model": recipeModel,
    });
  }
}
