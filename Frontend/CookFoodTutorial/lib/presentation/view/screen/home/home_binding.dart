import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
