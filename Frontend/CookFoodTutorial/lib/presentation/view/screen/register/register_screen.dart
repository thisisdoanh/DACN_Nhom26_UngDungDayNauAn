import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/screen/register/register_controller.dart';

import '../../../../res/string/app_string.dart';
import '../../widget/app_button.dart';

class RegisterScreen extends AppBaseScreen<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget buildWidget() {
    return AppContainer(
      bgImage: AppImage.imgBgFood,
      resizeToAvoidBottomInset: true,
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
                    StringConstants.register.tr,
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
                          path: AppImage.icUser,
                        ),
                      ),
                      hintText: StringConstants.name.tr,
                      keyboardType: TextInputType.text,
                      errorText: controller.firstErrorText.value,
                      onChanged: controller.onFirstInputChange,
                      textEditingController: controller.nameTextEditingController,
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
                          path: AppImage.icEmail,
                        ),
                      ),
                      hintText: StringConstants.email.tr,
                      keyboardType: TextInputType.emailAddress,
                      errorText: controller.secondErrorText.value,
                      onChanged: controller.onSecondInputChange,
                      textEditingController: controller.emailTextEditingController,
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
                      suffixIcon: AppTouchable(
                        onPressed: () => controller.onPressShowPassword(),
                        child: Icon(
                          controller.isHidePass.value ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.white,
                          size: 24.sp,
                        ),
                      ),
                      isHide: controller.isHidePass.value,
                      errorText: controller.thirdErrorText.value,
                      onChanged: controller.onThirdInputChange,
                      textEditingController: controller.passwordTextEditingController,
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
                      hintText: StringConstants.rePassword.tr,
                      isHide: controller.isHidePass.value,
                      suffixIcon: AppTouchable(
                        onPressed: () => controller.onPressShowPassword(),
                        child: Icon(
                          controller.isHidePass.value ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.white,
                          size: 24.sp,
                        ),
                      ),
                      errorText: controller.fourthErrorText.value,
                      onChanged: controller.onFourthInputChange,
                      textEditingController: controller.rePasswordTextEditingController,
                    ),
                  ),
                  Gap(32.h),
                  AppButton(
                    onPressed: () => controller.onPressRegister(),
                    borderRadius: BorderRadius.circular(20.sp),
                    width: 344.w,
                    height: 56.h,
                    color: AppColors.primaryColor,
                    child: Text(
                      StringConstants.register.tr,
                      style:
                          AppTextTheme.headlineSmall(AppColors.white)?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                StringConstants.doYouHaveAccount.tr,
                style: AppTextTheme.titleMedium(AppColors.white)?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppTouchable(
                onPressed: () => controller.onPressLogin(),
                child: Text(
                  StringConstants.login.tr,
                  style: AppTextTheme.titleMedium(AppColors.primaryColor)
                      ?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Gap(Get.mediaQuery.padding.bottom),
        ],
      ),
    );
  }
}