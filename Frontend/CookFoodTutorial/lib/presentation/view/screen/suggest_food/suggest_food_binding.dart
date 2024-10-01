import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/suggest_food/suggest_food_controller.dart';

class SuggestFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuggestFoodController());
  }
}
