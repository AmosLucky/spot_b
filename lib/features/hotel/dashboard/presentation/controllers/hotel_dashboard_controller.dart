import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/dashboard_state.dart';




class HotelDashboardController extends StateNotifier<HotelDashboardState> {
  HotelDashboardController() : super(HotelDashboardState.initial());

  /// 📅 Pick date from calendar
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      state = state.copyWith(selectedDate: picked);
    }
  }

  /// 🔄 Reset date to today
  void resetDate() {
    state = state.copyWith(selectedDate: DateTime.now());
  }

  /// ⏳ Example loading toggle (dashboard fetch)
  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
}
