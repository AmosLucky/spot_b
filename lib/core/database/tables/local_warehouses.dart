import 'package:drift/drift.dart';

class LocalWarehouses extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get zipCode => text().nullable()();
  IntColumn get status => integer().nullable()();
  IntColumn get companyId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
