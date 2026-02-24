import 'package:drift/drift.dart';

class AmenitiesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get icon => text()(); // store icon name as String
  TextColumn get status => text().withDefault(const Constant('Active'))();
}
