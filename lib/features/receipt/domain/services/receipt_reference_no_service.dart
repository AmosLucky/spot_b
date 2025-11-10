import '../../../../core/shared/result.dart';

abstract class ReceiptReferenceNoService {
  Future<Result<String>> generateReceiptReferenceNo();
}
