import '../entities/booking_premium_service_entity.dart';

abstract class BookingPremiumServiceRepository {
  Future<List<BookingPremiumServiceEntity>> getByBooking(int bookingId);

  Future<int> insert(BookingPremiumServiceEntity entity);

  Future<void> update(BookingPremiumServiceEntity entity);

  Future<void> delete(int id);
}
