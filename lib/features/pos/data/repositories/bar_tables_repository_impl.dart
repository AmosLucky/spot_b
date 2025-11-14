import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/bar_tables_repository.dart';
import '../datasources/local/bar_tables_local_datasource.dart';
import '../datasources/remote/bar_tables_remote_datasource.dart';
import '../models/bar_table.dart';

class BarTablesRepositoryImpl extends BarTablesRepository {
  final BarTablesLocalDatasource localDatasource;
  final BarTablesRemoteDatasource remoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  BarTablesRepositoryImpl(this.localDatasource, this.remoteDatasource, this.networkInfoRepository);

  @override
  Stream<Result<List<BarTable>>> getBarTables() async* {
    final isConnected = await networkInfoRepository.isConnected;

    final localResult = await localDatasource.getBarTables();

    yield localResult;

    if (isConnected == true) {
      final allBarTables = <BarTable>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await remoteDatasource.getBarTables(pageNumber: currentPage);
        if (remoteResult is Success) {
          allBarTables.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          yield Result.failure(remoteResult.error);
          break;
        }
      } while (lastPage != null && currentPage <= lastPage);
      await localDatasource.saveBarTables(allBarTables);
      yield Result.success(allBarTables);
    }
  }
}
