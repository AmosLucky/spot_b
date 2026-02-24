import '../../../../core/shared/result.dart';
import '../../data/models/product_category.dart';

abstract class ProductCategoriesRepository {
  Stream<Result<List<ProductCategory>>> getProductCategories();
}
