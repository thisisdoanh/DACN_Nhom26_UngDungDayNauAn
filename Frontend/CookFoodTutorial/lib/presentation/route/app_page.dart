import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/splash/splash_binding.dart';
import 'package:tutorial/presentation/view/screen/splash/splash_screen.dart';

import '../view/screen/login/login_binding.dart';
import '../view/screen/login/login_screen.dart';
import '../view/screen/register/register_binding.dart';
import '../view/screen/register/register_screen.dart';
import 'app_route.dart';

class AppPage {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoute.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoute.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoute.registerScreen,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
  ];
}
