import '../../../../core/shared/result.dart';
import '../../data/models/spotstock_user.dart';

abstract class UserRepository {
  void saveUser(SpotstockUser user);
  Future<Result<SpotstockUser?>> getUser();
  void clearUser();
}
