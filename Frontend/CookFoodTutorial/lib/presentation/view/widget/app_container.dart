import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/view/app_view.dart';

class AppContainer extends GetView {
  const AppContainer({
    super.key,
    this.appBar,
    this.canPop,
    this.onPopInvoked,
    this.bottomNavigationBar,
    this.child,
    this.backgroundColor,
    this.coverScreenWidget,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton,
    this.bgImage,
  });

  final PreferredSizeWidget? appBar;
  final bool? canPop;
  final Function(bool)? onPopInvoked;
  final Widget? bottomNavigationBar;
  final Widget? child;
  final Color? backgroundColor;
  final Widget? coverScreenWidget;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final String? bgImage;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop ?? true,
      onPopInvoked: onPopInvoked,
      child: Stack(
        children: [
          bgImage != null
              ? AppImageWidget.asset(
                  path: bgImage!,
                  width: Get.width,
                  height: Get.height,
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              backgroundColor: backgroundColor ?? (bgImage != null ? AppColor.transparent : AppColor.background),
              appBar: appBar,
              body: child ?? const SizedBox.shrink(),
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          ),
          coverScreenWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
