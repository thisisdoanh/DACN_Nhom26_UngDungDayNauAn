import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextTheme {
  AppTextTheme._();

  static String defaultFontFamily = "Lora";

  static TextStyle? displayLarge(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 57.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? displayMedium(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 45.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? displaySmall(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 36.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? headlineLarge(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 32.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? headlineMedium(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 28.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? headlineSmall(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 24.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    );
  }

  static TextStyle? titleLarge(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 22.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
    );
  }

  static TextStyle? titleMedium(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    );
  }

  static TextStyle? titleSmall(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    );
  }

  static TextStyle? labelLarge(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 18.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    );
  }

  static TextStyle? labelMedium(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? labelSmall(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? bodyLarge(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    );
  }

  static TextStyle? bodyMedium(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    );
  }

  static TextStyle? bodySmall(Color textColor, {String fontFamily = ""}) {
    return TextStyle(
      color: textColor,
      fontFamily: fontFamily.isEmpty ? defaultFontFamily : fontFamily,
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    );
  }

  static TextTheme textTheme(Color textColor, {String fontFamily = ""}) => TextTheme(
        bodyLarge: bodyLarge(textColor),
        bodyMedium: bodyMedium(textColor),
        bodySmall: bodySmall(textColor),
        displayLarge: displayLarge(textColor),
        displayMedium: displayMedium(textColor),
        displaySmall: displaySmall(textColor),
        headlineLarge: headlineLarge(textColor),
        headlineMedium: headlineMedium(textColor),
        headlineSmall: headlineSmall(textColor),
        labelLarge: labelLarge(textColor),
        labelMedium: labelMedium(textColor),
        labelSmall: labelSmall(textColor),
        titleLarge: titleLarge(textColor),
        titleMedium: titleMedium(textColor),
        titleSmall: titleSmall(textColor),
      );
}
