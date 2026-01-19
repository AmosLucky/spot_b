import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../pos/data/mappers/product_mapper.dart';
import '../../../../pos/domain/errors/errors.dart';
import '../../mappers/stock_item_mapper.dart';
import '../../models/stock_item.dart';

class StockItemLocalDatasource {
  final DatabaseClient db;

  StockItemLocalDatasource(this.db);

  Future<Result<List<StockItem>>> getStockItems() async {
    try {
      final localProducts = await db.select(db.localProducts).get();
      final domainProducts = localProducts.map((product) => ProductMapper.fromDrift(product)).toList();
      final stockItems = domainProducts.map((product) => StockItemMapper.fromProduct(product)).toList();

      return Result.success(stockItems);
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
