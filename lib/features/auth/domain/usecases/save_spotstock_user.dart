import '../../data/models/spotstock_user.dart';
import '../repositories/user_repository.dart';

class SaveSpotstockUser {
  final UserRepository userRepository;

  SaveSpotstockUser(this.userRepository);

  void call(SpotstockUser user) {
    userRepository.saveUser(user);
  }
}
