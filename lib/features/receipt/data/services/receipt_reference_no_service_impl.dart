import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/error_handling/app_error.dart';
import '../../../../core/shared/result.dart';
import '../../domain/services/receipt_reference_no_service.dart';

class ReceiptReferenceNoServiceImpl implements ReceiptReferenceNoService {
  @override
  Future<Result<String>> generateReceiptReferenceNo() async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final receiptNo = '${SpotstockStrings.localReceiptReferenceNoPrefix}$timestamp';
      return Result.success(receiptNo);
    } catch (e) {
      return Result.failure(
          AppError(message: "${SpotstockStrings.failedToGenerateReceiptReferenceNo}}"));
    }
  }
}
