import '../../../../core/networking/api_response/spotstock_api_response.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/login_dto.dart';
import '../../data/models/login_response_dao.dart';
import '../repositories/login_repository.dart';

class Login {
  final LoginRepository loginRepository;

  Login(this.loginRepository);

  Future<Result<SpotstockApiResponse<LoginResponseDao>>> call(LoginDto loginDto) async {
    return await loginRepository.login(loginDto);
  }
}
