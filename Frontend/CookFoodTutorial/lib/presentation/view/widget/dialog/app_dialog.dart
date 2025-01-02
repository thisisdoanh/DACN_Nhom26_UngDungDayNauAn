import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? messageWidget;
  final bool dismissAble;
  final Widget? widgetBody;
  final Widget? widgetTopRight;
  final Widget? coverScreenWidget;
  final String firstButtonText;
  final VoidCallback? firstButtonCallback;
  final String? secondButtonText;
  final VoidCallback? secondButtonCallback;
  final Color? backgroundColor;
  final double? heightDialog;
  final double? widthDialog;
  final bool? hideGroupButton;
  final Widget? fullContentWidget;
  final EdgeInsetsGeometry? padding;

  const AppDialog({
    super.key,
    this.title,
    this.message,
    this.messageWidget,
    this.dismissAble = false,
    this.widgetBody,
    this.widgetTopRight,
    this.coverScreenWidget,
    required this.firstButtonText,
    this.firstButtonCallback,
    this.secondButtonText,
    this.secondButtonCallback,
    this.backgroundColor,
    this.heightDialog,
    this.widthDialog,
    this.hideGroupButton,
    this.fullContentWidget,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var dialogWidth = min<double>(width * 0.9, 400.0.sp);

    return PopScope(
      canPop: true,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.sp),
        ),
        elevation: 0.0,
        backgroundColor: backgroundColor ?? Colors.white,
        child: Stack(
          children: [
            fullContentWidget ??
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(12.0.sp),
                  ),
                  width: widthDialog ?? dialogWidth,
                  height: heightDialog,
                  padding: padding ??
                      EdgeInsets.symmetric(
                        vertical: 12.0.sp,
                        horizontal: 16.0.sp,
                      ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (title ?? '').isNotEmpty
                          ? Text(
                              title!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0.sp,
                                fontWeight: FontWeight.w400,
                                height: 24 / 20,
                              ),
                            )
                          : const SizedBox.shrink(),
                      widgetBody ??
                          Column(
                            children: [
                              (message ?? '').isEmpty
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20.0.sp,
                                      ),
                                      child: Text(
                                        message!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                              messageWidget ?? const SizedBox.shrink(),
                            ],
                          ),
                    ],
                  ),
                ),
            Positioned.fill(
              child: coverScreenWidget ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
