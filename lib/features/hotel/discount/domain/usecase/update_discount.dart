import '../entities/discount_entity.dart';
import '../repositories/discount_repository.dart';

class UpdateDiscount {
  final DiscountRepository repo;

  UpdateDiscount(this.repo);

  Future<void> call(DiscountEntity discount) {
    return repo.update(discount);
  }
}
