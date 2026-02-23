import '../entities/discount_entity.dart';
import '../repositories/discount_repository.dart';

class GetAllDiscountRequests {
  final DiscountRepository repo;

  GetAllDiscountRequests(this.repo);

  Future<List<DiscountEntity>> call() {
    return repo.getAllDiscountRequests();
  }
}