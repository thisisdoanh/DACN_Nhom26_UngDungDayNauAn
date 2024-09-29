import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/forgot_password/forgot_pass_controller.dart';

class ForgotPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ForgotPassController(),
    );
  }
}
