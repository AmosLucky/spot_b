import '../repositories/payment_repository.dart';

class DeletePayment {
  final PaymentRepository repo;

  DeletePayment(this.repo);

  Future<void> call(int id) {
    return repo.deletePayment(id);
  }
}
