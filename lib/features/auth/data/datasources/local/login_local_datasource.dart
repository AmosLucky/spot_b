import 'dart:convert';

import 'package:spotstock_inventory/core/local_storage/local_storage_keys.dart';
import 'package:spotstock_inventory/features/auth/data/models/login_dto.dart';
import 'package:spotstock_inventory/features/auth/services/password_hashing_service.dart';
import 'package:spotstock_inventory/features/auth/services/salt_generation_service.dart';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/error_handling/app_error.dart';
import '../../../../../core/local_storage/local_storage_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../models/login_response_dao.dart';

class LoginLocalDatasource {
  final SaltGenerationService saltGenerationService;
  final PasswordHashingService passwordHashingService;
  final LocalStorageClient localStorageClient;

  LoginLocalDatasource(
    this.saltGenerationService,
    this.passwordHashingService,
    this.localStorageClient,
  );

  Future<Result<LoginResponseDao>> login(LoginDto loginDto) async {
    final offlineUsersString = await localStorageClient.privateRead(LocalStorageKeys.offlineUsers);
    if (offlineUsersString == null) {
      return Result.failure(
        AppError(
          message: SpotstockStrings.noOfflineUser,
          code: SpotstockStatusCode.internalAppError.toString(),
          originalError: null,
        ),
      );
    }

    final offlineUsers = jsonDecode(offlineUsersString) as Map<String, dynamic>;
    if (!offlineUsers.containsKey(loginDto.email)) {
      return Result.failure(
        AppError(
          message: SpotstockStrings.userNotFound,
          code: SpotstockStatusCode.internalAppError.toString(),
          originalError: null,
        ),
      );
    }

    final offlineUser = offlineUsers[loginDto.email];

    final salt = offlineUser['salt'] as String;

    final storedPasswordHash = offlineUser['passwordHash'] as String;

    final inputPasswordHash = passwordHashingService.hashPassword(loginDto.password, salt);

    if (inputPasswordHash == storedPasswordHash) {
      return Result.success(LoginResponseDao.fromJson(offlineUser['loginResponse']));
    }

    return Result.failure(
      AppError(
        message: SpotstockStrings.loginFailed,
        code: SpotstockStatusCode.internalAppError.toString(),
        originalError: null,
      ),
    );
  }

  Future<Result<void>> saveOfflineUser(LoginDto loginDto, LoginResponseDao loginResponse) async {
    try {
      final offlineUsersString = await localStorageClient.privateRead(LocalStorageKeys.offlineUsers);

      Map<String, dynamic> offlineUsers =
          offlineUsersString == null || offlineUsersString.isEmpty ? {} : jsonDecode(offlineUsersString) as Map<String, dynamic>;

      final salt = saltGenerationService.generateSalt();
      final passwordHash = passwordHashingService.hashPassword(loginDto.password, salt);

      offlineUsers[loginDto.email] = {
        "salt": salt,
        "passwordHash": passwordHash,
        "loginResponse": loginResponse.toJson(),
      };

      await localStorageClient.privateWrite(
        LocalStorageKeys.offlineUsers,
        jsonEncode(offlineUsers),
      );

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        AppError(
          message: SpotstockStrings.unableToSaveOfflineUser,
          code: SpotstockStatusCode.internalAppError.toString(),
          originalError: e,
        ),
      );
    }
  }
}
