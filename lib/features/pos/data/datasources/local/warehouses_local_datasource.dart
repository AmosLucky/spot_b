import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../domain/errors/errors.dart';
import '../../mappers/warehouse_mapper.dart';
import '../../models/warehouse.dart';

class WarehousesLocalDatasource {
  final DatabaseClient db;

  WarehousesLocalDatasource(this.db);

  Future<Result<void>> saveWarehouses(List<Warehouse> warehouses) async {
    try {
      await db.transaction(() async {
        await db.delete(db.localWarehouses).go();
        final companions = warehouses.map((w) => w.toDrift()).toList();
        await db.batch((batch) {
          batch.insertAll(db.localWarehouses, companions);
        });
      });
      return Result.success(null);
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToWriteData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }

  Future<Result<List<Warehouse>>> getWarehouses() async {
    try {
      final rows = await db.select(db.localWarehouses).get();
      final warehouses = rows.map((warehouse) => WarehouseMapper.fromDrift(warehouse)).toList();
      return Result.success(warehouses);
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToReadData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }
}
