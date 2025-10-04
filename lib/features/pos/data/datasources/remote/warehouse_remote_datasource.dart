// import '../../../../../core/networking/api_response/spotstock_api_response.dart';
// import '../../../../../core/networking/dio_client.dart';
// import '../../../../../core/networking/spotstock_api_error_handler.dart';
// import '../../../../../core/networking/spotstock_api_paths.dart';
// import '../../../../../core/shared/result.dart';

// class WarehouseRemoteDatasource {
//   final DioClient dioClient;

//   WarehouseRemoteDatasource(this.dioClient);

//   Future<Result<SpotstockApiResponse<List<Warehouse>>>> getWarehouses({
//     int? pageNumber,
//     int? pageSize,
//   }) async {
//     try {
//       final response = await dioClient.dio.get(
//         SpotstockApiPaths.warehouses,
//         queryParameters: {
//           'page[number]': pageNumber,
//           'page[size]': pageSize,
//         },
//       );
//     } catch (e) {
//       return Result.failure(handleSpotstockApiError(e));
//     }
//   }
// }
