import 'dart:io';

class Message {
  final String text;
  final List<File?> ?images;
  final bool isMe;

  Message({
    required this.text,
     this.images,
     this.isMe = false,
  });
}
