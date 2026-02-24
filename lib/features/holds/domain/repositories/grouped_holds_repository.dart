import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/grouped_hold.dart';

abstract class GroupedHoldsRepository {
  Stream<Result<List<GroupedHold>>> getGroupedHolds({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
    int? limit = SpotstockApiConstants.limit,
  });
}
