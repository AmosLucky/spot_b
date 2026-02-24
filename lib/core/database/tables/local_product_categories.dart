import 'package:drift/drift.dart';

class LocalProductCategories extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  IntColumn get companyId => integer().nullable()();
  TextColumn get image => text().nullable()();
  IntColumn get productCount => integer().nullable()();
  TextColumn get link => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
