import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/networking/api_response/spotstock_api_response.dart';
import '../../../../../core/networking/dio_client.dart';
import '../../../../../core/networking/spotstock_api_constants.dart';
import '../../../../../core/networking/spotstock_api_error.dart';
import '../../../../../core/networking/spotstock_api_error_handler.dart';
import '../../../../../core/networking/spotstock_api_paths.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../models/stock_item.dart';

class StockItemRemoteDatasource {
  final DioClient dioClient;

  StockItemRemoteDatasource(this.dioClient);

  SpotstockApiResponse<List<StockItem>> _createGetStockItemsApiResponse(Map<String, dynamic> responseData) {
    final List<StockItem> stockItems =
        (responseData['data'] as List<dynamic>).map((item) => StockItem.fromJson(item as Map<String, dynamic>)).toList();
    return SpotstockApiResponse<List<StockItem>>(
      data: stockItems,
      links: responseData['links'] != null ? ApiLinks.fromJson(responseData['links']) : null,
      meta: responseData['meta'] != null ? ApiMeta.fromJson(responseData['meta']) : null,
      rawResponse: responseData,
    );
  }

  Future<Result<SpotstockApiResponse<List<StockItem>>>> getStockItems({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
  }) async {
    try {
      final response = await dioClient.dio.get(SpotstockApiPaths.stockReport, queryParameters: {
        'page[number]': pageNumber,
        'page[size]': pageSize,
      });
      if (response.statusCode == SpotstockStatusCode.success) {
        final apiResponse = _createGetStockItemsApiResponse(response.data);
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
