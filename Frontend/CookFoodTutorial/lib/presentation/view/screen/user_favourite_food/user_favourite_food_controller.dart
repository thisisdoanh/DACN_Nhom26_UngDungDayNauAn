import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';

class UserFavoriteFoodController extends AppBaseController {
  final RxList<RecipeModel> listRecipe = <RecipeModel>[].obs;
  final RxList<RecipeModel> listRecipeFilter = <RecipeModel>[].obs;

  @override
  void onInit() async {
    listRecipe.value = appController.listRecipeUserFavorite.toList();
    listRecipeFilter.value = listRecipe.toList();
    showLoading();
    await 1.seconds.delay();
    hideLoading();
    super.onInit();
  }
}
