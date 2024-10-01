import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/favorite_food/suggest_food_controller.dart';
import 'package:tutorial/res/string/app_string.dart';

class FavoriteFoodScreen extends AppBaseScreen<FavoriteFoodController> {
  const FavoriteFoodScreen({super.key});

  @override
  Widget buildWidget() {
    final double itemWidth = Get.width / 2;
    const double itemHeight = 250;
    return BackGroundShare(
      body: Column(
        children: [_buildAppBar(), _buildBody(itemWidth, itemHeight)],
      ).paddingSymmetric(horizontal: AppDimens.paddingMedium),
    );
  }

  Widget _buildBody(double itemWidth, double itemHeight) {
    return Expanded(
      child: Column(
        children: [_buildSearchBar(), _buildListFood(itemWidth, itemHeight)],
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
        itemCount: 20,
        itemBuilder: (context, index) {
          return FoodCard(food: foodTest);
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextFieldSearch(),
        _buildIconFilter().paddingOnly(left: AppDimens.paddingSmall),
      ],
    );
  }

  Widget _buildIconFilter() {
    return Container(
      height: AppDimens.sizeIconLineChart,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius8),
          border: Border.all(color: AppColor.white)),
      child: const Icon(
        Icons.filter_alt_rounded,
        color: AppColor.white,
      ),
    );
  }

  Widget _buildTextFieldSearch() {
    return Expanded(
      child: AppTextField(
        hintText: StringConstants.searchRecipe.tr,
        backgroundColor: AppColor.transparent,
        border: Border.all(
          color: AppColor.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBarShare(
      title: StringConstants.motsFavorite.tr,
      action: InkWell(
        onTap: Get.back,
        child: const Icon(
          Icons.arrow_back_outlined,
          color: AppColor.primaryColor,
          size: AppDimens.fontLarge,
        ),
      ),
    );
  }
}

final FoodModel foodTest = FoodModel(
    mealType: "Bữa sáng",
    foodName: "Bữa nướng",
    time: '10:02',
    rating: 4.5,
    imageUrl:
        'https://ik.imagekit.io/tvlk/blog/2017/01/30-mon-ngon-nuc-long-nhat-dinh-phai-thu-khi-toi-ha-noi-phan-1.jpg?tr=dpr-2,w-675');
