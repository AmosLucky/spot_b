import '../../../../core/shared/result.dart';
import '../../data/models/hold.dart';
import '../repositories/holds_repository.dart';

class GetHold {
  final HoldsRepository holdsRepository;

  GetHold(this.holdsRepository);

  Stream<Result<Hold>> call(int holdId, String referenceCode) async* {
    yield* holdsRepository.getHold(holdId, referenceCode: referenceCode);
  }
}
