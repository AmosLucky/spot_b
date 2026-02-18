import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../state/booking_history_state.dart';

class BookingHistoryController extends StateNotifier<BookingHistoryState> {
  final GetBookingsUseCase getBookingsUseCase;

  BookingHistoryController({
    required this.getBookingsUseCase,
  }) : super(const BookingHistoryState());

  Future<void> loadBookings() async {
  
    state = state.copyWith(isLoading: true);
 

    final bookings = await getBookingsUseCase.call();
    print(bookings);

    state = state.copyWith(
      isLoading: false,
      allBookings: bookings,
    );

    _applyFilters();
    
  }

  void updateSearch(String value) {
    state = state.copyWith(searchQuery: value);
    _applyFilters();
  }

  void updateDateRange(DateTime? from, DateTime? to) {
    state = state.copyWith(dateFrom: from, dateTo: to);
    _applyFilters();
  }

  void updateStatus({
    String? status,
    String? paymentStatus,
    String? checkInStatus,
    String? checkOutStatus,
  }) {
    state = state.copyWith(
      status: status ?? state.status,
      paymentStatus: paymentStatus ?? state.paymentStatus,
      checkInStatus: checkInStatus ?? state.checkInStatus,
      checkOutStatus: checkOutStatus ?? state.checkOutStatus,
    );

    _applyFilters();
  }

  void _applyFilters() {
    List<BookingEntity> filtered = state.allBookings;

    // 🔍 Search
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered
          .where((b) => b.bookingNumber
              .toLowerCase()
              .contains(state.searchQuery.toLowerCase()))
          .toList();
    }

    // 📅 Date filter
    if (state.dateFrom != null) {
      filtered = filtered
          .where((b) => b.dateFrom
              .isAfter(state.dateFrom!.subtract(const Duration(days: 1))))
          .toList();
    }

    if (state.dateTo != null) {
      filtered = filtered
          .where((b) =>
              b.dateTo.isBefore(state.dateTo!.add(const Duration(days: 1))))
          .toList();
    }

    // 📌 Status filters
    if (state.status != 'all') {
      filtered = filtered.where((b) => b.status == state.status).toList();
    }

    if (state.paymentStatus != 'all') {
      filtered = filtered
          .where((b) => b.paymentStatus == state.paymentStatus)
          .toList();
    }

    if (state.checkInStatus != 'all') {
      filtered = filtered
          .where((b) => b.checkInStatus == state.checkInStatus)
          .toList();
    }

    if (state.checkOutStatus != 'all') {
      filtered = filtered
          .where((b) => b.checkOutStatus == state.checkOutStatus)
          .toList();
    }

    state = state.copyWith(filteredBookings: filtered);
  }

  void selectBooking(BookingEntity booking) {
    state = state.copyWith(selectedBooking: booking);
  }
}
