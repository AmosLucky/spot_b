import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/stock_item.dart';

abstract class StockItemRepository {
  Future<Result<List<StockItem>>> getStockItems({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
  });
}
