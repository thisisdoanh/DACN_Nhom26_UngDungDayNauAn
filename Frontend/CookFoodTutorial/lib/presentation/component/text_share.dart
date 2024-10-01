import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilWidget {
  static Widget buildText(
    String text, {
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Color? textColor,
    int? maxLines,
    double? fontSize,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) {
    final defaultTextStyle = Get.textTheme.bodySmall?.copyWith(
      color: textColor,
      fontWeight: fontWeight,
      overflow: overflow,
      fontSize: fontSize,
      fontStyle: fontStyle,
      decoration: decoration,
    );
    return Text(
      text.tr,
      maxLines: maxLines,
      textAlign: textAlign,
      style: textStyle ?? defaultTextStyle,
    );
  }
}
