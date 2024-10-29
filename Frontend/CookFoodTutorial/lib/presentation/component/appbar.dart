import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';

class AppBarShare extends StatelessWidget {
  const AppBarShare({
    super.key,
    this.hasBackIcon = false,
    this.title,
    this.leading,
    this.action,
    this.bgColor,
  });
  final bool hasBackIcon;
  final String? title;
  final Widget? leading;
  final Widget? action;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: !hasBackIcon && leading == null ? 0 : null,
      titleSpacing: 0,
      backgroundColor: bgColor ?? AppColors.transparent,
      title: title != null
          ? UtilWidget.buildText(
              title!,
              textAlign: TextAlign.start,
              fontSize: AppDimens.fontLarge,
              textColor: AppColors.white,
              fontWeight: FontWeight.bold,
            )
          : const SizedBox.shrink(),
      leading: hasBackIcon
          ? IconButton(
              onPressed: Get.back,
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: AppColors.primaryColor,
                size: AppDimens.sizeImage35,
              ),
            )
          : leading,
      actions: [action ?? const SizedBox.shrink()],
    );
  }
}
