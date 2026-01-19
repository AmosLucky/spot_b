import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/shared/result.dart';
import '../../../auth/domain/usecases/get_spotstock_user.dart';
import '../../../pos/data/models/sale.dart';
import '../../data/models/extra_receipt_details.dart';
import '../services/sale_receipt_service.dart';

class PrintPdfReceipt {
  final SaleReceiptService saleReceiptService;
  final GetSpotstockUser getSpotstockUser;

  PrintPdfReceipt(this.saleReceiptService, this.getSpotstockUser);

  Future<Result<void>> call(Sale sale, {ExtraReceiptDetails? extraReceiptDetails}) async {
    final userResult = await getSpotstockUser();
    userResult.when(
      onSuccess: (user) {
        extraReceiptDetails = extraReceiptDetails?.copyWith(
          companyName: user?.company?.name ?? SpotstockStrings.EMPTY,
          companyAddress: user?.company?.address ?? SpotstockStrings.EMPTY,
          companyPhone: user?.company?.phone ?? SpotstockStrings.EMPTY,
          companyEmail: user?.company?.email ?? SpotstockStrings.EMPTY,
        );
      },
      onFailure: (error) {},
    );
    return await saleReceiptService.printReceipt(
      sale,
      extraReceiptDetails: extraReceiptDetails,
    );
  }
}
