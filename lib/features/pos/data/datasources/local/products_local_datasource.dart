import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../domain/errors/errors.dart';
import '../../mappers/product_mapper.dart';
import '../../models/product.dart';

class ProductsLocalDatasource {
  final DatabaseClient db;

  ProductsLocalDatasource(this.db);

  Future<Result<void>> saveProducts(List<Product> products) async {
    try {
      await db.transaction(() async {
        await db.delete(db.localProducts).go();
        final companions = products.map((p) => p.toDrift()).toList();
        await db.batch((batch) {
          batch.insertAll(db.localProducts, companions);
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

  Future<Result<List<Product>>> getProducts() async {
    try {
      final rows = await db.select(db.localProducts).get();
      final products = rows.map((product) => ProductMapper.fromDrift(product)).toList();
      return Result.success(products);
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
