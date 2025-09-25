import '../../../../core/shared/result.dart';
import '../../data/models/spotstock_user.dart';
import '../repositories/user_repository.dart';

class GetSpotstockUser {
  final UserRepository userRepository;

  GetSpotstockUser(this.userRepository);

  Future<Result<SpotstockUser?>> call() async {
    return await userRepository.getUser();
  }
}
