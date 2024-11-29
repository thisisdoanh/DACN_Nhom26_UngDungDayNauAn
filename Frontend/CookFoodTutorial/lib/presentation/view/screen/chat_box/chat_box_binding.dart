import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/chat_box/chat_box_controller.dart';

class ChatBoxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatBoxController());
  }
}
