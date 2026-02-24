import '../../../../core/shared/result.dart';
import '../../../../features/holds/data/datasources/local/deleted_hold_ids_datasource.dart';
import '../../../../features/holds/data/datasources/remote/holds_remote_datasource.dart';
import '../../domain/repositories/deleted_hold_ids_repository.dart';

class DeletedHoldIdsRepositoryImpl implements DeletedHoldIdsRepository {
  final DeletedHoldIdsDatasource deletedHoldIdsDatasource;
  final HoldsRemoteDatasource holdsRemoteDatasource;

  DeletedHoldIdsRepositoryImpl(this.deletedHoldIdsDatasource, this.holdsRemoteDatasource);

  @override
  Future<Result<void>> addHoldId(String holdId) async {
    return await deletedHoldIdsDatasource.addHoldId(holdId);
  }

  @override
  Future<Result<void>> removeHoldId(String holdId) async {
    return await deletedHoldIdsDatasource.removeHoldId(holdId);
  }

  @override
  Future<Result<void>> clearHoldIdsList() async {
    return await deletedHoldIdsDatasource.clearHoldIdsList();
  }

  @override
  Future<Result<void>> syncDeletedHolds() async {
    final deletedHoldIds = await deletedHoldIdsDatasource.getDeletedHoldIds();
    for (final holdId in deletedHoldIds) {
      final deleteHoldResult = await holdsRemoteDatasource.deleteHold(holdId);
      if (deleteHoldResult is Success) {
        await deletedHoldIdsDatasource.removeHoldId(holdId);
      }
      if (deleteHoldResult is Failure) {
        Result.failure(deleteHoldResult.error);
      }
    }
    return Result.success(null);
  }
}
