import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/stock_item_repository.dart';
import '../datasources/local/stock_item_local_datasource.dart';
import '../datasources/remote/stock_item_remote_datasource.dart';
import '../models/stock_item.dart';

class StockItemRepositoryImpl implements StockItemRepository {
  final StockItemRemoteDatasource remoteDatasource;
  final StockItemLocalDatasource localDatasource;
  final NetworkInfoRepository networkInfoRepository;

  StockItemRepositoryImpl(this.remoteDatasource, this.localDatasource, this.networkInfoRepository);

  @override
  Future<Result<List<StockItem>>> getStockItems({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
  }) async {
    final isConnected = await networkInfoRepository.isConnected;
    if (isConnected == true) {
      final allStockItems = <StockItem>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await remoteDatasource.getStockItems(pageNumber: currentPage, pageSize: pageSize);
        if (remoteResult is Success) {
          allStockItems.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          return Result.failure(remoteResult.error);
        }
      } while (lastPage != null && currentPage <= lastPage);
      return Result.success(allStockItems);
    } else {
      return await localDatasource.getStockItems();
    }
  }
}
