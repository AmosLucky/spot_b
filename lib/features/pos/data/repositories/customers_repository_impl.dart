import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/customers_repository.dart';
import '../datasources/local/customers_local_datasource.dart';
import '../datasources/remote/customers_remote_datasource.dart';
import '../models/customer.dart';

class CustomersRepositoryImpl extends CustomersRepository {
  final CustomersLocalDatasource localDatasource;
  final CustomersRemoteDatasource remoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  CustomersRepositoryImpl(this.localDatasource, this.remoteDatasource, this.networkInfoRepository);

  @override
  Stream<Result<List<Customer>>> getCustomers() async* {
    final isConnected = await networkInfoRepository.isConnected;

    final localResult = await localDatasource.getCustomers();

    yield localResult;

    if (isConnected == true) {
      final allCustomers = <Customer>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await remoteDatasource.getCustomers(pageNumber: currentPage);
        if (remoteResult is Success) {
          allCustomers.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          yield Result.failure(remoteResult.error);
          break;
        }
      } while (lastPage != null && currentPage <= lastPage);
      localDatasource.saveCustomers(allCustomers);
      yield Result.success(allCustomers);
    }
  }
}
