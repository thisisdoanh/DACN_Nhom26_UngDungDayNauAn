import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/login/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(LoginController());
  }
}