import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_controller.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/home/home_controller.dart';

class FoodCard extends StatelessWidget {
  final IconData? timerIcon;
  final Color? timerColor;
  final RecipeModel recipeModel;

  const FoodCard({
    super.key,
    this.timerIcon,
    this.timerColor,
    required this.recipeModel,
  });

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: () {
        Get.find<HomeController>().onPressItemRecipe(recipeModel);
      },
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.paddingVerySmall),
      decoration: BoxDecoration(
        color: AppColors.primaryGray.withOpacity(0.4),
        borderRadius: BorderRadius.circular(AppDimens.radius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFavourAndImage(),
          Gap(8.h),
          _buildMealType(),
          Gap(8.h),
          _buildFoodName(),
          Gap(8.h),
          _buildTime(),
          Gap(8.h),
          _buildRateFood(),
        ],
      ),
    );
  }

  Widget _buildRateFood() {
    return RatingBarIndicator(
      rating: recipeModel.rating ?? 5,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColors.primaryColor,
      ),
      itemCount: 5,
      itemSize: AppDimens.btnSmall,
      direction: Axis.horizontal,
    );
  }

  Widget _buildTime() {
    return Row(
      children: [
        Icon(
          timerIcon ?? Icons.timer_outlined,
          color: timerColor ?? AppColors.primaryColor,
        ),
        Gap(4.w),
        Expanded(
          child: UtilWidget.buildText(
            recipeModel.cookTime ?? "Unknown",
            textAlign: TextAlign.left,
            textColor: timerColor ?? AppColors.primaryColor,
            fontSize: AppDimens.fontSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildFoodName() {
    return UtilWidget.buildText(
      recipeModel.recipeName ?? "Unknown",
      fontSize: AppDimens.fontSmall,
      textColor: AppColors.white,
    );
  }

  Widget _buildMealType() {
    return UtilWidget.buildText(
      recipeModel.category?.name ?? "Unknown",
      fontSize: AppDimens.font14,
      textColor: const Color.fromARGB(255, 0, 157, 255),
    );
  }

  Widget _buildFavourAndImage() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () async {
                Get.find<AppController>().updateFavorite(recipeModel);
              },
              child: Obx(
                () => Icon(
                  Get.find<AppController>().listRecipeUserFavorite.any((element) => element.id == recipeModel.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.hardEdge,
            child: ClipRRect(
              child: AppImageWidget.network(
                path: recipeModel.image ?? "",
                width: 80.r,
                height: 80.r,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodModel {
  final String mealType;
  final String foodName;
  final String time;
  final double rating;
  final RxBool isFavorite;
  final String imageUrl;
  final int calo;
  final int portion;

  FoodModel({
    required this.mealType,
    required this.foodName,
    required this.time,
    required this.rating,
    required this.imageUrl,
    required this.isFavorite,
    required this.calo,
    required this.portion,
  });
  static final FoodModel foodTest = FoodModel(
    mealType: "Bữa sáng",
    foodName: "Bữa nướng",
    portion: 4,
    time: '10:02',
    rating: 4.5,
    calo: 280,
    imageUrl:
        'https://ik.imagekit.io/tvlk/blog/2017/01/30-mon-ngon-nuc-long-nhat-dinh-phai-thu-khi-toi-ha-noi-phan-1.jpg?tr=dpr-2,w-675',
    isFavorite: false.obs,
  );
}
