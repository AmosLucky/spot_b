import '../../../../core/shared/result.dart';
import '../../data/models/product.dart';
import '../repositories/products_repository.dart';

class GetProducts {
  final ProductsRepository productsRepository;

  GetProducts(this.productsRepository);

  Stream<Result<List<Product>>> call({int? warehouseId}) async* {
    yield* productsRepository.getProducts(warehouseId: warehouseId);
  }
}
