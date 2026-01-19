import '../../../../core/shared/result.dart';

abstract class DeletedHoldIdsRepository {
  Future<Result<void>> addHoldId(String holdId);
  Future<Result<void>> removeHoldId(String holdId);
  Future<Result<void>> clearHoldIdsList();
  Future<Result<void>> syncDeletedHolds();
}
