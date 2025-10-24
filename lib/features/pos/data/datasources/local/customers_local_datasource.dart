import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../domain/errors/errors.dart';
import '../../mappers/customer_mapper.dart';
import '../../models/customer.dart';

class CustomersLocalDatasource {
  final DatabaseClient db;

  CustomersLocalDatasource(this.db);

  Future<Result<void>> saveCustomers(List<Customer> customers) async {
    try {
      await db.transaction(() async {
        await db.delete(db.localCustomers).go();
        final companions = customers.map((c) => c.toDrift()).toList();
        await db.batch((batch) {
          batch.insertAll(db.localCustomers, companions);
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

  Future<Result<List<Customer>>> getCustomers() async {
    try {
      final rows = await db.select(db.localCustomers).get();
      final customers = rows.map((customer) => CustomerMapper.fromDrift(customer)).toList();
      return Result.success(customers);
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
