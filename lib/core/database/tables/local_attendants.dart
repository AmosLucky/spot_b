import 'package:drift/drift.dart';

class LocalAttendants extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get image => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  IntColumn get isAdmin => integer().nullable()();
  IntColumn get isSuper => integer().nullable()();
  IntColumn get isAttendant => integer().nullable()();
  BoolColumn get setPin => boolean().nullable()();
  TextColumn get link => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
