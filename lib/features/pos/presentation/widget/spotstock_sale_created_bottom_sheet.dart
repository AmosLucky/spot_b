import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/colors/color_scheme_extension.dart';
import '../../../../core/presentation/dates/datetime_extension.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../data/models/sale.dart';

class SpotstockSaleCreatedBottomSheetBody extends StatelessWidget {
  final Sale sale;
  const SpotstockSaleCreatedBottomSheetBody({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SpotstockSizes.s10,
        vertical: SpotstockSizes.s16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(SpotstockSizes.s10),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                SpotstockStrings.totalProducts,
              ),
              Container(
                padding: EdgeInsets.all(SpotstockSizes.s8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  sale.saleItems?.length.toString() ?? '0',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: SpotstockSizes.s1,
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                SpotstockStrings.totalAmount,
              ),
              Row(
                children: [
                  NairaSymbol(
                    size: SpotstockSizes.s12,
                  ),
                  Text(sale.grandTotal?.toMoney() ?? '0'),
                ],
              ),
            ],
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: SpotstockSizes.s1,
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(SpotstockStrings.date),
              Text(sale.date?.toFormattedDate() ?? ''),
            ],
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: SpotstockSizes.s1,
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(SpotstockStrings.time),
              Text(
                sale.date?.toFormattedDate() ?? '',
              ),
            ],
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: SpotstockSizes.s1,
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(SpotstockStrings.paymentType),
              Text(sale.paymentType?.name ?? ''),
            ],
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: SpotstockSizes.s1,
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(SpotstockStrings.paymentStatus),
              Text(sale.paymentStatus?.name ?? ''),
            ],
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: SpotstockSizes.s1,
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(SpotstockStrings.referenceCode),
              Text(sale.referenceCode ?? ''),
            ],
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: SpotstockSizes.s1,
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(SpotstockStrings.createdAt),
              Text(sale.createdAt?.toFormattedDate() ?? ''),
            ],
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: SpotstockSizes.s1,
          ),
          const SizedBox(height: SpotstockSizes.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(SpotstockStrings.note),
              Text(sale.note ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}

class SpotstockSaleCreatedBottomSheetHeader extends StatelessWidget {
  const SpotstockSaleCreatedBottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.correct.withAlpha(50),
              radius: SpotstockSizes.s40,
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.correct.withAlpha(100),
              radius: SpotstockSizes.s30,
            ),
            Icon(
              Icons.check_circle,
              size: SpotstockSizes.s48,
              color: Theme.of(context).colorScheme.correct,
            ),
          ],
        ),
        const SizedBox(height: SpotstockSizes.s13),
        Text(
          SpotstockStrings.transactionSuccessful,
          style: TextStyle(
            fontSize: SpotstockSizes.s18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: SpotstockSizes.s20),
      ],
    );
  }
}
