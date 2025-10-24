import 'package:drift/drift.dart';

class LocalCustomers extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  IntColumn get companyId => integer().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  TextColumn get link => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
