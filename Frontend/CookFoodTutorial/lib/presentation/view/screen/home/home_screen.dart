import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/component/food_suggest_item_small.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/route/app_route.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/screen/home/home_controller.dart';
import 'package:tutorial/res/string/app_string.dart';

import '../../resources/app_dimen.dart';

class HomeScreen extends AppBaseScreen<HomeController> {
  const HomeScreen({super.key});

  Widget _buildAppbar() {
    return Builder(
      builder: (context) => AppBarShare(
        leading: AppTouchable(
          margin: EdgeInsets.only(left: 16.w),
          onPressed: () {
            Scaffold.of(context).openDrawer();
            // controller.advancedDrawerController.showDrawer();
          },
          child: Center(
            child: AppImageWidget.asset(
              path: AppImage.icMenu,
              height: 24.sp,
              width: 24.sp,
            ),
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            size: AppDimens.sizeImage35,
          ),
        ),
      ),
    );
  }

  Widget _buildTextHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: StringConstants.hello.tr,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' Denny',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        UtilWidget.buildText(
          StringConstants.whatWantToCook,
          fontWeight: FontWeight.w700,
          fontSize: 35.sp,
          maxLines: 2,
        ),
        Gap(10.h),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildHighRatingList() {
    final double itemWidth = Get.width / 2.5;
    return Column(
      children: [
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UtilWidget.buildText(
              StringConstants.mostFavourite,
              textColor: AppColors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            InkWell(
              onTap: () => controller.onPressFavorite(),
              child: UtilWidget.buildText(
                StringConstants.seeAll,
                textColor: AppColors.primaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Gap(10.h),
        SizedBox(
          height: 210.h,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  min(controller.appController.listRecipeHighRating.length, 5),
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                height: 210.h,
                width: itemWidth,
                margin: EdgeInsets.only(
                  right: 10.w,
                ),
                child: FoodCard(
                  recipeModel:
                      controller.appController.listRecipeHighRating[index],
                  timerIcon: Icons.timer,
                  timerColor: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestList() {
    return Column(
      children: [
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UtilWidget.buildText(
              StringConstants.suggest,
              textColor: AppColors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            InkWell(
              onTap: () => Get.toNamed(
                AppRoute.suggestFoodSreen,
              ),
              child: UtilWidget.buildText(
                StringConstants.seeAll,
                textColor: AppColors.primaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        Gap(10.h),
        Obx(
          () => ListView.separated(
            itemCount:
                min(controller.appController.listRecipeRandom.length, 10),
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) {
              return Container(
                height: 8.sp,
              );
            },
            itemBuilder: (context, index) => FoodSuggestItemSmall(
                recipeModel: controller.appController.listRecipeRandom[index]),
          ),
        ),
        Gap(20.h),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        border: Border.all(
          color: AppColors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: SearchField<RecipeModel>(
              suggestionStyle:
                  const TextStyle(fontSize: 18, color: Colors.pink),
              suggestions: controller.appController.listRecipe
                  .map(
                    (element) => SearchFieldListItem<RecipeModel>(
                      element.recipeName ?? "Unknown",
                      item: element,
                      child: Text(
                        element.recipeName ?? "Unknown",
                      ),
                    ),
                  )
                  .toList(),
              onSuggestionTap: (p0) {
                controller.onPressItemRecipe(p0.item);
              },
              searchInputDecoration: SearchInputDecoration(
                hintText: StringConstants.searchRecipe.tr,
                hintStyle: AppTextTheme.labelLarge(AppColors.dsGray4),
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColors.white,
                ),
                cursorColor: AppColors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              ),
              suggestionsDecoration: SuggestionDecoration(
                color: AppColors.colorBackgrounDialog,
                borderRadius: BorderRadius.circular(20.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          foregroundImage: NetworkImage(
            "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=338&ext=jpg&ga=GA1.1.933601817.1727827200&semt=ais_hybrid",
          ),
          radius: 50,
        ),
        Gap(12.sp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Denny',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              UtilWidget.buildText(
                StringConstants.personalInfo,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              )
            ],
          ),
        ),
        AppTouchable(
          onPressed: () {
            Scaffold.of(context).closeDrawer();
            // controller.advancedDrawerController.hideDrawer();
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: AppColors.primaryColor,
            size: AppDimens.fontLargest,
          ),
        ),
      ],
    );
  }

  _buildItemDrawer(
      {required Function() function,
      required String icon,
      required String title}) {
    return AppTouchable(
      onPressed: function,
      child: Row(
        children: [
          AppImageWidget.asset(
            path: icon,
            height: 28.sp,
            width: 28.sp,
          ),
          Gap(20.w),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildWidget() {
    return BackGroundShare(
      hasChatBox: true,
      drawer: _buildDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppbar(),
          Expanded(
            child: AppScrollView(
              child: Column(
                children: [
                  _buildTextHeader(),
                  _buildHighRatingList(),
                  _buildSuggestList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Builder _buildDrawer() {
    return Builder(
      builder: (context) => Drawer(
        width: Get.width,
        backgroundColor: AppColors.black,
        child: Stack(
          children: [
            AppImageWidget.asset(
              path: AppImage.bgDrawer,
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: ColoredBox(
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
            AppScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(60.h),
                  _buildUserInfo(context),
                  Gap(30.h),
                  _buildItemDrawer(
                    function: () => controller.onPressHome(),
                    icon: AppImage.icHome,
                    title: StringConstants.home.tr,
                  ),
                  Gap(30.h),
                  _buildItemDrawer(
                    function: () => controller.onPressUserFavorite(),
                    icon: AppImage.icFavorite,
                    title: StringConstants.favorite.tr,
                  ),
                  Gap(30.h),
                  _buildItemDrawer(
                    function: () => controller.onPressHistory(),
                    icon: AppImage.icHistory,
                    title: StringConstants.history.tr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
