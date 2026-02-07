import '../entities/premium_type_entity.dart';

abstract class PremiumTypeRepository {
  Future<List<PremiumTypeEntity>> getAllPremiumTypes();

  Stream<List<PremiumTypeEntity>> watchPremiumTypes();

  Future<void> addPremiumType(PremiumTypeEntity premiumType);

  Future<void> updatePremiumType(PremiumTypeEntity premiumType);

  Future<void> deletePremiumType(int id);
}
