import 'package:intl/intl.dart';

extension DateFormatX on DateFormat {
  String? formatOrNull(DateTime? date) {
    if(date == null) return null;
    return format(date);
  }
}