import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../controllers/folio_booking_controller.dart';
import '../state/folio_booking_state.dart';
import 'booking_provider.dart';


final folioBookingControllerProvider =
    StateNotifierProvider<FolioBookingController, FolioBookingState>((ref) {
  final getBookings = ref.read(getBookingsUseCaseProvider);
  return FolioBookingController(getBookings);
});
