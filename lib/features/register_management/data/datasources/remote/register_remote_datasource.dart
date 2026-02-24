import 'dart:developer';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/networking/api_response/spotstock_api_data_item.dart';
import '../../../../../core/networking/api_response/spotstock_api_response.dart';
import '../../../../../core/networking/dio_client.dart';
import '../../../../../core/networking/spotstock_api_constants.dart';
import '../../../../../core/networking/spotstock_api_error.dart';
import '../../../../../core/networking/spotstock_api_error_handler.dart';
import '../../../../../core/networking/spotstock_api_paths.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../register_management/data/models/register.dart';
import '../../models/close_register_dto.dart';
import '../../models/get_register_details_response_dao.dart';
import '../../models/open_register_dto.dart';

class RegisterRemoteDatasource {
  final DioClient dioClient;

  RegisterRemoteDatasource(this.dioClient);

  SpotstockApiResponse<List<Register>> _createGetPOSRegistersApiResponse(Map<String, dynamic> responseData) {
    final List<SpotstockApiDataItem> apiDataItems =
        (responseData['data'] as List<dynamic>).map((item) => SpotstockApiDataItem.fromJson(item as Map<String, dynamic>)).toList();

    final List<Register> registers = apiDataItems
        .map((item) => Register.fromJson({
              'id': item.id,
              'attributes': item.attributes,
            }))
        .toList();
    return SpotstockApiResponse<List<Register>>(
      data: registers,
      links: responseData['links'] != null ? ApiLinks.fromJson(responseData['links']) : null,
      meta: responseData['meta'] != null ? ApiMeta.fromJson(responseData['meta']) : null,
      rawResponse: responseData,
    );
  }

  Future<Result<SpotstockApiResponse>> openRegister(OpenRegisterDto openRegisterDto) async {
    try {
      final response = await dioClient.dio.post(SpotstockApiPaths.registerEntry, data: openRegisterDto.toJson());
      if (response.statusCode == SpotstockStatusCode.success) {
        final apiResponse = SpotstockApiResponse(
          data: null,
          success: response.data['success'] ?? false,
          message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
          rawResponse: response.data,
        );
        return Result.success(apiResponse);
      } else {
        return Result.failure(SpotstockApiError(
          message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
          code: response.statusCode.toString(),
          success: response.data['success'] ?? false,
          rawResponse: response.data,
        ));
      }
    } catch (e) {
      return Result.failure(handleSpotstockApiError(e));
    }
  }

  Future<Result<SpotstockApiResponse>> closeRegister(CloseRegisterDto closeRegisterDto) async {
    try {
      final response = await dioClient.dio.post(SpotstockApiPaths.registerClose, data: closeRegisterDto.toJson());
      if (response.statusCode == SpotstockStatusCode.success) {
        final apiResponse = SpotstockApiResponse(
          data: null,
          success: response.data['success'] ?? false,
          message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
          rawResponse: response.data,
        );
        return Result.success(apiResponse);
      } else {
        return Result.failure(SpotstockApiError(
          message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
          code: response.statusCode.toString(),
          success: response.data['success'] ?? false,
          rawResponse: response.data,
        ));
      }
    } catch (e) {
      return Result.failure(handleSpotstockApiError(e));
    }
  }

  Future<Result<bool>> isRegisterOpen() async {
    final registerDetailsResult = await getRegisterDetails();
    if (registerDetailsResult is Success) {
      final registerDetails = registerDetailsResult.data.data;
      return Result.success(!registerDetails.isClosed);
    } else {
      return Result.failure(registerDetailsResult.error);
    }
  }

  Future<Result<SpotstockApiResponse<GetRegisterDetailsResponseDao>>> getRegisterDetails({int? registerId}) async {
    try {
      final url = registerId == null ? SpotstockApiPaths.getRegisterDetails : '${SpotstockApiPaths.getRegisterDetails}/$registerId';
      final response = await dioClient.dio.get(url);
      if (response.statusCode == SpotstockStatusCode.success) {
        final responseDao = GetRegisterDetailsResponseDao.fromJson(response.data['data']);
        final apiResponse = SpotstockApiResponse<GetRegisterDetailsResponseDao>(
          data: responseDao,
          links: response.data['links'] != null ? ApiLinks.fromJson(response.data['links']) : null,
          meta: response.data['meta'] != null ? ApiMeta.fromJson(response.data['meta']) : null,
          rawResponse: response.data,
        );
        return Result.success(apiResponse);
      } else {
        return Result.failure(SpotstockApiError(
          message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
          code: response.statusCode.toString(),
          success: response.data['success'] ?? false,
          rawResponse: response.data,
        ));
      }
    } catch (e) {
      return Result.failure(handleSpotstockApiError(e));
    }
  }

  Future<Result<SpotstockApiResponse<List<Register>>>> getPOSRegisters({
    DateTime? startDate,
    DateTime? endDate,
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
  }) async {
    try {
      final response = await dioClient.dio.get(SpotstockApiPaths.registerReport, queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
        'page': pageNumber,
        'page[size]': pageSize,
      });
      if (response.statusCode == SpotstockStatusCode.success) {
        final apiResponse = _createGetPOSRegistersApiResponse(response.data);
        return Result.success(apiResponse);
      } else {
        return Result.failure(SpotstockApiError(
          message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
          code: response.statusCode.toString(),
          success: response.data['success'] ?? false,
          rawResponse: response.data,
        ));
      }
    } catch (e) {
      return Result.failure(handleSpotstockApiError(e));
    }
  }
}
