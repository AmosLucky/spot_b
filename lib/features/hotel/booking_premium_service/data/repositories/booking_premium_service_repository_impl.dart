import '../../domain/entities/booking_premium_service_entity.dart';
import '../../domain/repositories/booking_premium_service_repository.dart';
import '../datasources/booking_premium_service_local_data_source.dart';

class BookingPremiumServiceRepositoryImpl
    implements BookingPremiumServiceRepository {
  final BookingPremiumServiceLocalDataSource local;

  BookingPremiumServiceRepositoryImpl(this.local);

  @override
  Future<List<BookingPremiumServiceEntity>> getByBooking(
      int bookingId) {
    return local.getByBooking(bookingId);
  }

  @override
  Future<int> insert(BookingPremiumServiceEntity entity) {
    return local.insert(entity);
  }

  @override
  Future<void> update(BookingPremiumServiceEntity entity) {
    return local.update(entity);
  }

  @override
  Future<void> delete(int id) {
    return local.delete(id);
  }
}
