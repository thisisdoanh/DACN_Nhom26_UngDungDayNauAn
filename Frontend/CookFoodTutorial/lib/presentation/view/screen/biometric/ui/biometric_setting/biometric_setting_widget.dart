part of 'biometric_setting.dart';

extension BiometricWidget on BiometricSetting {
  Widget _buildBiometricSetting() {
    return Row(children: [
      SvgPicture.asset(
              colorFilter:
                  const ColorFilter.mode(SharedColors.dsGray2, BlendMode.srcIn),
              width: AppDimens.btnDsIcon,
              controller.biometric.value.iconSvg)
          .paddingSymmetric(horizontal: AppDimens.paddingItemList),
      Expanded(
        child: ItemUtils.itemSwitch(
          title: LocaleKeys.biometric_loginWithBiometric.trParams({
            'biometric': controller.biometric.value.title,
          }),
          value: controller.checkSetBiometric.value,
          onChanged: (_) async {
            await controller.authCheck(child: _passAuthWidget());
          },
        ),
      ),
    ]).paddingSymmetric(vertical: AppDimens.defaultPadding);
  }

  Widget _passAuthWidget() {
    return Obx(
      () => Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UtilWidget.buildText(
              LocaleKeys.biometric_password.tr,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start,
              fontSize: AppDimens.fontMedium(),
            ),
            sdsSizedBox5,
            UtilWidget.buildText(
              LocaleKeys.biometric_enterPassword.tr,
              textAlign: TextAlign.start,
              fontSize: AppDimens.fontSmall(),
            ),
            sdsSizedBoxDefault,
            _buildPassword(),
            sdsSizedBoxDefault,
            if (controller.wrongPassword.value) ...[
              UtilWidget.buildText(LocaleKeys.login_loginPasswordNotCorrect,
                  textAlign: TextAlign.start,
                  fontSize: AppDimens.fontSmall(),
                  textColor: AppColors.colorRed444),
              sdsSizedBoxDefault,
            ],
            SDSBackConfirmButton(
              titleLeft: LocaleKeys.label_cancel,
              titleRight: LocaleKeys.label_accept,
              isBottom: false,
              functionLeft: () {
                Get.back();
                controller.passwordController.clear();
                controller.wrongPassword.value = false;
              },
              function: () async => await controller.checkPassword(),
            ),
          ],
        ),
      ).paddingAll(AppDimens.defaultPadding),
    );
  }

  Widget _buildPassword() {
    return SDSInputWithLabel(
      inputLabelModel: SDSInputLabelModel(
        label: '',
        isValidate: true,
        labelTextStyle: const TextStyle(
          color: AppColors.dsGray2,
          fontWeight: FontWeight.bold,
        ),
        paddingLabel: EdgeInsets.zero,
      ),
      inputTextFormModel: SDSInputTextModel(
        controller: controller.passwordController,
        iconLeading: Icons.lock,
        paddingModel: EdgeInsets.zero,
        hintText: LocaleKeys.login_password.tr,
        obscureText: true,
        submitFunc: (v) async => await controller.checkPassword(),
        focusNode: controller.passwordFocus,
        inputFormatters: InputFormatterEnum.password,
        fillColor: Colors.transparent,
        iconNextTextInputAction: TextInputAction.done,
        prefixIconColor: AppColors.dsPrimaryBlueBlue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius4),
          borderSide: const BorderSide(
            width: AppDimens.borderDefault,
            color: AppColors.dsGray3,
          ),
        ),
        validator: (value) {
          if (value != null && (value.length < 6 || value.length > 50)) {
            return LocaleKeys.login_errorPassword.tr;
          }
          return null;
        },
      ),
    );
  }
}
