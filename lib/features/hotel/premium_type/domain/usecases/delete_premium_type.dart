import '../repositories/premium_type_repository.dart';

class DeletePremiumType {
  final PremiumTypeRepository repository;

  DeletePremiumType(this.repository);

  Future<void> call(int id) {
    return repository.deletePremiumType(id);
  }
}
