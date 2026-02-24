import '../repositories/discount_repository.dart';

class DeleteDiscount {
  final DiscountRepository repo;

  DeleteDiscount(this.repo);

  Future<void> call(int id) {
    return repo.delete(id);
  }
}
