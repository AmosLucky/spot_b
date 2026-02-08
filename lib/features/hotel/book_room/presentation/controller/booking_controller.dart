import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/create_booking_usecase.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../state/booking_state.dart';

class BookingController extends StateNotifier<BookingState> {
  final CreateBookingUseCase createUseCase;
  final GetBookingsUseCase getUseCase;

  BookingController(this.createUseCase, this.getUseCase)
      : super(const BookingState()) {
    //loadBookings();
  }

  // Future<void> loadBookings() async {
  //   state = state.copyWith(isLoading: true);
  //   final data = await getUseCase.call();
  //   state = state.copyWith(isLoading: false, bookings: data);
  // }

  Future<void> createBooking(BookingEntity entity) async {
    await createUseCase.call(entity);
    //loadBookings();
  }
}
