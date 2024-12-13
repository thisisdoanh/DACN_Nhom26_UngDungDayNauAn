import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFoodType(),
          _buildTimer(),
          _buildDivider(),
          _buildMaking()
        ],
      ),
    );
  }

  Widget _buildMaking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UtilWidget.buildText(StringConstants.making.tr,
            fontSize: AppDimens.fontSmall),
        Gap(16.h),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.recipeModel.instructions?.length,
            itemBuilder: (context, index) {
              final ingreduent = controller.recipeModel.instructions?[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Container(
                      height: 4,
                      width: 4,
                      color: AppColors.primaryColor,
                    ).paddingAll(8),
                  ),
                  Gap(8.w),
                  Flexible(
                    child: UtilWidget.buildText(
                      maxLines: 5,
                      ingreduent?.description ?? '',
                      fontSize: AppDimens.font14,
                    ),
                  ),
                ],
              ).paddingOnly(bottom: AppDimens.paddingLittleSmall);
            })
      ],
    );
  }

  Widget _buildTimer() {
    return Row(
      children: [
        const Icon(
          Icons.timer_outlined,
          color: AppColors.dsGray3,
        ),
        Gap(4.w),
        UtilWidget.buildText(
          controller.recipeModel.cookTime ?? "1h",
          textColor: AppColors.dsGray3,
          fontSize: AppDimens.font14,
        ),
      ],
    ).paddingOnly(top: AppDimens.paddingSmallest);
  }

  Widget _buildFoodType() {
    return UtilWidget.buildText(
      controller.recipeModel.category?.name ?? '',
      fontSize: AppDimens.font14,
      textColor: AppColors.textNote,
    );
  }

  Widget _buildDivider() => const Divider(color: AppColors.dsGray2)
      .paddingSymmetric(vertical: AppDimens.paddingSmallest);
}
