import '../../../../core/shared/result.dart';
import '../../domain/repositories/local_receipt_reference_no_repository.dart';
import '../../domain/services/receipt_reference_no_service.dart';

class LocalReceiptReferenceNoRepositoryImpl extends LocalReceiptReferenceNoRepository {
  final ReceiptReferenceNoService receiptReferenceNoService;

  LocalReceiptReferenceNoRepositoryImpl(this.receiptReferenceNoService);

  @override
  Future<Result<String>> generateReceiptReferenceNo() async {
    return await receiptReferenceNoService.generateReceiptReferenceNo();
  }
}
