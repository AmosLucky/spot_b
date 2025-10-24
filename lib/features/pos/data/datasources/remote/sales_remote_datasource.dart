import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/networking/api_response/spotstock_api_data_item.dart';
import '../../../../../core/networking/api_response/spotstock_api_response.dart';
import '../../../../../core/networking/dio_client.dart';
import '../../../../../core/networking/spotstock_api_error.dart';
import '../../../../../core/networking/spotstock_api_error_handler.dart';
import '../../../../../core/networking/spotstock_api_paths.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../models/create_sale_dto.dart';

class SalesRemoteDatasource {
  final DioClient dioClient;

  SalesRemoteDatasource(this.dioClient);

  Future<Result<SpotstockApiResponse<SpotstockApiDataItem>>> createSale(
    CreateSaleDto createSaleDto,
  ) async {
    try {
      final response = await dioClient.dio.post(
        SpotstockApiPaths.sales,
        data: createSaleDto.toJson(),
      );
      if (response.statusCode == SpotstockStatusCode.created) {
        return Result.success(
          SpotstockApiResponse<SpotstockApiDataItem>(
            data: SpotstockApiDataItem.fromJson(response.data['data']),
            message: response.data['message'],
            success: response.data['success'],
            rawResponse: response.data,
          ),
        );
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
