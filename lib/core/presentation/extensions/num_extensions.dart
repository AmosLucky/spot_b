import 'package:intl/intl.dart';

extension MoneyFormatting on num {
  String toMoney({int decimalDigits = 0}) {
    final pattern = decimalDigits > 0 ? '#,##0.${'0' * decimalDigits}' : '#,##0';
    final formatter = NumberFormat(pattern);
    return formatter.format(this);
  }
}
