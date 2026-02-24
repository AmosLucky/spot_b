import '../../../../core/shared/result.dart';
import '../../data/models/hold.dart';
import '../repositories/holds_repository.dart';

class DeleteHold {
  final HoldsRepository holdsRepository;

  DeleteHold(this.holdsRepository);

  Future<Result<void>> call(Hold hold) async {
    return await holdsRepository.deleteHold(hold);
  }
}
