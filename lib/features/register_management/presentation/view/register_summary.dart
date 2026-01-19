import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/dates/datetime_extension.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../../../pos/data/models/sale.dart';
import '../../data/models/get_register_details_response_dao.dart';
import '../view_model/register_summary_view_model.dart';
import '../widget/spotstock_summary_item.dart';
import '../widget/spotstock_summary_product_item.dart';
import '../widget/spotstock_summary_sale_item.dart';

class RegisterSummary extends StatelessWidget {
  final RegisterSummaryViewModel viewModel;
  final int? registerId;
  const RegisterSummary({
    super.key,
    required this.viewModel,
    this.registerId,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel..bind(context, registerId: registerId),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Column(
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.registerSummary,
                  withBackButton: true,
                  trailing: Row(
                    children: [
                      if (viewModel.showDownloadAllButton)
                        SpotstockIconButton(
                          icon: Icon(
                            Icons.download,
                            size: SpotstockSizes.s18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          color: Theme.of(context).colorScheme.onPrimary,
                          onPressed: () {},
                        )
                    ],
                  ),
                ),
                if (viewModel.getRegisterDetailsCommand.running && viewModel.registerDetails == null)
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpotstockProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(height: SpotstockSizes.s16),
                              Text(SpotstockStrings.gettingRegisterSummary),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await viewModel.getRegisterDetailsCommand.execute(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: SpotstockSizes.s16,
                          left: SpotstockSizes.s16,
                          right: SpotstockSizes.s16,
                        ),
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: SpotstockSizes.s10),
                              Text(
                                '${SpotstockStrings.openedAtColon} ${viewModel.registerDetails?.openedAt?.toRealDateWithTime() ?? SpotstockStrings.na}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: SpotstockSizes.s5),
                              Text(
                                '${SpotstockStrings.closedAtColon} ${viewModel.registerDetails?.closedAt?.toRealDateWithTime() ?? SpotstockStrings.na}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: SpotstockSizes.s16),
                              SpotstockSummaryItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.salesSummary,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SpotstockSizes.s16,
                                          ),
                                        ),
                                        SpotstockIconButton(
                                          icon: Icon(
                                            Icons.download,
                                            size: SpotstockSizes.s18,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                    SizedBox(height: SpotstockSizes.s10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.totalSales,
                                        ),
                                        Row(
                                          children: [
                                            NairaSymbol(
                                              size: SpotstockSizes.s14,
                                            ),
                                            Text(
                                              viewModel.registerDetails?.todaySalesAmount?.toMoney() ?? '0',
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.transactions,
                                        ),
                                        Text(
                                          viewModel.transactionCount.toString(),
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.returns,
                                        ),
                                        Row(
                                          children: [
                                            NairaSymbol(
                                              size: SpotstockSizes.s14,
                                            ),
                                            Text(
                                              viewModel.registerDetails?.todaySalesReturnAmount?.toMoney() ?? '0',
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.itemsSold,
                                        ),
                                        Text(
                                          viewModel.numberOfItemsSold.toString(),
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                              SizedBox(height: SpotstockSizes.s16),
                              SpotstockSummaryItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.paymentBreakdown,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SpotstockSizes.s16,
                                          ),
                                        ),
                                        SpotstockIconButton(
                                          icon: Icon(
                                            Icons.download,
                                            size: SpotstockSizes.s18,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                    SizedBox(height: SpotstockSizes.s10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.cash,
                                        ),
                                        Row(
                                          children: [
                                            NairaSymbol(
                                              size: SpotstockSizes.s14,
                                            ),
                                            Text(
                                              viewModel.registerDetails?.todaySalesCashPayment?.toMoney() ?? '0',
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.pos,
                                        ),
                                        Row(
                                          children: [
                                            NairaSymbol(
                                              size: SpotstockSizes.s14,
                                            ),
                                            Text(
                                              viewModel.registerDetails?.todaySalesPosPayment?.toMoney() ?? '0',
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.bankTransfer,
                                        ),
                                        Row(
                                          children: [
                                            NairaSymbol(
                                              size: SpotstockSizes.s14,
                                            ),
                                            Text(
                                              viewModel.registerDetails?.todaySalesBankTransferPayment?.toMoney() ?? '0',
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.folio,
                                        ),
                                        Row(
                                          children: [
                                            NairaSymbol(
                                              size: SpotstockSizes.s14,
                                            ),
                                            Text(
                                              viewModel.registerDetails?.todaySalesFolioPayment?.toMoney() ?? '0',
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.other,
                                        ),
                                        Row(
                                          children: [
                                            NairaSymbol(
                                              size: SpotstockSizes.s14,
                                            ),
                                            Text(
                                              viewModel.registerDetails?.todaySalesOtherPayment?.toMoney() ?? '0',
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                              SizedBox(height: SpotstockSizes.s16),
                              SpotstockSummaryItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.itemsSold,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SpotstockSizes.s16,
                                          ),
                                        ),
                                        SpotstockIconButton(
                                          icon: Icon(
                                            Icons.download,
                                            size: SpotstockSizes.s18,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                    SizedBox(height: SpotstockSizes.s10),
                                    if ((viewModel.registerDetails?.itemsSold == null || viewModel.registerDetails?.itemsSold?.isEmpty == true)) ...[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: SpotstockSizes.s16),
                                          Icon(
                                            Icons.inventory_2_outlined,
                                            size: SpotstockSizes.s24,
                                          ),
                                          SizedBox(height: SpotstockSizes.s4),
                                          Text(SpotstockStrings.noItemsSold),
                                          SizedBox(height: SpotstockSizes.s16),
                                        ],
                                      ),
                                    ],
                                    for (final saleItem in (viewModel.registerDetails?.itemsSold ?? <SaleItem>[]).take(SpotstockSizes.s3.toInt()))
                                      SpotstockSummaryProductItem(
                                        saleItem: saleItem,
                                        stockRemaining: viewModel.getStockRemaining(saleItem.productId),
                                      ),
                                    if ((viewModel.registerDetails?.itemsSold?.length ?? 0) > SpotstockSizes.s3.toInt())
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.onTapViewAllItemsSold(context, viewModel.registerDetails?.itemsSold ?? <SaleItem>[]);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  SpotstockStrings.viewAll,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                ),
                                                const SizedBox(width: SpotstockSizes.s4),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: SpotstockSizes.s12,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: SpotstockSizes.s16),
                              SpotstockSummaryItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.salesTransactions,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SpotstockSizes.s16,
                                          ),
                                        ),
                                        SpotstockIconButton(
                                          icon: Icon(
                                            Icons.download,
                                            size: SpotstockSizes.s18,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                    SizedBox(height: SpotstockSizes.s10),
                                    if ((viewModel.registerDetails?.itemsSold == null || viewModel.registerDetails?.todaySales?.isEmpty == true)) ...[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: SpotstockSizes.s16),
                                          Icon(
                                            Icons.shopping_cart_outlined,
                                            size: SpotstockSizes.s24,
                                          ),
                                          SizedBox(height: SpotstockSizes.s4),
                                          Text(SpotstockStrings.noSales),
                                          SizedBox(height: SpotstockSizes.s16),
                                        ],
                                      ),
                                    ],
                                    for (final sale in (viewModel.registerDetails?.todaySales ?? <RegisterSaleDao>[]).take(SpotstockSizes.s3.toInt()))
                                      SpotstockSummarySaleItem(registerSale: sale),
                                    if ((viewModel.registerDetails?.todaySales?.length ?? 0) > SpotstockSizes.s3.toInt())
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.onTapViewAllSales(context, viewModel.registerDetails?.todaySales ?? <RegisterSaleDao>[]);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  SpotstockStrings.viewAll,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context).colorScheme.primary,
                                                  ),
                                                ),
                                                const SizedBox(width: SpotstockSizes.s4),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: SpotstockSizes.s12,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: SpotstockSizes.s16),
                              SpotstockSummaryItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.details,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SpotstockSizes.s16,
                                          ),
                                        ),
                                        SpotstockIconButton(
                                          icon: Icon(
                                            Icons.download,
                                            size: SpotstockSizes.s18,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                    SizedBox(height: SpotstockSizes.s10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.cashAtHand,
                                        ),
                                        Row(
                                          children: [
                                            NairaSymbol(
                                              size: SpotstockSizes.s14,
                                            ),
                                            Text(
                                              viewModel.registerDetails?.cashInHand?.toMoney() ?? '0',
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SpotstockStrings.staff,
                                        ),
                                        Text(
                                          viewModel.registerDetails?.staff?.name ?? SpotstockStrings.na,
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                              SizedBox(height: SpotstockSizes.s16),
                            ],
                          ),
                        ),
                      ),
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
