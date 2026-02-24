import 'package:drift/drift.dart';

class CreditRequestsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get bookingId => integer()();

  RealColumn get amount => real()();

  TextColumn get description => text().nullable()();

TextColumn get status =>
    text().withDefault(const Constant('pending'))();

  // false = pending, true = approved

  DateTimeColumn get dateCreated =>
      dateTime().withDefault(currentDateAndTime)();

  IntColumn get userId => integer()();

  IntColumn get registerId => integer()();
}
