import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/screen/login/login_controller.dart';
import 'package:tutorial/presentation/view/widget/app_outline_button.dart';
import 'package:tutorial/res/string/app_string.dart';

class LoginScreen extends AppBaseScreen<LoginController> {
  const LoginScreen({super.key});

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
                      color: AppColor.white,
                      fontSize: 37.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    StringConstants.cookingIsEasy.tr,
                    style: AppTextTheme.titleMedium(
                      AppColor.white,
                    ),
                  ),
                  Gap(28.h),
                  Text(
                    StringConstants.login.tr,
                    style: AppTextTheme.headlineLarge(AppColor.white)?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(40.h),
                  Obx(
                    () => AppTextField(
                      maxLines: 1,
                      maxLength: 255,
                      backgroundColor: AppColor.transparent,
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
                      errorText: controller.firstErrorText.value,
                      onChanged: controller.onFirstInputChange,
                    ),
                  ),
                  Gap(8.h),
                  Obx(
                    () => AppTextField(
                      maxLines: 1,
                      maxLength: 255,
                      backgroundColor: AppColor.transparent,
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
                      isHide: !controller.isShowPass.value,
                      suffixIcon: AppTouchable(
                        onPressed: () => controller.onPressShowPassword(),
                        child: Icon(
                          controller.isShowPass.value ? Icons.visibility_off : Icons.visibility,
                          color: AppColor.white,
                          size: 24.sp,
                        ),
                      ),
                      textEditingController: controller.passwordTextEditingController,
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
                        style: AppTextTheme.bodyLarge(AppColor.primaryColor),
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
                  AppOutlineButton(
                    onPressed: () => controller.onPressLogin(),
                    borderRadius: BorderRadius.circular(20.sp),
                    width: 344.w,
                    height: 56.h,
                    child: Text(
                      StringConstants.login.tr,
                      style: AppTextTheme.headlineSmall(AppColor.white)?.copyWith(
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
                StringConstants.doNotHaveAccount.tr,
                style: AppTextTheme.titleMedium(AppColor.white)?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppTouchable(
                onPressed: () => controller.onPressRegister(),
                child: Text(
                  StringConstants.register.tr,
                  style: AppTextTheme.titleMedium(AppColor.primaryColor)?.copyWith(
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
