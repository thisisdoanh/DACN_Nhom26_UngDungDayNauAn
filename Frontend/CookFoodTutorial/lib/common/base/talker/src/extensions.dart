import '../talker.dart';

extension TalkerDataInterfaceListExt on List<TalkerDataInterface> {
  /// The method allows you to get
  /// full text of logs or history
  String get text {
    final sb = StringBuffer();
    for (final data in this) {
      sb.write('${data.generateTextMessage()}\n');
    }
    return sb.toString();
  }
}