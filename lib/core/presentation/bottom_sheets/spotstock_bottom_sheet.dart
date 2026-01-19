import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';
import '../../routing/navigation.dart';
import '../buttons/spotstock_icon_button.dart';

mixin SpotstockBottomSheetMixin {
  /// [body] should be a column of widgets
  Future<T?> showSpotstockBottomSheet<T>(
    BuildContext context, {
    Widget? header,
    Widget? body,
    List<Widget>? actions,
  }) async {
    double maxBottomSheetHeight = SpotstockSizes.s0_8;
    if (actions != null && actions.isNotEmpty) {
      maxBottomSheetHeight = SpotstockSizes.s0_8;
    } else {
      maxBottomSheetHeight = SpotstockSizes.s0_7;
    }

    return showModalBottomSheet<T>(
      context: SpotstockNavigation.context ?? context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SpotstockSizes.s8)),
      builder: (sheetContext) {
        final screenHeight = MediaQuery.of(SpotstockNavigation.context ?? context).size.height;
        final sheetHeight = screenHeight * maxBottomSheetHeight;
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: SpotstockSizes.bottomSpacing(SpotstockNavigation.context ?? context),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: sheetHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16, vertical: SpotstockSizes.s16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SpotstockIconButton(
                          icon: Icon(Icons.close, size: SpotstockSizes.s18),
                          onPressed: () {
                            SpotstockNavigation.goBack(sheetContext);
                          },
                        ),
                      ],
                    ),
                  ),
                  header ?? SizedBox.shrink(),
                  header != null ? const Divider(height: SpotstockSizes.s0) : SizedBox.shrink(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (body != null) const SizedBox(height: SpotstockSizes.s8),
                            body ?? SizedBox.shrink(),
                            if (actions != null) const SizedBox(height: SpotstockSizes.s8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (actions != null) const Divider(height: SpotstockSizes.s0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                    child: Column(
                      children: actions ?? [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
