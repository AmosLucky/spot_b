import 'package:dio/dio.dart';

import '../constants/durations/spotstock_durations.dart';
import 'spotstock_api_constants.dart';

class DioClient {
  final Dio _dio;

  DioClient._internal(this._dio);

  static DioClient? _instance;

  Dio get dio => _dio;

  factory DioClient() {
    if (_instance != null) return _instance!;
    final dio = Dio(
      BaseOptions(
        baseUrl: SpotstockApiConstants.baseUrl,
        connectTimeout: SpotstockDurations.apiRequestTimeout,
        receiveTimeout: SpotstockDurations.apiRequestTimeout,
      ),
    );
    dio.interceptors.addAll([
      LogInterceptor(request: true, responseBody: true),
    ]);
    _instance = DioClient._internal(dio);
    return _instance!;
  }
}
