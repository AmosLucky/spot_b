import '../entities/booking_premium_service_entity.dart';
import '../repositories/booking_premium_service_repository.dart';

class AddBookingPremiumService {
  final BookingPremiumServiceRepository repository;

  AddBookingPremiumService(this.repository);

   Future<int> call(BookingPremiumServiceEntity entity) {
    return repository.insert(entity);
  }
}
