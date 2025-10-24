import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedDate() {
    return DateFormat.yMMMd().format(this);
  }
}
