import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      outlineVariant: AppColors.primaryColor,
    ),
    fontFamily: "Lora",
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.textTheme(AppColors.primaryColor),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: AppColors.primaryColor,
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

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      outlineVariant: AppColors.primaryColor.withOpacity(0.4),
    ),
    fontFamily: "Lora",
    primaryIconTheme: const IconThemeData(color: AppColors.white),
    iconTheme: const IconThemeData(color: AppColors.white),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(AppColors.white),
      ),
    ),
    scaffoldBackgroundColor: AppColors.black,
    textTheme: AppTextTheme.textTheme(AppColors.white),
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
