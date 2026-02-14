import '../entities/payment_entity.dart';
import '../repositories/payment_repository.dart';

class GetSinglePaymentByBooking {
  final PaymentRepository repo;

  GetSinglePaymentByBooking(this.repo);

  Future<PaymentEntity?> call(int bookingId) async {
    final list = await repo.getPaymentsByBooking(bookingId);
    if (list.isEmpty) return null;
    return list.first;
  }
}
