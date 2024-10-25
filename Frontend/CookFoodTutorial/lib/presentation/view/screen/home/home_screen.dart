import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/component/food_suggest_item_small.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/screen/home/home_controller.dart';
import 'package:tutorial/res/string/app_string.dart';

import '../../resources/app_dimen.dart';

class HomeScreen extends AppBaseScreen<HomeController> {
  const HomeScreen({super.key});

  Widget _buildAppbar() {
    return AppBarShare(
      leading: AppTouchable(
        margin: EdgeInsets.only(left: 16.w),
        onPressed: () {
          controller.advancedDrawerController.showDrawer();
        },
        child: Center(
          child: AppImageWidget.asset(
            path: AppImage.icMenu,
            height: 24.sp,
            width: 24.sp,
          ),
        ),
      ),
      action: Container(
        margin: EdgeInsets.only(right: 16.w),
        alignment: Alignment.center,
        child: AppImageWidget.asset(
          path: AppImage.icNoti,
          height: 24.sp,
          width: 24.sp,
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
                  color: AppColor.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' Denny',
                style: TextStyle(
                  color: AppColor.primaryColor,
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
        ),
        Gap(10.h),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildHighRatingList() {
    final double itemWidth = Get.width / 2.2;
    return Column(
      children: [
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UtilWidget.buildText(
              StringConstants.motsFavorite,
              textColor: AppColor.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            UtilWidget.buildText(
              StringConstants.seeAll,
              textColor: AppColor.primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        Gap(10.h),
        SizedBox(
          height: 210.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              height: 210.h,
              width: itemWidth,
              margin: EdgeInsets.only(
                right: 10.w,
              ),
              child: FoodCard(
                food: foodTest,
                timerIcon: Icons.timer,
                timerColor: AppColor.white,
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
              textColor: AppColor.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            UtilWidget.buildText(
              StringConstants.seeAll,
              textColor: AppColor.primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        Gap(10.h),
        ListView.separated(
          itemCount: 10,
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) {
            return Container(
              height: 8.sp,
            );
          },
          itemBuilder: (context, index) => FoodSuggestItemSmall(food: foodTest),
        ),
        Gap(20.h),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        _buildTextFieldSearch(),
      ],
    );
  }

  Widget _buildTextFieldSearch() {
    return Expanded(
      child: AppTextField(
        hintText: StringConstants.searchRecipe.tr,
        backgroundColor: AppColor.transparent,
        border: Border.all(
          color: AppColor.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        CircleAvatar(
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
                  color: AppColor.white,
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
              controller.advancedDrawerController.hideDrawer();
            },
            child: IconButton(
              onPressed: Get.back,
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: AppColor.primaryColor,
                size: AppDimens.fontLargest,
              ),
            )),
      ],
    );
  }

  @override
  Widget buildWidget() {
    return AdvancedDrawer(
      controller: controller.advancedDrawerController,
      openScale: 1,
      openRatio: 1,
      backdrop: AppImageWidget.asset(
        path: AppImage.bgDrawer,
        width: Get.width,
        height: Get.height,
        fit: BoxFit.cover,
      ),
      drawer: AppScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(60.h),
            _buildUserInfo(),
          ],
        ),
      ),
      disabledGestures: true,
      child: BackGroundShare(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppbar(),
            Expanded(
              child: AppScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
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
      ),
    );
  }
}

final FoodModel foodTest = FoodModel(
  mealType: "Bữa sáng",
  foodName: "Bánh Chocolate",
  time: '10:02',
  rating: 4.5,
  imageUrl:
      'https://ik.imagekit.io/tvlk/blog/2017/01/30-mon-ngon-nuc-long-nhat-dinh-phai-thu-khi-toi-ha-noi-phan-1.jpg?tr=dpr-2,w-675',
);
