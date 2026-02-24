import 'dart:convert';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/error_handling/app_error.dart';
import '../../../../../core/local_storage/local_storage_client.dart';
import '../../../../../core/local_storage/local_storage_keys.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../models/spotstock_user.dart';

class UserDatasource {
  final LocalStorageClient localStorageClient;

  UserDatasource(this.localStorageClient);

  void saveUser(SpotstockUser user) async {
    await localStorageClient.write(LocalStorageKeys.spotStockUser, jsonEncode(user.toJson()));
  }

  Future<Result<SpotstockUser?>> getUser() async {
    final user = localStorageClient.read(LocalStorageKeys.spotStockUser);
    if (user == null) {
      return Result.failure(
        AppError(
          message: SpotstockStrings.userNotFound,
          code: SpotstockStatusCode.internalAppError.toString(),
          originalError: null,
        ),
      );
    }
    return Result.success(SpotstockUser.fromJson(jsonDecode(user)));
  }

  void clearUser() async {
    await localStorageClient.delete(LocalStorageKeys.spotStockUser);
  }
}
