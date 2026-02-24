import '../../../../core/shared/result.dart';
import '../../data/models/open_register_dto.dart';
import '../repositories/register_repository.dart';

class OpenRegister {
  final RegisterRepository registerRepository;

  OpenRegister(this.registerRepository);

  Future<Result<void>> call(OpenRegisterDto openRegisterDto) async {
    return await registerRepository.openRegister(openRegisterDto);
  }
}
