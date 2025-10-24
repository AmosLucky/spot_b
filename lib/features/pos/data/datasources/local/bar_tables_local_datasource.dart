import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../domain/errors/errors.dart';
import '../../models/bar_table.dart';
import '../../mappers/bar_table_mapper.dart';

class BarTablesLocalDatasource {
  final DatabaseClient db;

  BarTablesLocalDatasource(this.db);

  Future<Result<void>> saveBarTables(List<BarTable> barTables) async {
    try {
      await db.transaction(() async {
        await db.delete(db.localBarTables).go();
        final companions = barTables.map((b) => b.toDrift()).toList();
        await db.batch((batch) {
          batch.insertAll(db.localBarTables, companions);
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

  Future<Result<List<BarTable>>> getBarTables() async {
    try {
      final rows = await db.select(db.localBarTables).get();
      final barTables = rows.map((barTable) => BarTableMapper.fromDrift(barTable)).toList();
      return Result.success(barTables);
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
