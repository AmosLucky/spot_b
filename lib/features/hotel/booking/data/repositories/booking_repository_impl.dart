import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/local/booking_local_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingLocalDataSource local;

  BookingRepositoryImpl(this.local);

  @override
  Future<int> createBooking(BookingEntity booking) {
    return local.createBooking(booking);
  }

  @override
  Future<void> updateBooking(BookingEntity booking) {
    return local.updateBooking(booking);
  }

  @override
  Future<List<BookingEntity>> getBookings({String? search}) {
    return local.getBookings(search: search);
  }
}
