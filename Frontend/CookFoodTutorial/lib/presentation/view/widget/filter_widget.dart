import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/view/widget/app_touchable.dart';

import '../../../common/utils/app_utils.dart';
import '../../../data/model/category_response_model.dart';
import '../resources/app_color.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key, required this.listCategory});

  final List<CategoryModel> listCategory;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<CategoryModel> listCategorySelected = [];
  double firstValue = 0;
  double secondValue = 60;
  TextStyle labelTextStyle =  TextStyle(
    color: AppColors.white,
    fontSize: 13.sp,
    fontFamily: 'Segoe UI',
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(8.h),
        Center(
          child: Container(
            height: 4.h,
            width: Get.width / 2,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.sp),
            ),
          ),
        ),
        Gap(32.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lọc',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            AppTouchable(
              onPressed: () {},
              child: Text(
                'Tải lại',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        Gap(32.h),
        Text(
          'Phân loại',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(12.h),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 12.h,
          spacing: 16.w,
          children: widget.listCategory
              .map(
                (e) => AppTouchable(
                  onPressed: () {
                    if (listCategorySelected.contains(e)) {
                      listCategorySelected.remove(e);
                    } else {
                      listCategorySelected.add(e);
                    }
                    setState(() {});
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Color.lerp(
                      const Color(0xFF4A4A4A),
                      AppColors.primaryColor.withOpacity(0.2),
                      listCategorySelected.contains(e) ? 1 : 0,
                    ),
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(
                      color: Color.lerp(
                            const Color(0xFF4A4A4A),
                            AppColors.primaryColor,
                            listCategorySelected.contains(e) ? 1 : 0,
                          ) ??
                          AppColors.transparent,
                      width: 1.sp,
                    ),
                  ),
                  child: Text(
                    e.name ?? "Unknown",
                    style: TextStyle(
                      color: Color.lerp(
                        const Color(0xFF727272),
                        AppColors.primaryColor,
                        listCategorySelected.contains(e) ? 1 : 0,
                      ),
                      fontSize: 15.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Gap(20.h),
        Divider(
          color: const Color(0xFF474747),
          height: 1.h,
        ),
        Gap(20.h),
        Text(
          'Thời gian chuẩn bị',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(12.h),
        Stack(
          children: [
            RangeSlider(
              values: RangeValues(firstValue, secondValue),
              min: 0,
              max: 60,
              activeColor: AppColors.primaryColor,
              inactiveColor: const Color(0xFF474747),
              onChanged: (value) {
                firstValue = value.start;
                secondValue = value.end;
                setState(() {});
              },
              labels: RangeLabels(
                "${firstValue.toStringAsFixed(0)} phút",
                "${secondValue.toStringAsFixed(0)} phút",
              ),
            ),
            Positioned(
                bottom: 0,
                left: (firstValue / 60 * (Get.width - 32.w) ) - getTextWidth("$firstValue phút",labelTextStyle, context )/2,
                child: Text("$firstValue phút")),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }
}
