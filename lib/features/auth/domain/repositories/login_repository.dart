import '../../../../core/networking/spotstock_api_response.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/login_dto.dart';
import '../../data/models/login_response_dao.dart';

abstract class LoginRepository {
  Future<Result<SpotstockApiResponse<LoginResponseDao>>> login(LoginDto loginDto);
}
