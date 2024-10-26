import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';

class SDSBottomSheet extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? iconTitle;
  final double? miniSizeHeight;
  final Function()? onPressed;
  final Widget? actionArrowBack;
  final double? padding;
  final double? paddingBottom;
  final double? paddingTop;
  final bool noAppBar;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final double? maxWidth;
  final AlignmentGeometry? alignment;
  final double? paddingPage;
  const SDSBottomSheet({
    super.key,
    required this.title,
    required this.body,
    this.iconTitle,
    this.miniSizeHeight,
    this.onPressed,
    this.actionArrowBack,
    this.padding,
    this.paddingBottom,
    this.paddingTop,
    this.noAppBar = false,
    this.backgroundColor,
    this.textAlign,
    this.maxWidth,
    this.alignment,
    this.paddingPage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingPage ?? AppDimens.paddingVerySmall,
          ),
          constraints: BoxConstraints(
            maxWidth: AppDimens.bottomSheetMaxWidth(maxWidth: maxWidth),
            maxHeight: miniSizeHeight ?? Get.height / 2,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.colorBackgrounDialog,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(
                AppDimens.radius16,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(12.h),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 6,
                  width: AppDimens.widthChip,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppDimens.radius16)),
                ),
              ),
              noAppBar
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title.tr,
                            textAlign: textAlign ?? TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.titleLarge!.copyWith(),
                          ).paddingOnly(left: AppDimens.defaultPadding),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: actionArrowBack ??
                              const CloseButton(
                                color: AppColors.primaryColor,
                              ),
                        ),
                        iconTitle ?? const SizedBox(),
                      ],
                    ),
              Expanded(
                child: body,
              ),
            ],
          ).paddingSymmetric(
            horizontal: padding ?? 0,
          ),
        ),
      ).paddingOnly(
        bottom: paddingBottom ?? 0,
        top: paddingTop ?? 0,
      ),
    );
  }
}
