import 'package:drift/drift.dart';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../auth/data/datasources/local/user_datasource.dart';
import '../../../../pos/domain/errors/errors.dart';
import '../../mappers/register_mapper.dart';
import '../../models/close_register_dto.dart';
import '../../models/get_register_details_response_dao.dart';
import '../../models/open_register_dto.dart';
import '../../models/register.dart';
import 'get_register_details_local_datasource.dart';

class RegisterLocalDatasource {
  final DatabaseClient db;
  final GetRegisterDetailsLocalDatasource getRegisterDetailsLocalDatasource;
  final UserDatasource userDatasource;

  RegisterLocalDatasource(this.db, this.getRegisterDetailsLocalDatasource, this.userDatasource);

  Future<bool> _hasOpenRegister() async {
    final query = db.select(db.localRegisters)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(1);
    final latestRegister = await query.getSingleOrNull();
    if (latestRegister == null) return false;
    return latestRegister.closedAt == null;
  }

  Future<Result<void>> openRegister(OpenRegisterDto openRegisterDto) async {
    try {
      final hasOpenRegister = await _hasOpenRegister();

      if (hasOpenRegister) {
        return Result.failure(
          LocalDatabaseError(
            message: SpotstockStrings.registerAlreadyOpen,
            subtitle: SpotstockStrings.failedToOpenRegister,
            code: SpotstockStatusCode.internalAppDatabaseError.toString(),
            originalError: null,
          ),
        );
      }
      final userResult = await userDatasource.getUser();
      if (userResult is Failure) {
        return Result.failure(userResult.error);
      }
      if (userResult is Success) {
        final user = userResult.data;
        if (user == null) {
          return Result.failure(
            LocalDatabaseError(
              message: SpotstockStrings.userNotFound,
              subtitle: SpotstockStrings.failedToOpenRegister,
              code: SpotstockStatusCode.internalAppDatabaseError.toString(),
              originalError: null,
            ),
          );
        }
        await db.transaction(() async {
          await db.into(db.localRegisters).insert(LocalRegistersCompanion(
                createdAt: Value(DateTime.now()),
                openingCashAtHand: Value(openRegisterDto.openingCashAtHand),
                note: Value(openRegisterDto.note),
                user: Value(user),
              ));
        });
      }
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

  Future<Result<void>> closeRegister(CloseRegisterDto closeRegisterDto) async {
    try {
      final latestRegister = await (db.select(db.localRegisters)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(1))
          .getSingleOrNull();

      if (latestRegister == null) {
        return Result.failure(LocalDatabaseError(
          message: SpotstockStrings.failedToWriteData,
          subtitle: SpotstockStrings.registerIdNotFound,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        ));
      }

      await db.transaction(() async {
        await (db.update(db.localRegisters)..where((row) => row.id.equals(latestRegister.id))).write(
          LocalRegistersCompanion(
            closedAt: Value(DateTime.now()),
            cashInHandWhileClosing: Value(closeRegisterDto.cashInHandWhileClosing),
            note: Value(closeRegisterDto.notes),
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
    final hasOpenRegister = await _hasOpenRegister();
    return Result.success(hasOpenRegister);
  }

  Future<Result<GetRegisterDetailsResponseDao>> getRegisterDetails({int? registerId}) async {
    return await getRegisterDetailsLocalDatasource.getRegisterDetails(registerId: registerId);
  }

  Future<Result<void>> saveRegisters(List<Register> registers) async {
    try {
      await db.transaction(() async {
        await db.delete(db.localRegisters).go();

        for (final register in registers) {
          await db.into(db.localRegisters).insert(register.copyWith(isSynced: true).toDrift());
        }
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

  Future<Result<List<Register>>> getPOSRegisters({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final query = db.select(db.localRegisters);

      if (startDate != null) {
        query.where((tbl) => tbl.createdAt.isBiggerOrEqualValue(startDate));
      }

      if (endDate != null) {
        query.where((tbl) => tbl.createdAt.isSmallerOrEqualValue(endDate));
      }

      query.orderBy([
        (t) => OrderingTerm(expression: t.closedAt.isNull(), mode: OrderingMode.desc),
        (t) => OrderingTerm.desc(t.createdAt),
      ]);

      final localRegisters = await query.get();

      final registers = localRegisters.map(RegisterMapper.fromDrift).toList();

      return Result.success(registers);
    } catch (e) {
      return Result.failure(
        LocalDatabaseError(
          message: SpotstockStrings.failedToReadData,
          subtitle: SpotstockStrings.somethingWentWrong,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
          originalError: e,
        ),
      );
    }
  }
}
