import '../../../../core/constants/durations/spotstock_durations.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/shared/result.dart';
import '../../../../features/holds/data/datasources/local/deleted_hold_ids_datasource.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../../pos/domain/errors/errors.dart';
import '../../../receipt/domain/repositories/local_receipt_reference_no_repository.dart';
import '../../domain/repositories/holds_repository.dart';
import '../datasources/local/holds_local_datasource.dart';
import '../datasources/remote/holds_remote_datasource.dart';
import '../mappers/hold_mapper.dart';
import '../models/create_hold_dto.dart';
import '../models/hold.dart';

class HoldsRepositoryImpl implements HoldsRepository {
  final HoldsRemoteDatasource holdsRemoteDatasource;
  final HoldsLocalDatasource holdsLocalDatasource;
  final DeletedHoldIdsDatasource deletedHoldIdsDatasource;
  final LocalReceiptReferenceNoRepository localReceiptReferenceNoRepository;
  final NetworkInfoRepository networkInfoRepository;

  HoldsRepositoryImpl(
    this.holdsRemoteDatasource,
    this.holdsLocalDatasource,
    this.deletedHoldIdsDatasource,
    this.localReceiptReferenceNoRepository,
    this.networkInfoRepository,
  );

  @override
  Stream<Result<List<Hold>>> getHolds({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
    int? limit = SpotstockApiConstants.limit,
    int? userId,
  }) async* {
    final isConnected = await networkInfoRepository.isConnected;
    final localResult = await holdsLocalDatasource.getHolds(userId: userId);

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
      final receiptRefNoResult = await localReceiptReferenceNoRepository.generateReceiptReferenceNo();
      if (receiptRefNoResult is Success) {
        final localResult = await holdsLocalDatasource.createHold(
          createHoldDto.copyWith(
            referenceCode: receiptRefNoResult.data,
          ),
        );
        if (localResult is Success) {
          return Result.success(localResult.data);
        }
        if (localResult is Failure) {
          return Result.failure(localResult.error);
        }
      }
      if (receiptRefNoResult is Failure) {
        return Result.failure(receiptRefNoResult.error);
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
  Future<Result<void>> syncHolds() async {
    final localHoldsResult = await holdsLocalDatasource.getHolds();
    if (localHoldsResult is Success) {
      final holds = localHoldsResult.data;
      for (final hold in holds) {
        if (hold.isSynced == false) {
          final remoteResult = await holdsRemoteDatasource.createHold(hold.toCreateHoldDto());
          if (remoteResult is Success) {
            await holdsLocalDatasource.markHoldAsSynced(hold.referenceCode);
            await Future.delayed(SpotstockDurations.syncHoldsDelay);
          } else if (remoteResult is Failure) {
            return Result.failure(remoteResult.error);
          }
        }
      }
    }
    if (localHoldsResult is Failure) {
      return Result.failure(localHoldsResult.error);
    }
    return Result.success(null);
  }

  @override
  Future<Result<void>> deleteHold(Hold hold) async {
    final isConnected = await networkInfoRepository.isConnected;

    final holdReferenceCode = hold.referenceCode;
    final holdId = hold.id.toString();

    if (isConnected == true && hold.isSynced == true) {
      final remoteResult = await holdsRemoteDatasource.deleteHold(holdId);
      if (remoteResult is Success) {
        getHolds();
        return Result.success(null);
      }
      if (remoteResult is Failure) {
        return Result.failure(remoteResult.error);
      }
    } else if (isConnected == false && hold.isSynced == true) {
      final localResult = await holdsLocalDatasource.deleteHold(holdReferenceCode);
      if (localResult is Success) {
        await deletedHoldIdsDatasource.addHoldId(holdId);
        getHolds();
        return Result.success(null);
      }
      if (localResult is Failure) {
        return Result.failure(localResult.error);
      }
    } else {
      final localResult = await holdsLocalDatasource.deleteHold(holdReferenceCode);
      if (localResult is Success) {
        getHolds();
        return Result.success(null);
      }
      if (localResult is Failure) {
        return Result.failure(localResult.error);
      }
    }

    return Result.failure(LocalDatabaseError(
      message: SpotstockStrings.failedToDeleteData,
      subtitle: SpotstockStrings.somethingWentWrong,
      code: SpotstockStatusCode.internalAppDatabaseError.toString(),
      originalError: null,
    ));
  }

  @override
  Stream<Result<Hold>> getHold(int holdId, {String? referenceCode}) async* {
    final isConnected = await networkInfoRepository.isConnected;
    final localResult = await holdsLocalDatasource.getHold(referenceCode);

    yield localResult;

    if (isConnected == true) {
      final remoteResult = await holdsRemoteDatasource.getHold(holdId.toString());
      if (remoteResult is Success) {
        await holdsLocalDatasource.saveHold(remoteResult.data.data);
        yield Result.success(remoteResult.data.data);
      }
      if (remoteResult is Failure) {
        yield Result.failure(remoteResult.error);
      }
    }
  }
}
