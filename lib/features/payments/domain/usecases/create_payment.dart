import '../entities/payment_entity.dart';
import '../repositories/payment_repository.dart';

class CreatePayment {
  final PaymentRepository repo;

  CreatePayment(this.repo);

  Future<void> call(PaymentEntity payment) {
    return repo.createPayment(payment);
  }
}
