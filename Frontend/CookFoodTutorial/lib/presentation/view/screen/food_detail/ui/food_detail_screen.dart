import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/resources/app_text_theme.dart';
import 'package:tutorial/presentation/view/screen/food_detail/food_detail_controller.dart';
import 'package:tutorial/presentation/view/screen/food_detail/ui/instruction_screen.dart';
import 'package:tutorial/presentation/view/screen/food_detail/ui/rating_screen.dart';
import 'package:tutorial/presentation/view/widget/app_image_widget.dart';
import 'package:tutorial/presentation/view/widget/app_outline_button.dart';
import 'package:tutorial/res/string/app_string.dart';

class FoodDetailScreen extends AppBaseScreen<FoodDetailController> {
  const FoodDetailScreen({super.key});

  @override
  Widget buildWidget() {
    return BackGroundShare(
      body: Obx(
        () => Visibility(
          visible: !controller.isShowLoading.value,
          child: Column(
            children: [
              _buildAppBar(),
              _buildBody(),
            ],
          ),
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
                  _buildFoodNameAndFavour(),
                  _buildTimeAndImage(),
                  _buildDivider(),
                  _buildIngredient(),
                ],
              ),
            ),
          ),
          _buildBtn(
            text: StringConstants.instruction.tr,
            onPressed: () => controller.goToGuideScreen(const InstructionScreen()),
          ),
          _buildBtn(
            text: StringConstants.rating.tr,
            onPressed: () => controller.goToRatingScreen(const RatingScreen()),
          ),
        ],
      ).paddingAll(AppDimens.paddingMedium),
    );
  }

  Widget _buildBtn({
    required String text,
    required VoidCallback onPressed,
  }) {
    return AppOutlineButton(
      color: AppColors.primaryColor,
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(20.sp),
      width: double.infinity,
      height: AppDimens.btnDefault,
      child: Text(
        text,
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
        Gap(16.h),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.recipeModel.ingredients?.length,
            itemBuilder: (context, index) {
              final ingreduent = controller.recipeModel.ingredients?[index];
              return Row(
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
                    "${ingreduent?.name ?? ''}${(ingreduent?.amount?.trim().isEmpty ?? true) ? '' : ' : ${ingreduent?.amount}'}",
                    fontSize: AppDimens.font14,
                  ),
                ],
              ).paddingOnly(bottom: AppDimens.paddingLittleSmall);
            })
      ],
    );
  }

  Widget _buildDivider() => const Divider(color: AppColors.dsGray2).paddingAll(AppDimens.paddingMedium);

  Widget _buildFoodType() {
    return UtilWidget.buildText(
      controller.recipeModel.category?.name ?? '',
      fontSize: AppDimens.font14,
      textColor: AppColors.textNote,
    );
  }

  Widget _buildTimeAndImage() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFoodType(),
            _buildFoodRate(),
            _buildRowCustom(
              Icons.timer_outlined,
              controller.recipeModel.cookTime ?? '',
            ),
          ],
        ),
        const Spacer(),
        _buildFoodImage(),
      ],
    );
  }

  Widget _buildRowCustom(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.dsGray3,
        ),
        Gap(4.w),
        UtilWidget.buildText(
          text,
          textColor: AppColors.dsGray3,
          fontSize: AppDimens.fontSmall,
        ),
      ],
    );
  }

  Widget _buildFoodImage() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child: ClipRRect(
        child: AppImageWidget.network(
          path: controller.recipeModel.image ?? "",
          fit: BoxFit.cover,
          width: Get.width / 2,
          height: Get.width / 2,
        ),
      ),
    );
  }

  Widget _buildFoodRate() {
    return RatingBarIndicator(
      rating: controller.recipeModel.rating ?? 4,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColors.primaryColor,
      ),
      itemCount: 5,
      itemSize: 20.0,
      direction: Axis.horizontal,
    ).paddingSymmetric(vertical: 12);
  }

  Widget _buildFoodNameAndFavour() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UtilWidget.buildText(
          controller.recipeModel.recipeName ?? '',
          fontSize: AppDimens.fontMedium,
        ),
        Obx(
          () => IconButton(
            onPressed: FoodModel.foodTest.isFavorite.toggle,
            icon: Icon(
              FoodModel.foodTest.isFavorite.value ? Icons.favorite : Icons.favorite_border,
              color: FoodModel.foodTest.isFavorite.value ? AppColors.primaryColor : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
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
