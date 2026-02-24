import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/error_handling/app_error.dart';
import '../../../../../core/local_storage/local_storage_client.dart';
import '../../../../../core/local_storage/local_storage_keys.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';

class LastLoginTimeDatasource {
  final LocalStorageClient localStorageClient;

  LastLoginTimeDatasource(this.localStorageClient);

  void saveLastLoginTime(DateTime lastLoginTime) async {
    await localStorageClient.write(LocalStorageKeys.lastLoginTime, lastLoginTime.toIso8601String());
  }

  Future<Result<DateTime?>> getLastLoginTime() async {
    final lastLoginTime = localStorageClient.read(LocalStorageKeys.lastLoginTime);
    if (lastLoginTime == null) {
      return Result.failure(
        AppError(
          message: SpotstockStrings.lastLoginTimeNotFound,
          code: SpotstockStatusCode.internalAppError.toString(),
          originalError: null,
        ),
      );
    }
    return Result.success(DateTime.parse(lastLoginTime));
  }

  void clearLastLoginTime() async {
    await localStorageClient.delete(LocalStorageKeys.lastLoginTime);
  }
}
