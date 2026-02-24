import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';

const int borderAlpha = 25;
const int valueDecimals = 2;

class SpotstockDashboardCard extends StatelessWidget {
  final String title;
  final double value;
  final Widget icon;
  final Color? color;
  final Color? textColor;

  const SpotstockDashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SpotstockSizes.s16),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(SpotstockSizes.s10),
        border: Border.all(
          color: color ?? Theme.of(context).colorScheme.surfaceContainerLow.withAlpha(borderAlpha),
          width: SpotstockSizes.s1,
        ),
        boxShadow: [
          BoxShadow(
            color: color?.withAlpha(borderAlpha) ??
                Theme.of(context).colorScheme.surfaceContainerLow.withAlpha(borderAlpha),
            blurRadius: SpotstockSizes.s10,
            offset: Offset(0, SpotstockSizes.s10),
          ),
        ],
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: SpotstockSizes.s20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor ?? Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: SpotstockSizes.s5),
              Row(
                children: [
                  NairaSymbol(),
                  Text(
                    value.toStringAsFixed(valueDecimals),
                    style: TextStyle(
                      color: textColor ?? Theme.of(context).colorScheme.onSurface,
                      fontSize: SpotstockSizes.s16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
