import 'package:drift/drift.dart';

class LocalProducts extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get code => text().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  IntColumn get mainProductId => integer().nullable()();
  IntColumn get productCategoryId => integer().nullable()();
  RealColumn get productCost => real().nullable()();
  RealColumn get productPrice => real().nullable()();
  BoolColumn get isActive => boolean().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  IntColumn get inStock => integer().nullable()();
  TextColumn get link => text().nullable()();
  IntColumn get stockId => integer().nullable()();
  IntColumn get warehouseId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
