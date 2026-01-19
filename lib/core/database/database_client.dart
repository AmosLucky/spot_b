import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../features/pos/data/models/sale.dart';
import '../../features/holds/data/models/hold.dart';
import '../../features/auth/data/models/spotstock_user.dart';
import '../../features/pos/data/models/product_warehouse.dart';
import '../../features/pos/data/models/product_unit_name.dart';
import 'tables/local_attendants.dart';
import 'tables/local_customers.dart';
import 'tables/local_bar_tables.dart';
import 'tables/local_product_categories.dart';
import 'tables/local_product.dart';
import 'tables/local_sales.dart';
import 'tables/local_warehouses.dart';
import 'tables/local_registers.dart';
import 'tables/local_holds.dart';

part 'database_client.g.dart';

@DriftDatabase(
  tables: [
    LocalAttendants,
    LocalCustomers,
    LocalBarTables,
    LocalProductCategories,
    LocalProducts,
    LocalWarehouses,
    LocalRegisters,
    LocalSales,
    LocalHolds,
  ],
)
class DatabaseClient extends _$DatabaseClient {
  DatabaseClient() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'spotstock.db'));
    return NativeDatabase.createInBackground(file);
  });
}
