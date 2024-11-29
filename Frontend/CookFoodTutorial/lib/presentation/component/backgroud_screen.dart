import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/chat_box/chat_box_controller.dart';
import 'package:tutorial/presentation/view/screen/chat_box/chat_box_screen.dart';
import 'package:tutorial/presentation/view/widget/app_bottom_sheet.dart';
import 'package:tutorial/presentation/view/widget/app_image_widget.dart';
import 'package:tutorial/res/image/app_image.dart';

class BackGroundShare extends StatelessWidget {
  const BackGroundShare({
    super.key,
    this.body,
    this.padding,
    this.hasChatBox = false,
  });
  final bool hasChatBox;
  final Widget? body;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
          color: AppColors.black,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [
          //       AppColors.primaryText,
          //       AppColors.dsGray3,
          //     ],
          //   ),
          // ),
          child: body,
        ),
        floatingActionButton: hasChatBox
            ? InkWell(
                onTap: () {
                  Get.bottomSheet(
                    SDSBottomSheet(
                      title: 'Chat With AI',
                      body: ChatBoxScreen(),
                      miniSizeHeight: Get.height * 0.7,
                    ),
                    isScrollControlled: true,
                  );
                },
                child: ClipOval(
                  child: AppImageWidget.asset(
                    path: AppImage.icChatBox,
                    height: AppDimens.btnDefault,
                    width: AppDimens.btnDefault,
                    fit: BoxFit.cover,
                    isAsset: true,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
