import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/holds/data/models/grouped_hold.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/colors/color_scheme_extension.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../../holds/data/models/hold.dart';
import '../../data/models/create_sale_dto.dart';
import '../../data/models/product.dart';
import '../view_model/spotstock_cart_tab_view_model.dart';

class SpotstockCartTab extends StatelessWidget {
  final List<SaleItemDto>? saleItems;
  final TextEditingController? discountController;
  final TextEditingController? shippingController;
  final double taxAmount;
  final double grandTotal;
  final double subTotal;
  final Function(String?) onDiscountChanged;
  final Function(String?) onShippingChanged;
  final List<Product> products;
  final Function(int?) onRemoveSaleItem;
  final Function(int?) onIncreaseSaleItemQuantity;
  final Function(int?) onDecreaseSaleItemQuantity;
  final Function(SaleItemDto?) onEditSaleItem;
  final Function(BuildContext) onResetPressed;
  final Function(BuildContext) onHoldPressed;
  final Function(BuildContext) onPayPressed;
  final bool canPay;
  final bool isHold;
  final Hold? selectedHold;
  final GroupedHold? selectedGroupedHold;

  const SpotstockCartTab({
    super.key,
    required this.saleItems,
    required this.discountController,
    required this.shippingController,
    required this.taxAmount,
    required this.grandTotal,
    required this.subTotal,
    required this.onDiscountChanged,
    required this.onShippingChanged,
    required this.products,
    required this.onRemoveSaleItem,
    required this.onIncreaseSaleItemQuantity,
    required this.onDecreaseSaleItemQuantity,
    required this.onEditSaleItem,
    required this.onResetPressed,
    required this.onHoldPressed,
    required this.onPayPressed,
    required this.canPay,
    required this.isHold,
    this.selectedHold,
    this.selectedGroupedHold,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SpotstockCartTabViewModel>();
    return ListenableBuilder(
      listenable: viewModel
        ..bind(
          context,
          products: products,
          saleItems: saleItems,
          selectedGroupedHold: selectedGroupedHold,
          selectedHold: selectedHold,
        ),
      builder: (context, _) {
        return Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(SpotstockSizes.s16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(SpotstockSizes.s10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: SpotstockSizes.s1,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SpotstockSizes.s10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              SpotstockStrings.productCapital,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              SpotstockStrings.qtyCapital,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              SpotstockStrings.priceCapital,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  SpotstockStrings.subTotalCapital,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      height: SpotstockSizes.s1,
                    ),
                    Expanded(
                      child: viewModel.saleItems?.isEmpty ?? true
                          ? Scrollbar(
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: SpotstockSizes.s80),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_shopping_cart_outlined,
                                          size: SpotstockSizes.s40,
                                          color: Theme.of(context).colorScheme.outline,
                                        ),
                                        SizedBox(height: SpotstockSizes.s5),
                                        Text(
                                          SpotstockStrings.yourCartIsEmpty,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: SpotstockSizes.s16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: SpotstockSizes.s5),
                                        Text(
                                          SpotstockStrings.addItemsToGetStarted,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: SpotstockSizes.s14,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: Scrollbar(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: viewModel.saleItems?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final saleItem = viewModel.saleItems?[index];
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                  SpotstockSizes.s5,
                                                  SpotstockSizes.s5,
                                                  SpotstockSizes.s5,
                                                  SpotstockSizes.s5,
                                                ),
                                                padding: EdgeInsets.fromLTRB(
                                                  SpotstockSizes.s10,
                                                  SpotstockSizes.s10,
                                                  SpotstockSizes.s0,
                                                  SpotstockSizes.s10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  borderRadius: BorderRadius.circular(SpotstockSizes.s10),
                                                  border: Border.all(
                                                    color: Theme.of(context).colorScheme.outlineVariant,
                                                    width: SpotstockSizes.s1,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            saleItem?.isCustom == true
                                                                ? saleItem?.customName ?? viewModel.getProductName(saleItem?.productId ?? 0)
                                                                : viewModel.getProductName(saleItem?.productId ?? 0),
                                                          ),
                                                          if (saleItems?[index].isCustom == true)
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: SpotstockSizes.s3,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal: SpotstockSizes.s5,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(SpotstockSizes.s1000),
                                                                    color: Theme.of(context).colorScheme.primary,
                                                                  ),
                                                                  child: Text(
                                                                    SpotstockStrings.custom,
                                                                    style: TextStyle(
                                                                      fontSize: SpotstockSizes.s11,
                                                                      color: Theme.of(context).colorScheme.onPrimary,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            isHold
                                                                ? SizedBox.shrink()
                                                                : SpotstockIconButton(
                                                                    icon: Icon(
                                                                      Icons.remove,
                                                                      color: Theme.of(context).colorScheme.primary,
                                                                      size: SpotstockSizes.s18,
                                                                    ),
                                                                    onPressed: () {
                                                                      onDecreaseSaleItemQuantity(viewModel.saleItems?[index].productId);
                                                                    },
                                                                  ),
                                                            SizedBox(width: SpotstockSizes.s5),
                                                            Text(
                                                              viewModel.saleItems![index].quantity?.toInt().toString() ?? '0',
                                                            ),
                                                            SizedBox(width: SpotstockSizes.s5),
                                                            isHold
                                                                ? SizedBox.shrink()
                                                                : SpotstockIconButton(
                                                                    icon: Icon(
                                                                      Icons.add,
                                                                      color: Theme.of(context).colorScheme.primary,
                                                                      size: SpotstockSizes.s18,
                                                                    ),
                                                                    onPressed: () {
                                                                      onIncreaseSaleItemQuantity(viewModel.saleItems?[index].productId);
                                                                    },
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              viewModel.saleItems?[index].productPrice?.toMoney() ?? '0',
                                                            ),
                                                            SizedBox(width: SpotstockSizes.s5),
                                                            isHold
                                                                ? SizedBox.shrink()
                                                                : SpotstockIconButton(
                                                                    icon: Icon(
                                                                      Icons.edit,
                                                                      color: Theme.of(context).colorScheme.primary,
                                                                      size: SpotstockSizes.s16,
                                                                    ),
                                                                    onPressed: () {
                                                                      onEditSaleItem(viewModel.saleItems?[index]);
                                                                    },
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            viewModel.saleItems?[index].subTotal?.toMoney() ?? '0',
                                                          ),
                                                          SizedBox(width: SpotstockSizes.s5),
                                                          isHold
                                                              ? SizedBox.shrink()
                                                              : SpotstockIconButton(
                                                                  icon: Icon(
                                                                    Icons.close,
                                                                    color: Theme.of(context).colorScheme.error,
                                                                    size: SpotstockSizes.s18,
                                                                  ),
                                                                  onPressed: () {
                                                                    onRemoveSaleItem(viewModel.saleItems?[index].productId);
                                                                  },
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.outlineVariant,
              height: SpotstockSizes.s1,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                SpotstockSizes.s16,
                SpotstockSizes.s10,
                SpotstockSizes.s16,
                SpotstockSizes.s0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(SpotstockStrings.discount),
                            SizedBox(height: SpotstockSizes.s8),
                            SpotstockTextField(
                              controller: discountController,
                              enabled: !(viewModel.saleItems?.isEmpty ?? true) && !isHold,
                              hintText: SpotstockStrings.zero_00,
                              keyboardType: TextInputType.number,
                              onChanged: onDiscountChanged,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: SpotstockSizes.s10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(SpotstockStrings.shipping),
                            SizedBox(height: SpotstockSizes.s8),
                            SpotstockTextField(
                              controller: shippingController,
                              enabled: !(viewModel.saleItems?.isEmpty ?? true) && !isHold,
                              hintText: SpotstockStrings.zero_00,
                              keyboardType: TextInputType.number,
                              onChanged: onShippingChanged,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SpotstockSizes.s10),
                  Divider(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    height: SpotstockSizes.s1,
                  ),
                  SizedBox(height: SpotstockSizes.s8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        SpotstockStrings.vatPercentageColon,
                      ),
                      Text(
                        taxAmount.toMoney(),
                      ),
                    ],
                  ),
                  SizedBox(height: SpotstockSizes.s8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        SpotstockStrings.subtotalColon,
                      ),
                      Text(
                        subTotal.toMoney(),
                      ),
                    ],
                  ),
                  SizedBox(height: SpotstockSizes.s8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        SpotstockStrings.totalColon,
                        style: TextStyle(fontSize: SpotstockSizes.s16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        grandTotal.toMoney(),
                        style: TextStyle(fontSize: SpotstockSizes.s16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: SpotstockSizes.s8),
                  Row(
                    children: [
                      Expanded(
                        child: SpotstockPrimaryButton(
                          enabled: !(viewModel.saleItems?.isEmpty ?? true),
                          color: Theme.of(context).colorScheme.reset,
                          child: Text(
                            SpotstockStrings.reset,
                            style: TextStyle(color: Theme.of(context).colorScheme.onReset),
                          ),
                          onPressed: () => onResetPressed(context),
                        ),
                      ),
                      SizedBox(width: SpotstockSizes.s10),
                      Expanded(
                        child: SpotstockPrimaryButton(
                          enabled: canPay && !isHold,
                          color: Theme.of(context).colorScheme.hold,
                          child: Text(
                            SpotstockStrings.hold,
                            style: TextStyle(color: Theme.of(context).colorScheme.onHold),
                          ),
                          onPressed: () => onHoldPressed(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SpotstockSizes.s10),
                  SpotstockPrimaryButton(
                    enabled: canPay,
                    color: Theme.of(context).colorScheme.payNow,
                    child: Text(
                      SpotstockStrings.pay,
                      style: TextStyle(color: Theme.of(context).colorScheme.onPayNow),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      onPayPressed(context);
                    },
                  ),
                  SizedBox(height: SpotstockSizes.bottomSpacing(context)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
