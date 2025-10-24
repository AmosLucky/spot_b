import '../../../../core/shared/result.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/local/local_register_datasource.dart';
import '../models/close_register_dto.dart';
import '../models/open_register_dto.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final LocalRegisterDatasource registerDatasource;

  RegisterRepositoryImpl(this.registerDatasource);

  @override
  Future<Result<void>> openRegister(OpenRegisterDto openRegisterDto) async {
    return await registerDatasource.openRegister(openRegisterDto);
  }

  @override
  Future<Result<void>> closeRegister(CloseRegisterDto registerDto) async {
    return await registerDatasource.closeRegister(registerDto);
  }

  @override
  Future<Result<bool>> isRegisterOpen() async {
    return await registerDatasource.isRegisterOpen();
  }
}
