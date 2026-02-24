import '../entities/booking_premium_service_entity.dart';
import '../repositories/booking_premium_service_repository.dart';

class UpdateBookingPremiumService {
  final BookingPremiumServiceRepository repository;

  UpdateBookingPremiumService(this.repository);

  Future<void> call(BookingPremiumServiceEntity entity) {
    return repository.update(entity);
  }
}
