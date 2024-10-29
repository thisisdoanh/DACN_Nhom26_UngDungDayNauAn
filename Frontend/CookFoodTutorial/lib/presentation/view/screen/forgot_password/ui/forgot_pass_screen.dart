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
import 'package:tutorial/res/image/app_image.dart';
import 'package:tutorial/res/string/app_string.dart';

class ForgotPassScreen extends AppBaseScreen<ForgotPassController> {
  const ForgotPassScreen({super.key});

  @override
  Widget buildWidget() {
    return BackGroundShare(
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
                  _buildInputEmail(),
                ],
              ).paddingAll(AppDimens.paddingMedium),
            ),
          ),
          _buildBtnContinue(),
        ],
      ),
    );
  }

  Widget _buildBtnContinue() {
    return AppOutlineButton(
      color: AppColors.primaryColor,
      onPressed: controller.forgotPass,
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

  Widget _buildInputEmail() {
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
            path: AppImage.icEmail,
          ),
        ),
        hintText: StringConstants.email.tr,
        keyboardType: TextInputType.emailAddress,
        textEditingController: controller.emailTextEditingController,
        errorText: controller.emailErrorText.value,
        onChanged: controller.onEmailInputChange,
      ),
    );
  }

  Widget _buildLableTextField() {
    return Text(
      StringConstants.inputYourEmail.tr,
      style: AppTextTheme.labelLarge(AppColors.white)?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget buildLableScreen() {
    return Text(
      StringConstants.forgotPass.tr,
      style: AppTextTheme.headlineLarge(AppColors.primaryColor)?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
