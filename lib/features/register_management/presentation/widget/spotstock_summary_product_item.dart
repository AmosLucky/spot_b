import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../../pos/data/models/sale.dart';
import 'spotstock_summary_item.dart';

class SpotstockSummaryProductItem extends StatelessWidget {
  final SaleItem saleItem;
  final int? stockRemaining;
  const SpotstockSummaryProductItem({super.key, required this.saleItem, this.stockRemaining});

  @override
  Widget build(BuildContext context) {
    return SpotstockSummaryItem(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  saleItem.productName ?? SpotstockStrings.na,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  NairaSymbol(
                    size: SpotstockSizes.s14,
                  ),
                  Text(
                    saleItem.productPrice?.toMoney() ?? SpotstockStrings.na,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SpotstockSizes.s4),
          Row(
            children: [
              Text(
                "${saleItem.quantity?.toInt().toString() ?? SpotstockStrings.na} ${saleItem.quantity == 1 ? SpotstockStrings.unit : SpotstockStrings.units}",
              ),
              const SizedBox(width: SpotstockSizes.s4),
              Text('•'),
              const SizedBox(width: SpotstockSizes.s4),
              Text("${stockRemaining?.toString() ?? SpotstockStrings.na} ${SpotstockStrings.remaining}"),
            ],
          )
        ],
      ),
    );
  }
}
