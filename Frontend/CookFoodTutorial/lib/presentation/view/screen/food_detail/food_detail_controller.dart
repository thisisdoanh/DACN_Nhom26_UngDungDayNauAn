import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/view/widget/app_bottom_sheet.dart';

class FoodDetailController extends AppBaseController {
  final RxInt curentStart = 5.obs;
  RecipeModel recipeModel = RecipeModel();

  @override
  void onInit() async {
    if (Get.arguments is RecipeModel) {
      recipeModel = Get.arguments;
    }
    showLoading();
    await 1.seconds.delay();
    hideLoading();
    super.onInit();
  }

  void goToGuideScreen(Widget guideScreen) {
    Get.bottomSheet(
      SDSBottomSheet(
        title: recipeModel.recipeName ?? '',
        body: guideScreen,
        miniSizeHeight: Get.height * 0.8,
      ),
      isScrollControlled: true,
    );
  }

  void goToRatingScreen(Widget ratingScreen) {
    Get.dialog(ratingScreen);
  }

  void rating(int index) {
    curentStart.value = index;
  }
}
