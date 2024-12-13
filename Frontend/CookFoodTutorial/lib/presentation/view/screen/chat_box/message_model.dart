import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Message {
  int id;
  final Rx<String> text;
  final List<File?> images;
  final bool isMe;

  Message({
    required String initialText,
    required this.images,
    required this.id,
    this.isMe = false,
  }) : text = initialText.obs;
}
