import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';

import '../view/app_view.dart';
import '../view/resources/app_dimen.dart';
import 'text_share.dart';

class FoodSuggestItemSmall extends StatelessWidget {
  const FoodSuggestItemSmall({super.key, required this.food});
  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: ShapeDecoration(
        color: const Color(0xFF373737),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
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
            path: food.imageUrl,
            height: 56.w,
            width: 66.h,
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    food.foodName,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  RatingBarIndicator(
                    rating: food.rating,
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
          ),
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
                    food.time,
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
