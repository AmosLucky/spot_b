abstract class SyncEvent {}

class SyncStarted extends SyncEvent {}

class SyncTaskStarted extends SyncEvent {
  final String taskName;

  SyncTaskStarted(this.taskName);
}

class SyncTaskSuccess extends SyncEvent {
  final String taskName;

  SyncTaskSuccess(this.taskName);
}

class SyncTaskFailure extends SyncEvent {
  final String taskName;
  final Object error;

  SyncTaskFailure(this.error, this.taskName);
}

class SyncCompleted extends SyncEvent {}
