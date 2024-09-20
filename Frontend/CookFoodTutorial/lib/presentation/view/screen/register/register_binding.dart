import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
