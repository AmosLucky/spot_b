import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';
import '../../constants/strings/spotstock_strings.dart';
import '../../routing/navigation.dart';
import '../buttons/spotstock_icon_button.dart';
import '../buttons/spotstock_primary_button.dart';

mixin SpotstockDialogMixin {
  Future<T?> showSpotstockInformationDialog<T>(
    BuildContext context, {
    Icon? icon,
    required String title,
    required String description,
    List<Widget>? actions,
    bool? isDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible ?? true,
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
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SpotstockSizes.s16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: SpotstockSizes.s10),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
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

  Future<T?> showSpotstockFormDialog<T>(
    BuildContext context, {
    required String title,
    required Widget form,
    List<Widget>? actions,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxDialogHeight = screenHeight - SpotstockSizes.s100; // leaves 50px margin top & bottom

    return showDialog<T>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: SpotstockSizes.s16,
          vertical: SpotstockSizes.s50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpotstockSizes.s8),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxDialogHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    SpotstockSizes.s16,
                    SpotstockSizes.s16,
                    SpotstockSizes.s16,
                    SpotstockSizes.s8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: SpotstockSizes.s16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      SpotstockIconButton(
                        icon: const Icon(Icons.close, size: SpotstockSizes.s18),
                        onPressed: () => SpotstockNavigation.goBack(context),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: SpotstockSizes.s0,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SpotstockSizes.s16,
                        SpotstockSizes.s8,
                        SpotstockSizes.s16,
                        SpotstockSizes.s16,
                      ),
                      child: form,
                    ),
                  ),
                ),
                if (actions != null) ...[
                  const Divider(height: SpotstockSizes.s0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      SpotstockSizes.s16,
                      SpotstockSizes.s8,
                      SpotstockSizes.s16,
                      SpotstockSizes.s16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: actions,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
