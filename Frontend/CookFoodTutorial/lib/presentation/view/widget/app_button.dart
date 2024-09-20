import 'package:flutter/material.dart';

import '../app_view.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final EdgeInsets? padding, margin;
  final BorderRadius? borderRadius;
  final Widget child;
  final double? width, height;
  final Color? color;

  const AppButton({
    super.key,
    this.onPressed,
    this.padding,
    this.margin,
    this.borderRadius,
    required this.child,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      width: width,
      height: height,
      onPressed: onPressed,
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? AppColor.transparent,
        shape: BoxShape.rectangle,
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      child: child,
    );
  }
}
