import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/resources/app_color.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/food_detail/food_detail_controller.dart';

class FoodDetailScreen extends AppBaseScreen<FoodDetailController> {
  const FoodDetailScreen({super.key});

  @override
  Widget buildWidget() {
    return Scaffold(
      backgroundColor: AppColor.primaryText,
      body: Column(
        children: [
          AppBarShare(
            hasBackIcon: true,
            action: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                size: AppDimens.sizeImage35,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UtilWidget.buildText(
                FoodModel.foodTest.mealType,
                fontSize: AppDimens.font14,
                textColor: AppColor.textNote,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UtilWidget.buildText(
                    FoodModel.foodTest.foodName,
                    fontSize: AppDimens.fontMedium,
                    // fontWeight: FontWeight.bold,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline,
                    ),
                  )
                ],
              )
            ],
          ).paddingSymmetric(horizontal: AppDimens.paddingMedium),
        ],
      ),
    );
  }
}
