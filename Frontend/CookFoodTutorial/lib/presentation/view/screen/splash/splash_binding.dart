import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
