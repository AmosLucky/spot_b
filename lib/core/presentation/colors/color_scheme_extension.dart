import 'package:flutter/material.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get online =>
      brightness == Brightness.dark ? const Color(0xFF81C784) : const Color(0xFF388E3C);
  Color get offline =>
      brightness == Brightness.dark ? const Color(0xFFEF5350) : const Color(0xFFF44336);
  Color get correct =>
      brightness == Brightness.dark ? const Color(0xFF81C784) : const Color(0xFF388E3C);
  Color get payNow =>
      brightness == Brightness.dark ? const Color(0xFF66BB6A) : const Color(0xFF43A047);
  Color get onPayNow =>
      brightness == Brightness.dark ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  Color get reset =>
      brightness == Brightness.dark ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
  Color get onReset =>
      brightness == Brightness.dark ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  Color get hold =>
      brightness == Brightness.dark ? const Color(0xFFF57C00) : const Color(0xFFF57C00);
  Color get onHold =>
      brightness == Brightness.dark ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
}
