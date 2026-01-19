import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/chips/spotstock_simple_chip.dart';
import '../../../../core/presentation/colors/color_scheme_extension.dart';
import '../../../../core/presentation/dates/datetime_extension.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../data/models/register.dart';

class SpotstockRegisterWidget extends StatelessWidget {
  final Register register;
  final Function(Register register)? onRegisterSelected;
  const SpotstockRegisterWidget({super.key, required this.register, this.onRegisterSelected});

  String getRegisterShift() {
    final createdAt = register.createdAt;
    if (createdAt == null) {
      return SpotstockStrings.na;
    }

    final hour = createdAt.hour;
    final minute = createdAt.minute;

    final isDayShift = (hour > 7 || (hour == 7 && minute >= 0)) && (hour < 15 || (hour == 15 && minute < 30));

    return isDayShift ? SpotstockStrings.dayShift : SpotstockStrings.nightShift;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onRegisterSelected?.call(register);
      },
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${SpotstockStrings.hashtagPos} ${register.isClosed == true ? register.id : SpotstockStrings.na}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SpotstockSizes.s16,
                            ),
                          ),
                          Text(
                            getRegisterShift(),
                            style: TextStyle(
                              fontSize: SpotstockSizes.s12,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                      SpotstockSimpleChip(
                        label: register.user?.firstName ?? SpotstockStrings.na,
                        color: Theme.of(context).colorScheme.attendantChip,
                        textColor: Theme.of(context).colorScheme.onAttendantChip,
                      ),
                    ],
                  ),
                ),
                SpotstockSimpleChip(
                  label: register.isClosed == true ? SpotstockStrings.closed : SpotstockStrings.open,
                  color: register.isClosed == true ? Theme.of(context).colorScheme.closedChip : Theme.of(context).colorScheme.openChip,
                  textColor: register.isClosed == true ? Theme.of(context).colorScheme.onClosedChip : Theme.of(context).colorScheme.onOpenChip,
                ),
              ],
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: SpotstockSizes.s5.toInt(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${SpotstockStrings.opened}: ${register.createdAt?.toLocal().toRealDateWithTime() ?? SpotstockStrings.na}',
                      ),
                      const SizedBox(height: SpotstockSizes.s4),
                      Text(
                        '${SpotstockStrings.closed}: ${register.closedAt?.toLocal().toRealDateWithTime() ?? SpotstockStrings.na}',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: SpotstockSizes.s2.toInt(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        SpotstockStrings.cashAtHand,
                        style: TextStyle(
                          fontSize: SpotstockSizes.s12,
                          color: Theme.of(context).colorScheme.cashAtHand,
                        ),
                      ),
                      const SizedBox(height: SpotstockSizes.s4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          NairaSymbol(
                            size: SpotstockSizes.s12,
                            color: Theme.of(context).colorScheme.cashAtHand,
                          ),
                          Text(
                            '${register.openingCashAtHand ?? SpotstockStrings.zero_00}',
                            style: TextStyle(
                              fontSize: SpotstockSizes.s12,
                              color: Theme.of(context).colorScheme.cashAtHand,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
