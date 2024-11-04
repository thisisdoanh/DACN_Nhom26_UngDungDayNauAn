import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/view/widget/app_bottom_sheet.dart';

class FoodDetailController extends AppBaseController {
  final RxInt curentStart = 5.obs;

  void goToGuideScreen(Widget guideScreen) {
    Get.bottomSheet(
      SDSBottomSheet(
        title: FoodModel.foodTest.foodName,
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
