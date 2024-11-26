import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/view/screen/chat_box/message_model.dart';
import 'package:tutorial/presentation/view/screen/chat_box/resoure.dart';

class ChatBoxController extends AppBaseController {
  late GenerativeModel model;
  final RxList<File?> imageFiles = RxList<File?>();
  final TextEditingController textCtrl = TextEditingController();
  final RxList<Message> messageList = RxList<Message>();

  @override
  onInit() async {
    super.onInit();
    const apiKey = "AIzaSyB10JQnQl57aPWbyfyEPg_bj9WXcW8mAtk";
    model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
  }
//   Future pickImage()async{
//     final ImagePicker picker = ImagePicker();
// // // Pick an image.
// // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// // Capture a photo.
// final XFile? photo = await picker.pickImage(source: ImageSource.camera);
// // Pick multiple images.
// //final List<XFile> medias = await picker.pickMultipleMedia();

//   }

  void getResponseMessagee() async {
    final prompt = 'What do you see?';

    final (catBytes, sconeBytes) = await (
      readResource('cat.jpg'),
      readResource('scones.jpg'),
    ).wait;
    final content = [
      Content.multi([
        TextPart(prompt),
        // The only accepted mime types are image/*.
        DataPart('image/jpeg', catBytes),
        DataPart('image/jpeg', sconeBytes),
      ])
    ];

    final response = await model.generateContent(content);
    print('Response:');
    print(response.text);
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
        TextPart(message.text),
        ...imageBytes.where((bytes) => bytes != null).map(
              (bytes) => DataPart('image/jpeg', bytes!),
            ),
      ]),
    ];

    // Gọi API generateContent
    final response = await model.generateContent(content);
    return response.text ?? "not found";
  }

  void sendQuestion() async {
    final question = textCtrl.text;
    final message =
        Message(text: question, images: List.from(imageFiles), isMe: true);
    messageList.add(message);
    textCtrl.clear();

    showLoading();
    final response = await getResponseMessage(message);
    hideLoading();
    messageList.add(Message(text: response, images: [], isMe: false));
    // messageList.refresh();
    imageFiles.clear();
  }
}
