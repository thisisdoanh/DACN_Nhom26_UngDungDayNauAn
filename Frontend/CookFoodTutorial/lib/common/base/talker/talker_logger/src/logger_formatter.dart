import '../talker_logger.dart';

/// Responsible for formatting message before output
///
/// [ColoredLoggerFormatter] is used by default
/// You can create your own filter by implementing [LoggerFormatter]
/// or use [ColoredLoggerFormatter].
abstract class LoggerFormatter {
  /// Formats the message in the appropriate way
  String fmt(LogDetails details, TalkerLoggerSettings settings);
}

/// This formatter makes messages colorful
/// if this setting is enabled in the settings [TalkerLoggerSettings]
class ColoredLoggerFormatter implements LoggerFormatter {
  const ColoredLoggerFormatter();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final underline = ConsoleUtils.getUnderLine(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
    );

    final msg = details.message?.toString() ?? '';
    if (!settings.enableColors) {
      return '$msg\n$underline';
    }

    List lines = msg.split('\n');
    lines = lines.map((e) => details.pen.write(e)).toList();
    lines.add(details.pen.write(underline));
    final coloredMsg = lines.join('\n');

    return coloredMsg;
  }
}

/// This formatter makes messages colorful
/// if this setting is enabled in the settings [TalkerLoggerSettings]
class ExtendedLoggerFormatter implements LoggerFormatter {
  const ExtendedLoggerFormatter();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final underline = ConsoleUtils.getUnderLine(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
      withCorner: true,
    );

    final topLine = ConsoleUtils.getTopLine(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
      withCorner: true,
    );

    final msg = details.message?.toString() ?? '';
    final msgBorderedLines = msg.split('\n').map((e) => '│ $e');
    if (!settings.enableColors) {
      return '$topLine\n${msgBorderedLines.join('\n')}\n$underline';
    }

    List lines = [topLine, ...msgBorderedLines, underline];
    lines = lines.map((e) => details.pen.write(e)).toList();
    final coloredMsg = lines.join('\n');
    return coloredMsg;
  }
}