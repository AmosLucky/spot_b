import '../../domain/entities/booking_entity.dart';

class FolioBookingState {
  final List<BookingEntity> bookings;
  final List<BookingEntity> filteredBookings;

  final bool isLoading;
  final String selectedFilter;
  final String searchQuery;

  final String? error;

  const FolioBookingState({
    this.bookings = const [],
    this.filteredBookings = const [],
    this.isLoading = false,
    this.selectedFilter = 'All',
    this.searchQuery = '',
    this.error,
  });

  FolioBookingState copyWith({
    List<BookingEntity>? bookings,
    List<BookingEntity>? filteredBookings,
    bool? isLoading,
    String? selectedFilter,
    String? searchQuery,
    String? error,
  }) {
    return FolioBookingState(
      bookings: bookings ?? this.bookings,
      filteredBookings: filteredBookings ?? this.filteredBookings,
      isLoading: isLoading ?? this.isLoading,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
    );
  }
}
