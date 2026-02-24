import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';

class SpotstockSummaryItem extends StatelessWidget {
  final Widget child;
  const SpotstockSummaryItem({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SpotstockSizes.s8),
      margin: EdgeInsets.only(bottom: SpotstockSizes.s8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(SpotstockSizes.s8),
      ),
      child: child,
    );
  }
}
