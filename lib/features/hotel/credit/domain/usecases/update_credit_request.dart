import '../entities/credit_request_entity.dart';
import '../repositories/credit_repository.dart';

class UpdateCreditRequest {
  final CreditRepository repo;

  UpdateCreditRequest(this.repo);

  Future<void> call(CreditRequestEntity credit) {
    return repo.update(credit);
  }
}
