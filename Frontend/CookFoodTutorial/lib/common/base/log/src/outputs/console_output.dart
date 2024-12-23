import '../../logger.dart';

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // ignore: avoid_print
    event.lines.forEach(print);
  }
}
