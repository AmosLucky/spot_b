import '../../domain/entities/premium_type_entity.dart';
import '../../domain/repositories/premium_type_repository.dart';
import '../local/premium_type_local_service.dart';

class PremiumTypeRepositoryImpl implements PremiumTypeRepository {
  final PremiumTypeLocalDataSource localDataSource;

  PremiumTypeRepositoryImpl(this.localDataSource);

  @override
  Future<List<PremiumTypeEntity>> getAllPremiumTypes() {
    return localDataSource.getAllPremiumTypes();
  }

  @override
  Stream<List<PremiumTypeEntity>> watchPremiumTypes() {
    return localDataSource.watchPremiumTypes();
  }

  @override
  Future<void> addPremiumType(PremiumTypeEntity premiumType) {
    return localDataSource.addPremiumType(premiumType);
  }

  @override
  Future<void> updatePremiumType(PremiumTypeEntity premiumType) {
    return localDataSource.updatePremiumType(premiumType);
  }

  @override
  Future<void> deletePremiumType(int id) {
    return localDataSource.deletePremiumType(id);
  }
}
