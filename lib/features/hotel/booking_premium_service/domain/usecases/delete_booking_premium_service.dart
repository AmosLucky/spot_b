import '../repositories/booking_premium_service_repository.dart';

class DeleteBookingPremiumService {
  final BookingPremiumServiceRepository repository;

  DeleteBookingPremiumService(this.repository);

  Future<void> call(int id) {
    return repository.delete(id);
  }
}
