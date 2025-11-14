import '../../../../../core/database/database_client.dart';
import '../../../../../core/shared/result.dart';
import '../../models/create_hold_dto.dart';
import '../../models/hold.dart';

class HoldsLocalDatasource {
  final DatabaseClient db;

  HoldsLocalDatasource(this.db);

  Future<Result<List<Hold>>> getHolds() async {
    return Result.success([]);
  }

  Future<Result<void>> createHold(CreateHoldDto createHoldDto) async {
    return Result.success(null);
  }

  Future<Result<void>> saveHolds(List<Hold> holds) async {
    return Result.success(null);
  }
}
