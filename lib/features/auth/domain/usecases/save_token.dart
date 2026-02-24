import '../repositories/token_repository.dart';

class SaveToken {
  final TokenRepository tokenRepository;

  SaveToken(this.tokenRepository);

  Future<void> call(String token) async {
    tokenRepository.saveToken(token);
  }
}
