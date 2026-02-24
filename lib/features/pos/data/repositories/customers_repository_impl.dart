import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/customers_repository.dart';
import '../datasources/local/customers_local_datasource.dart';
import '../datasources/remote/customers_remote_datasource.dart';
import '../mappers/customer_mapper.dart';
import '../models/create_customer_dto.dart';
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
      await localDatasource.saveCustomers(allCustomers);
      yield Result.success(allCustomers);
    }
  }

  @override
  Future<Result<Customer>> createCustomer(CreateCustomerDto createCustomerDto) async {
    final isConnected = await networkInfoRepository.isConnected;

    if (isConnected == true) {
      final remoteResult = await remoteDatasource.createCustomer(createCustomerDto);
      if (remoteResult is Success) {
        final customer = CustomerMapper.fromCustomerCreationResponse(remoteResult.data.data);
        final localResult = await localDatasource.saveCustomer(customer);
        if (localResult is Failure) {
          return Result.failure(localResult.error);
        }
        return Result.success(customer);
      }
      if (remoteResult is Failure) {
        return Result.failure(remoteResult.error);
      }
    } else {
      final localResult = await localDatasource.createCustomer(createCustomerDto);
      if (localResult is Success) {
        final customer = CustomerMapper.fromCreateCustomerDto(createCustomerDto);
        return Result.success(customer);
      }
      if (localResult is Failure) {
        return Result.failure(localResult.error);
      }
    }

    return Result.failure(LocalDatabaseError(
      message: SpotstockStrings.failedToWriteData,
      subtitle: SpotstockStrings.somethingWentWrong,
      code: SpotstockStatusCode.internalAppDatabaseError.toString(),
      originalError: null,
    ));
  }

  @override
  Future<Result<void>> syncCustomers() async {
    final localCustomersResult = await localDatasource.getCustomers();
    if (localCustomersResult is Success) {
      final customers = localCustomersResult.data;
      final hasUnsyncedCustomers = customers.any((customer) => customer.isSynced == false);
      if (hasUnsyncedCustomers == false) {
        return Result.success(null);
      }
      for (final customer in customers) {
        if (customer.isSynced == false) {
          final remoteResult = await remoteDatasource.createCustomer(customer.toCreateCustomerDto());
          if (remoteResult is Success) {
            await localDatasource.markCustomerAsSynced(customer.id);
          } else if (remoteResult is Failure) {
            return Result.failure(remoteResult.error);
          }
        }
      }
    }
    if (localCustomersResult is Failure) {
      return Result.failure(localCustomersResult.error);
    }
    return Result.success(null);
  }
}
