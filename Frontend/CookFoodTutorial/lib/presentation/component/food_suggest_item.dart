import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingVerySmall),
      decoration: BoxDecoration(
        color: AppColors.primaryGray.withOpacity(0.4),
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
        color: AppColors.primaryColor,
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
          color: AppColors.primaryColor,
        ),
        Gap(4.w),
        UtilWidget.buildText(
          food.time,
          textColor: AppColors.primaryColor,
          fontSize: AppDimens.fontMedium,
        ),
      ],
    );
  }

  Widget _buildFoodName() {
    return UtilWidget.buildText(
      food.foodName,
      fontSize: AppDimens.fontSmall,
      textColor: AppColors.white,
    );
  }

  Widget _buildMealType() {
    return UtilWidget.buildText(
      food.mealType,
      fontSize: AppDimens.fontSmall,
      textColor: const Color.fromARGB(255, 0, 157, 255),
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
            child: InkWell(
              onTap: food.isFavorite.toggle,
              child: Obx(
                () => Icon(
                  food.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: AppColors.primaryColor,
                ),
              ),
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
  final RxBool isFavorite;
  final String imageUrl;

  FoodModel({
    required this.mealType,
    required this.foodName,
    required this.time,
    required this.rating,
    required this.imageUrl,
    required this.isFavorite,
  });
  static final FoodModel foodTest = FoodModel(
    mealType: "Bữa sáng",
    foodName: "Bữa nướng",
    time: '10:02',
    rating: 4.5,
    imageUrl:
        'https://ik.imagekit.io/tvlk/blog/2017/01/30-mon-ngon-nuc-long-nhat-dinh-phai-thu-khi-toi-ha-noi-phan-1.jpg?tr=dpr-2,w-675',
    isFavorite: false.obs,
  );
}
