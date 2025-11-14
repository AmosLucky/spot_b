import 'dart:developer';

import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/shared/result.dart';
import '../../domain/repositories/grouped_holds_repository.dart';
import '../../domain/repositories/holds_repository.dart';
import '../models/grouped_hold.dart';
import '../models/hold.dart';

class GroupedHoldsRepositoryImpl implements GroupedHoldsRepository {
  final HoldsRepository holdsRepository;

  GroupedHoldsRepositoryImpl(this.holdsRepository);

  @override
  Stream<Result<List<GroupedHold>>> getGroupedHolds({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
    int? limit = SpotstockApiConstants.limit,
  }) async* {
    await for (final result in holdsRepository.getHolds(
      pageNumber: pageNumber,
      pageSize: pageSize,
      limit: limit,
    )) {
      if (result is Success) {
        final holds = result.data;

        final Map<String, List<Hold>> groupedMap = {};

        var singleCount = 0;
        var multiCount = 0;

        for (final hold in holds) {
          if (hold.tableId == null) {
            final key = 'single-${hold.id}';
            groupedMap.putIfAbsent(key, () => []).add(hold);
            singleCount++;
          } else {
            final key = '${hold.attendant?.id}-${hold.customerId}-${hold.tableId}';
            groupedMap.putIfAbsent(key, () => []).add(hold);
            multiCount++;
          }
        }

        final groupedHolds =
            groupedMap.values.map((groupedList) => GroupedHold(holds: groupedList)).toList();

        yield Result.success(groupedHolds);
      } else if (result is Failure) {
        yield Result.failure(result.error);
      }
    }
  }
}
