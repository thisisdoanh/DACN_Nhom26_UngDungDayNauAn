import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/suggest_food/suggest_food_controller.dart';
import 'package:tutorial/res/string/app_string.dart';

class SuggestFoodScreen extends AppBaseScreen<SuggestFoodController> {
  const SuggestFoodScreen({super.key});

  @override
  Widget buildWidget() {
    return Obx(
      () => BackGroundShare(
        body: controller.isShowLoading.value
            ? Container()
            : Column(
                children: [
                  _buildAppBar(),
                  _buildBody(),
                ],
              ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Column(
        children: [
          _buildSearchBar(),
          _buildListFood(),
        ],
      ),
    );
  }

  Widget _buildListFood() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 220,
          mainAxisSpacing: AppDimens.paddingSmall,
          crossAxisSpacing: AppDimens.paddingVerySmall,
        ),
        shrinkWrap: true,
        itemCount: controller.appController.listRecipe.length,
        itemBuilder: (context, index) {
          final food = controller.appController.listRecipe[index];
          return FoodCard(
            recipeModel: food,
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextFieldSearch(),
        _buildIconFilter(),
      ],
    );
  }

  Widget _buildIconFilter() {
    return Container(
      height: AppDimens.sizeTextField,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radius8),
        border: Border.all(color: AppColors.white),
      ),
      child: const Icon(
        Icons.filter_alt_rounded,
        color: AppColors.white,
      ),
    ).paddingOnly(left: AppDimens.paddingSmall);
  }

  Widget _buildTextFieldSearch() {
    return Expanded(
      child: AppTextField(
        hintText: StringConstants.searchRecipe.tr,
        backgroundColor: AppColors.transparent,
        border: Border.all(
          color: AppColors.white,
          width: 1,
        ),
        suffixIcon: const Icon(
          Icons.search,
          color: AppColors.white,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBarShare(
      title: StringConstants.suggest.tr,
      action: InkWell(
        onTap: Get.back,
        child: const Icon(
          Icons.arrow_back_outlined,
          color: AppColors.primaryColor,
          size: AppDimens.sizeImage35,
        ),
      ),
    );
  }
}
