import 'package:get/get.dart';

import 'favourite_food_controller.dart';

class FavouriteFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouriteFoodController());
  }
}
