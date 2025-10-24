import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';

const int appWidgetColorAlpha = 102;

class SpotstockAppWidget extends StatelessWidget {
  final String name;
  final String iconPath;
  final VoidCallback onTap;
  const SpotstockAppWidget({
    super.key,
    required this.name,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * SpotstockSizes.s0_3,
            height: MediaQuery.of(context).size.width * SpotstockSizes.s0_3,
            padding: EdgeInsets.all(SpotstockSizes.s20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withAlpha(appWidgetColorAlpha),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: SpotstockSizes.s2,
              ),
            ),
            child: SvgPicture.asset(
              iconPath,
              width: MediaQuery.of(context).size.width * SpotstockSizes.s0_1,
              height: MediaQuery.of(context).size.width * SpotstockSizes.s0_1,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: SpotstockSizes.s10),
          Text(name),
        ],
      ),
    );
  }
}
