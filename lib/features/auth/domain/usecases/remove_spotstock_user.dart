import '../repositories/user_repository.dart';

class RemoveSpotstockUser {
  final UserRepository userRepository;

  RemoveSpotstockUser(this.userRepository);

  void call() {
    userRepository.clearUser();
  }
}
