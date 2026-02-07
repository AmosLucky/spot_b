import '../entities/premium_type_entity.dart';
import '../repositories/premium_type_repository.dart';

class GetPremiumTypes {
  final PremiumTypeRepository repository;

  GetPremiumTypes(this.repository);

  Future<List<PremiumTypeEntity>> call() {
    return repository.getAllPremiumTypes();
  }
}
