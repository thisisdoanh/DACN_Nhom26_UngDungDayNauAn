import 'package:flutter/material.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';

class BackGroundShare extends StatelessWidget {
  const BackGroundShare({
    super.key,
    this.body,
    this.padding,
  });
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
      ),
    );
  }
}
