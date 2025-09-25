import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/error_handling/app_error.dart';
import '../../../../../core/local_storage/local_storage_client.dart';
import '../../../../../core/local_storage/local_storage_keys.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';

class TokenDatasource {
  final LocalStorageClient localStorageClient;

  TokenDatasource(this.localStorageClient);

  void saveToken(String token) async {
    await localStorageClient.privateWrite(LocalStorageKeys.accessToken, token);
  }

  Future<Result<String?>> getToken() async {
    final token = await localStorageClient.privateRead(LocalStorageKeys.accessToken);
    if (token == null) {
      return Result.failure(
        AppError(
          message: SpotstockStrings.tokenNotFound,
          code: SpotstockStatusCode.internalAppError.toString(),
          originalError: null,
        ),
      );
    }
    return Result.success(token);
  }

  void clearToken() async {
    await localStorageClient.delete(LocalStorageKeys.accessToken);
  }
}
