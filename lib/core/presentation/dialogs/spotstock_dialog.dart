import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';
import '../../constants/strings/spotstock_strings.dart';
import '../../routing/navigation.dart';
import '../buttons/spotstock_primary_button.dart';

mixin SpotstockDialogMixin {
  void showSpotstockDialog(
    BuildContext context, {
    Icon? icon,
    required String title,
    required String description,
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SpotstockSizes.s8)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            SpotstockSizes.s16,
            SpotstockSizes.s24,
            SpotstockSizes.s16,
            SpotstockSizes.s24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? SizedBox.shrink(),
              const SizedBox(height: SpotstockSizes.s8),
              Text(
                title,
                style: TextStyle(fontSize: SpotstockSizes.s16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: SpotstockSizes.s10),
              Text(description),
              const SizedBox(height: SpotstockSizes.s16),
              ...actions ?? [],
              if (actions == null)
                SpotstockPrimaryButton(
                  child: Text(
                    SpotstockStrings.ok,
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  onPressed: () {
                    SpotstockNavigation.goBack(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
