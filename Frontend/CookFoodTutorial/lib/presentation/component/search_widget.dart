import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/view/screen/search/search_screen.dart';

import '../../data/model/recipe_response_model.dart';
import '../../res/string/app_string.dart';
import '../view/app_view.dart';
import '../view/resources/app_dimen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.listRecipe});

  final List<RecipeModel> listRecipe;

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: () => Get.to(() => SearchScreen(listRecipe: listRecipe)),
      height: AppDimens.sizeTextField,
      padding: EdgeInsets.symmetric(
        vertical: 8.sp,
        horizontal: 16.0.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radius8),
        border: Border.all(
          color: AppColors.white,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringConstants.searchRecipe.tr,
            style: AppTextTheme.labelLarge(AppColors.dsGray4),
          ),
          const Icon(
            Icons.search,
            color: AppColors.white,
          )
        ],
      ),
    );
  }
}
