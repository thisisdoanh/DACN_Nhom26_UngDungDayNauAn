import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/widget/filter_widget.dart';

import '../../data/model/category_response_model.dart';

class AppController extends SuperController {
  RxList<CategoryModel> listCategory = RxList();
  RxList<RecipeModel> listRecipe = RxList();
  RxList<RecipeModel> listRecipeHighRating = RxList();
  RxList<RecipeModel> listRecipeRandom = RxList();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> updateLocale(Locale locale) async {
    Get.updateLocale(locale);
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  void showFilterBottomSheet(Function(List<RecipeModel>) onPressApply) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.6, // Giới hạn chiều cao là 90% màn hình
        ),
        child: FilterWidget(
          listCategory: listCategory.toList(),
          onPressApply: onPressApply,
          listRecipe: listRecipe.toList(),
        ),
      ),
      backgroundColor: AppColors.dsGray2D,
      isScrollControlled: true,
    );
  }
}
