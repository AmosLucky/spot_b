import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/presentation/buttons/spotstock_icon_button.dart';

import '../../constants/sizes/spotstock_sizes.dart';
import '../../constants/strings/spotstock_strings.dart';
import '../../routing/navigation.dart';

class SpotstockAppbar<T> extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Color? backgroundColor;
  final bool? withBackButton;
  final Future<T?> Function()? onBackPressed;
  const SpotstockAppbar({
    super.key,
    required this.title,
    this.trailing,
    this.backgroundColor,
    this.withBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor ?? Theme.of(context).colorScheme.primary),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: SpotstockSizes.topSpacing(context)),
            Row(
              children: [
                if (withBackButton == true) ...[
                  SpotstockIconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: SpotstockSizes.s18,
                    ),
                    onPressed: () async {
                      if (onBackPressed != null) {
                        await onBackPressed!();
                      } else {
                        SpotstockNavigation.goBack();
                      }
                    },
                    tooltip: SpotstockStrings.back,
                  ),
                  SizedBox(width: SpotstockSizes.s16),
                ],
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: SpotstockSizes.s18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      trailing ?? SizedBox(width: SpotstockSizes.s25, height: SpotstockSizes.s25),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SpotstockSizes.s8),
          ],
        ),
      ),
    );
  }
}
