import '../../../../core/shared/result.dart';
import '../../data/models/product.dart';

abstract class ProductsRepository {
  Stream<Result<List<Product>>> getProducts();
}
