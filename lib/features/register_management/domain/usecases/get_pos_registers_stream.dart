import '../../../../core/shared/result.dart';
import '../../data/models/register.dart';
import '../repositories/register_repository.dart';

class GetPOSRegistersStream {
  final RegisterRepository registerRepository;

  GetPOSRegistersStream(this.registerRepository);

  Stream<Result<List<Register>>> call({
    DateTime? startDate,
    DateTime? endDate,
    bool updateLocalDatabase = true,
  }) {
    return registerRepository.getPOSRegistersStream(
      startDate: startDate,
      endDate: endDate,
      updateLocalDatabase: updateLocalDatabase,
    );
  }
}
