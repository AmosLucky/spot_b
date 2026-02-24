import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/grouped_hold.dart';
import '../repositories/grouped_holds_repository.dart';

class GetGroupedHolds {
  final GroupedHoldsRepository groupedHoldsRepository;

  GetGroupedHolds(this.groupedHoldsRepository);

  Stream<Result<List<GroupedHold>>> call({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
    int? limit = SpotstockApiConstants.limit,
  }) async* {
    yield* groupedHoldsRepository.getGroupedHolds(
      pageNumber: pageNumber,
      pageSize: pageSize,
      limit: limit,
    );
  }
}
