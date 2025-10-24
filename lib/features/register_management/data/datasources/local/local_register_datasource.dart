import 'package:drift/drift.dart';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../pos/domain/errors/errors.dart';
import '../../models/close_register_dto.dart';
import '../../models/open_register_dto.dart';

class LocalRegisterDatasource {
  final DatabaseClient db;

  LocalRegisterDatasource(this.db);

  Future<bool> _hasOpenValidRegister() async {
    final existingRegisters = await db.select(db.localRegisters).get();
    final hasOpenValidRegister = existingRegisters.any((reg) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final createdDate = reg.createdAt != null
          ? DateTime(reg.createdAt!.year, reg.createdAt!.month, reg.createdAt!.day)
          : null;
      return reg.isOpen == true && createdDate == today;
    });
    return hasOpenValidRegister;
  }

  Future<Result<void>> openRegister(OpenRegisterDto openRegisterDto) async {
    try {
      final hasOpenValidRegister = await _hasOpenValidRegister();

      if (hasOpenValidRegister) {
        return Result.failure(LocalDatabaseError(
          message: SpotstockStrings.registerAlreadyOpen,
          subtitle: SpotstockStrings.oneRegisterAtATime,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        ));
      }
      await db.transaction(() async {
        await db.into(db.localRegisters).insert(LocalRegistersCompanion(
              openingCashAtHand: Value(openRegisterDto.openingCashAtHand),
              note: Value(openRegisterDto.note),
              createdAt: Value(DateTime.now()),
              isOpen: const Value(true),
            ));
      });
      return Result.success(null);
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToWriteData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }

  Future<Result<void>> closeRegister(CloseRegisterDto registerDto) async {
    try {
      await db.transaction(() async {
        await (db.update(db.localRegisters)..where((row) => row.id.equals(registerDto.id))).write(
          LocalRegistersCompanion(
            isOpen: const Value(false),
            closingCashAtHand: Value(registerDto.closingCashAtHand),
          ),
        );
      });
      return Result.success(null);
    } catch (e) {
      return Result.failure(LocalDatabaseError(
        message: SpotstockStrings.failedToWriteData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      ));
    }
  }

  Future<Result<bool>> isRegisterOpen() async {
    final hasOpenValidRegister = await _hasOpenValidRegister();
    return Result.success(hasOpenValidRegister);
  }
}
