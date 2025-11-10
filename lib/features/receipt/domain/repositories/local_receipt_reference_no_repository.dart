import '../../../../core/shared/result.dart';

abstract class LocalReceiptReferenceNoRepository {
  Future<Result<String>> generateReceiptReferenceNo();
}
