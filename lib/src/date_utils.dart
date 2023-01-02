
import 'package:intl/intl.dart';

final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

String? dateToString(DateTime? dateTime) {
  if (dateTime == null) {
    return null;
  }
  return dateFormat.format(dateTime);
}

DateTime? stringToDate(String? dateTime) {
  if (dateTime == null || dateTime.isEmpty) {
    return null;
  }
  return dateFormat.parse(dateTime);
}