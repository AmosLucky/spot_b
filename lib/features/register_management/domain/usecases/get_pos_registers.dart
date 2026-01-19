import '../../../../core/shared/result.dart';
import '../../data/models/register.dart';
import '../repositories/register_repository.dart';

class GetPOSRegisters {
  final RegisterRepository registerRepository;

  GetPOSRegisters(this.registerRepository);

  Future<Result<List<Register>>> call({
    DateTime? startDate,
    DateTime? endDate,
    bool updateLocalDatabase = true,
  }) {
    return registerRepository.getPOSRegisters(
      startDate: startDate,
      endDate: endDate,
      updateLocalDatabase: updateLocalDatabase,
    );
  }
}
