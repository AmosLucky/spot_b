import '../../../../core/shared/result.dart';
import '../../data/models/product_category.dart';
import '../repositories/product_categories_repository.dart';

class GetProductCategories {
  final ProductCategoriesRepository productCategoriesRepository;

  GetProductCategories(this.productCategoriesRepository);

  Stream<Result<List<ProductCategory>>> call() async* {
    yield* productCategoriesRepository.getProductCategories();
  }
}
