import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'navigation.dart';

@immutable
class Money {
  const Money._();

  static final _fc = NumberFormat('#,###.##');

  static final _fccFull = NumberFormat.simpleCurrency(
      locale: Platform.localeName, name: 'NGN', decimalDigits: 2);

  static String get symbol => _fc.currencySymbol;

  static String format(num price, {bool symbol = false}) {
    Locale locale = Localizations.localeOf(Navigation.getContext());
    final _fcFull = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: 'NGN', decimalDigits: 2);
    return symbol ? _fcFull.format(price) : '₦${_fc.format(price)}';
  }

  static num unformat(String money) {
    if (money == '') {
      return 0;
    }
    // extract numbers, sign, commas & dots
    var s = money.replaceAll(RegExp(r'[^0-9,.-]'), '');
    s = s == '-' ? '0' : s;
    return _fc.parse(s);
  }
}
