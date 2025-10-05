import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/local_attendants.dart';

part 'database_client.g.dart';

@DriftDatabase(
  tables: [LocalAttendants],
)
class DatabaseClient extends _$DatabaseClient {
  DatabaseClient() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'spotstock.db'));
    return NativeDatabase.createInBackground(file);
  });
}
