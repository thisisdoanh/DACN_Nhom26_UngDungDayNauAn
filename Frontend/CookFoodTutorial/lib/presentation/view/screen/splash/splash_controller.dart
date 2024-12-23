import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/data/model/user_info_response.dart';
import 'package:tutorial/data/provider/api_service.dart';
import 'package:tutorial/data/share_preference_utils.dart';
import 'package:tutorial/presentation/route/app_route.dart';
import 'package:tutorial/presentation/view/resources/app_key.dart';

import '../../../base/app_base_controller.dart';

class SplashController extends AppBaseController {
  RxString version = ''.obs;

  @override
  void onInit() {
    appController.haveBiometric.value =
        PreferenceUtils.getString(AppKey.keyAccount) != null;
    super.onInit();
  }

  @override
  void onReady() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    nextScreen();
    super.onReady();
  }

  void nextScreen() async {
    await fetchData();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Get.offAndToNamed(AppRoute.loginScreen);
      },
    );
  }

  Future fetchData() async {
    await Future.wait([
      getUserInfo(),
      getListRecipe(),
      getListCategory(),
    ]);
  }

  Future getUserInfo() async {
    appController.userInfo = await ApiService.getUserInfo() ?? UserInfo();
    // appController.listRecipeUserFavorite.value = await ApiService.getRecipeFavorite(appController.userInfo.id );
    List<RecipeModel> listRecipe = await ApiService.getRecipeFavorite(1);
    appController.listRecipeUserFavorite.assignAll(listRecipe..removeAt(0));
  }

  Future getListRecipe() async {
    final listRecipe = await ApiService.getRecipes();
    appController.listRecipe.assignAll(listRecipe..removeAt(0));
  }

  Future getListCategory() async {
    final listCategory = await ApiService.getCategories();
    appController.listCategory.assignAll(listCategory);
  }
}
