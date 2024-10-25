import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/food_detail/food_detail_controller.dart';

class FoodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodDetailController());
  }
}
