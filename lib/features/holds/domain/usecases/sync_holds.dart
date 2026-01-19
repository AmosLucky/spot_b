import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/domain/usecases/spotstock_sync_task_usecase.dart';
import '../../../../core/shared/result.dart';
import '../repositories/holds_repository.dart';

class SyncHolds extends SpotstockSyncTaskUsecase {
  final HoldsRepository holdsRepository;

  SyncHolds(this.holdsRepository);

  @override
  String get name => SpotstockStrings.smallHolds;

  @override
  Future<Result<void>> sync() async {
    return await holdsRepository.syncHolds();
  }
}
