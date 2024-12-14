import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';

import '../view/app_view.dart';
import '../view/resources/app_dimen.dart';
import '../view/screen/home/home_controller.dart';
import 'text_share.dart';

class FoodSuggestItemSmall extends StatelessWidget {
  const FoodSuggestItemSmall({super.key, required this.recipeModel});
  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: () {
        Get.find<HomeController>().onPressItemRecipe(recipeModel);
      },
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF373737),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          AppImageWidget.network(
            path: recipeModel.imageUrl ?? recipeModel.image ?? "",
            height: 56.w,
            width: 66.h,
            fit: BoxFit.cover,
          ),
          Gap(10.w),
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    recipeModel.recipeName ?? "Unknown",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                RatingBarIndicator(
                  rating: recipeModel.rating ?? 5,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: AppColors.primaryColor,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ),
          Gap(10.w),
          Column(
            children: [
              Icon(
                FoodModel.foodTest.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                color: AppColors.primaryColor,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timer,
                    color: AppColors.white,
                  ),
                  Gap(4.w),
                  UtilWidget.buildText(
                    recipeModel.cookTime ?? "Unknown",
                    textColor: AppColors.primaryColor,
                    fontSize: AppDimens.fontSmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
