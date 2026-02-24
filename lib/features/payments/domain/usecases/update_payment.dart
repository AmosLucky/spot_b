import '../entities/payment_entity.dart';
import '../repositories/payment_repository.dart';

class UpdatePayment {
  final PaymentRepository repo;

  UpdatePayment(this.repo);

  Future<void> call(PaymentEntity payment) {
    return repo.updatePayment(payment);
  }
}
