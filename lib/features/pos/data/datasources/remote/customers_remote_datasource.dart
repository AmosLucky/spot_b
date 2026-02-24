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
import '../../models/create_customer_dto.dart';
import '../../models/customer.dart';

class CustomersRemoteDatasource {
  final DioClient dioClient;

  CustomersRemoteDatasource(this.dioClient);

  SpotstockApiResponse<List<Customer>> _createApiResponse(Map<String, dynamic> responseData) {
    final List<SpotstockApiDataItem> apiDataItems =
        (responseData['data'] as List<dynamic>).map((item) => SpotstockApiDataItem.fromJson(item as Map<String, dynamic>)).toList();
    final List<Customer> customers = apiDataItems
        .map((item) => Customer.fromJson({
              'id': item.id,
              'attributes': item.attributes,
              'links': item.links,
            }).copyWith(isSynced: true))
        .toList();
    return SpotstockApiResponse<List<Customer>>(
      data: customers,
      links: responseData['links'] != null ? ApiLinks.fromJson(responseData['links']) : null,
      meta: responseData['meta'] != null ? ApiMeta.fromJson(responseData['meta']) : null,
      rawResponse: responseData,
    );
  }

  Future<Result<SpotstockApiResponse<List<Customer>>>> getCustomers({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
  }) async {
    try {
      final response = await dioClient.dio.get(SpotstockApiPaths.customers, queryParameters: {
        'page[number]': pageNumber,
        'page[size]': pageSize,
      });
      if (response.statusCode == SpotstockStatusCode.success) {
        final apiResponse = _createApiResponse(response.data);
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

  Future<Result<SpotstockApiResponse<SpotstockApiDataItem>>> createCustomer(CreateCustomerDto createCustomerDto) async {
    try {
      final response = await dioClient.dio.post(
        SpotstockApiPaths.customers,
        data: createCustomerDto.toJson(),
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
