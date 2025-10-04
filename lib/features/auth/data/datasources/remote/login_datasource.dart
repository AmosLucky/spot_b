import '../../../../../core/networking/dio_client.dart';
import '../../../../../core/networking/spotstock_api_error.dart';
import '../../../../../core/networking/spotstock_api_error_handler.dart';
import '../../../../../core/networking/spotstock_api_paths.dart';
import '../../../../../core/networking/api_response/spotstock_api_response.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../models/login_dto.dart';
import '../../models/login_response_dao.dart';

class LoginDatasource {
  final DioClient dioClient;

  LoginDatasource(this.dioClient);

  Future<Result<SpotstockApiResponse<LoginResponseDao>>> login(LoginDto loginDto) async {
    try {
      final response = await dioClient.dio.post(
        SpotstockApiPaths.login,
        data: loginDto.toJson(),
      );
      if (response.statusCode == SpotstockStatusCode.success) {
        return Result.success(
          SpotstockApiResponse<LoginResponseDao>(
            data: LoginResponseDao.fromJson(response.data['data']),
            message: response.data['message'],
            success: response.data['success'],
            rawResponse: response.data,
          ),
        );
      } else {
        return Result.failure(
          SpotstockApiError(
            message: response.data['message'],
            code: response.statusCode.toString(),
            success: response.data['success'],
            rawResponse: response.data['data'],
            originalError: response.data,
          ),
        );
      }
    } catch (e) {
      return Result.failure(handleSpotstockApiError(e));
    }
  }
}
