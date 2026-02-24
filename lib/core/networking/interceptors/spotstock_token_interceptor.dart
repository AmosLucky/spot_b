import 'package:dio/dio.dart';

import '../../../features/auth/domain/repositories/token_repository.dart';
import '../../../features/auth/domain/usecases/remove_last_login_time.dart';
import '../../../features/auth/domain/usecases/remove_token.dart';
import '../../constants/strings/spotstock_strings.dart';
import '../../error_handling/app_error.dart';
import '../../presentation/snackbars/spotstock_snackbar.dart';
import '../../routing/navigation.dart';
import '../../routing/router.dart';
import '../spotstock_api_paths.dart';
import '../spotstock_status_code.dart';

class SpotstockTokenInterceptor extends QueuedInterceptorsWrapper with SpotstockSnackbarMixin {
  final TokenRepository tokenRepository;
  final RemoveLastLoginTime removeLastLoginTime;
  final RemoveToken removeToken;

  SpotstockTokenInterceptor(this.tokenRepository, this.removeLastLoginTime, this.removeToken);

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

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == SpotstockStatusCode.unauthorized) {
      tokenRepository.clearToken();
      removeLastLoginTime();
      removeToken();
      SpotstockNavigation.replace(SpotstockMobileRoutes.login);
      showErrorSnackbar(
        AppError(
          message: SpotstockStrings.sessionExpired,
          code: SpotstockStatusCode.unauthorized.toString(),
          originalError: err,
        ),
        title: SpotstockStrings.sessionExpired,
        subtitle: SpotstockStrings.sessionExpiredSubtitle,
      );
    }
    handler.next(err);
  }
}
