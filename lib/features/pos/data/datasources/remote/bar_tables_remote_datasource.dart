import '../../../../../core/networking/dio_client.dart';
import '../../../../../core/networking/spotstock_api_error.dart';
import '../../../../../core/networking/spotstock_api_error_handler.dart';
import '../../../../../core/networking/spotstock_api_paths.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../domain/datasources/bar_tables_datasource.dart';
import '../../models/bar_table.dart';

class BarTablesRemoteDatasource implements BarTablesDatasource {
  final DioClient dioClient;

  BarTablesRemoteDatasource(this.dioClient);

  @override
  Future<Result<List<BarTable>>> getBarTables() async {
    try {
      final response = await dioClient.dio.get(SpotstockApiPaths.barTables);
      if (response.statusCode == SpotstockStatusCode.success) {
        return Result.success(response.data.map((e) => BarTable.fromJson(e)).toList());
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
