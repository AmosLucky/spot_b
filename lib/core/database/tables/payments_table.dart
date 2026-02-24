import 'package:drift/drift.dart';

class PaymentsTable extends Table {

  IntColumn get id => integer().autoIncrement()();

  IntColumn get bookingId => integer()();

  RealColumn get amount => real()();

  RealColumn get tax => real().withDefault(const Constant(0))();

  TextColumn get paymentMethod => text()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get date => dateTime()();

  IntColumn get userId => integer()();

  IntColumn get registerId => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}
