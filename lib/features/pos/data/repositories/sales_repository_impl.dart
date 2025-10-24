import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/sales_repository.dart';
import '../datasources/local/sales_local_datasource.dart';
import '../datasources/remote/sales_remote_datasource.dart';
import '../mappers/sale_mapper.dart';
import '../models/create_sale_dto.dart';
import '../models/sale.dart';

class SalesRepositoryImpl extends SalesRepository {
  final SalesLocalDatasource localDatasource;
  final SalesRemoteDatasource remoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  SalesRepositoryImpl(this.localDatasource, this.remoteDatasource, this.networkInfoRepository);

  @override
  Future<Result<Sale>> createSale(CreateSaleDto createSaleDto) async {
    final isConnected = await networkInfoRepository.isConnected;

    if (isConnected == true) {
      final remoteResult = await remoteDatasource.createSale(createSaleDto.copyWith(isOffline: 0));
      if (remoteResult is Success) {
        final sale = SaleMapper.fromSaleCreationResponse(remoteResult.data);
        final localResult = await localDatasource.saveSale(sale);
        if (localResult is Failure) {
          return Result.failure(localResult.error);
        }
        return Result.success(sale);
      }
      if (remoteResult is Failure) {
        return Result.failure(remoteResult.error);
      }
    } else {
      final localResult = await localDatasource.createSale(createSaleDto.copyWith(isOffline: 1));
      if (localResult is Failure) {
        return Result.failure(localResult.error);
      }
      final sale = SaleMapper.fromCreateDto(createSaleDto.copyWith(isOffline: 1));
      return Result.success(sale);
    }
    return Result.failure(LocalDatabaseError(
      message: SpotstockStrings.failedToWriteData,
      subtitle: SpotstockStrings.somethingWentWrong,
      code: SpotstockStatusCode.internalAppDatabaseError.toString(),
      originalError: null,
    ));
  }
}
