import 'package:get/get.dart';

import 'user_favourite_food_controller.dart';

class UserFavouriteFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserFavoriteFoodController());
  }
}
