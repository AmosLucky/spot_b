import 'package:drift/drift.dart';

class LocalFacilitiesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  // store icon as codePoint
  IntColumn get iconCodePoint => integer()();

  // store status as string (Active / Inactive)
  TextColumn get status => text()();
}
