import '../../../../core/networking/spotstock_api_response.dart';
import '../../../../core/shared/result.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/remote/login_datasource.dart';
import '../models/login_dto.dart';
import '../models/login_response_dao.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDatasource loginDatasource;

  LoginRepositoryImpl(this.loginDatasource);

  @override
  Future<Result<SpotstockApiResponse<LoginResponseDao>>> login(LoginDto loginDto) async {
    return await loginDatasource.login(loginDto);
  }
}
