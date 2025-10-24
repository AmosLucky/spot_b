import '../../../../core/shared/result.dart';
import '../../data/models/close_register_dto.dart';
import '../repositories/register_repository.dart';

class CloseRegister {
  final RegisterRepository registerRepository;

  CloseRegister(this.registerRepository);

  Future<Result<void>> call(CloseRegisterDto closeRegisterDto) async {
    return await registerRepository.closeRegister(closeRegisterDto);
  }
}
