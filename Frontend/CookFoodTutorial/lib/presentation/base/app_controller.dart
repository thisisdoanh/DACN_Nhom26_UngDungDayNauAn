import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/model/comment_response.dart';
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
  RxList<CommentModel> commentListGlobal = RxList();
  final RxBool haveBiometric = RxBool(false);

  UserInfo userInfo = UserInfo();



  Future<void> updateLocale(Locale locale) async {
    Get.updateLocale(locale);
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
  
  @override
  void onDetached() {
  }
  
  @override
  void onHidden() {
  }
  
  @override
  void onInactive() {
  }
  
  @override
  void onPaused() {
  }
  
  @override
  void onResumed() {
  }
}
