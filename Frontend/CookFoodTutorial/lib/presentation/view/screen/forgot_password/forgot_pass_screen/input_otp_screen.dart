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
import 'package:tutorial/presentation/view/widget/app_outline_button.dart';
import 'package:tutorial/res/string/app_string.dart';

class InputOtpScreen extends AppBaseScreen<ForgotPassController> {
  const InputOtpScreen({super.key});

  @override
  Widget buildWidget() {
    return SafeArea(
      child: BackGroundShare(
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
                    _buildInputOtp(),
                  ],
                ).paddingAll(AppDimens.paddingMedium),
              ),
            ),
            _buildBtnCountinue(),
          ],
        ),
      ),
    );
  }

  Widget _buildBtnCountinue() {
    return AppOutlineButton(
      color: AppColor.primaryColor,
      onPressed: controller.verifyAccount,
      borderRadius: BorderRadius.circular(20.sp),
      width: double.infinity,
      height: AppDimens.btnDefault,
      child: Text(
        StringConstants.next.tr,
        style: AppTextTheme.headlineSmall(AppColor.white)?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ).paddingAll(AppDimens.paddingMedium);
  }

  Widget _buildInputOtp() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.otpValues.length,
          (index) => _buildInputOtpItem(index),
        ),
      ),
    );
  }

  Widget _buildInputOtpItem(int index) {
    return Container(
      width: AppDimens.btnDefault,
      height: AppDimens.btnDefault,
      margin:
          const EdgeInsets.symmetric(horizontal: AppDimens.paddingVerySmall),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
      child: Center(
        child: TextField(
          autofocus: index == 0,
          focusNode: controller.focusNodes[index],
          onChanged: (value) => controller.updateOtpValue(index, value),
          keyboardType: TextInputType.number,
          maxLength: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: AppDimens.fontMedium, color: AppColor.black),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildLableTextField() {
    return Text(
      StringConstants.inputOTP.tr,
      style: AppTextTheme.labelLarge(AppColor.white)?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget buildLableScreen() {
    return Text(
      StringConstants.verifyAccount.tr,
      style: AppTextTheme.headlineLarge(AppColor.primaryColor)?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
