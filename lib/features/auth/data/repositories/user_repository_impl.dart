import '../../../../core/shared/result.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_datasource.dart';
import '../models/spotstock_user.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);

  @override
  void saveUser(SpotstockUser user) {
    userDatasource.saveUser(user);
  }

  @override
  Future<Result<SpotstockUser?>> getUser() async {
    return await userDatasource.getUser();
  }

  @override
  void clearUser() {
    userDatasource.clearUser();
  }
}
