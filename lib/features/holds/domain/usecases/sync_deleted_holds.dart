import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/domain/usecases/spotstock_sync_task_usecase.dart';
import '../../../../core/shared/result.dart';
import '../../../../features/holds/domain/repositories/deleted_hold_ids_repository.dart';

class SyncDeletedHolds extends SpotstockSyncTaskUsecase {
  final DeletedHoldIdsRepository deletedHoldIdsRepository;

  SyncDeletedHolds(this.deletedHoldIdsRepository);

  @override
  String get name => SpotstockStrings.deletedHolds;

  @override
  Future<Result<void>> sync() async {
    return await deletedHoldIdsRepository.syncDeletedHolds();
  }
}
