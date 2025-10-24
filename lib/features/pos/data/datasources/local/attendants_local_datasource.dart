import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../domain/errors/errors.dart';
import '../../models/attendant.dart';
import '../../mappers/attendant_mapper.dart';

class AttendantsLocalDatasource {
  final DatabaseClient db;

  AttendantsLocalDatasource(this.db);

  Future<Result<void>> saveAttendants(List<Attendant> attendants) async {
    try {
      await db.transaction(() async {
        await db.delete(db.localAttendants).go();
        final companions = attendants.map((a) => a.toDrift()).toList();
        await db.batch((batch) {
          batch.insertAll(db.localAttendants, companions);
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

  Future<Result<List<Attendant>>> getAttendants() async {
    try {
      final rows = await db.select(db.localAttendants).get();
      final attendants = rows.map((attendant) => AttendantMapper.fromDrift(attendant)).toList();
      return Result.success(attendants);
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
