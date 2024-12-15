import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/account_info/account_infor_binding.dart';
import 'package:tutorial/presentation/view/screen/account_info/account_infor_screen.dart';
import 'package:tutorial/presentation/view/screen/favourite_food/favourite_food_binding.dart';
import 'package:tutorial/presentation/view/screen/favourite_food/favourite_food_screen.dart';
import 'package:tutorial/presentation/view/screen/food_detail/food_detail_binding.dart';
import 'package:tutorial/presentation/view/screen/food_detail/ui/food_detail_screen.dart';
import 'package:tutorial/presentation/view/screen/forgot_password/forgot_pass_binding.dart';
import 'package:tutorial/presentation/view/screen/forgot_password/ui/forgot_pass_screen.dart';
import 'package:tutorial/presentation/view/screen/history/history_binding.dart';
import 'package:tutorial/presentation/view/screen/home/home_binding.dart';
import 'package:tutorial/presentation/view/screen/home/home_screen.dart';
import 'package:tutorial/presentation/view/screen/splash/splash_binding.dart';
import 'package:tutorial/presentation/view/screen/splash/splash_screen.dart';
import 'package:tutorial/presentation/view/screen/suggest_food/suggest_food_binding.dart';
import 'package:tutorial/presentation/view/screen/suggest_food/suggest_food_screen.dart';

import '../view/screen/history/history_screen.dart';
import '../view/screen/login/login_binding.dart';
import '../view/screen/login/login_screen.dart';
import '../view/screen/register/register_binding.dart';
import '../view/screen/register/register_screen.dart';
import '../view/screen/user_favourite_food/user_favourite_food_binding.dart';
import '../view/screen/user_favourite_food/user_favourite_food_screen.dart';
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
      name: AppRoute.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoute.registerScreen,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoute.forgotPassScreen,
      page: () => const ForgotPassScreen(),
      binding: ForgotPassBinding(),
    ),
    GetPage(
      name: AppRoute.suggestFoodSreen,
      page: () => const SuggestFoodScreen(),
      binding: SuggestFoodBinding(),
    ),
    GetPage(
      name: AppRoute.accountInforScreen,
      page: () => const AccountInforScreen(),
      binding: AccountInforBinding(),
    ),
    GetPage(
      name: AppRoute.foodDetailScreen,
      page: () => const FoodDetailScreen(),
      binding: FoodDetailBinding(),
    ),
    GetPage(
      name: AppRoute.favouriteFoodSreen,
      page: () => const FavouriteFoodScreen(),
      binding: FavouriteFoodBinding(),
    ),
    GetPage(
      name: AppRoute.userFavoriteScreen,
      page: () => const UserFavouriteFoodScreen(),
      binding: UserFavouriteFoodBinding(),
    ),
    GetPage(
      name: AppRoute.historyScreen,
      page: () => const HistoryScreen(),
      binding: HistoryBinding(),
    ),
  ];
}
