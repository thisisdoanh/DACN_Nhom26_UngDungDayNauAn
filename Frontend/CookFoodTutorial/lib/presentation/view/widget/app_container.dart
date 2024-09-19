import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/app_color.dart';

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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop ?? false,
      onPopInvoked: onPopInvoked,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              backgroundColor: backgroundColor ?? AppColor.background,
              appBar: appBar,
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: child ?? const SizedBox.shrink(),
              ),
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
