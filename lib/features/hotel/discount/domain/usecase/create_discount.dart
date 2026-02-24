import '../entities/discount_entity.dart';
import '../repositories/discount_repository.dart';

class CreateDiscount {
  final DiscountRepository repo;

  CreateDiscount(this.repo);

  Future<int> call(DiscountEntity discount) {
    return repo.create(discount);
  }
}
