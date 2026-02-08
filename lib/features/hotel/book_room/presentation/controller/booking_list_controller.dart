import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../state/booking_list_state.dart';

class BookingListController extends StateNotifier<BookingListState> {
  final GetBookingsUseCase getBookings;

  BookingListController(this.getBookings) : super(const BookingListState());

  Future<void> loadBookings() async {
    try {
      state = state.copyWith(isLoading: true);
      final data = await getBookings();
      state = state.copyWith(isLoading: false, bookings: data);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> searchBookings(String keyword) async {
    try {
      state = state.copyWith(isLoading: true);
      final data = await getBookings(
          //search: keyword
          );
      state = state.copyWith(isLoading: false, bookings: data);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
