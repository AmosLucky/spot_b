import '../../shared/result.dart';

abstract class SpotstockSyncTaskUsecase {
  String get name;
  Future<Result<void>> sync();
}
