import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConstants {
  static final availableLocales = [
    const Locale('vi', 'VN'),
    const Locale('en', 'US'),
  ];
  static final dateTimeFormatCommon = DateFormat('HH:mm dd/MM/yyyy');
}
