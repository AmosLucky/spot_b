import 'package:drift/drift.dart';

class RoomTypesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get totalAdults => integer().withDefault(const Constant(1))();
  IntColumn get totalChildren => integer().withDefault(const Constant(0))();
  IntColumn get totalBeds => integer().withDefault(const Constant(0))();
  RealColumn get fare => real().withDefault(const Constant(0))();
  TextColumn get keywords => text().nullable()();
  TextColumn get description => text()();
  RealColumn get cancellationFee => real().withDefault(const Constant(0))();
  TextColumn get cancellationPolicy => text()();
  TextColumn get amenities => text().withDefault(const Constant(''))();
  TextColumn get facilities => text().withDefault(const Constant(''))();
  TextColumn get bedTypes => text().withDefault(const Constant(''))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
