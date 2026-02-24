import 'package:spotstock_inventory/core/constants/strings/spotstock_strings.dart';
import 'package:spotstock_inventory/core/error_handling/app_error.dart';
import 'package:spotstock_inventory/core/networking/spotstock_status_code.dart';

import '../../../../core/shared/result.dart';
import '../../../../features/network_info/domain/repositories/network_info_repository.dart';
import '../../../../features/auth/data/datasources/local/login_local_datasource.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/remote/login_remote_datasource.dart';
import '../models/login_dto.dart';
import '../models/login_response_dao.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDatasource loginRemoteDatasource;
  final LoginLocalDatasource loginLocalDatasource;
  final NetworkInfoRepository networkInfoRepository;

  LoginRepositoryImpl(
    this.loginRemoteDatasource,
    this.loginLocalDatasource,
    this.networkInfoRepository,
  );

  @override
  Future<Result<LoginResponseDao>> login(LoginDto loginDto) async {
    final isConnected = await networkInfoRepository.isConnected;

    if (isConnected == true) {
      final remoteResult = await loginRemoteDatasource.login(loginDto);
      if (remoteResult is Success) {
        return Result.success(remoteResult.data.data);
      }
      if (remoteResult is Failure) {
        return Result.failure(remoteResult.error);
      }
    }

    final localResult = await loginLocalDatasource.login(loginDto);
    if (localResult is Success) {
      return Result.success(localResult.data);
    }
    if (localResult is Failure) {
      return Result.failure(localResult.error);
    }

    return Result.failure(
      AppError(
        message: SpotstockStrings.loginFailed,
        code: SpotstockStatusCode.internalAppError.toString(),
        originalError: null,
      ),
    );
  }
}
