import 'dart:io';

class Message {
  final String text;
  final List<File?> images;
  final bool isMe;

  Message({
    required this.text,
    required this.images,
    this.isMe = false,
  });

    // copyWith method
   Message copyWith({
    String? text,
    List<File?>? images,
    bool? isMe,
  }) {
    return Message(
      text: text ??
          this.text, 
      images: images ??
          this.images, 
      isMe: isMe ??
          this.isMe, 
    );
  }
}
