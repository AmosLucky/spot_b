import '../entities/payment_entity.dart';
import '../repositories/payment_repository.dart';

class GetPaymentsByBooking {
  final PaymentRepository repo;

  GetPaymentsByBooking(this.repo);

  Future<List<PaymentEntity>> call(int bookingId) {
    return repo.getPaymentsByBooking(bookingId);
  }
}
