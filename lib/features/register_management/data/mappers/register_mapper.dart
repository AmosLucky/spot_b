import 'package:drift/drift.dart';

import '../../../../core/database/database_client.dart';
import '../../../../core/database/tables/local_registers.dart';
import '../models/register.dart';

extension RegisterMapper on Register {
  LocalRegistersCompanion toDrift() {
    return LocalRegistersCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      closedAt: closedAt != null ? Value(closedAt!) : const Value.absent(),
      openingCashAtHand: openingCashAtHand != null ? Value(openingCashAtHand!) : const Value.absent(),
      cashInHandWhileClosing: closingCashAtHand != null ? Value(closingCashAtHand!) : const Value.absent(),
      note: note != null ? Value(note!) : const Value.absent(),
      isSynced: isSynced != null ? Value(isSynced!) : const Value.absent(),
      user: user != null ? Value(user) : const Value.absent(),
    );
  }

  static Register fromDrift(LocalRegister row) {
    return Register(
      id: row.id,
      createdAt: row.createdAt,
      closedAt: row.closedAt,
      isClosed: row.isClosed,
      openingCashAtHand: row.openingCashAtHand,
      closingCashAtHand: row.cashInHandWhileClosing,
      note: row.note,
      isSynced: row.isSynced,
      user: row.user,
    );
  }
}
