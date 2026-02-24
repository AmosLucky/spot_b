import '../../../../core/shared/result.dart';

abstract class TokenRepository {
  void saveToken(String token);
  Future<Result<String?>> getToken();
  void clearToken();
}
