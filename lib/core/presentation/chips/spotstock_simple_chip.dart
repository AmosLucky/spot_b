import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockSimpleChip extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;
  const SpotstockSimpleChip({
    super.key,
    required this.label,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s8, vertical: SpotstockSizes.s4),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(SpotstockSizes.s1000),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: SpotstockSizes.s11,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
