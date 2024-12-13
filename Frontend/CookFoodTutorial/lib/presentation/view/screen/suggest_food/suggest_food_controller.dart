import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';

class SuggestFoodController extends AppBaseController {
  @override
  void onInit() async {
    showLoading();
    await 1.seconds.delay();
    hideLoading();
    super.onInit();
  }
}
