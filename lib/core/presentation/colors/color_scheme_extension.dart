import 'package:flutter/material.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get online => brightness == Brightness.dark ? const Color(0xFF81C784) : const Color(0xFF388E3C);
  Color get offline => brightness == Brightness.dark ? const Color(0xFFEF5350) : const Color(0xFFF44336);
  Color get correct => brightness == Brightness.dark ? const Color(0xFF81C784) : const Color(0xFF388E3C);
  Color get payNow => brightness == Brightness.dark ? const Color(0xFF66BB6A) : const Color(0xFF43A047);
  Color get onPayNow => brightness == Brightness.dark ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  Color get reset => brightness == Brightness.dark ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
  Color get onReset => brightness == Brightness.dark ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  Color get hold => brightness == Brightness.dark ? const Color(0xFFF57C00) : const Color(0xFFF57C00);
  Color get onHold => brightness == Brightness.dark ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  Color get tableChip => brightness == Brightness.dark ? const Color(0xFF6B4E00) : const Color(0xFFFFF5C2);
  Color get onTableChip => brightness == Brightness.dark ? const Color(0xFFFFF5C2) : const Color(0xFF913D01);
  Color get customerChip => brightness == Brightness.dark ? const Color(0xFF162B66) : const Color(0xFFDCE9FF);
  Color get onCustomerChip => brightness == Brightness.dark ? const Color(0xFFDCE9FF) : const Color(0xFF1D42AA);
  Color get attendantChip => brightness == Brightness.dark ? const Color(0xFF121A22) : const Color(0xFFF3F5F7);
  Color get onAttendantChip => brightness == Brightness.dark ? const Color(0xFFF3F5F7) : const Color(0xFF1E2936);
  Color get warehouseChip => brightness == Brightness.dark ? const Color(0xFF004D40) : const Color(0xFFE0F2F1);
  Color get onWarehouseChip => brightness == Brightness.dark ? const Color(0xFFE0F2F1) : const Color(0xFF004D40);
  Color get itemCountChip => brightness == Brightness.dark ? const Color(0xFF2E1A47) : const Color(0xFFF3E8FF);
  Color get onItemCountChip => brightness == Brightness.dark ? const Color(0xFFF3E8FF) : const Color(0xFF4A0072);
  Color get warning => brightness == Brightness.dark ? const Color(0xFFFFC107) : const Color(0xFFFFA000);
  Color get onWarning => brightness == Brightness.dark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  Color get paidChip => brightness == Brightness.dark ? const Color(0xFF4CAF50) : const Color(0xFF4CAF50);
  Color get onPaidChip => brightness == Brightness.dark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  Color get partialChip => brightness == Brightness.dark ? const Color(0xFFFFB74D) : const Color(0xFFFF9800);
  Color get onPartialChip => brightness == Brightness.dark ? const Color(0xFF000000) : const Color(0xFF000000);
  Color get unpaidChip => brightness == Brightness.dark ? const Color(0xFFEF5350) : const Color(0xFFF44336);
  Color get onUnpaidChip => brightness == Brightness.dark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  Color get closedChip => brightness == Brightness.dark ? const Color(0xFFEF9A9A) : const Color(0xFFFFCDD2);
  Color get onClosedChip => brightness == Brightness.dark ? const Color(0xFFB71C1C) : const Color(0xFFC62828);
  Color get openChip => brightness == Brightness.dark ? const Color(0xFFA5D6A7) : const Color(0xFFC8E6C9);
  Color get onOpenChip => brightness == Brightness.dark ? const Color(0xFF1B5E20) : const Color(0xFF2E7D32);
  Color get cashAtHand => brightness == Brightness.dark ? const Color(0xFFF57C00) : const Color(0xFFF57C00);
}
