import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/food_detail/food_detail_controller.dart';
import 'package:tutorial/res/string/app_string.dart';

class InstructionScreen extends AppBaseScreen<FoodDetailController> {
  const InstructionScreen({super.key});
  @override
  FoodDetailController get controller => Get.find<FoodDetailController>();
  @override
  Widget buildWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalo(),
        _buildTimerAndPortion(),
        _buildDivider(),
        _buildMaking()
      ],
    );
  }

  Widget _buildMaking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UtilWidget.buildText(StringConstants.making.tr,
            fontSize: AppDimens.fontSmall),
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

  Widget _buildTimerAndPortion() {
    return Row(
      children: [
        const Icon(
          Icons.timer_outlined,
          color: AppColors.dsGray3,
        ),
        Gap(4.w),
        UtilWidget.buildText(
          FoodModel.foodTest.time,
          textColor: AppColors.dsGray3,
          fontSize: AppDimens.font14,
        ),
        Gap(12.w),
        const Icon(
          Icons.timer_outlined,
          color: AppColors.dsGray3,
        ),
        Gap(4.w),
        UtilWidget.buildText(
          FoodModel.foodTest.time,
          textColor: AppColors.dsGray3,
          fontSize: AppDimens.font14,
        ),
      ],
    ).paddingOnly(top: AppDimens.paddingSmallest);
  }

  Widget _buildCalo() {
    return UtilWidget.buildText(
      '${FoodModel.foodTest.calo} Calo',
      textColor: AppColors.primaryColor,
    );
  }

  Widget _buildDivider() => const Divider(color: AppColors.dsGray2)
      .paddingSymmetric(vertical: AppDimens.paddingSmallest);
}
