import 'package:drift/drift.dart';

class DiscountsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get bookingId => integer()();

  RealColumn get amount => real()();

  TextColumn get description => text().nullable()();

  IntColumn get userId => integer()();

  IntColumn get registerId => integer()();

  DateTimeColumn get dateCreated =>
      dateTime().withDefault(currentDateAndTime)();

  TextColumn get status =>
      text().withDefault(const Constant('Pending'))();
}
