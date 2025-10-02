import 'package:flutter/material.dart';

import '../../constants/durations/spotstock_durations.dart';
import '../../constants/strings/spotstock_strings.dart';
import '../buttons/spotstock_icon_button.dart';

mixin SpotstockBannerMixin {
  void showNetworkBanner(BuildContext context, bool isConnected) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    final banner = MaterialBanner(
      content: Text(isConnected ? SpotstockStrings.youAreOnline : SpotstockStrings.youAreOffline),
      leading: Icon(isConnected ? Icons.wifi : Icons.wifi_off),
      backgroundColor: isConnected ? Colors.green.shade100 : Colors.red.shade100,
      actions: [
        SpotstockIconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
        ),
      ],
    );
    ScaffoldMessenger.of(context).showMaterialBanner(banner);
    if (isConnected) {
      Future.delayed(
        SpotstockDurations.networkBannerDisplayTime,
        () {
          if (context.mounted) {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }
        },
      );
    }
  }
}
