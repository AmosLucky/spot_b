import 'dart:convert';

import 'package:spotstock_inventory/core/local_storage/local_storage_client.dart';
import 'package:spotstock_inventory/core/local_storage/local_storage_keys.dart';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../pos/domain/errors/errors.dart';

class DeletedHoldIdsDatasource {
  final LocalStorageClient localStorageClient;

  DeletedHoldIdsDatasource(this.localStorageClient);

  Future<List<String>> getDeletedHoldIds() async {
    try {
      final deleteHoldIds = localStorageClient.read(LocalStorageKeys.deletedHoldIds);
      if (deleteHoldIds == null || deleteHoldIds.isEmpty) return <String>[];

      final decoded = jsonDecode(deleteHoldIds);
      final list = List<String>.from(decoded);

      return list;
    } catch (e) {
      return <String>[];
    }
  }

  Future<Result<void>> addHoldId(String holdId) async {
    try {
      final list = await getDeletedHoldIds();

      if (!list.contains(holdId)) {
        list.add(holdId);
      }

      await localStorageClient.write(
        LocalStorageKeys.deletedHoldIds,
        jsonEncode(list),
      );

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        LocalDatabaseError(
          message: SpotstockStrings.failedToWriteData,
          subtitle: SpotstockStrings.somethingWentWrong,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
          originalError: e,
        ),
      );
    }
  }

  Future<Result<void>> removeHoldId(String holdId) async {
    try {
      final list = await getDeletedHoldIds();

      list.remove(holdId);

      await localStorageClient.write(
        LocalStorageKeys.deletedHoldIds,
        jsonEncode(list),
      );

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        LocalDatabaseError(
          message: SpotstockStrings.failedToWriteData,
          subtitle: SpotstockStrings.somethingWentWrong,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
          originalError: e,
        ),
      );
    }
  }

  Future<Result<void>> clearHoldIdsList() async {
    try {
      await localStorageClient.write(
        LocalStorageKeys.deletedHoldIds,
        jsonEncode(<String>[]),
      );

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        LocalDatabaseError(
          message: SpotstockStrings.failedToWriteData,
          subtitle: SpotstockStrings.somethingWentWrong,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
          originalError: e,
        ),
      );
    }
  }
}
