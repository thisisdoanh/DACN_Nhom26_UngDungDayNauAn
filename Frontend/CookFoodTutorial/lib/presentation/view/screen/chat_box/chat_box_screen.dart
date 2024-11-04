import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/backgroud_screen.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/chat_box/chat_box_controller.dart';

class ChatBoxScreen extends AppBaseScreen<ChatBoxController> {
  ChatBoxScreen({super.key});
  @override
  final controller = Get.put(ChatBoxController());
  @override
  Widget buildWidget() {
    return BackGroundShare(
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView()),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  borderRadius: BorderRadius.circular(AppDimens.radius16),
                  backgroundColor: AppColors.black,
                  hintText: 'enter your question..',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await controller.pickImage();
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.white,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await controller.pickImage(isFromCamera: false);
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                          color: AppColors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  border: Border.all(color: AppColors.white, width: 2),
                ),
              ),
              Gap(12.w),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: AppColors.white,
                  size: AppDimens.sizeImage35,
                ),
              )
            ],
          ),
          Gap(16.h),
        ],
      ),
    );
  }
}
