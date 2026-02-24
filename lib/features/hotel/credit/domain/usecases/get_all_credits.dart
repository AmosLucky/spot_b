import '../entities/credit_request_entity.dart';
import '../repositories/credit_repository.dart';

class GetAllCredits {
  final CreditRepository repo;

  GetAllCredits(this.repo);

  Future<List<CreditRequestEntity>> call() {
    return repo.getAllCredits();
  }
}