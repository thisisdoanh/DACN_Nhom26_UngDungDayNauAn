import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';

import '../../data/model/category_response_model.dart';

class AppController extends SuperController {
  RxList<CategoryModel> listCategory = RxList();
  RxList<RecipeModel> listRecipe = RxList();

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
}
