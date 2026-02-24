import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/presentation/colors/color_scheme_extension.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockDialogWarningBanner extends StatelessWidget {
  final String message;
  const SpotstockDialogWarningBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SpotstockSizes.s8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.error),
        borderRadius: BorderRadius.circular(SpotstockSizes.s4),
        color: Theme.of(context).colorScheme.error.withAlpha((SpotstockSizes.s0_1 * SpotstockSizes.s255).toInt()),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning,
            size: SpotstockSizes.s20,
            color: Theme.of(context).colorScheme.warning,
          ),
          const SizedBox(width: SpotstockSizes.s8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          )
        ],
      ),
    );
  }
}
