import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/model/comment_response.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/food_detail/food_detail_controller.dart';
import 'package:tutorial/presentation/view/widget/app_outline_button.dart';
import 'package:tutorial/res/string/app_string.dart';

class RatingScreen extends AppBaseScreen<FoodDetailController> {
  const RatingScreen({super.key, this.comment});
  final CommentModel? comment;

  @override
  Widget buildWidget() {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Container(
          margin: const EdgeInsetsDirectional.all(AppDimens.paddingMedium),
          padding: const EdgeInsetsDirectional.all(AppDimens.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.colorBackgrounDialog,
            borderRadius: BorderRadius.circular(AppDimens.radius16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLableScreen(),
              _buildDivider(),
              _buildRateFood(),
              _buildInputComment(),
              _buildDivider(),
              Row(
                children: [
                  _buildBtnConfirm(isConfirm: false),
                  Gap(12.w),
                  _buildBtnConfirm(
                    onConfirm: () => comment != null
                        ? controller.updateComment(comment?.commentIndex ?? "")
                        : controller.createComment(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputComment() {
    return AppTextField(
      maxLines: null,
      height: null,
      maxLength: 255,
      textEditingController: controller.commentCtrl,
      hintText: 'Nhập đánh giá',
      borderRadius: BorderRadius.circular(AppDimens.radius8),
      border: Border.all(color: AppColors.dsGray4, width: 1),
      backgroundColor: AppColors.transparent,
    ).paddingSymmetric(vertical: 16);
  }

  Widget _buildBtnConfirm({
    VoidCallback? onConfirm,
    bool isConfirm = true,
  }) {
    return Expanded(
      child: AppOutlineButton(
        color: isConfirm ? AppColors.primaryColor : AppColors.white,
        onPressed: isConfirm ? onConfirm : Get.back,
        border: isConfirm ? null : Border.all(color: AppColors.white),
        borderRadius: BorderRadius.circular(AppDimens.radius8),
        width: double.infinity,
        height: AppDimens.btnMedium,
        child: UtilWidget.buildText(
          isConfirm ? StringConstants.next.tr : StringConstants.cancel.tr,
          textColor: isConfirm ? AppColors.white : AppColors.primaryColor,
          fontSize: AppDimens.fontMedium,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLableScreen() {
    return UtilWidget.buildText(
      StringConstants.ratingLableDialog.tr,
      fontSize: AppDimens.fontSmall,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildRateFood() {
    return Obx(
      () => RatingBarIndicator(
        rating: controller.curentStart.value.toDouble(),
        itemPadding:
            const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmallest),
        itemBuilder: (context, index) {
          bool isStarSelected = controller.curentStart.value == index + 1;

          return TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 150),
            tween: Tween<double>(begin: 1.0, end: isStarSelected ? 1.5 : 1.0),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: InkWell(
                  onTap: () => controller.rating(index + 1),
                  child: const Icon(
                    Icons.star,
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            },
          );
        },
        itemCount: 5,
        itemSize: (Get.width - 40) / 10,
        direction: Axis.horizontal,
      ),
    );
  }

  Widget _buildDivider() => const Divider(
        color: AppColors.dsGray3,
        thickness: 0.5,
      ).paddingSymmetric(vertical: AppDimens.paddingVerySmall);
}
