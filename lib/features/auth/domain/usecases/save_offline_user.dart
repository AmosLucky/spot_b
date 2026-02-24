import '../../../../core/shared/result.dart';
import '../../../../features/auth/data/datasources/local/login_local_datasource.dart';
import '../../data/models/login_dto.dart';
import '../../data/models/login_response_dao.dart';

class SaveOfflineUser {
  final LoginLocalDatasource localDatasource;

  SaveOfflineUser(this.localDatasource);

  Future<Result<void>> call(LoginDto loginDto, LoginResponseDao loginResponse) async {
    return await localDatasource.saveOfflineUser(loginDto, loginResponse);
  }
}
