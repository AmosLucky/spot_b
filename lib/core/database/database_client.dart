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
import 'tables/amenities_table.dart';
import 'tables/local_attendants.dart';
import 'tables/local_customers.dart';
import 'tables/local_bar_tables.dart';
import 'tables/local_facilities_table.dart';
import 'tables/local_product_categories.dart';
import 'tables/local_product.dart';
import 'tables/local_sales.dart';
import 'tables/local_warehouses.dart';
import 'tables/local_registers.dart';
import 'tables/local_holds.dart';
import 'tables/bed_types_table.dart';
import 'tables/premium_type_table.dart';
import 'tables/room_types_table.dart';

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
    //dektop
    AmenitiesTable,
    LocalFacilitiesTable,
    BedTypesTable,
    RoomTypesTable,
    PremiumTypesTable
  ],
)
class DatabaseClient extends _$DatabaseClient {
  DatabaseClient() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          // Called when database is created for the FIRST time
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Called when schemaVersion increases

          if (from < 7) {
            await m.createTable(amenitiesTable);
            await m.createTable(localFacilitiesTable);
            await m.createTable(bedTypesTable);
            await m.createTable(roomTypesTable);
            await m.createTable(premiumTypesTable);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'spotstock.db'));
    return NativeDatabase.createInBackground(file);
  });
}
