import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    // Date and Time Format
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    // Today Format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Tomorrow Format
    var formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }

  static currentDate(date) {
    var now = date != 0
        ? DateTime.now().subtract(Duration(days: date))
        : DateTime.now();
    // var formatter = DateFormat('yyyy-MM-dd');
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25
    return formattedDate;
  }

  static String calculateAge(DateTime? birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate!.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return "$age";
  }

  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "y" : "yrs"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "m" : "ms"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "wk" : "wks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "d" : "ds"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hr" : "hrs"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "m" : "mins"} ago";
    return "just now";
  }

  /// Get the start of the current week (Monday).
  static DateTime startOfWeek() {
    final now = DateTime.now();
    final daysSinceMonday = now.weekday - DateTime.monday; // Monday is 1
    return now.subtract(Duration(days: daysSinceMonday)).toUtc();
  }

  /// Get the end of the current week (Sunday).
  static DateTime endOfWeek() {
    final now = DateTime.now();
    final daysUntilSunday = DateTime.sunday - now.weekday; // Sunday is 7
    return now
        .add(Duration(
            days: daysUntilSunday, hours: 23, minutes: 59, seconds: 59))
        .toUtc();
  }

  /// Get the start of the last week (Monday).
  static DateTime startOfLastWeek() {
    final now = DateTime.now();
    return startOfWeek().subtract(Duration(days: 7));
  }

  /// Get the end of the last week (Sunday).
  static DateTime endOfLastWeek() {
    final now = DateTime.now();
    return endOfWeek().subtract(Duration(days: 7));
  }

  /// Get the start of the current month.
  static DateTime startOfMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1).toUtc();
  }

  /// Get the end of the current month.
  static DateTime endOfMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0, 23, 59, 59)
        .toUtc(); // 0 gets the last day of the month
  }

  /// Get the start of the last month.
  static DateTime startOfLastMonth() {
    final now = DateTime.now();
    final lastMonth = now.month == 1 ? 12 : now.month - 1;
    final lastMonthYear = now.month == 1 ? now.year - 1 : now.year;
    return DateTime(lastMonthYear, lastMonth, 1).toUtc();
  }

  /// Get the end of the last month.
  static DateTime endOfLastMonth() {
    final now = DateTime.now();
    final lastMonth = now.month == 1 ? 12 : now.month - 1;
    final lastMonthYear = now.month == 1 ? now.year - 1 : now.year;
    return DateTime(lastMonthYear, lastMonth + 1, 0, 23, 59, 59)
        .toUtc(); // 0 gets the last day of the month
  }
}
