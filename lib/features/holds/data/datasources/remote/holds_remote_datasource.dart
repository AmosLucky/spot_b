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

  SpotstockApiResponse<List<Hold>> _createGetHoldsApiResponse(Map<String, dynamic> responseData) {
    final List<SpotstockApiDataItem> apiDataItems =
        (responseData['data'] as List<dynamic>).map((item) => SpotstockApiDataItem.fromJson(item as Map<String, dynamic>)).toList();

    final holds = <Hold>[];
    for (var item in apiDataItems) {
      try {
        Hold hold = HoldMapper.fromJson({
          'id': item.id,
          'attributes': item.attributes,
          'links': item.links,
        });
        hold = hold.copyWith(isSynced: true);
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
        final apiResponse = _createGetHoldsApiResponse(response.data);
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

  Future<Result<SpotstockApiResponse<SpotstockApiDataItem>>> createHold(CreateHoldDto createHoldDto) async {
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

  Future<Result<SpotstockApiResponse>> deleteHold(String holdId) async {
    try {
      final response = await dioClient.dio.delete("${SpotstockApiPaths.holds}/$holdId");
      if (response.statusCode == SpotstockStatusCode.success) {
        return Result.success(SpotstockApiResponse(
          data: null,
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

  // final List<SpotstockApiDataItem> apiDataItems = (responseData['data'] as List<dynamic>)
  //       .map((item) => SpotstockApiDataItem.fromJson(item as Map<String, dynamic>))
  //       .toList();

  //   final List<BarTable> barTables = apiDataItems
  //       .map((item) => BarTable.fromJson({
  //             'id': item.id,
  //             'attributes': item.attributes,
  //             'links': item.links,
  //           }))
  //       .toList();

  //   return SpotstockApiResponse(
  //     data: barTables,
  //     links: responseData['links'] != null ? ApiLinks.fromJson(responseData['links']) : null,
  //     meta: responseData['meta'] != null ? ApiMeta.fromJson(responseData['meta']) : null,
  //     rawResponse: responseData,
  //   );

  // method to convert data item to hold

  SpotstockApiResponse<Hold> _createGetHoldApiResponse(Map<String, dynamic> responseData) {
    SpotstockApiDataItem item = SpotstockApiDataItem.fromJson(responseData['data']);
    Hold hold = Hold.fromJson({
      'id': item.id,
      'attributes': item.attributes,
      'links': item.links,
    });
    return SpotstockApiResponse(
      data: hold,
      links: responseData['links'] != null ? ApiLinks.fromJson(responseData['links']) : null,
      meta: responseData['meta'] != null ? ApiMeta.fromJson(responseData['meta']) : null,
      rawResponse: responseData,
    );
  }

  Future<Result<SpotstockApiResponse<Hold>>> getHold(String holdId) async {
    try {
      final response = await dioClient.dio.get("${SpotstockApiPaths.holds}/$holdId");
      if (response.statusCode == SpotstockStatusCode.success) {
        final apiResponse = _createGetHoldApiResponse(response.data);
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
}
