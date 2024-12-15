import 'dart:math';

import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';

class SuggestFoodController extends AppBaseController {
  final RxList<RecipeModel> listRecipeTemp = <RecipeModel>[].obs;

  @override
  void onInit() async {
    showLoading();
    await 1.seconds.delay();
    listRecipeTemp.assignAll(createShuffledList(appController.listRecipe));
    hideLoading();
    super.onInit();
  }

  List<T> createShuffledList<T>(List<T> originalList) {
    final newList = List<T>.from(originalList);
    newList.shuffle(Random());
    return newList;
  }
}
