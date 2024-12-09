import 'talker.dart';

Future<void> main() async {
  final talker = Talker();

  /// Logs with LogLevel
  talker.warning('The pizza is over 😥');
  talker.debug('Thinking about order new one 🤔');
  talker.error('The restaurant is closed ❌');
  talker.info('Ordering from other restaurant...');
  talker.info('Payment started...');
  talker.good('Payment completed! Waiting for pizza 🍕');

  /// [Exception]'s and [Error]'s handling
  try {
    throw Exception('Something went wrong');
  } catch (e, st) {
    talker.handle(e, st, 'Exception with');
  }

  /// Custom logs
  talker.logTyped(YourCustomLog('Something like your own service message'));
}

class YourCustomLog extends TalkerLog {
  YourCustomLog(String message) : super(message);

  /// Your custom log title
  @override
  String get title => 'CUSTOM';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..xterm(121);
}