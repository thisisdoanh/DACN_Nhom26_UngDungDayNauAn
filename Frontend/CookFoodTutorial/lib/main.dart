import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tutorial/common/constants/app_constants.dart';
import 'package:tutorial/presentation/route/app_route.dart';
import 'package:tutorial/res/string/app_string.dart';

import 'data/share_preference_utils.dart';
import 'presentation/base/app_binding.dart';
import 'presentation/route/app_page.dart';
import 'presentation/view/resources/app_theme.dart';

void main() {
  mainDelegate();
}

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await PreferenceUtils.init();

  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, widget) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AppBinding(),
        initialRoute: AppRoute.suggestFoodSreen,
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 500),
        getPages: AppPage.pages,
        theme: AppTheme.lightTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        translations: AppString(),
        supportedLocales: AppConstants.availableLocales,
        locale: AppConstants.availableLocales[0],
        fallbackLocale: AppConstants.availableLocales[0],
      ),
    ),
  );
}
