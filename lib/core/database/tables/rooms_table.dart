import 'package:drift/drift.dart';

class RoomsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get roomNumber => text()();
  IntColumn get roomTypeId => integer()();

  /// Room condition
  /// active | inactive | dirty | maintenance
  TextColumn get status =>
      text().withDefault(const Constant('active'))();

  /// Booking state
  /// available | booked | checked_in
  TextColumn get bookingStatus =>
      text().withDefault(const Constant('available'))();

      

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
