import '../../../../core/shared/result.dart';
import '../../../pos/data/models/sale.dart';
import '../../data/models/extra_receipt_details.dart';

abstract class SaleReceiptService {
  Future<dynamic> generateReceipt(Sale sale, {ExtraReceiptDetails? extraReceiptDetails});
  Future<Result> printReceipt(Sale sale, {ExtraReceiptDetails? extraReceiptDetails});
  Future<Result> shareReceipt(Sale sale, {ExtraReceiptDetails? extraReceiptDetails});
}
