import '../../../../core/shared/result.dart';
import '../../domain/repositories/token_repository.dart';
import '../datasources/local/token_datasource.dart';

class TokenRepositoryImpl extends TokenRepository {
  final TokenDatasource tokenDatasource;

  TokenRepositoryImpl(this.tokenDatasource);

  @override
  void saveToken(String token) {
    tokenDatasource.saveToken(token);
  }

  @override
  Future<Result<String?>> getToken() async {
    return await tokenDatasource.getToken();
  }

  @override
  void clearToken() {
    tokenDatasource.clearToken();
  }
}
