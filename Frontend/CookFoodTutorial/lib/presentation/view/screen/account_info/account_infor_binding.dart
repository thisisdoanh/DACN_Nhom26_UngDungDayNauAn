import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/account_info/account_infor_controller.dart';

class AccountInforBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountInforController());
  }
}
