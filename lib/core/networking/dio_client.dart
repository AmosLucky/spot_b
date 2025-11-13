import 'package:dio/dio.dart';

import '../../features/auth/domain/repositories/token_repository.dart';
import '../../features/auth/domain/usecases/remove_last_login_time.dart';
import '../../features/auth/domain/usecases/remove_token.dart';
import '../constants/durations/spotstock_durations.dart';
import '../di/di.dart';
import 'interceptors/spotstock_token_interceptor.dart';
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
        headers: {
          'Content-Type': SpotstockApiConstants.contentType,
          'Accept': SpotstockApiConstants.accept,
        },
      ),
    );
    dio.interceptors.addAll([
      LogInterceptor(request: true, responseBody: true),
      SpotstockTokenInterceptor(
        getIt<TokenRepository>(),
        getIt<RemoveLastLoginTime>(),
        getIt<RemoveToken>(),
      ),
    ]);
    _instance = DioClient._internal(dio);
    return _instance!;
  }
}
