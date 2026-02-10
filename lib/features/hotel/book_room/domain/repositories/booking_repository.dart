import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<void> createBooking(BookingEntity booking);
  Future<List<BookingEntity>> getBookings({String? search});
   Future<void> updateBooking(BookingEntity booking);
   
}
