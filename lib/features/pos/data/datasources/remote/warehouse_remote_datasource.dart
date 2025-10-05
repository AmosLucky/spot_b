import '../../../../../core/networking/api_response/spotstock_api_response.dart';
import '../../../../../core/networking/dio_client.dart';
import '../../../../../core/networking/spotstock_api_constants.dart';
import '../../../../../core/networking/spotstock_api_error.dart';
import '../../../../../core/networking/spotstock_api_error_handler.dart';
import '../../../../../core/networking/spotstock_api_paths.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../models/warehouse.dart';

class WarehouseRemoteDatasource {
  final DioClient dioClient;

  WarehouseRemoteDatasource(this.dioClient);

  SpotstockApiResponse<List<Warehouse>> _createApiResponse(Map<String, dynamic> responseData) {
    final List<dynamic> dataList = responseData['data'];
    final warehouses = dataList.map((item) => Warehouse.fromJson(item)).toList();
    return SpotstockApiResponse<List<Warehouse>>(
      data: warehouses,
      message: responseData['message'],
      success: responseData['success'],
      rawResponse: responseData,
    );
  }

  Future<Result<SpotstockApiResponse<List<Warehouse>>>> getWarehouses({
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final response = await dioClient.dio.get(
        SpotstockApiPaths.warehouses,
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
            message: response.data['message'],
            code: response.statusCode.toString(),
            success: response.data['success'],
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
