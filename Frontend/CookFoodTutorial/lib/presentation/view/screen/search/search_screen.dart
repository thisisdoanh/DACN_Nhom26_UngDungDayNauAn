import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_controller.dart';
import 'package:tutorial/presentation/view/app_view.dart';

import '../../../../data/model/recipe_response_model.dart';
import '../../../../res/string/app_string.dart';
import '../../../component/appbar.dart';
import '../../../component/backgroud_screen.dart';
import '../../../component/food_suggest_item.dart';
import '../../resources/app_dimen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.listRecipe,
  });

  final List<RecipeModel> listRecipe;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AppController appController = Get.find<AppController>();
  late List<RecipeModel> listShow = widget.listRecipe;
  late List<RecipeModel> listShowAndFilter = widget.listRecipe;
  Widget _buildAppBar() {
    return AppBarShare(
      title: "Tìm kiếm",
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

  Widget _buildIconFilter() {
    return AppTouchable(
      onPressed: () => appController.showFilterBottomSheet(
        listShow.toList(),
        (p0) {
          listShowAndFilter = p0;
          setState(() {});
        },
      ),
      height: AppDimens.sizeTextField,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius8), border: Border.all(color: AppColors.white)),
      child: const Icon(
        Icons.filter_alt_rounded,
        color: AppColors.white,
      ),
    ).paddingOnly(left: AppDimens.paddingSmall);
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

  Widget _buildTextFieldSearch() {
    return Expanded(
      child: AppTextField(
        hintText: StringConstants.searchRecipe.tr,
        backgroundColor: AppColors.transparent,
        border: Border.all(
          color: AppColors.white,
          width: 1,
        ),
        suffixIcon: const Icon(
          Icons.search,
          color: AppColors.white,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radius8),
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
      ),
    );
  }

  Widget _buildBody(double itemWidth, double itemHeight) {
    return _buildListFood(itemWidth, itemHeight);
  }

  Widget _buildListFood(double itemWidth, double itemHeight) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: itemWidth / itemHeight,
          crossAxisSpacing: AppDimens.paddingMedium,
          mainAxisSpacing: AppDimens.paddingMedium,
        ),
        itemCount: listShowAndFilter.length,
        itemBuilder: (context, index) {
          return FoodCard(
            recipeModel: listShowAndFilter[index],
          );
        },
      ),
    );
  }

  void onSubmitted(String value) {
    listShow = widget.listRecipe
        .where(
          (element) => (element.recipeName ?? "").toLowerCase().contains(value.toLowerCase()),
        )
        .toList();
    listShowAndFilter = listShow;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = Get.width / 2;
    const double itemHeight = 250;
    return BackGroundShare(
      body: Column(
        children: [
          _buildAppBar(),
          _buildSearchBar(),
          _buildBody(itemWidth, itemHeight),
        ],
      ),
    );
  }
}
