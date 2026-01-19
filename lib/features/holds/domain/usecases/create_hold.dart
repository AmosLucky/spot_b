import '../../../../core/shared/result.dart';
import '../../data/models/create_hold_dto.dart';
import '../../data/models/hold.dart';
import '../repositories/holds_repository.dart';

class CreateHold {
  final HoldsRepository holdsRepository;
  CreateHold(this.holdsRepository);

  Future<Result<Hold>> call(CreateHoldDto createHoldDto) async {
    return await holdsRepository.createHold(createHoldDto);
  }
}
