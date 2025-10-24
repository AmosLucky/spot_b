import 'package:drift/drift.dart';

import '../database_client.dart';

class LocalRegisters extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  BoolColumn get isOpen => boolean().withDefault(const Constant(false))();
  RealColumn get openingCashAtHand => real().nullable()();
  RealColumn get closingCashAtHand => real().nullable()();
  TextColumn get note => text().nullable()();
}

extension LocalRegisterExtension on LocalRegister {
  bool get isValid {
    if (createdAt == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final createdDate = DateTime(createdAt!.year, createdAt!.month, createdAt!.day);

    return today == createdDate;
  }
}
