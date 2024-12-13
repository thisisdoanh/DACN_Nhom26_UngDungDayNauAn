import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tutorial/data/model/category_response_model.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';

class AppGlobal {
  static final AppGlobal _singleton = AppGlobal._();
  factory AppGlobal() {
    return _singleton;
  }
  AppGlobal._();

  static RxList<CategoryModel> listCategory = RxList();
  static RxList<RecipeModel> listRecipe = RxList();
}
