import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/bottom_sheets/spotstock_bottom_sheet.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/snackbars/spotstock_snackbar.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../../features/register_management/data/models/get_register_details_response_dao.dart';
import '../../../pos/data/models/sale.dart';
import '../../../stock/data/models/stock_item.dart';
import '../../../stock/domain/usecases/get_stock_items.dart';
import '../../domain/usecases/get_register_details.dart';
import '../widget/spotstock_summary_product_item.dart';
import '../widget/spotstock_summary_sale_item.dart';

class RegisterSummaryViewModel extends SpotstockViewModel with SpotstockDialogMixin, SpotstockSnackbarMixin, SpotstockBottomSheetMixin {
  final GetRegisterDetails getRegisterDetails;
  final GetStockItems getStockItems;

  RegisterSummaryViewModel(this.getRegisterDetails, this.getStockItems);

  GetRegisterDetailsResponseDao? _registerDetails;
  GetRegisterDetailsResponseDao? get registerDetails => _registerDetails;

  List<StockItem>? _stockItems;
  List<StockItem>? get stockItems => _stockItems;

  int? _registerId;
  int? get registerId => _registerId;

  Command1<void, BuildContext>? _getRegisterDetailsCommand;
  Command1<void, BuildContext> get getRegisterDetailsCommand => _getRegisterDetailsCommand ??= Command1<void, BuildContext>(_getRegisterDetails);

  int get transactionCount => registerDetails?.todaySales?.length ?? 0;

  int get numberOfItemsSold =>
      registerDetails?.itemsSold?.fold<int>(
        0,
        (total, item) => total + (item.quantity?.toInt() ?? 0),
      ) ??
      0;

  bool get showDownloadAllButton => !getRegisterDetailsCommand.running && registerDetails != null;

  @override
  void bind(BuildContext context, {int? registerId}) {
    _registerId = registerId;
    _getRegisterDetailsCommand ??= Command1<void, BuildContext>(_getRegisterDetails)
      ..execute(context)
      ..addListener(() => notifyListeners());
  }

  Future<Result<void>> _getRegisterDetails(BuildContext context) async {
    final theme = Theme.of(context);
    final result = await getRegisterDetails(registerId);
    if (result is Success) {
      _registerDetails = result.data;
      final stockItemsResult = await getStockItems();
      if (stockItemsResult is Success) {
        _stockItems = stockItemsResult.data;
      }
    }
    if (result is Failure) {
      showSpotstockInformationDialog(
        SpotstockNavigation.context ?? context,
        icon: Icon(Icons.error, color: theme.colorScheme.error, size: SpotstockSizes.s40),
        title: result.error.message,
        description: '${SpotstockStrings.errorCodeColon} ${result.error.code}',
        actions: [
          SpotstockPrimaryButton(
            child: Text(
              SpotstockStrings.ok,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            onPressed: () {
              SpotstockNavigation.goBack(context);
            },
          ),
        ],
      );
      addError(result.error);
    }
    return result;
  }

  Future<void> onTapViewAllSales(BuildContext context, List<RegisterSaleDao> saleItems) async {
    await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.salesTransactions,
      form: Column(
        children: saleItems.map((saleItem) => SpotstockSummarySaleItem(registerSale: saleItem)).toList(),
      ),
    );
  }

  Future<void> onTapViewAllItemsSold(BuildContext context, List<SaleItem> saleItems) async {
    await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.itemsSold,
      form: Column(
        children: saleItems
            .map((saleItem) => SpotstockSummaryProductItem(
                  saleItem: saleItem,
                  stockRemaining: getStockRemaining(saleItem.productId),
                ))
            .toList(),
      ),
    );
  }

  int? getStockRemaining(int? productId) {
    if (productId == null) return null;
    final stockItem = _stockItems?.where((item) => item.productId == productId).firstOrNull;
    return stockItem?.quantity;
  }
}
