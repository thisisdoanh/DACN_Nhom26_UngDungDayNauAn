import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';

class FavoriteFoodController extends AppBaseController {
  final RxList<RecipeModel> listRecipeTemp = <RecipeModel>[].obs;

  @override
  void onInit() async {
    showLoading();
    listRecipeTemp.value = appController.listRecipeUserFavorite.toList();
    await 1.seconds.delay();
    hideLoading();
    super.onInit();
  }
}
