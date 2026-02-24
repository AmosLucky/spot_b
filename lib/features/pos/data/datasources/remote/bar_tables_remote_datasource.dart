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
import '../../models/bar_table.dart';

class BarTablesRemoteDatasource {
  final DioClient dioClient;

  BarTablesRemoteDatasource(this.dioClient);

  SpotstockApiResponse<List<BarTable>> _createApiResponse(Map<String, dynamic> responseData) {
    final List<SpotstockApiDataItem> apiDataItems = (responseData['data'] as List<dynamic>)
        .map((item) => SpotstockApiDataItem.fromJson(item as Map<String, dynamic>))
        .toList();

    final List<BarTable> barTables = apiDataItems
        .map((item) => BarTable.fromJson({
              'id': item.id,
              'attributes': item.attributes,
              'links': item.links,
            }))
        .toList();

    return SpotstockApiResponse(
      data: barTables,
      links: responseData['links'] != null ? ApiLinks.fromJson(responseData['links']) : null,
      meta: responseData['meta'] != null ? ApiMeta.fromJson(responseData['meta']) : null,
      rawResponse: responseData,
    );
  }

  Future<Result<SpotstockApiResponse<List<BarTable>>>> getBarTables({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
  }) async {
    try {
      final response = await dioClient.dio.get(
        SpotstockApiPaths.barTables,
        queryParameters: {
          'page[number]': pageNumber,
          'page[size]': pageSize,
        },
      );
      if (response.statusCode == SpotstockStatusCode.success) {
        final apiResponse = _createApiResponse(response.data);
        return Result.success(apiResponse);
      } else {
        return Result.failure(
          SpotstockApiError(
            message: response.data['message'] ?? SpotstockStrings.somethingWentWrong,
            code: response.statusCode.toString(),
            success: response.data['success'] ?? false,
            rawResponse: response.data,
            originalError: response.data,
          ),
        );
      }
    } catch (e) {
      return Result.failure(handleSpotstockApiError(e));
    }
  }
}
