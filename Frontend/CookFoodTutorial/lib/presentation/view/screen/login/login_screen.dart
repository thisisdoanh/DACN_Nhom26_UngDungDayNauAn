import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/data/share_preference_utils.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/route/app_route.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/resources/app_key.dart';
import 'package:tutorial/presentation/view/screen/biometric/ui/biometric_login/biometric_login.dart';
import 'package:tutorial/presentation/view/screen/login/login_controller.dart';
import 'package:tutorial/presentation/view/widget/app_outline_button.dart';
import 'package:tutorial/res/string/app_string.dart';

part 'package:tutorial/presentation/view/screen/login/login_widget.dart';

class LoginScreen extends AppBaseScreen<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget buildWidget() {
    return AppContainer(
      bgImage: AppImage.imgBgFood,
      resizeToAvoidBottomInset: true,
      canPop: true,
      child: SafeArea(
        top: true,
        child: Column(
          children: [
            Expanded(
              child: AppScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 35.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(80.h),
                    AppImageWidget.asset(
                      path: AppImage.imgLogo,
                      width: 136.w,
                    ),
                    Text(
                      StringConstants.deliciousCooking.tr.toUpperCase(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 37.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      StringConstants.cookingIsEasy.tr,
                      style: AppTextTheme.titleMedium(
                        AppColors.white,
                      ),
                    ),
                    Gap(28.h),
                    Text(
                      StringConstants.login.tr,
                      style:
                          AppTextTheme.headlineLarge(AppColors.white)?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(40.h),
                    Obx(
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
                        textEditingController:
                            controller.emailTextEditingController,
                        errorText: controller.firstErrorText.value,
                        onChanged: controller.onFirstInputChange,
                      ),
                    ),
                    Gap(8.h),
                    Obx(
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
                        hintText: StringConstants.password.tr,
                        isHide: controller.isHidePass.value,
                        suffixIcon: AppTouchable(
                          onPressed: () => controller.onPressShowPassword(),
                          child: Icon(
                            controller.isHidePass.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                        ),
                        textEditingController:
                            controller.passwordTextEditingController,
                        errorText: controller.secondErrorText.value,
                        onChanged: controller.onSecondInputChange,
                      ),
                    ),
                    Gap(8.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppTouchable(
                        onPressed: () => controller.onPressForgotPass(),
                        child: Text(
                          StringConstants.forgotPass.tr,
                          style: AppTextTheme.bodyLarge(AppColors.primaryColor),
                        ),
                      ),
                    ),
                    Gap(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTouchable(
                          onPressed: () => controller.onPressLoginWithGoogle(),
                          child: AppImageWidget.asset(
                            path: AppImage.icGoogle,
                            width: 32.sp,
                            height: 32.sp,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppOutlineButton(
                          onPressed: () => controller.onPressLogin(),
                          borderRadius: BorderRadius.circular(20.sp),
                          height: 56.h,
                          child: Text(
                            StringConstants.login.tr,
                            style: AppTextTheme.headlineSmall(AppColors.white)
                                ?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Gap(16.w),
                        _buildButtonBiometric(),
                      ],
                    ),
                    Gap(80.h),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringConstants.doNotHaveAccount.tr,
                  style: AppTextTheme.titleMedium(AppColors.white)?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppTouchable(
                  onPressed: () => controller.onPressRegister(),
                  child: Text(
                    StringConstants.register.tr,
                    style: AppTextTheme.titleMedium(AppColors.primaryColor)
                        ?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
