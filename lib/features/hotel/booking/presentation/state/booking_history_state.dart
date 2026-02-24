import '../../domain/entities/booking_entity.dart';

class BookingHistoryState {
  final bool isLoading;
  final List<BookingEntity> allBookings;
  final List<BookingEntity> filteredBookings;
  final BookingEntity? selectedBooking;

  // Filters
  final String searchQuery;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String status;
  final String paymentStatus;
  final String checkInStatus;
  final String checkOutStatus;

  const BookingHistoryState({
     this.selectedBooking,
    this.isLoading = false,
    this.allBookings = const [],
    this.filteredBookings = const [],
    this.searchQuery = '',
    this.dateFrom,
    this.dateTo,
    this.status = 'all',
    this.paymentStatus = 'all',
    this.checkInStatus = 'all',
    this.checkOutStatus = 'all',
  });

  BookingHistoryState copyWith({
    BookingEntity? selectedBooking,
    bool? isLoading,
    List<BookingEntity>? allBookings,
    List<BookingEntity>? filteredBookings,
    String? searchQuery,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? status,
    String? paymentStatus,
    String? checkInStatus,
    String? checkOutStatus,
  }) {
    return BookingHistoryState(
      selectedBooking:selectedBooking?? this.selectedBooking,
      isLoading: isLoading ?? this.isLoading,
      allBookings: allBookings ?? this.allBookings,
      filteredBookings: filteredBookings ?? this.filteredBookings,
      searchQuery: searchQuery ?? this.searchQuery,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      checkInStatus: checkInStatus ?? this.checkInStatus,
      checkOutStatus: checkOutStatus ?? this.checkOutStatus,
    );
  }
}
