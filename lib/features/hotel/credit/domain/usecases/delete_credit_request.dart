import '../repositories/credit_repository.dart';

class DeleteCreditRequest {
  final CreditRepository repo;

  DeleteCreditRequest(this.repo);

  Future<void> call(int id) {
    return repo.delete(id);
  }
}
