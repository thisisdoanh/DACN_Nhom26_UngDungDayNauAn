import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';

class FavoriteFoodController extends AppBaseController {
  final RxList<RecipeModel> listRecipe = <RecipeModel>[].obs;

  @override
  void onInit() async {
    showLoading();
    await 1.seconds.delay();
    hideLoading();
    super.onInit();
  }
}
