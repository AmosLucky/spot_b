import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../state/folio_booking_state.dart';

class FolioBookingController extends StateNotifier<FolioBookingState> {
  final GetBookingsUseCase getBookingsUseCase;

  FolioBookingController(this.getBookingsUseCase)
      : super(const FolioBookingState());

  // ================= LOAD BOOKINGS =================

  Future<void> loadBookings() async {
    state = state.copyWith(isLoading: true);

    try {
      final bookings = await getBookingsUseCase();

      state = state.copyWith(
        bookings: bookings,
        isLoading: false,
      );

      _applyFilters();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load bookings',
      );
    }
  }

  // ================= FILTER =================

  void setFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
    _applyFilters();
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    List<BookingEntity> filtered = List.from(state.bookings);

    // Filter by Status
    if (state.selectedFilter != 'All') {
      filtered = filtered.where((booking) {
        return booking.status.toLowerCase() ==
            state.selectedFilter.toLowerCase();
      }).toList();
    }

    // Search
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();

      filtered = filtered.where((booking) {
        return booking.bookingNumber.toLowerCase().contains(query);
        //      ||
        // booking.customerName
        //     .toLowerCase()
        //     .contains(query);
      }).toList();
    }

    state = state.copyWith(filteredBookings: filtered);
  }
}
