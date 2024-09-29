// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  });
  final bool hasBackIcon;
  final String? title;
  final Widget? leading;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.transparent,
      title: title != null
          ? UtilWidget.buildText(title!)
          : const SizedBox.shrink(),
      leading: hasBackIcon
          ? IconButton(
              onPressed: Get.back,
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: AppColor.primaryColor,
                size: AppDimens.fontLargest,
              ),
            )
          : leading,
      actions: [action ?? const SizedBox.shrink()],
    );
  }
}
