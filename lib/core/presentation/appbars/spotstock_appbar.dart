import 'package:flutter/material.dart';

import '../../constants/colors/spotstock_colors.dart';
import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockAppbar extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const SpotstockAppbar({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: SpotstockColors.c4D2B5B),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: SpotstockSizes.topSpacing(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: SpotstockSizes.s20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing ?? const SizedBox.shrink(),
              ],
            ),
            SizedBox(height: SpotstockSizes.s8),
          ],
        ),
      ),
    );
  }
}
