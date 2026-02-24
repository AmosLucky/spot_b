import '../../../../core/shared/result.dart';
import '../../data/models/close_register_dto.dart';
import '../../data/models/get_register_details_response_dao.dart';
import '../../data/models/open_register_dto.dart';
import '../../data/models/register.dart';

abstract class RegisterRepository {
  Future<Result<void>> openRegister(OpenRegisterDto openRegisterDto);
  Future<Result<void>> closeRegister(CloseRegisterDto closeRegisterDto);
  Future<Result<bool>> isRegisterOpen();
  Future<Result<List<Register>>> getPOSRegisters({DateTime? startDate, DateTime? endDate, bool updateLocalDatabase = true});

  /// Returns a stream of registers. First emits the local data, then emits the remote data if the device is connected.
  Stream<Result<List<Register>>> getPOSRegistersStream({DateTime? startDate, DateTime? endDate, bool updateLocalDatabase = true});
  Future<Result<GetRegisterDetailsResponseDao>> getRegisterDetails({int? registerId});
}
