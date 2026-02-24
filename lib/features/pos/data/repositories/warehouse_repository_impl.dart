import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/warehouses_repository.dart';
import '../datasources/local/warehouses_local_datasource.dart';
import '../datasources/remote/warehouses_remote_datasource.dart';
import '../models/warehouse.dart';

class WarehousesRepositoryImpl extends WarehousesRepository {
  final WarehousesLocalDatasource localDatasource;
  final WarehousesRemoteDatasource remoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  WarehousesRepositoryImpl(this.localDatasource, this.remoteDatasource, this.networkInfoRepository);

  @override
  Stream<Result<List<Warehouse>>> getWarehouses() async* {
    final isConnected = await networkInfoRepository.isConnected;

    final localResult = await localDatasource.getWarehouses();

    yield localResult;

    if (isConnected == true) {
      final allWarehouses = <Warehouse>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await remoteDatasource.getWarehouses(pageNumber: currentPage);
        if (remoteResult is Success) {
          allWarehouses.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          yield Result.failure(remoteResult.error);
          break;
        }
      } while (lastPage != null && currentPage <= lastPage);
      await localDatasource.saveWarehouses(allWarehouses);
      yield Result.success(allWarehouses);
    }
  }
}
