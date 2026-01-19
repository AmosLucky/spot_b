import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/chips/spotstock_simple_chip.dart';
import '../../../../core/presentation/colors/color_scheme_extension.dart';
import '../../../../core/presentation/dates/datetime_extension.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../data/models/hold.dart';

class SpotstockHoldWidget extends StatelessWidget {
  final Hold hold;
  final VoidCallback? onTap;
  const SpotstockHoldWidget({super.key, required this.hold, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isItemsCountMoreThanOne = hold.holdItems?.length != null && hold.holdItems!.length > 1;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(SpotstockSizes.s8),
        margin: EdgeInsets.only(bottom: SpotstockSizes.s8),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(SpotstockSizes.s8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: SpotstockSizes.s5,
                    runSpacing: SpotstockSizes.s5,
                    children: [
                      if (hold.tableName != null)
                        SpotstockSimpleChip(
                          label: hold.tableName ?? '',
                          color: Theme.of(context).colorScheme.tableChip,
                          textColor: Theme.of(context).colorScheme.onTableChip,
                        ),
                      if (hold.customerName != null)
                        SpotstockSimpleChip(
                          label: hold.customerName ?? '',
                          color: Theme.of(context).colorScheme.customerChip,
                          textColor: Theme.of(context).colorScheme.onCustomerChip,
                        ),
                      if (hold.warehouseName != null)
                        SpotstockSimpleChip(
                          label: hold.warehouseName ?? '',
                          color: Theme.of(context).colorScheme.warehouseChip,
                          textColor: Theme.of(context).colorScheme.onWarehouseChip,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    NairaSymbol(),
                    Text(
                      hold.grandTotal?.toMoney() ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SpotstockSizes.s16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: SpotstockSizes.s8),
            Text(
              '${hold.holdItems?.length} ${isItemsCountMoreThanOne ? SpotstockStrings.items : SpotstockStrings.itemSmallLetter}',
            ),
            const SizedBox(height: SpotstockSizes.s8),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    hold.referenceCode ?? '',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox.shrink(),
                ),
              ],
            ),
            const SizedBox(height: SpotstockSizes.s8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hold.date?.toFormattedDate() ?? ''),
                if (hold.isSynced == false) ...[
                  Icon(
                    Icons.sync_problem,
                    size: SpotstockSizes.s16,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
