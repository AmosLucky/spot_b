import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/chips/spotstock_simple_chip.dart';
import '../../../../core/presentation/colors/color_scheme_extension.dart';
import '../../../../core/presentation/dates/datetime_extension.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../data/models/grouped_hold.dart';

class SpotstockGroupedHoldWidget extends StatelessWidget {
  final GroupedHold groupedHold;
  final VoidCallback? onTap;
  const SpotstockGroupedHoldWidget({super.key, required this.groupedHold, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isCountMoreThanOne = groupedHold.holdCount > 1;
    final isItemsCountMoreThanOne = groupedHold.totalHoldItemsCount > 1;
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
                      if (groupedHold.tableName != null)
                        SpotstockSimpleChip(
                          label: groupedHold.tableName ?? '',
                          color: Theme.of(context).colorScheme.tableChip,
                          textColor: Theme.of(context).colorScheme.onTableChip,
                        ),
                      if (groupedHold.customerName != null)
                        SpotstockSimpleChip(
                          label: groupedHold.customerName ?? '',
                          color: Theme.of(context).colorScheme.customerChip,
                          textColor: Theme.of(context).colorScheme.onCustomerChip,
                        ),
                      if (groupedHold.attendantName != null)
                        SpotstockSimpleChip(
                          label: groupedHold.attendantName ?? '',
                          color: Theme.of(context).colorScheme.attendantChip,
                          textColor: Theme.of(context).colorScheme.onAttendantChip,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    NairaSymbol(),
                    Text(
                      groupedHold.grandTotal.toMoney(),
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
            Row(
              children: [
                Text('${groupedHold.holdCount} ${isCountMoreThanOne ? SpotstockStrings.holds : SpotstockStrings.holdSmallLetter}'),
                const SizedBox(width: SpotstockSizes.s4),
                Text('•'),
                const SizedBox(width: SpotstockSizes.s4),
                Text('${groupedHold.totalHoldItemsCount} ${isItemsCountMoreThanOne ? SpotstockStrings.items : SpotstockStrings.itemSmallLetter}'),
              ],
            ),
            const SizedBox(height: SpotstockSizes.s8),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    groupedHold.groupedHoldReferenceNo ?? '',
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
                Text(groupedHold.date?.toFormattedDate() ?? ''),
                if (groupedHold.hasUnsyncedHold == true) ...[
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
