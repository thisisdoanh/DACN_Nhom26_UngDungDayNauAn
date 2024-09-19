import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutorial/common/utils/app_log.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/screen/login/login_controller.dart';
import 'package:tutorial/res/string/app_string.dart';

class LoginScreen extends AppBaseScreen<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget buildWidget() {
    return AppContainer(
      bgImage: AppImage.imgBgFood,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            StringConstants.cookingIsEasy.tr.toUpperCase(),
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
          Row(
            children: [
              AppTouchable(
                  onPressed: () async {
                    try {
                      await GoogleSignIn().signOut();
                      var user = await GoogleSignIn().signIn();
                      AppLog.info(user, tag: "Google sign in");
                    } catch (e) {
                      AppLog.error(e, tag: "Google sign in");
                    }
                  },
                  child: Text("Login")),
            ],
          ),
        ],
      ),
    );
  }
}
