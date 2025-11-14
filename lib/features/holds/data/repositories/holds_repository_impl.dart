import 'dart:developer';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../../pos/domain/errors/errors.dart';
import '../../domain/repositories/holds_repository.dart';
import '../datasources/local/holds_local_datasource.dart';
import '../datasources/remote/holds_remote_datasource.dart';
import '../mappers/hold_mapper.dart';
import '../models/create_hold_dto.dart';
import '../models/hold.dart';

class HoldsRepositoryImpl implements HoldsRepository {
  final HoldsRemoteDatasource holdsRemoteDatasource;
  final HoldsLocalDatasource holdsLocalDatasource;
  final NetworkInfoRepository networkInfoRepository;

  HoldsRepositoryImpl(
    this.holdsRemoteDatasource,
    this.holdsLocalDatasource,
    this.networkInfoRepository,
  );

  @override
  Stream<Result<List<Hold>>> getHolds({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
    int? limit = SpotstockApiConstants.limit,
  }) async* {
    final isConnected = await networkInfoRepository.isConnected;
    final localResult = await holdsLocalDatasource.getHolds();

    yield localResult;

    if (isConnected == true) {
      final allHolds = <Hold>[];
      int currentPage = 1;
      int? lastPage;
      do {
        final remoteResult = await holdsRemoteDatasource.getHolds(
          pageNumber: currentPage,
          limit: limit,
          pageSize: pageSize,
        );
        if (remoteResult is Success) {
          allHolds.addAll(remoteResult.data.data);
          currentPage = remoteResult.data.meta?.currentPage ?? currentPage;
          lastPage = remoteResult.data.meta?.lastPage ?? currentPage;
          currentPage++;
        }
        if (remoteResult is Failure) {
          yield Result.failure(remoteResult.error);
          break;
        }
      } while (lastPage != null && currentPage <= lastPage);
      await holdsLocalDatasource.saveHolds(allHolds);
      yield Result.success(allHolds);
    }
  }

  @override
  Future<Result<Hold>> createHold(CreateHoldDto createHoldDto) async {
    final isConnected = await networkInfoRepository.isConnected;

    if (isConnected == true) {
      final remoteResult = await holdsRemoteDatasource.createHold(createHoldDto);
      if (remoteResult is Success) {
        final hold = HoldMapper.fromHoldCreationResponse(remoteResult.data);
        getHolds();
        return Result.success(hold);
      }
      if (remoteResult is Failure) {
        return Result.failure(remoteResult.error);
      }
    } else {
      final localResult = await holdsLocalDatasource.createHold(createHoldDto);
      if (localResult is Success) {
        return Result.success(localResult.data);
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
}
