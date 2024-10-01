import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/suggest_food/suggest_food_controller.dart';

class SuggestFoodScreen extends AppBaseScreen<SuggestFoodController> {
  const SuggestFoodScreen({super.key});

  @override
  Widget buildWidget() {
    final double itemWidth = Get.width / 2;
    final const double itemHeight = 250;
    return BackGroundShare(
      body: Column(
        children: [
          const AppBarShare(
            title: "Được yêu thích nhất",
            action: Icon(
              Icons.arrow_back_outlined,
              color: AppColor.primaryColor,
            ),
          ),
          Expanded(
              child: Column(
            children: [
              const AppTextField(),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: itemWidth / itemHeight,
                    crossAxisSpacing: AppDimens.paddingMedium,
                    mainAxisSpacing: AppDimens.paddingMedium,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return FoodCard(food: foodTest);
                  },
                ),
              )
            ],
          ))
        ],
      ).paddingSymmetric(horizontal: AppDimens.paddingMedium),
    );
  }
}

final FoodModel foodTest = FoodModel(
    mealType: "Bữa sáng",
    foodName: "Bữa nướng",
    time: '10:02',
    rating: 4.5,
    imageUrl:
        'https://ik.imagekit.io/tvlk/blog/2017/01/30-mon-ngon-nuc-long-nhat-dinh-phai-thu-khi-toi-ha-noi-phan-1.jpg?tr=dpr-2,w-675');
