import 'package:drift/drift.dart';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../../features/pos/data/mappers/sale_mapper.dart';
import '../../../domain/errors/errors.dart';
import '../../models/create_sale_dto.dart';
import '../../models/sale.dart';

class SalesLocalDatasource {
  final DatabaseClient db;

  SalesLocalDatasource(this.db);

  /// This method is used to create a new sale locally.
  /// Call this method when a sale is created offline.
  Future<Result<void>> createSale(CreateSaleDto sale) async {
    try {
      await db.transaction(() async {
        final companion = sale.toDrift().copyWith(
              createdLocallyAt: Value(DateTime.now()),
              isSynced: Value(false),
              isOffline: Value(1),
            );
        await db.into(db.localSales).insert(companion);
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

  /// This method is used to save a sale locally.
  /// Call this method when a sale is created online.
  Future<Result<void>> saveSale(Sale sale) async {
    try {
      await db.transaction(() async {
        final companion = sale.toDrift().copyWith(
              createdLocallyAt: Value(DateTime.now()),
              isSynced: Value(true),
              lastSyncedAt: Value(DateTime.now()),
              isOffline: Value(0),
            );
        await db.into(db.localSales).insert(companion);
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
}
