import '../logger.dart';

abstract class LogOutput {
  void init() {}

  void output(OutputEvent event);

  void destroy() {}
}
