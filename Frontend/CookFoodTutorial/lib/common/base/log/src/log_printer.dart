import '../logger.dart';

abstract class LogPrinter {
  void init() {}

  List<String> log(LogEvent event);

  void destroy() {}
}
