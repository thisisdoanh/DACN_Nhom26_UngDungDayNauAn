import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/resources/app_text_theme.dart';
import 'package:tutorial/presentation/view/screen/food_detail/food_detail_controller.dart';
import 'package:tutorial/presentation/view/widget/app_outline_button.dart';
import 'package:tutorial/res/string/app_string.dart';

class FoodDetailScreen extends AppBaseScreen<FoodDetailController> {
  const FoodDetailScreen({super.key});

  @override
  Widget buildWidget() {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.primaryText,
        body: Column(
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFoodType(),
                  _buildFoodNameAndFavour(),
                  _buildFoodRate(),
                  _buildTimeAndImage(),
                  _buildDivider(),
                  _buildIngredient(),
                ],
              ),
            ),
          ),
          _buildBtnGuide(),
          _buildBtnRate(),
        ],
      ).paddingAll(AppDimens.paddingMedium),
    );
  }

  Widget _buildBtnRate() {
    return AppOutlineButton(
      color: AppColors.primaryColor,
      onPressed: () {},
      borderRadius: BorderRadius.circular(20.sp),
      width: double.infinity,
      height: AppDimens.btnDefault,
      child: Text(
        StringConstants.rate.tr,
        style: AppTextTheme.headlineSmall(AppColors.white)?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ).paddingSymmetric(vertical: AppDimens.paddingSmall);
  }

  Widget _buildBtnGuide() {
    return AppOutlineButton(
      color: AppColors.primaryColor,
      onPressed: () => controller.guide(Container()),
      borderRadius: BorderRadius.circular(20.sp),
      width: double.infinity,
      height: AppDimens.btnDefault,
      child: Text(
        StringConstants.guide.tr,
        style: AppTextTheme.headlineSmall(AppColors.white)?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ).paddingSymmetric(vertical: AppDimens.paddingSmall);
  }

  Widget _buildIngredient() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UtilWidget.buildText(
          StringConstants.ingredient.tr,
          fontSize: AppDimens.fontSmall,
        ),
        Gap(8.h),
        Row(
          children: [
            ClipOval(
              child: Container(
                height: 4,
                width: 4,
                color: AppColors.primaryColor,
              ),
            ),
            Gap(8.w),
            UtilWidget.buildText(
              "StringConstants.ingredient.tr",
              fontSize: AppDimens.font14,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() => const Divider(color: AppColors.dsGray2)
      .paddingAll(AppDimens.paddingMedium);

  Widget _buildFoodType() {
    return UtilWidget.buildText(
      FoodModel.foodTest.mealType,
      fontSize: AppDimens.font14,
      textColor: AppColors.textNote,
    );
  }

  Widget _buildTimeAndImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: AppColors.dsGray3,
                ),
                Gap(4.w),
                UtilWidget.buildText(
                  FoodModel.foodTest.time,
                  textColor: AppColors.dsGray3,
                  fontSize: AppDimens.fontSmall,
                ),
              ],
            ),
            Gap(16.h),
            Row(
              children: [
                const Icon(
                  Icons.food_bank_outlined,
                  color: AppColors.dsGray3,
                ),
                Gap(4.w),
                UtilWidget.buildText(
                  '4 Khẩu phần ăn',
                  textColor: AppColors.dsGray3,
                  fontSize: AppDimens.fontSmall,
                ),
              ],
            ),
          ],
        ).paddingOnly(right: AppDimens.paddingLarge),
        Expanded(
          child: ClipOval(
            // borderRadius: BorderRadius.circular(AppDimens.radius8),
            child: Image.network(
              FoodModel.foodTest.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFoodRate() {
    return RatingBarIndicator(
      rating: FoodModel.foodTest.rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColors.primaryColor,
      ),
      itemCount: 5,
      itemSize: 20.0,
      direction: Axis.horizontal,
    );
  }

  Widget _buildFoodNameAndFavour() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UtilWidget.buildText(
          FoodModel.foodTest.foodName,
          fontSize: AppDimens.fontMedium,
        ),
        Obx(
          () => IconButton(
            onPressed: FoodModel.foodTest.isFavorite.toggle,
            icon: Icon(
              FoodModel.foodTest.isFavorite.value
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: FoodModel.foodTest.isFavorite.value
                  ? AppColors.primaryColor
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  AppBarShare _buildAppBar() {
    return AppBarShare(
      hasBackIcon: true,
      action: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications,
          size: AppDimens.sizeImage35,
        ),
      ),
    );
  }
}
