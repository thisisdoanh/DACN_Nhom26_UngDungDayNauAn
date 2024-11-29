import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tutorial/presentation/component/text_share.dart';
import 'package:tutorial/presentation/view/app_view.dart';
import 'package:tutorial/presentation/view/resources/app_dimen.dart';
import 'package:tutorial/presentation/view/screen/chat_box/chat_box_controller.dart';
import 'package:tutorial/presentation/view/screen/chat_box/message_model.dart';

class ChatBoxScreen extends GetView<ChatBoxController> {
  ChatBoxScreen({super.key});
  @override
  final controller = Get.put(ChatBoxController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //if (controller.scrollController.hasClients) {
      controller.scrollToBottom();
      //}
    });
    return Center(
      child: Obx(
        () => SafeArea(
          child: Column(
            children: [
              _buildListMessage(),
              Gap(16.h),
              _buildTextFieldAndIconSend(),
              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListMessage() {
    return Expanded(
      child: ListView.builder(
        controller: controller.scrollController,
        shrinkWrap: true,
        itemCount: controller.messageList.length,
        itemBuilder: (context, index) {
          final message = controller.messageList[index];
          return Row(
            mainAxisAlignment:
                message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: Column(
                    crossAxisAlignment: message.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      message.images.isEmpty
                          ? const SizedBox.shrink()
                          : _buildListAskedQuestion(message),
                      message.text.value.isNotEmpty || message.images.isNotEmpty
                          ? _buildResponseView(message)
                          : _buildResponseLoadding()
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 8),
                ).paddingOnly(
                  top: 16,
                  right: message.isMe ? 0 : 32,
                  left: message.isMe ? 32 : 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListAskedQuestion(Message message) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: List.generate(
        message.images.length,
        (index) => _buildImageItem(
          haveDeleteIcon: false,
          message.images[index]!.path,
          index: index,
        ),
      ),
    ).paddingSymmetric(vertical: 4);
  }

  Widget _buildResponseView(Message message) {
    return Visibility(
      visible: message.text.value.isNotEmpty,
      child: UtilWidget.buildText(
        message.text.value,
        fontSize: 14.sp,
        overflow: TextOverflow.ellipsis,
        maxLines: 50,
      ),
    );
  }

  Widget _buildResponseLoadding() {
    return const SizedBox(
      width: 20,
      child: Center(
        child: CupertinoActivityIndicator(
          color: Colors.white,
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
                    : _buildListQuestionImage(),
                _buildInputQuestion(),
              ],
            ),
          ),
        ),
        Gap(12.w),
        _buildIconBotton()
      ],
    );
  }

  Widget _buildIconBotton() {
    return IconButton(
      onPressed: () {
        if (controller.textCtrl.text.isEmpty && controller.imageFiles.isEmpty)
          return;
        controller.sendQuestion();
      },
      icon: const Icon(
        Icons.send,
        color: AppColors.white,
        size: AppDimens.sizeImage35,
      ),
    );
  }

  Widget _buildInputQuestion() {
    return TextField(
      controller: controller.textCtrl,
      maxLines: 1,
      maxLength: 255,
      scrollPadding: EdgeInsets.zero,
      style: AppTextTheme.labelLarge(AppColors.white),
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        counterText: '',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.sp,
          horizontal: 16.0.sp,
        ),
        hintText: "Enter your message",
        hintStyle: AppTextTheme.labelSmall(AppColors.dsGray4),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => controller.pickImage(isFromCamera: false),
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
    );
  }

  Widget _buildListQuestionImage() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 70,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.imageFiles.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildImageItem(controller.imageFiles[index]!.path,
                    index: index)
                .paddingOnly(right: 8);
          }).paddingAll(10),
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
    ).paddingSymmetric(horizontal: 4);
  }
}
