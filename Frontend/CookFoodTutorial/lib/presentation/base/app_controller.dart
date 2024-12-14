import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/data/model/user_info_response.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/widget/filter_widget.dart';

import '../../data/model/category_response_model.dart';

class AppController extends SuperController {
  RxList<CategoryModel> listCategory = RxList();
  RxList<RecipeModel> listRecipe = RxList();
  RxList<RecipeModel> listRecipeUserFavorite = RxList();
  RxList<RecipeModel> listRecipeHistory = RxList();
  RxList<RecipeModel> listRecipeHighRating = RxList();
  RxList<RecipeModel> listRecipeRandom = RxList();

  UserInfo userInfo = UserInfo();

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

  void showFilterBottomSheet(List<RecipeModel> listRecipeInput, Function(List<RecipeModel>) onPressApply) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.6, // Giới hạn chiều cao là 90% màn hình
        ),
        child: FilterWidget(
          listCategory: listCategory.toList(),
          onPressApply: onPressApply,
          listRecipe: listRecipeInput.toList(),
        ),
      ),
      backgroundColor: AppColors.dsGray2D,
      isScrollControlled: true,
    );
  }

  Future<void> updateFavorite(RecipeModel recipeModel) async {
    if (listRecipeUserFavorite.any((element) => element.id == recipeModel.id)) {
      listRecipeUserFavorite.remove(recipeModel);
    } else {
      listRecipeUserFavorite.add(recipeModel);
    }
  }
}
