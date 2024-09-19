import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryColor,
      outlineVariant: AppColor.primaryColor,
    ),
    fontFamily: "Lora",
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.textTheme(AppColor.primaryColor),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: AppColor.primaryColor,
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.all(Colors.white),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryColor,
      outlineVariant: AppColor.primaryColor.withOpacity(0.4),
    ),
    fontFamily: "Lora",
    scaffoldBackgroundColor: AppColor.primaryColor,
    textTheme: AppTextTheme.textTheme(AppColor.primaryColor),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.all(Colors.white),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
