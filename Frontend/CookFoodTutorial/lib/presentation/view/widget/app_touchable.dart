import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_color.dart';

class AppTouchable extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onLongPressed;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? rippleColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final OutlinedBorder? outlinedBorder;
  final BoxDecoration? decoration;

  const AppTouchable({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.rippleColor,
    this.padding,
    this.margin,
    this.outlinedBorder,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.zero,
      decoration: decoration,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPressed ?? () {},
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(backgroundColor ?? Colors.transparent),
          overlayColor:
              WidgetStateProperty.all(rippleColor ?? Colors.transparent),
          foregroundColor:
              WidgetStateProperty.all(foregroundColor ?? AppColors.black),
          shape: WidgetStateProperty.all(
            outlinedBorder ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0.sp),
                ),
          ),
          padding: WidgetStateProperty.all(padding ?? EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.standard,
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
