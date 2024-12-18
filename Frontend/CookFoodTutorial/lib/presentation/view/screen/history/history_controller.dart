import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';

class HistoryController extends AppBaseController {
  final RxList<RecipeModel> listRecipe = <RecipeModel>[].obs;
  final RxList<RecipeModel> listRecipeFilter = <RecipeModel>[].obs;

  @override
  void onInit() async {
    if (appController.listRecipeHistory.isEmpty) {
      appController.listRecipeHistory.addAll([
        appController.listRecipe[0],
        appController.listRecipe[2],
        appController.listRecipe[2],
        appController.listRecipe[5],
        appController.listRecipe[6],
        appController.listRecipe[7],
      ]);
    }
    listRecipe.value = appController.listRecipeHistory.toList();
    listRecipeFilter.value = listRecipe.toList();
    showLoading();
    await 1.seconds.delay();
    hideLoading();
    super.onInit();
  }
}
