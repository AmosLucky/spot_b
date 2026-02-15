import '../entities/discount_entity.dart';
import '../repositories/discount_repository.dart';

class GetDiscountsByBooking {
  final DiscountRepository repo;

  GetDiscountsByBooking(this.repo);

  Future<List<DiscountEntity>> call(int bookingId) {
    return repo.getByBooking(bookingId);
  }
}
