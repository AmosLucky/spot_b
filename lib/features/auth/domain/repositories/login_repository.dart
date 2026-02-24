import '../../../../core/shared/result.dart';
import '../../data/models/login_dto.dart';
import '../../data/models/login_response_dao.dart';

abstract class LoginRepository {
  Future<Result<LoginResponseDao>> login(LoginDto loginDto);
}
