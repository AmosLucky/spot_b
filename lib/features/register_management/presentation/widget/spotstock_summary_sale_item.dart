import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/colors/color_scheme_extension.dart';
import '../../../../core/presentation/dates/datetime_extension.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/chips/spotstock_simple_chip.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../../pos/data/enums/enums.dart';
import '../../data/models/get_register_details_response_dao.dart';
import 'spotstock_summary_item.dart';

class SpotstockSummarySaleItem extends StatelessWidget {
  final RegisterSaleDao registerSale;
  const SpotstockSummarySaleItem({super.key, required this.registerSale});

  @override
  Widget build(BuildContext context) {
    return SpotstockSummaryItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                registerSale.referenceCode ?? SpotstockStrings.na,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  NairaSymbol(
                    size: SpotstockSizes.s14,
                  ),
                  Text(
                    registerSale.receivedAmount?.toMoney() ?? SpotstockStrings.na,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SpotstockSizes.s4),
          Row(
            children: [
              NairaSymbol(size: SpotstockSizes.s14),
              Text(registerSale.receivedAmount?.toMoney() ?? SpotstockStrings.na),
              const SizedBox(width: SpotstockSizes.s4),
              Text(SpotstockStrings.paid),
            ],
          ),
          SizedBox(height: SpotstockSizes.s4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(registerSale.date?.toFormattedDate() ?? SpotstockStrings.na),
              if (registerSale.paymentStatus == PaymentStatus.paid)
                SpotstockSimpleChip(
                  label: registerSale.paymentStatus?.name ?? SpotstockStrings.na,
                  color: Theme.of(context).colorScheme.paidChip,
                  textColor: Theme.of(context).colorScheme.onPaidChip,
                ),
              if (registerSale.paymentStatus == PaymentStatus.partial)
                SpotstockSimpleChip(
                  label: registerSale.paymentStatus?.name ?? SpotstockStrings.na,
                  color: Theme.of(context).colorScheme.partialChip,
                  textColor: Theme.of(context).colorScheme.onPartialChip,
                ),
              if (registerSale.paymentStatus == PaymentStatus.unpaid)
                SpotstockSimpleChip(
                  label: registerSale.paymentStatus?.name ?? SpotstockStrings.na,
                  color: Theme.of(context).colorScheme.unpaidChip,
                  textColor: Theme.of(context).colorScheme.onUnpaidChip,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
