import '../../../../core/shared/result.dart';
import '../../../auth/domain/usecases/get_spotstock_user.dart';
import '../../../pos/data/models/sale.dart';
import '../../data/models/extra_receipt_details.dart';
import '../services/sale_receipt_service.dart';

class SharePdfReceipt {
  final SaleReceiptService saleReceiptService;
  final GetSpotstockUser getSpotstockUser;

  SharePdfReceipt(this.saleReceiptService, this.getSpotstockUser);

  Future<Result<void>> call(Sale sale, {ExtraReceiptDetails? extraReceiptDetails}) async {
    final userResult = await getSpotstockUser();
    userResult.when(
      onSuccess: (user) {
        extraReceiptDetails = extraReceiptDetails?.copyWith(
          companyName: user?.company.name,
          companyAddress: user?.company.address,
          companyPhone: user?.company.phone,
          companyEmail: user?.company.email,
        );
      },
      onFailure: (error) {},
    );
    return await saleReceiptService.shareReceipt(sale, extraReceiptDetails: extraReceiptDetails);
  }
}
