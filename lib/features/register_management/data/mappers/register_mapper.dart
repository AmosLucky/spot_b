import 'package:drift/drift.dart';
import 'package:spotstock_inventory/core/database/tables/local_registers.dart';

import '../../../../core/database/database_client.dart';
import '../models/register.dart';

extension RegisterMapper on Register {
  LocalRegistersCompanion toDrift() {
    return LocalRegistersCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      createdAt: createdAt != null ? Value(createdAt!) : const Value.absent(),
      isOpen: isOpen != null ? Value(isOpen!) : const Value.absent(),
      openingCashAtHand:
          openingCashAtHand != null ? Value(openingCashAtHand!) : const Value.absent(),
      closingCashAtHand:
          closingCashAtHand != null ? Value(closingCashAtHand!) : const Value.absent(),
    );
  }

  static Register fromDrift(LocalRegister row) {
    return Register(
      id: row.id,
      createdAt: row.createdAt,
      isOpen: row.isOpen,
      isValid: row.isValid,
      openingCashAtHand: row.openingCashAtHand,
      closingCashAtHand: row.closingCashAtHand,
    );
  }
}
