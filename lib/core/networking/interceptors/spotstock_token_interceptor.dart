import 'package:dio/dio.dart';

import '../../../features/auth/domain/repositories/token_repository.dart';
import '../spotstock_api_paths.dart';

class SpotstockTokenInterceptor extends QueuedInterceptorsWrapper {
  final TokenRepository tokenRepository;

  SpotstockTokenInterceptor(this.tokenRepository);

  final List<String> _unauthorizedPaths = [
    SpotstockApiPaths.login,
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final result = await tokenRepository.getToken();
    result.when(
      onSuccess: (token) {
        if (_unauthorizedPaths.contains(options.path)) {
          handler.next(options);
        } else {
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        }
      },
      onFailure: (error) {
        handler.next(options);
      },
    );
  }
}
