import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart'; // Để hiển thị đánh giá sao

class FoodCard extends StatelessWidget {
  final FoodModel food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingVerySmall),
      decoration: BoxDecoration(
        color: AppColor.primaryGray.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppDimens.radius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
      rating: food.rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColor.primaryColor,
      ),
      itemCount: 5,
      itemSize: 20.0,
      direction: Axis.horizontal,
    );
  }

  Widget _buildTime() {
    return Row(
      children: [
        const Icon(
          Icons.timer_outlined,
          color: AppColor.primaryColor,
        ),
        Gap(4.w),
        UtilWidget.buildText(
          food.time,
          textColor: AppColor.primaryColor,
          fontSize: AppDimens.fontMedium,
        ),
      ],
    );
  }

  Widget _buildFoodName() {
    return UtilWidget.buildText(
      food.foodName,
      fontSize: AppDimens.fontSmall,
      textColor: AppColor.white,
    );
  }

  Widget _buildMealType() {
    return UtilWidget.buildText(
      food.mealType,
      fontSize: AppDimens.fontSmall,
      textColor: AppColor.dsPrimaryBlueBlue,
    );
  }

  Widget _buildFavourAndImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Icon(
              food.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: AppColor.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radius8),
            child: Image.network(
              food.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class FoodModel {
  final String mealType;
  final String foodName;
  final String time;
  final double rating;
  final bool isFavorite;
  final String imageUrl;

  FoodModel({
    required this.mealType,
    required this.foodName,
    required this.time,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
