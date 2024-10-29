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
      leadingWidth: (hasBackIcon || leading != null) ? null : 0,
      titleSpacing: 0,
      backgroundColor: bgColor ?? AppColors.transparent,
      title: _buildTitle(),
      leading: _buildLeading(),
      actions: [action ?? const SizedBox()],
    );
  }

  Widget? _buildTitle() {
    return title != null
        ? UtilWidget.buildText(
            title!,
            textAlign: TextAlign.start,
            fontSize: AppDimens.fontLarge,
            textColor: AppColors.white,
            fontWeight: FontWeight.bold,
          )
        : null;
  }

  Widget? _buildLeading() {
    if (hasBackIcon) {
      return Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: AppColors.primaryColor,
            size: AppDimens.sizeImage35,
          ),
        ),
      );
    }
    return leading;
  }
}
