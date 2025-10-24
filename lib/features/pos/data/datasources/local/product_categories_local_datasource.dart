import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../domain/errors/errors.dart';
import '../../mappers/product_category_mapper.dart';
import '../../models/product_category.dart';

class ProductCategoriesLocalDatasource {
  final DatabaseClient db;

  ProductCategoriesLocalDatasource(this.db);

  Future<Result<void>> saveProductCategories(List<ProductCategory> productCategories) async {
    try {
      await db.transaction(() async {
        await db.delete(db.localProductCategories).go();
        final companions = productCategories.map((p) => p.toDrift()).toList();
        await db.batch((batch) {
          batch.insertAll(db.localProductCategories, companions);
        });
      });
      return Result.success(null);
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToWriteData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }

  Future<Result<List<ProductCategory>>> getProductCategories() async {
    try {
      final rows = await db.select(db.localProductCategories).get();
      final productCategories =
          rows.map((productCategory) => ProductCategoryMapper.fromDrift(productCategory)).toList();
      return Result.success(productCategories);
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToReadData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }
}
