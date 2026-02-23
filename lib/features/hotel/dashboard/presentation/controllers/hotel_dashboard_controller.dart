import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../payments/presentation/providers/payment_providers.dart';
import '../../../amenities/presentation/providers/amenities_provider.dart';
import '../../../bed_type/presentation/providers/bed_types_provider.dart';
import '../../../booking/presentation/providers/booking_history_provider.dart';
import '../../../credit/presentation/providers/credit_providers.dart';
import '../../../discount/presentation/providers/discount_providers.dart';
import '../../../facilities/presentation/providers/facilities_provider.dart';
import '../../../premium_type/presentation/providers/premium_type_provider.dart';
import '../../../room_types/presentation/providers/room_type_provider.dart';
import '../../../rooms/presentation/providers/room_providers.dart';
import '../../domain/entities/dashboard_state.dart';

class HotelDashboardController extends StateNotifier<HotelDashboardState> {
  Ref ref;
  HotelDashboardController(
    this.ref
  ) : super(HotelDashboardState.initial());

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

  loadAllModule() {
    ref.read(roomControllerProvider.notifier).getRooms();
    ref.read(roomTypeControllerProvider.notifier).loadRoomTypes();
    ref.read(amenitiesControllerProvider.notifier).loadAmenities();
    ref.read(facilitiesControllerProvider.notifier).loadFacilities();
    ref.read(bedTypesControllerProvider.notifier).loadBedTypes();
    ref.read(premiumTypeControllerProvider.notifier).loadAllTypes();
    //ref.read(bookingControllerProvider.notifier).g
    ref.read(bookingHistoryControllerProvider.notifier).loadBookings();
    ref.read(paymentControllerProvider.notifier).loadAllPayments();
    ref.read(discountRequestProvider.notifier).loadAllDiscountRequests();
    ref.read(creditControllerProvider.notifier).loadAllCredits();
  }
}
