import 'package:spotstock_inventory/core/domain/usecases/spotstock_sync_task_usecase.dart';
import 'package:spotstock_inventory/features/sync/presentation/view_model/sync_event/sync_event.dart';

import '../../../../core/shared/result.dart';

class SyncOfflineData {
  final List<SpotstockSyncTaskUsecase> tasks;

  SyncOfflineData(this.tasks);

  Stream<SyncEvent> call() async* {
    yield SyncStarted();

    for (final task in tasks) {
      yield SyncTaskStarted(task.name);

      final result = await task.sync();

      if (result is Success) {
        yield SyncTaskSuccess(task.name);
      } else if (result is Failure) {
        yield SyncTaskFailure(result.error, task.name);
        // IMPORTANT: decide whether to stop or continue
        // yield break; // to stop immediately
      }
    }

    yield SyncCompleted();
  }
}
