import '../../../../core/networking/spotstock_api_constants.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/create_hold_dto.dart';
import '../../data/models/hold.dart';

abstract class HoldsRepository {
  Stream<Result<List<Hold>>> getHolds({
    int? pageNumber,
    int? pageSize = SpotstockApiConstants.pageSize,
    int? limit = SpotstockApiConstants.limit,
  });

  Future<Result<Hold>> createHold(CreateHoldDto createHoldDto);
}
