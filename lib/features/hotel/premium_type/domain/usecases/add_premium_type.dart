import '../entities/premium_type_entity.dart';
import '../repositories/premium_type_repository.dart';

class AddPremiumType {
  final PremiumTypeRepository repository;

  AddPremiumType(this.repository);

  Future<void> call(PremiumTypeEntity premiumType) {
    return repository.addPremiumType(premiumType);
  }
}
