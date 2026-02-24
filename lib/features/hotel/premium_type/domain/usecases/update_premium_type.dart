import '../entities/premium_type_entity.dart';
import '../repositories/premium_type_repository.dart';

class UpdatePremiumType {
  final PremiumTypeRepository repository;

  UpdatePremiumType(this.repository);

  Future<void> call(PremiumTypeEntity premiumType) {
    return repository.updatePremiumType(premiumType);
  }
}
