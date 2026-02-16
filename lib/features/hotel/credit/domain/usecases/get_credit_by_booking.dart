import '../entities/credit_request_entity.dart';
import '../repositories/credit_repository.dart';

class GetCreditByBooking {
  final CreditRepository repo;

  GetCreditByBooking(this.repo);

  Future<List<CreditRequestEntity>> call(int bookingId) {
    return repo.getByBooking(bookingId);
  }
}
