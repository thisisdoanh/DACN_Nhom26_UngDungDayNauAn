import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    String? fontFamily = "Lora",
  }) {
    return AutoSizeText(text.tr,
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: Get.textTheme.bodySmall?.copyWith(
          color: textColor,
          fontWeight: fontWeight,
          overflow: overflow,
          fontSize: fontSize,
          fontStyle: fontStyle,
          fontFamily: fontFamily,
          decoration: decoration,
        ));
  }
}
