import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/image/app_image.dart';
import '../app_view.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final String? hintContent;
  final String? hintTitle;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget? middleWidget;
  final Widget? extendWidget;
  final CrossAxisAlignment? crossAxisAlignmentMainRow;

  const AppHeader({
    super.key,
    this.title,
    this.leftWidget,
    this.rightWidget,
    this.middleWidget,
    this.extendWidget,
    this.crossAxisAlignmentMainRow,
    this.hintContent,
    this.hintTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0.0,
        MediaQuery.of(context).padding.top + 12.0.sp,
        0.0,
        8.0.sp,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
            child: Row(
              crossAxisAlignment:
                  crossAxisAlignmentMainRow ?? CrossAxisAlignment.center,
              children: [
                leftWidget ??
                    AppTouchable(
                      width: 40.0.sp,
                      height: 40.0.sp,
                      onPressed: Get.back,
                      child: AppImageWidget.asset(
                        path: AppImage.icBack,
                      ),
                    ),
                Expanded(
                  child: middleWidget ??
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextTheme.displayLarge(AppColors.black),
                      ),
                ),
                rightWidget ?? SizedBox(width: 40.0.sp),
              ],
            ),
          ),
          extendWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
