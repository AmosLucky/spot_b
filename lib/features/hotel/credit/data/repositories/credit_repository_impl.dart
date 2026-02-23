import '../../domain/entities/credit_request_entity.dart';
import '../../domain/repositories/credit_repository.dart';
import '../datasources/credit_local_data_source.dart';

class CreditRepositoryImpl implements CreditRepository {
  final CreditLocalDataSource local;

  CreditRepositoryImpl(this.local);

  @override
  Future<List<CreditRequestEntity>> getByBooking(int bookingId) {
    return local.getByBooking(bookingId);
  }

  @override
  Future<int> create(CreditRequestEntity credit) {
    return local.insert(credit);
  }

  @override
  Future<void> update(CreditRequestEntity credit) {
    return local.update(credit);
  }

  @override
  Future<void> delete(int id) {
    return local.delete(id);
  }

  @override
  Future<List<CreditRequestEntity>> getAllCredits() {
    return local.getAllCredits();
  }
}
