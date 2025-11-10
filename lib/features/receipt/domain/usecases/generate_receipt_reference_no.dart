import '../../../../core/shared/result.dart';
import '../services/receipt_reference_no_service.dart';

class GenerateReceiptReferenceNo {
  final ReceiptReferenceNoService receiptReferenceNoService;

  GenerateReceiptReferenceNo(this.receiptReferenceNoService);

  Future<Result<String>> call() async {
    return await receiptReferenceNoService.generateReceiptReferenceNo();
  }
}
