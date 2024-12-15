import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';

import '../../../component/food_suggest_item.dart';
import '../../../component/search_widget.dart';
import 'suggest_food_controller.dart';

class SuggestFoodScreen extends AppBaseScreen<SuggestFoodController> {
  const SuggestFoodScreen({super.key});

  @override
  Widget buildWidget() {
    final double itemWidth = Get.width / 2;
    const double itemHeight = 250;
    return Obx(
      () => BackGroundShare(
        body: controller.isShowLoading.value
            ? Container()
            : Column(
                children: [
                  _buildAppBar(),
                  _buildBody(itemWidth, itemHeight),
                ],
              ),
      ),
    );
  }

  Widget _buildBody(double itemWidth, double itemHeight) {
    return Expanded(
      child: Column(
        children: [
          _buildSearchBar(),
          _buildListFood(itemWidth, itemHeight),
        ],
      ),
    );
  }

  Widget _buildListFood(double itemWidth, double itemHeight) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: itemWidth / itemHeight,
          crossAxisSpacing: AppDimens.paddingMedium,
          mainAxisSpacing: AppDimens.paddingMedium,
        ),
        itemCount: controller.listRecipeFilter.length,
        itemBuilder: (context, index) {
          return FoodCard(
            recipeModel: controller.listRecipeFilter[index],
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
    return AppTouchable(
      onPressed: () => controller.appController.showFilterBottomSheet(
        controller.listRecipe.toList(),
        (p0) {
          controller.listRecipeFilter.value = p0;
        },
      ),
      height: AppDimens.sizeTextField,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius8), border: Border.all(color: AppColors.white)),
      child: const Icon(
        Icons.filter_alt_rounded,
        color: AppColors.white,
      ),
    ).paddingOnly(left: AppDimens.paddingSmall);
  }

  Widget _buildTextFieldSearch() {
    return Expanded(
      child: SearchWidget(
        listRecipe: controller.listRecipe.toList(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBarShare(
      title: "Được yêu thích nhất",
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
