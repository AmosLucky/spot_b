import 'dart:math';

import 'package:spotstock_inventory/core/constants/strings/spotstock_strings.dart';
import 'package:spotstock_inventory/core/error_handling/app_error.dart';
import 'package:spotstock_inventory/core/networking/spotstock_status_code.dart';

import '../../../../core/shared/result.dart';
import '../../domain/repositories/custom_product_repository.dart';

class CustomProductRepositoryImpl implements CustomProductRepository {
  final Random _random = Random.secure();

  @override
  Future<Result<int>> getCustomProductId() async {
    try {
      final id = _generate16DigitId();
      return Result.success(id);
    } catch (e) {
      return Result.failure(
        AppError(
          message: SpotstockStrings.failedToReadData,
          code: SpotstockStatusCode.internalAppError.toString(),
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<String>> getCustomProductCode() async {
    try {
      final random = _generate16DigitId();
      return Result.success('${SpotstockStrings.customProductCodePrefix}$random');
    } catch (e) {
      return Result.failure(
        AppError(
          message: SpotstockStrings.failedToReadData,
          code: SpotstockStatusCode.internalAppError.toString(),
          originalError: e,
        ),
      );
    }
  }

  int _generate16DigitId() {
    final buffer = StringBuffer();
    for (int i = 0; i < 4; i++) {
      final block = 1000 + _random.nextInt(9000);
      buffer.write(block);
    }
    return int.parse(buffer.toString());
  }
}
