import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_base_controller.dart';

abstract class AppBaseScreen<T extends AppBaseController> extends GetView<T> {
  const AppBaseScreen({super.key});

  Widget buildWidget();

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Stack(
      children: [
        buildWidget(),
        buildShowLoading(),
      ],
    );
  }

  Widget buildShowLoading() {
    return Obx(
      () => controller.isShowLoading.value
          ? Scaffold(
              backgroundColor: Colors.black.withOpacity(0.3),
              body: SizedBox(
                height: 40.sp,
                width: 40.sp,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
