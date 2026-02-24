import 'package:drift/drift.dart';

import '../../../../core/database/database_client.dart';
import '../models/bar_table.dart';

extension BarTableMapper on BarTable {
  LocalBarTablesCompanion toDrift() {
    return LocalBarTablesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      companyId: Value(companyId),
      chairsNo: Value(chairsNo),
      createdAt: Value(createdAt),
      link: Value(link),
    );
  }

  static BarTable fromDrift(LocalBarTable row) {
    return BarTable(
      id: row.id,
      name: row.name,
      companyId: row.companyId,
      chairsNo: row.chairsNo,
      createdAt: row.createdAt,
      link: row.link,
    );
  }
}
