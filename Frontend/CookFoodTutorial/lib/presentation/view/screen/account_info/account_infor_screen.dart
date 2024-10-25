import 'package:flutter/material.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/screen/account_info/account_infor_controller.dart';
import 'package:tutorial/presentation/view/widget/app_text_field.dart';

class AccountInforScreen extends AppBaseScreen<AccountInforController> {
  const AccountInforScreen({super.key});

  @override
  Widget buildWidget() {
    return BackGroundShare(
      body: Column(
        children: [
          AppBarShare(
            hasBackIcon: true,
          ),
          ClipOval(
            child: Icon(
              Icons.face,
              size: 60,
            ),
          ),
          AppTextField(
            maxLines: 1,
            maxLength: 255,
            backgroundColor: AppColor.transparent,
            prefixIcon: Icon(Icons.person),
            readOnly: controller.canEdit.value,
            // textEditingController: controller.verifyPasswordCtrl,
            // errorText: controller.verifyPassError.value,
            // onChanged: controller.onChangeVerifyPass,
          ),
        ],
      ),
    );
  }
}
