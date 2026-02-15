import '../../domain/entities/discount_entity.dart';
import '../../domain/repositories/discount_repository.dart';
import '../datasources/discount_local_data_source.dart';

class DiscountRepositoryImpl implements DiscountRepository {
  final DiscountLocalDataSource local;

  DiscountRepositoryImpl(this.local);

  @override
  Future<List<DiscountEntity>> getByBooking(int bookingId) {
    return local.getByBooking(bookingId);
  }

  @override
  Future<int> create(DiscountEntity discount) {
    return local.insert(discount);
  }

  @override
  Future<void> update(DiscountEntity discount) {
    return local.update(discount);
  }

  @override
  Future<void> delete(int id) {
    return local.delete(id);
  }
}
