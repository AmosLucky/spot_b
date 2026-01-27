import 'package:flutter/foundation.dart';

@immutable
class HotelDashboardState {
  final DateTime selectedDate;
  final bool isLoading;

  const HotelDashboardState({
    required this.selectedDate,
    required this.isLoading,
  });

  factory HotelDashboardState.initial() {
    return HotelDashboardState(
      selectedDate: DateTime.now(),
      isLoading: false,
    );
  }

  HotelDashboardState copyWith({
    DateTime? selectedDate,
    bool? isLoading,
  }) {
    return HotelDashboardState(
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
