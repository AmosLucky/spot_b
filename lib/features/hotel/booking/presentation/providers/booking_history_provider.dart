import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/booking_history_controller.dart';
import '../state/booking_history_state.dart';
import 'booking_provider.dart';

final bookingHistoryControllerProvider =
    StateNotifierProvider<BookingHistoryController, BookingHistoryState>(
        (ref) {
  return BookingHistoryController(
    getBookingsUseCase: ref.watch(getBookingsUseCaseProvider),
  );
});
