import 'package:drift/drift.dart';

class BookingPremiumServicesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get bookingId => integer()();

  IntColumn get serviceId => integer()();

  IntColumn get quantity =>
      integer().withDefault(const Constant(1))();

  // Snapshot of price at time of adding
  RealColumn get unitPriceAtTime => real()();

  // Service usage period
  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime()();

  // Snapshot of days used
  IntColumn get numberOfDays => integer()();

  // Snapshot of total price
  RealColumn get totalPrice => real()();

  DateTimeColumn get dateCreated =>
      dateTime().withDefault(currentDateAndTime)();
}
