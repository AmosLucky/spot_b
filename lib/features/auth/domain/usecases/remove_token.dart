import '../repositories/token_repository.dart';

class RemoveToken {
  final TokenRepository tokenRepository;

  RemoveToken(this.tokenRepository);

  void call() {
    tokenRepository.clearToken();
  }
}
