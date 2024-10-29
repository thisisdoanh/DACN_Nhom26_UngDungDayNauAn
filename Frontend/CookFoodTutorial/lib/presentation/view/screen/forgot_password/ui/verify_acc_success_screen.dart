import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/resources/app_text_theme.dart';
import 'package:tutorial/presentation/view/screen/forgot_password/forgot_pass_controller.dart';
import 'package:tutorial/presentation/view/widget/app_image_widget.dart';
import 'package:tutorial/presentation/view/widget/app_outline_button.dart';
import 'package:tutorial/presentation/view/widget/app_text_field.dart';
import 'package:tutorial/presentation/view/widget/app_touchable.dart';
import 'package:tutorial/res/image/app_image.dart';
import 'package:tutorial/res/string/app_string.dart';

class VerifyAccSuccessScreen extends AppBaseScreen<ForgotPassController> {
  const VerifyAccSuccessScreen({super.key});

  @override
  Widget buildWidget() {
    return BackGroundShare(
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          const AppBarShare(hasBackIcon: true),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLableScreen(),
                  Gap(32.h),
                  _buildLableTextField(),
                  Gap(16.h),
                  _buildInputNewPass(),
                  Gap(16.h),
                  _buildInputVerifyNewPass(),
                ],
              ).paddingAll(AppDimens.paddingMedium),
            ),
          ),
          _buildBtnContinue(),
        ],
      ),
    );
  }

  Widget _buildInputVerifyNewPass() {
    return Obx(
      () => AppTextField(
        maxLines: 1,
        maxLength: 255,
        backgroundColor: AppColors.transparent,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.sp,
            horizontal: 12.sp,
          ),
          child: AppImageWidget.asset(
            path: AppImage.icKey,
          ),
        ),
        hintText: StringConstants.enterNewPass.tr,
        isHide: controller.isHideVerifyPass.value,
        suffixIcon: AppTouchable(
          onPressed: controller.isHideVerifyPass.toggle,
          child: Icon(
            controller.isHideVerifyPass.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.white,
            size: 24.sp,
          ),
        ),
        textEditingController: controller.verifyPasswordCtrl,
        errorText: controller.verifyPassError.value,
        onChanged: controller.onChangeVerifyPass,
      ),
    );
  }

  Widget _buildInputNewPass() {
    return Obx(
      () => AppTextField(
        maxLines: 1,
        maxLength: 255,
        backgroundColor: AppColors.transparent,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.sp,
            horizontal: 12.sp,
          ),
          child: AppImageWidget.asset(
            path: AppImage.icKey,
          ),
        ),
        hintText: StringConstants.enterNewPass.tr,
        isHide: controller.isHidePass.value,
        suffixIcon: AppTouchable(
          onPressed: controller.isHidePass.toggle,
          child: Icon(
            controller.isHidePass.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.white,
            size: 24.sp,
          ),
        ),
        textEditingController: controller.passwordCtrl,
        errorText: controller.passwordError.value,
        onChanged: controller.onChangePass,
      ),
    );
  }

  Widget _buildBtnContinue() {
    return AppOutlineButton(
      color: AppColors.primaryColor,
      onPressed: () => controller.forgotPassSuccess(),
      borderRadius: BorderRadius.circular(20.sp),
      width: double.infinity,
      height: AppDimens.btnDefault,
      child: Text(
        StringConstants.next.tr,
        style: AppTextTheme.headlineSmall(AppColors.white)?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ).paddingAll(AppDimens.paddingMedium);
  }

  Widget _buildLableTextField() {
    return Text(
      StringConstants.enterNewPassToLogin.tr,
      style: AppTextTheme.labelLarge(AppColors.white)?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget buildLableScreen() {
    return Text(
      StringConstants.verifyAccountSuccess.tr,
      style: AppTextTheme.headlineLarge(AppColors.primaryColor)?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
