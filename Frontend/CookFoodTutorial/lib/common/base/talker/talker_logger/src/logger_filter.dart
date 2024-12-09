import '../talker_logger.dart';

/// Abstract filter for messages logging.
///
/// [LogLevelFilter] is used by default
/// You can create your own filter by implementing [LoggerFilter]
/// or use [LogLevelFilter].
abstract class LoggerFilter {
  /// This method checks every message
  /// Displays a message if [true] is returned,
  /// and not display if [false]
  bool shouldLog(dynamic msg, LogLevel level);
}


class LogLevelFilter implements LoggerFilter {
  const LogLevelFilter(this.logLevel);

  final LogLevel logLevel;

  @override
  bool shouldLog(dynamic msg, LogLevel level) {
    final currLogLevelIndex = logLevelPriorityList.indexOf(logLevel);
    final msgLogLevelIndex = logLevelPriorityList.indexOf(level);
    return currLogLevelIndex >= msgLogLevelIndex;
  }
}