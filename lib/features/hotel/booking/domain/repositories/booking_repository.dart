import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<int> createBooking(BookingEntity booking);
  Future<List<BookingEntity>> getBookings({String? search});
   Future<void> updateBooking(BookingEntity booking);
   
}
