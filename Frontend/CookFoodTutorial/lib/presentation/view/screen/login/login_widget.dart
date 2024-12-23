part of 'package:tutorial/presentation/view/screen/login/login_screen.dart';

extension LoginWidget on LoginScreen {
  Widget _buildSettingBiometric() {
    return Obx(
      () => Center(
        child: controller.isShowLoading.value
            ? const CupertinoActivityIndicator()
            : Container(
                margin:
                    const EdgeInsetsDirectional.all(AppDimens.paddingMedium),
                padding:
                    const EdgeInsetsDirectional.all(AppDimens.paddingMedium),
                decoration: BoxDecoration(
                  color: AppColors.colorBackgrounDialog,
                  borderRadius: BorderRadius.circular(AppDimens.radius16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UtilWidget.buildText(
                      'Nhập mật khẩu để bật sinh trắc học',
                      fontWeight: FontWeight.bold,
                      maxLines: 4,
                      textAlign: TextAlign.start,
                      fontSize: AppDimens.fontMedium,
                    ),
                    Gap(5.h),
                    UtilWidget.buildText(
                      'Xác thực mật khẩu sinh trắc học',
                      textAlign: TextAlign.start,
                      fontSize: AppDimens.fontSmall,
                    ),
                    Gap(5.h),
                    _buildPassword(controller),
                    Gap(5.h),
                    Row(
                      children: [
                        _buildBtnConfirm(isConfirm: false),
                        Gap(12.w),
                        _buildBtnConfirm(
                          onConfirm: () async {
                            await controller.onPressLogin(isBiometric: true);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _promptBiometricSetup() {
    Get.dialog(
      Center(
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
              Row(
                children: [
                  _buildBtnConfirm(isConfirm: false),
                  Gap(12.w),
                  _buildBtnConfirm(
                    onConfirm: () => controller.biometricAuth(
                      func: () => _formSettingBio(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _formSettingBio() {
    Get.dialog(
      _buildSettingBiometric(),
    );
    controller.passSetBiometricController.clear();
  }

  Widget _buildButtonBiometric() {
    return BiometricLogin(
      func: () {
        if (PreferenceUtils.getBool(AppKey.keyCheckBiometric) == true) {
          controller.biometricAuth(func: () {
            controller.passwordTextEditingController.text =
                PreferenceUtils.getString(AppKey.keyPassword) ?? '';
            Get.toNamed(AppRoute.homeScreen);
          });
        } else {
          _promptBiometricSetup();
        }
      },
    );
  }

  Widget _buildPassword(LoginController controller) {
    return Obx(
      () => Material(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12),
        child: AppTextField(
          maxLines: 1,
          maxLength: 255,
          backgroundColor: AppColors.black,
          borderRadius: BorderRadius.circular(12),
          hintText: StringConstants.password.tr,
          isHide: !controller.isHidePass.value,
          outlineColor: AppColors.black,
          border: Border.all(color: AppColors.black, width: 1),
          suffixIcon: AppTouchable(
            onPressed: () => controller.onPressShowPassword(),
            child: Icon(
              controller.isHidePass.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: AppColors.dsGray2,
              size: 24.sp,
            ),
          ),
          textEditingController: controller.passwordTextEditingController,
          errorText: controller.secondErrorText.value,
          onChanged: controller.onSecondInputChange,
        ),
      ).paddingSymmetric(vertical: 12),
    );
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
      "Bạn chưa cài đặt sinh trắc học, bạn có muốn cài đặt không?",
      fontSize: AppDimens.fontSmall,
      maxLines: 4,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildDivider() => const Divider(
        color: AppColors.dsGray3,
        thickness: 0.5,
      ).paddingSymmetric(vertical: AppDimens.paddingVerySmall);
}
