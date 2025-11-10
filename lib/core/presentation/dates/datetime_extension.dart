import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedDate() {
    return DateFormat.yMMMd().format(this);
  }

  String toFormattedDateTime() {
    return DateFormat('yyyy-MM-dd hh:mm a').format(this);
  }
}
