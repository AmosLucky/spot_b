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
import '../../mappers/hold_mapper.dart';
import '../../models/create_hold_dto.dart';
import '../../models/hold.dart';

class HoldsRemoteDatasource {
  final DioClient dioClient;

  HoldsRemoteDatasource(this.dioClient);

  SpotstockApiResponse<List<Hold>> _createApiResponse(Map<String, dynamic> responseData) {
    final List<SpotstockApiDataItem> apiDataItems = (responseData['data'] as List<dynamic>)
        .map((item) => SpotstockApiDataItem.fromJson(item as Map<String, dynamic>))
        .toList();

    final holds = <Hold>[];
    for (var item in apiDataItems) {
      try {
        final hold = HoldMapper.fromJson({
          'id': item.id,
          'attributes': item.attributes,
          'links': item.links,
        });
        holds.add(hold);
      } catch (e) {
        rethrow;
      }
    }

    return SpotstockApiResponse<List<Hold>>(
      data: holds,
      links: responseData['links'] != null ? ApiLinks.fromJson(responseData['links']) : null,
      meta: responseData['meta'] != null ? ApiMeta.fromJson(responseData['meta']) : null,
      rawResponse: responseData,
    );
  }

  Future<Result<SpotstockApiResponse<List<Hold>>>> getHolds({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
    int? limit = SpotstockApiConstants.limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        SpotstockApiPaths.holds,
        queryParameters: {
          'page[number]': pageNumber,
          'limit': limit,
        },
      );
      if (response.statusCode == SpotstockStatusCode.success) {
        final apiResponse = _createApiResponse(response.data);
        return Result.success(apiResponse);
      } else {
        return Result.failure(SpotstockApiError(
          message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
          code: response.statusCode.toString(),
          success: response.data['success'] ?? false,
          rawResponse: response.data,
          originalError: response.data,
        ));
      }
    } catch (e) {
      return Result.failure(handleSpotstockApiError(e));
    }
  }

  Future<Result<SpotstockApiResponse<SpotstockApiDataItem>>> createHold(
      CreateHoldDto createHoldDto) async {
    try {
      final response = await dioClient.dio.post(
        SpotstockApiPaths.holds,
        data: createHoldDto.toJson(),
      );
      if (response.statusCode == SpotstockStatusCode.created) {
        return Result.success(SpotstockApiResponse<SpotstockApiDataItem>(
          data: SpotstockApiDataItem.fromJson(response.data['data']),
          message: response.data['message'],
          success: response.data['success'],
          rawResponse: response.data,
        ));
      } else {
        return Result.failure(SpotstockApiError(
          message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
          code: response.statusCode.toString(),
          success: response.data['success'] ?? false,
          rawResponse: response.data,
          originalError: response.data,
        ));
      }
    } catch (e) {
      return Result.failure(handleSpotstockApiError(e));
    }
  }
}
