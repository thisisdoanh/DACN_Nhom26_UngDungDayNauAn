import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/utils/app_log.dart';
import 'package:tutorial/common/utils/app_utils.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/data/provider/api_service.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/route/app_route.dart';

class HomeController extends AppBaseController {
  @override
  void onInit() async {
    await fetchData();

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
      getListRecipe(),
      getListCategory(),
    ]);
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
    AppLog.info(appController.listCategory.toJson(), tag: "listCategory");
    AppLog.info(appController.listRecipe.toJson(), tag: "listRecipe");
    Get.toNamed(AppRoute.favouriteFoodSreen);
  }

  void onPressHistory() {
    // Get.toNamed(AppRoute.favouriteFoodSreen);
  }

  void onPressLogout() {}

  void onPressItemRecipe(RecipeModel? recipeModel) {
    if (recipeModel == null) {
      showToast("Có lỗi khi chọn món ăn. Vui lòng chọn lại!");
      return;
    }
    Get.toNamed(AppRoute.foodDetailScreen, arguments: {
      "recipe_model": recipeModel,
    });
  }
}
