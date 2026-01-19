import '../../../../core/shared/result.dart';
import '../repositories/custom_product_repository.dart';

class GetCustomProductCode {
  final CustomProductRepository customProductRepository;

  GetCustomProductCode(this.customProductRepository);

  Future<Result<String>> call() async {
    return await customProductRepository.getCustomProductCode();
  }
}
