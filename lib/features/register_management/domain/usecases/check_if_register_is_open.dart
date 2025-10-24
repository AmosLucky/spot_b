import '../../../../core/shared/result.dart';
import '../repositories/register_repository.dart';

class CheckIfRegisterIsOpen {
  final RegisterRepository registerRepository;

  CheckIfRegisterIsOpen(this.registerRepository);

  Future<Result<bool>> call() async {
    return await registerRepository.isRegisterOpen();
  }
}
