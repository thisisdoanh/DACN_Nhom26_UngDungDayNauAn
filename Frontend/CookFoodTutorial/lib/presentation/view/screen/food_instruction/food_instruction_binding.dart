import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/food_instruction/food_instruction_controller.dart';

class FoodInstructionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodInstructionController());
  }
}
