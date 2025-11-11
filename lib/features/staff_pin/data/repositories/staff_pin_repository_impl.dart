import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/error_handling/app_error.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/shared/result.dart';
import '../../../network_info/domain/repositories/network_info_repository.dart';
import '../../domain/repositories/staff_pin_repository.dart';
import '../datasources/local/staff_pin_local_datasource.dart';
import '../datasources/remote/staff_pin_remote_datasource.dart';
import '../models/verify_pin_dto.dart';

class StaffPinRepositoryImpl extends StaffPinRepository {
  final StaffPinLocalDatasource localDatasource;
  final StaffPinRemoteDatasource remoteDatasource;
  final NetworkInfoRepository networkInfoRepository;

  StaffPinRepositoryImpl(this.localDatasource, this.remoteDatasource, this.networkInfoRepository);

  @override
  Future<Result<bool>> verifyPin(VerifyPinDto verifyPinDto) async {
    final isConnected = await networkInfoRepository.isConnected;
    if (isConnected == true) {
      final remoteResult = await remoteDatasource.verifyPin(verifyPinDto);
      if (remoteResult is Success) {
        final bool isVerified = remoteResult.data.success ?? false;
        if (isVerified) {
          await localDatasource.savePin(verifyPinDto);
          return Result.success(isVerified);
        }
        return Result.failure(
          AppError(
            message: remoteResult.data.message ?? SpotstockStrings.somethingWentWrong,
            code: SpotstockStatusCode.invalidPin.toString(),
            originalError: remoteResult.data.rawResponse,
          ),
        );
      }
      if (remoteResult is Failure) {
        return Result.failure(remoteResult.error);
      }
      return Result.failure(remoteResult.error);
    }
    final localResult = await localDatasource.verifyPin(verifyPinDto);
    if (localResult is Success) {
      return Result.success(localResult.data);
    }
    return Result.failure(localResult.error);
  }
}
