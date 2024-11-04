import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial/presentation/base/app_base_controller.dart';
import 'package:tutorial/presentation/view/screen/chat_box/resoure.dart';

class ChatBoxController extends AppBaseController {
  late GenerativeModel model;
    final Rx<File?> imageFile = Rx<File?>(null);


  @override
  onInit() async {
    // super.onInit();
    // final apiKey = Platform.environment['GEMINI_API_KEY'];
    // if (apiKey == null) {
    //   stderr.writeln(r'No $GEMINI_API_KEY environment variable');
    //   exit(1);
    // }
    // model = GenerativeModel(
    //   model: 'gemini-1.5-flash-latest',
    //   apiKey: apiKey,
    // );
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

  void getResponseMessage() async {
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
  @override
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
      imageFile.value = File(pickedFile.path);
    }
  }
}
