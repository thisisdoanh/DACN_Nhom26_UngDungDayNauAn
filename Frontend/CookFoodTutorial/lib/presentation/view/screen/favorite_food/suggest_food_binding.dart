import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/favorite_food/suggest_food_controller.dart';

class FavoriteFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteFoodController());
  }
}
