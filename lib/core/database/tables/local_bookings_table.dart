import 'package:drift/drift.dart';
import 'local_customers.dart';

class LocalBookingsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get bookingNumber => text()();

  IntColumn get customerId =>
      integer().references(LocalCustomers, #id)();

  /// "102,104,105"
  TextColumn get roomNumbers => text()();

  DateTimeColumn get dateFrom => dateTime()();
  DateTimeColumn get dateTo => dateTime()();

  /// active | canceled
  TextColumn get status => text()();

  /// partial | fully_paid
  TextColumn get paymentStatus => text()();

  /// not_checked_in | checked_in
  TextColumn get checkInStatus => text()();

  /// not_checked_out | checked_out
  TextColumn get checkOutStatus => text()();

  /// given | not_given
  TextColumn get roomKeyStatus => text()();

  /// 💰 Total before discount
  RealColumn get totalAmount => real()();

  /// 💸 Discount applied
  RealColumn get discount => real().withDefault(const Constant(0.0))();

  /// guest | walkin | existing
  TextColumn get guestType => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// 🔄 Updated timestamp
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
