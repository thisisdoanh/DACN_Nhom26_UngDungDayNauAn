import 'package:get/get.dart';

import 'suggest_food_controller.dart';

class SuggestFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuggestFoodController());
  }
}
