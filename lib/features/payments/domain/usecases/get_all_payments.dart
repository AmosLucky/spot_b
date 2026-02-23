import '../entities/payment_entity.dart';
import '../repositories/payment_repository.dart';

class GetAllPayments {
  final PaymentRepository repo;

  GetAllPayments(this.repo);

  Future<List<PaymentEntity>> call() {
    return repo.getAllPayments();
  }
}