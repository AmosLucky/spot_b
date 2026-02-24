import '../../../../core/shared/result.dart';
import '../../data/models/hold.dart';
import '../repositories/holds_repository.dart';

class DeleteHolds {
  final HoldsRepository holdsRepository;

  DeleteHolds(this.holdsRepository);

  Future<Result<void>> call(List<Hold> holds) async {
    for (final hold in holds) {
      await holdsRepository.deleteHold(hold);
    }
    return Result.success(null);
  }
}
