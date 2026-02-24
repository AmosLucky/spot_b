import '../entities/credit_request_entity.dart';
import '../repositories/credit_repository.dart';

class CreateCreditRequest {
  final CreditRepository repo;

  CreateCreditRequest(this.repo);

  Future<int> call(CreditRequestEntity credit) {
    return repo.create(credit);
  }
}
