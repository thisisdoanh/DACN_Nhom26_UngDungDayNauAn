import '../../talker.dart';

class TalkerError implements TalkerDataInterface {
  TalkerError(
      this.error, {
        this.message,
        this.logLevel,
        this.stackTrace,
        String? title,
        DateTime? time,
      }) {
    _title = title ?? WellKnownTitles.error.title;
    _time = time ?? DateTime.now();
  }

  late DateTime _time;
  late String _title;

  /// {@macro talker_data_error}
  @override
  final Error error;

  /// {@macro talker_data_message}
  @override
  final String? message;

  /// {@macro talker_data_stackTrace}
  @override
  final StackTrace? stackTrace;

  /// {@macro talker_data_title}
  @override
  String get title => _title;

  /// {@macro talker_data_loglevel}
  @override
  final LogLevel? logLevel;

  /// {@macro talker_data_generateTextMessage}
  @override
  String generateTextMessage() {
    return '$displayTitleWithTime$displayMessage$displayError$displayStackTrace';
  }

  /// {@macro talker_data_time}
  @override
  DateTime get time => _time;

  /// {@macro talker_data_exception}
  /// Not used in [TalkerError]
  @override
  final Exception? exception = null;
}