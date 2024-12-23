part of 'biometric_setting.dart';

extension BiometricWidget on BiometricSetting {
  Widget _buildBiometricSetting() {
    return Row(
      children: [
        AppImageWidget.asset(
          path: controller.biometric.value.iconSvg,
          height: 28.sp,
          width: 28.sp,
          color: Colors.white,
        ),
        Gap(20.w),
        Expanded(
          child: Text(
            controller.biometric.value.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        CupertinoSwitch(
          trackColor: AppColors.dsGray1,
          activeColor: AppColors.primaryColor,
          value: controller.haveBiometric.value,
          onChanged: (_) {
            Get.dialog(
              _buildDialogBiometric(),
              barrierColor: AppColors.transparent,
            );
          },
        ),
      ],
    );
  }

  Widget _buildDialogBiometric() {
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
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UtilWidget.buildText(
                  'Mật khẩu sinh trắc học',
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  fontSize: AppDimens.fontMedium,
                ),
                const Gap(5),
                UtilWidget.buildText(
                  'Nhập mật khẩu sinh trắc học',
                  textAlign: TextAlign.start,
                  fontSize: AppDimens.fontSmall,
                ),
                const Gap(5),
                _buildPassword(),
                const Gap(5),
                if (controller.wrongPassword.value) ...[
                  UtilWidget.buildText('Mật khẩu không chính xác',
                      textAlign: TextAlign.start,
                      fontSize: AppDimens.fontSmall,
                      textColor: AppColors.colorRedError),
                ],
                const Gap(5),
                Row(
                  children: [
                    _buildBtnConfirm(isConfirm: false),
                    Gap(12.w),
                    _buildBtnConfirm(
                      onConfirm: controller.checkPassword,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget _buildPassword() {
    return Material(
      color: AppColors.black,
      borderRadius: BorderRadius.circular(12),
      child: AppTextField(
        maxLines: 1,
        maxLength: 255,
        backgroundColor: AppColors.black,
        borderRadius: BorderRadius.circular(12),
        hintText: StringConstants.password.tr,
        isHide: controller.isHidePass.value,
        outlineColor: AppColors.black,
        border: Border.all(color: AppColors.black),
        suffixIcon: AppTouchable(
          onPressed: controller.isHidePass.toggle,
          child: Icon(
            controller.isHidePass.value
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.dsGray4,
            size: 24.sp,
          ),
        ),
        textEditingController: controller.passwordController,
      ),
    );
  }
}
