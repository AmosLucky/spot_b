import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/hold.dart';
import '../repositories/holds_repository.dart';

class GetHolds {
  final HoldsRepository holdsRepository;

  GetHolds(this.holdsRepository);

  Stream<Result<List<Hold>>> call({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
    int? limit = SpotstockApiConstants.limit,
    int? userId,
  }) async* {
    yield* holdsRepository.getHolds(
      pageNumber: pageNumber,
      pageSize: pageSize,
      limit: limit,
      userId: userId,
    );
  }
}
