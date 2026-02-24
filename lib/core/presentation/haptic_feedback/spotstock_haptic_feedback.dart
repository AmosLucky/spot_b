import 'package:flutter/services.dart';

class SpotstockHapticFeedback {
  static void networkStatusChanged() {
    HapticFeedback.lightImpact();
  }

  static void incorrectStaffPin() {
    HapticFeedback.lightImpact();
  }
}
