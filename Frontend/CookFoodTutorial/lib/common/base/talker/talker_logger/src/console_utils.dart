/// Class that contains methods for working with console output
abstract class ConsoleUtils {
  ConsoleUtils._();

  /// Method returns a line for the bottom of the message
  static String getUnderLine(
      int length, {
        String lineSymbol = '─',
        bool withCorner = false,
      }) {
    final line = lineSymbol * length;
    if (withCorner) {
      return '└$line';
    }
    return line;
  }

  /// Method returns a line for the top of the message
  static String getTopLine(
      int length, {
        String lineSymbol = '─',
        bool withCorner = false,
      }) {
    final line = lineSymbol * length;
    if (withCorner) {
      return '┌$line';
    }
    return line;
  }
}