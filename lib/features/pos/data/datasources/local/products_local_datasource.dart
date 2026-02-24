import 'package:drift/drift.dart';

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

  Future<Result<void>> saveProducts(List<Product> products, {int? warehouseId}) async {
    try {
      await db.transaction(() async {
        final companions = products.map((p) => p.toDrift(warehouseId: warehouseId)).toList();

        await db.batch((batch) {
          for (final companion in companions) {
            batch.insert(
              db.localProducts,
              companion,
              mode: InsertMode.insertOrReplace,
            );
          }
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

  Future<Result<List<Product>>> getProducts({int? warehouseId}) async {
    try {
      final query = db.select(db.localProducts);
      if (warehouseId != null) {
        query.where((p) => p.warehouseId.equals(warehouseId));
      }

      final rows = await query.get();
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
