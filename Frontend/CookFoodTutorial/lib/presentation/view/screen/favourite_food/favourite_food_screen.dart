import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/favourite_food/favourite_food_controller.dart';

import '../../../component/food_suggest_item.dart';
import '../../../component/search_widget.dart';

class FavouriteFoodScreen extends AppBaseScreen<FavouriteFoodController> {
  const FavouriteFoodScreen({super.key});

  @override
  Widget buildWidget() {
    final double itemWidth = Get.width / 2;
    const double itemHeight = 250;
    return Obx(
      () => BackGroundShare(
        body: controller.isShowLoading.value
            ? Container()
            : Column(
                children: [
                  _buildAppBar(),
                  _buildBody(itemWidth, itemHeight),
                ],
              ),
      ),
    );
  }

  Widget _buildBody(double itemWidth, double itemHeight) {
    return Expanded(
      child: Column(
        children: [
          _buildSearchBar(),
          _buildListFood(itemWidth, itemHeight),
        ],
      ),
    );
  }

  Widget _buildListFood(double itemWidth, double itemHeight) {
    return Expanded(
      child: controller.listRecipeTemp.isEmpty
          ? const Center(
              child: Text('Không có dữ liệu'),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: itemWidth / itemHeight,
                crossAxisSpacing: AppDimens.paddingMedium,
                mainAxisSpacing: AppDimens.paddingMedium,
              ),
              itemCount: controller.listRecipeTemp.length,
              itemBuilder: (context, index) {
                return 
                 FoodCard(
                    recipeModel: controller.listRecipeTemp[index],
                  
                );
              },
            ),

    );
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextFieldSearch(),
        _buildIconFilter(),
      ],
    );
  }

  Widget _buildIconFilter() {
    return AppTouchable(
      onPressed: () => controller.appController.showFilterBottomSheet(
// <<<<<<< HEAD
//         controller.appController.listRecipeUserFavorite.toList(),
//         (p0) {
//           controller.listRecipeTemp.assignAll(p0);
// =======
        controller.listRecipe.toList(),
        (p0) {
          controller.listRecipeFilter.value = p0;
        },
      ),
      height: AppDimens.sizeTextField,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius8),
          border: Border.all(color: AppColors.white)),
      child: const Icon(
        Icons.filter_alt_rounded,
        color: AppColors.white,
      ),
    ).paddingOnly(left: AppDimens.paddingSmall);
  }

  Widget _buildTextFieldSearch() {
    return Expanded(
// <<<<<<< HEAD
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.transparent,
//           border: Border.all(
//             color: AppColors.white,
//             width: 1,
//           ),
//           borderRadius: BorderRadius.circular(AppDimens.radius8),
//         ),
//         alignment: Alignment.center,
//         child: Row(
//           children: [
//             Expanded(
//               child: SearchField<RecipeModel>(
//                 suggestionStyle:
//                     const TextStyle(fontSize: 18, color: Colors.pink),
//                 suggestions: controller.listRecipeTemp
//                     .map(
//                       (element) => SearchFieldListItem<RecipeModel>(
//                         element.recipeName ?? "Unknown",
//                         item: element,
//                         child: Text(
//                           element.recipeName ?? "Unknown",
//                         ),
//                       ),
//                     )
//                     .toList(),
//                 onSuggestionTap: (p0) {
//                   Get.find<HomeController>().onPressItemRecipe(p0.item);
//                 },
//                 searchInputDecoration: SearchInputDecoration(
//                   hintText: StringConstants.searchRecipe.tr,
//                   hintStyle: AppTextTheme.labelLarge(AppColors.dsGray4),
//                   suffixIcon: const Icon(
//                     Icons.search,
//                     color: AppColors.white,
//                   ),
//                   cursorColor: AppColors.white,
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//                 ),
//                 suggestionsDecoration: SuggestionDecoration(
//                   color: AppColors.colorBackgrounDialog,
//                   borderRadius: BorderRadius.circular(20.sp),
//                 ),
//               ),
//             ),
//           ],
//         ),
// =======
      child: SearchWidget(
        listRecipe: controller.listRecipe.toList(),
      )
    );
  }

  Widget _buildAppBar() {
    return AppBarShare(
      title: "Được yêu thích nhất",
      action: InkWell(
        onTap: Get.back,
        child: const Icon(
          Icons.arrow_back_outlined,
          color: AppColors.primaryColor,
          size: AppDimens.sizeImage35,
        ),
      ),
    );
  }
}
