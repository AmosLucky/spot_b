import '../../../../core/shared/result.dart';
import '../repositories/token_repository.dart';

class GetToken {
  final TokenRepository tokenRepository;

  GetToken(this.tokenRepository);

  Future<Result<String?>> call() async {
    return await tokenRepository.getToken();
  }
}
