import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:tutorial/data/model/recipe_response_model.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/appbar.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/component/food_suggest_item.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/home/home_controller.dart';
import 'package:tutorial/presentation/view/screen/suggest_food/suggest_food_controller.dart';
import 'package:tutorial/res/string/app_string.dart';

class SuggestFoodScreen extends AppBaseScreen<SuggestFoodController> {
  const SuggestFoodScreen({super.key});

  @override
  Widget buildWidget() {
    return Obx(
      () => BackGroundShare(
        body: controller.isShowLoading.value
            ? Container()
            : Column(
                children: [
                  _buildAppBar(),
                  _buildBody(),
                ],
              ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Column(
        children: [
          _buildSearchBar(),
          _buildListFood(),
        ],
      ),
    );
  }

  Widget _buildListFood() {
    return Expanded(
      child: controller.listRecipeTemp.isEmpty
          ? const Center(
              child: Text('Không có dữ liệu'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 220,
                mainAxisSpacing: AppDimens.paddingSmall,
                crossAxisSpacing: AppDimens.paddingVerySmall,
              ),
              shrinkWrap: true,
              itemCount: controller.listRecipeTemp.length,
              itemBuilder: (context, index) {
                final food = controller.listRecipeTemp[index];
                return FoodCard(
                  recipeModel: food,
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
        controller.appController.listRecipe.toList(),
        (p0) {
          controller.listRecipeTemp.assignAll(p0);
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
      child: Container(
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
                suggestions: controller.listRecipeTemp
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
                  Get.find<HomeController>().onPressItemRecipe(p0.item);
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
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBarShare(
      title: StringConstants.suggest.tr,
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
