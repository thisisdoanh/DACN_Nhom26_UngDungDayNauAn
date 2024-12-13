import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/view/screen/chat_box/message_model.dart';

class ChatBoxController extends AppBaseController {
  late GenerativeModel model;
  final RxList<File?> imageFiles = RxList<File?>();
  final TextEditingController textCtrl = TextEditingController();
  final RxList<Message> messageList = RxList<Message>();
  final scrollController = ScrollController();

  @override
  onInit() async {
    super.onInit();
    const apiKey = "AIzaSyB10JQnQl57aPWbyfyEPg_bj9WXcW8mAtk";
    model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
    messageList.listen((_) async {
      if (scrollController.hasClients) {
        await scrollToBottom();
      }
    });
  }

  Future<void> pickImage({
    bool isFromCamera = true,
  }) async {
    const double width = 1000;
    const double height = 1000;
    const int quality = 100;

    final XFile? pickedFile = await ImagePicker().pickImage(
      source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: width,
      maxHeight: height,
      imageQuality: quality,
    );
    if (pickedFile != null) {
      imageFiles.add(
        File(pickedFile.path),
      );
    }
  }

  Future<String> getResponseMessage(Message message) async {
    // Đọc các file ảnh thành byte array
    final imageBytes = await Future.wait(
      message.images
          .map((file) async => file != null ? await file.readAsBytes() : null),
    );

    final content = [
      Content.multi([
        TextPart(message.text.value),
        ...imageBytes.where((bytes) => bytes != null).map(
              (bytes) => DataPart('image/jpeg', bytes!),
            ),
      ]),
    ];
    try {
      final response = await model.generateContent(content);
      return response.text?.trim() ?? "not found";
    } catch (e) {
      return "not found..";
    }
  }

  //hàm cuộn listView XUống dưới
  Future<void> scrollToBottom() async {
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendQuestion() async {
    await scrollToBottom();
    final question = textCtrl.text;
    final message = Message(
        id: DateTime.now().millisecondsSinceEpoch,
        initialText: question,
        images: List.from(imageFiles),
        isMe: true);
    messageList.add(message);
    textCtrl.clear();
    imageFiles.clear();
    final messageResponse = Message(
        id: DateTime.now().millisecondsSinceEpoch,
        initialText: '',
        images: [],
        isMe: false);
    messageList.add(messageResponse);

    isShowLoading.value = true;
    final response = await getResponseMessage(message);
    isShowLoading.value = false;

    messageResponse.text.value = response;
  }
}
