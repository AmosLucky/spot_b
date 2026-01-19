import 'package:drift/drift.dart';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../pos/domain/errors/errors.dart';
import '../../mappers/hold_mapper.dart';
import '../../models/create_hold_dto.dart';
import '../../models/hold.dart';

class HoldsLocalDatasource {
  final DatabaseClient db;

  HoldsLocalDatasource(this.db);

  Future<Result<List<Hold>>> getHolds({int? userId}) async {
    try {
      final query = db.select(db.localHolds);

      if (userId != null) {
        query.where((tbl) => tbl.userId.equals(userId));
      }

      query.orderBy([
        (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc),
      ]);

      final rows = await query.get();
      final holds = rows.map((row) => HoldMapper.fromDrift(row)).toList();

      return Result.success(holds);
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToReadData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }

  Future<Result<Hold>> createHold(CreateHoldDto createHoldDto) async {
    try {
      await db.transaction(() async {
        final companion = createHoldDto.toDrift().copyWith(
              isSynced: Value(false),
            );
        await db.into(db.localHolds).insert(companion);
      });
      return Result.success(createHoldDto.toDomain().copyWith(isSynced: false));
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToWriteData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }

  Future<Result<void>> saveHolds(List<Hold> incomingHolds) async {
    try {
      if (incomingHolds.isEmpty) {
        return Result.success(null);
      }

      await db.transaction(() async {
        await db.delete(db.localHolds).go();
        for (final hold in incomingHolds) {
          final companion = hold.toDrift().copyWith(
                isSynced: Value(true),
                lastSyncedAt: Value(DateTime.now()),
                createdLocallyAt: Value(DateTime.now()),
              );
          await db.into(db.localHolds).insert(companion);
        }
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

  Future<Result<void>> markHoldAsSynced(String? referenceCode) async {
    if (referenceCode == null) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.invalidHoldReferenceCode,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.invalidHoldReferenceCode.toString(),
        originalError: null,
      ));
    }
    try {
      final updateCompanion = LocalHoldsCompanion(
        isSynced: Value(true),
        lastSyncedAt: Value(DateTime.now()),
      );
      final updateQuery = db.update(db.localHolds)..where((tbl) => tbl.referenceCode.equals(referenceCode));
      await updateQuery.write(updateCompanion);
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

  Future<Result<void>> deleteHold(String? referenceCode) async {
    if (referenceCode == null || referenceCode.isEmpty) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.invalidHoldReferenceCode,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.invalidHoldReferenceCode.toString(),
        originalError: null,
      ));
    }
    try {
      await db.transaction(() async {
        final deleteQuery = db.delete(db.localHolds)..where((tbl) => tbl.referenceCode.equals(referenceCode));
        await deleteQuery.go();
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

  Future<Result<Hold>> getHold(String? referenceCode) async {
    if (referenceCode == null || referenceCode.trim().isEmpty) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.invalidHoldReferenceCode,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.invalidHoldReferenceCode.toString(),
        originalError: null,
      ));
    }

    try {
      final query = db.select(db.localHolds)
        ..where((tbl) => tbl.referenceCode.equals(referenceCode))
        ..limit(1);

      final row = await query.getSingleOrNull();

      if (row == null) {
        return Result.failure(LocalDatabaseError(
          message: SpotstockStrings.failedToReadData,
          subtitle: SpotstockStrings.somethingWentWrong,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
          originalError: null,
        ));
      }

      final hold = HoldMapper.fromDrift(row);
      return Result.success(hold);
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToReadData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }

  Future<Result<void>> saveHold(Hold hold) async {
    try {
      await db.transaction(() async {
        final refCode = hold.referenceCode;

        if (refCode == null || refCode.isEmpty) {
          return Result.failure(
            LocalDatabaseError(
              message: SpotstockStrings.referenceCodeIsRequiredToSaveAHold,
              subtitle: SpotstockStrings.somethingWentWrong,
              code: SpotstockStatusCode.internalAppDatabaseError.toString(),
              originalError: null,
            ),
          );
        }

        final existing = await (db.select(db.localHolds)..where((tbl) => tbl.referenceCode.equals(refCode))).getSingleOrNull();

        final companion = hold.toDrift().copyWith(
              lastSyncedAt: Value(DateTime.now()),
              createdLocallyAt: Value(
                existing?.createdLocallyAt ?? DateTime.now(),
              ),
            );

        if (existing == null) {
          await db.into(db.localHolds).insert(companion);
        } else {
          await (db.update(db.localHolds)..where((tbl) => tbl.referenceCode.equals(refCode))).write(companion);
        }
      });

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        LocalDatabaseError(
          message: SpotstockStrings.failedToWriteData,
          subtitle: SpotstockStrings.somethingWentWrong,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
          originalError: e,
        ),
      );
    }
  }
}
