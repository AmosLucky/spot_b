import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/pos_view_model.dart';
import '../widget/spotstock_cart_tab.dart';
import '../widget/spotstock_products_tab.dart';

const int _unselectedIconAlpha = 128;

class Pos extends StatefulWidget with SpotstockDialogMixin {
  final PosViewModel viewModel;
  Pos({super.key, required this.viewModel});

  @override
  State<Pos> createState() => _PosState();
}

class _PosState extends State<Pos> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.viewModel..bind(context, vsync: this),
        widget.viewModel.createSaleCommand,
      ]),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    SpotstockAppbar(
                      title: SpotstockStrings.pos,
                      withBackButton: true,
                      onBackPressed: () async {
                        return await widget.viewModel.onBackPressed(context);
                      },
                      trailing: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.viewModel.onBranchPressed(context);
                            },
                            child: Badge(
                              label: widget.viewModel.isBranchSelected
                                  ? null
                                  : Text(SpotstockStrings.exclamation),
                              backgroundColor: widget.viewModel.isBranchSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                              child: SpotstockIconButton(
                                icon: Icon(
                                  Icons.store_mall_directory,
                                  size: SpotstockSizes.s18,
                                  color: widget.viewModel.isBranchSelected
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withAlpha(_unselectedIconAlpha),
                                ),
                                onPressed: () {
                                  widget.viewModel.onBranchPressed(context);
                                },
                                tooltip: widget.viewModel.selectedBranch?.name ??
                                    SpotstockStrings.branch,
                              ),
                            ),
                          ),
                          SizedBox(width: SpotstockSizes.s16),
                          GestureDetector(
                            onTap: () {
                              widget.viewModel.onAttendantPressed(context);
                            },
                            child: Badge(
                              label: widget.viewModel.isAttendantSelected
                                  ? null
                                  : Text(SpotstockStrings.exclamation),
                              backgroundColor: widget.viewModel.isAttendantSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                              child: SpotstockIconButton(
                                icon: Icon(
                                  Icons.manage_accounts,
                                  size: SpotstockSizes.s18,
                                  color: widget.viewModel.isAttendantSelected
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withAlpha(_unselectedIconAlpha),
                                ),
                                onPressed: () {
                                  widget.viewModel.onAttendantPressed(context);
                                },
                                tooltip: widget.viewModel.selectedAttendant?.firstName ??
                                    SpotstockStrings.selectAttendant,
                              ),
                            ),
                          ),
                          SizedBox(width: SpotstockSizes.s16),
                          SpotstockIconButton(
                            icon: Icon(
                              Icons.table_bar,
                              size: SpotstockSizes.s18,
                              color: widget.viewModel.isBarTableSelected
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withAlpha(_unselectedIconAlpha),
                            ),
                            onPressed: () {
                              widget.viewModel.onBarTablePressed(context);
                            },
                            tooltip: widget.viewModel.selectedBarTable?.name ??
                                SpotstockStrings.selectBarTable,
                          ),
                          SizedBox(width: SpotstockSizes.s16),
                          SpotstockIconButton(
                            icon: Icon(
                              Icons.person,
                              size: SpotstockSizes.s18,
                              color: widget.viewModel.isCustomerSelected
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withAlpha(_unselectedIconAlpha),
                            ),
                            onPressed: () {
                              widget.viewModel.onCustomerPressed(context);
                            },
                            tooltip: widget.viewModel.selectedCustomer?.name ??
                                SpotstockStrings.selectCustomer,
                          ),
                          SizedBox(width: SpotstockSizes.s14),
                          Builder(
                            builder: (BuildContext buttonContext) {
                              return SpotstockIconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  size: SpotstockSizes.s18,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                onPressed: () async {
                                  final result = await showMenu(
                                    context: buttonContext,
                                    position: RelativeRect.fromLTRB(
                                      MediaQuery.of(context).size.width,
                                      kToolbarHeight,
                                      SpotstockSizes.s0,
                                      SpotstockSizes.s0,
                                    ),
                                    items: [
                                      PopupMenuItem(
                                        value: SpotstockStrings.holdsValue,
                                        child: Text(SpotstockStrings.holds),
                                        onTap: () {
                                          widget.viewModel.onHoldsPressed(context);
                                        },
                                      ),
                                    ],
                                  );
                                  if (result != null) {
                                    return;
                                  }
                                },
                                // tooltip: SpotstockStrings.more,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    TabBar(
                      controller: widget.viewModel.tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (index) {
                        FocusScope.of(context).unfocus();
                      },
                      tabs: [
                        Tab(
                          text: "${SpotstockStrings.cart}(${widget.viewModel.cartCount})",
                        ),
                        Tab(text: SpotstockStrings.products),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: widget.viewModel.tabController,
                        children: [
                          SpotstockCartTab(
                            saleItems: widget.viewModel.createSaleDto.saleItems ?? [],
                            discountController: widget.viewModel.discountController,
                            shippingController: widget.viewModel.shippingController,
                            taxAmount: widget.viewModel.taxAmount,
                            grandTotal: widget.viewModel.grandTotal,
                            subTotal: widget.viewModel.subTotal,
                            products: widget.viewModel.products,
                            canPay: widget.viewModel.canPay,
                            onDiscountChanged: (value) {
                              widget.viewModel.onDiscountChanged(value);
                            },
                            onShippingChanged: (value) {
                              widget.viewModel.onShippingChanged(value);
                            },
                            onRemoveSaleItem: (productId) {
                              widget.viewModel.onRemoveSaleItem(productId);
                            },
                            onIncreaseSaleItemQuantity: (productId) {
                              widget.viewModel.onIncreaseSaleItemQuantity(productId);
                            },
                            onDecreaseSaleItemQuantity: (productId) {
                              widget.viewModel.onDecreaseSaleItemQuantity(productId);
                            },
                            onEditSaleItem: (saleItem) {
                              widget.viewModel.onEditSaleItem(context, saleItem);
                            },
                            onResetPressed: (context) {
                              widget.viewModel.onResetPressed(context);
                            },
                            onHoldPressed: (context) {
                              widget.viewModel.onHoldPressed(context);
                            },
                            onPayPressed: (context) {
                              widget.viewModel.onPayPressed(context);
                            },
                          ),
                          SpotstockProductsTab(
                            products: widget.viewModel.products,
                            onAddProduct: widget.viewModel.onAddProduct,
                            isUpdatingProducts: widget.viewModel.getProductsCommand.running,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (widget.viewModel.createSaleCommand.running)
                  Material(
                    color: Theme.of(context).colorScheme.surface.withAlpha(186),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpotstockProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(height: SpotstockSizes.s5),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            SpotstockStrings.creatingSale,
                            style: TextStyle(
                              fontSize: SpotstockSizes.s10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
