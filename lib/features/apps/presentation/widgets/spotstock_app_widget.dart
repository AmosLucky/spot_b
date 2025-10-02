import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';

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
            padding: EdgeInsets.all(SpotstockSizes.s2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: SvgPicture.asset(
                iconPath,
                width: MediaQuery.of(context).size.width * SpotstockSizes.s0_3,
                height: MediaQuery.of(context).size.width * SpotstockSizes.s0_3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: SpotstockSizes.s10),
          Text(name),
        ],
      ),
    );
  }
}
