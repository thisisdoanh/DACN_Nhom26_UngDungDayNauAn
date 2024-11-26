import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/base/app_base_screen.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/chat_box/chat_box_controller.dart';

class ChatBoxScreen extends AppBaseScreen<ChatBoxController> {
  ChatBoxScreen({super.key});
  @override
  final controller = Get.put(ChatBoxController());
  @override
  Widget buildWidget() {
    return Center(
      child: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.messageList.length,
                  itemBuilder: (context, index) {
                    final message = controller.messageList[index];
                    return Row(
                      children: [
                        if (message.isMe) const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.white,
                              width: 1.sp,
                            ),
                          ),
                          child: Column(
                            children: [
                              message.images.isEmpty
                                  ? const SizedBox.shrink()
                                  : Container(
                                      alignment: Alignment.centerRight,
                                      height: 70,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: message.images.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return _buildImageItem(
                                            message.images[index]!.path,
                                            haveDeleteIcon: false,
                                          );
                                        },
                                      ).paddingAll(10),
                                    ),
                              UtilWidget.buildText(
                                message.text,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 50,
                              )
                            ],
                          ).paddingSymmetric(horizontal: 16, vertical: 8),
                        ).paddingOnly(
                          top: 16,
                          right: message.isMe ? 0 : 32,
                          left: message.isMe ? 32 : 0,
                        ),
                        if (!message.isMe) const Spacer(),
                      ],
                    );
                  },
                ),
              ),
              _buildTextFieldAndIconSend(),
              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldAndIconSend() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.white,
                width: 1.sp,
              ),
            ),
            child: Column(
              children: [
                controller.imageFiles.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        alignment: Alignment.centerLeft,
                        height: 70,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.imageFiles.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return _buildImageItem(
                                      controller.imageFiles[index]!.path,
                                      index: index)
                                  .paddingOnly(right: 8);
                            }).paddingAll(10),
                      ),
                TextField(
                  controller: controller.textCtrl,
                  maxLines: 1,
                  maxLength: 255,
                  scrollPadding: EdgeInsets.zero,

                  //onChanged: onChanged,
                  style: AppTextTheme.labelLarge(AppColors.white),
                  cursorColor: AppColors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.sp,
                      horizontal: 16.0.sp,
                    ),
                    hintText: "Enter your message",
                    hintStyle: AppTextTheme.labelLarge(AppColors.dsGray4),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () =>
                              controller.pickImage(isFromCamera: false),
                          child: const Icon(
                            Icons.image,
                            color: AppColors.white,
                            size: AppDimens.btnDsIcon,
                          ),
                        ),
                        Gap(4.w),
                        InkWell(
                          onTap: () => controller.pickImage(),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.white,
                            size: AppDimens.btnDsIcon,
                          ),
                        ),
                        Gap(4.w),
                      ],
                    ),
                    isDense: true,
                    focusColor: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(12.w),
        IconButton(
          onPressed: () {
            controller.sendQuestion();
          },
          icon: const Icon(
            Icons.send,
            color: AppColors.white,
            size: AppDimens.sizeImage35,
          ),
        )
      ],
    );
  }

  Widget _buildImageItem(
    String path, {
    bool haveDeleteIcon = true,
    int index = 0,
  }) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(path),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        Visibility(
          visible: haveDeleteIcon,
          child: InkWell(
            onTap: () => controller.imageFiles.removeAt(index),
            child: const Icon(
              Icons.close,
              size: 20,
            ),
          ),
        )
      ],
    ).paddingOnly(right: 8);
  }
}
