import '../../../../core/shared/result.dart';
import '../../data/models/close_register_dto.dart';
import '../../data/models/open_register_dto.dart';

abstract class RegisterRepository {
  Future<Result<void>> openRegister(OpenRegisterDto openRegisterDto);
  Future<Result<void>> closeRegister(CloseRegisterDto closeRegisterDto);
  Future<Result<bool>> isRegisterOpen();
}
