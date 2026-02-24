import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/stock_item.dart';
import '../repositories/stock_item_repository.dart';

class GetStockItems {
  final StockItemRepository repository;

  GetStockItems(this.repository);

  Future<Result<List<StockItem>>> call({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
  }) async {
    return repository.getStockItems(pageNumber: pageNumber, pageSize: pageSize);
  }
}
