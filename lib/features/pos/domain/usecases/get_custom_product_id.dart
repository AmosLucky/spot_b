import '../../../../core/shared/result.dart';
import '../repositories/custom_product_repository.dart';

class GetCustomProductId {
  final CustomProductRepository customProductRepository;

  GetCustomProductId(this.customProductRepository);

  Future<Result<int>> call() async {
    return await customProductRepository.getCustomProductId();
  }
}
