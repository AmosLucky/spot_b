import 'dart:convert';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/local_storage/local_storage_client.dart';
import '../../../../../core/local_storage/local_storage_keys.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../pos/domain/errors/errors.dart';
import '../../models/verify_pin_dto.dart';

class StaffPinLocalDatasource {
  final LocalStorageClient localStorageClient;

  StaffPinLocalDatasource(this.localStorageClient);

  Future<Map<int, String>> _getAllStaffPins() async {
    try {
      final savedPins = await localStorageClient.privateRead(LocalStorageKeys.staffPins);
      if (savedPins == null || savedPins.isEmpty) return {};

      final decoded = jsonDecode(savedPins) as Map<String, dynamic>;
      final result = decoded.map((key, value) => MapEntry(int.parse(key), value.toString()));
      return result;
    } catch (e) {
      return {};
    }
  }

  Future<Result<void>> savePin(VerifyPinDto verifyPinDto) async {
    try {
      final staffPins = await _getAllStaffPins();
      staffPins[verifyPinDto.userId] = verifyPinDto.pin;

      // Convert Map<int, String> to Map<String, String> for JSON encoding
      final pinsToSave = staffPins.map((key, value) => MapEntry(key.toString(), value));
      final jsonString = jsonEncode(pinsToSave);

      await localStorageClient.privateWrite(LocalStorageKeys.staffPins, jsonString);

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

  Future<Result<bool>> verifyPin(VerifyPinDto verifyPinDto) async {
    try {
      final staffPins = await _getAllStaffPins();
      final savedPin = staffPins[verifyPinDto.userId];
      if (savedPin == null) {
        return Result.failure(
          LocalDatabaseError(
            message: SpotstockStrings.pinNotFound,
            subtitle: SpotstockStrings.verifyAttendantOnlineAndTryAgain,
            code: SpotstockStatusCode.internalAppDatabaseError.toString(),
            originalError: null,
          ),
        );
      }
      if (savedPin != verifyPinDto.pin) {
        return Result.failure(
          LocalDatabaseError(
            message: SpotstockStrings.invalidPin,
            subtitle: SpotstockStrings.checkYourPinAndTryAgain,
            code: SpotstockStatusCode.internalAppDatabaseError.toString(),
            originalError: null,
          ),
        );
      }
      return Result.success(true);
    } catch (e) {
      return Result.failure(
        LocalDatabaseError(
          message: SpotstockStrings.failedToVerifyPin,
          subtitle: SpotstockStrings.somethingWentWrong,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
          originalError: e,
        ),
      );
    }
  }
}
