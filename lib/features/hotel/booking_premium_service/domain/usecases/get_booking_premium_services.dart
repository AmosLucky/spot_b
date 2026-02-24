import '../entities/booking_premium_service_entity.dart';
import '../repositories/booking_premium_service_repository.dart';

class GetBookingPremiumServices {
  final BookingPremiumServiceRepository repository;

  GetBookingPremiumServices(this.repository);

  Future<List<BookingPremiumServiceEntity>> call(int bookingId) {
    return repository.getByBooking(bookingId);
  }
}
