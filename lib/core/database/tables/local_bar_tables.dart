import 'package:drift/drift.dart';

class LocalBarTables extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  IntColumn get companyId => integer().nullable()();
  IntColumn get chairsNo => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  TextColumn get link => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
