import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/favourite_food/favourite_food_controller.dart';

class FavouriteFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteFoodController());
  }
}
