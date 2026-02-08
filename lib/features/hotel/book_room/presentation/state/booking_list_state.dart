import '../../domain/entities/booking_entity.dart';

class BookingListState {
  final bool isLoading;
  final List<BookingEntity> bookings;
  final String? error;

  const BookingListState({
    this.isLoading = false,
    this.bookings = const [],
    this.error,
  });

  BookingListState copyWith({
    bool? isLoading,
    List<BookingEntity>? bookings,
    String? error,
  }) {
    return BookingListState(
      isLoading: isLoading ?? this.isLoading,
      bookings: bookings ?? this.bookings,
      error: error,
    );
  }
}
