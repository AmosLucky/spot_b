import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class UpdateBookingUseCase {
  final BookingRepository repo;
  UpdateBookingUseCase(this.repo);

  Future<void> call(BookingEntity booking) {
    return repo.updateBooking(booking);
  }
}
