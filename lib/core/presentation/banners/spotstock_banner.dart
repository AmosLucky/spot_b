import 'package:flutter/material.dart';
import '../../constants/durations/spotstock_durations.dart';
import '../../constants/sizes/spotstock_sizes.dart';
import '../../constants/strings/spotstock_strings.dart';
import '../buttons/spotstock_icon_button.dart';

mixin SpotstockBannerMixin {
  static OverlayEntry? _currentBannerEntry;

  void showNetworkBanner(BuildContext context, bool isConnected) {
    _currentBannerEntry?.remove();
    _currentBannerEntry = null;

    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: SpotstockSizes.topSpacing(context),
        left: SpotstockSizes.s8,
        right: SpotstockSizes.s8,
        child: Material(
          color: Colors.transparent,
          child: AnimatedSlide(
            offset: const Offset(0, 0),
            duration: SpotstockDurations.networkBannerAnimationDuration,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SpotstockSizes.s16,
                vertical: SpotstockSizes.s12,
              ),
              decoration: BoxDecoration(
                color: isConnected
                    ? ColorScheme.fromSeed(
                            seedColor: Colors.green, brightness: Theme.of(context).brightness)
                        .primaryContainer
                    : Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(SpotstockSizes.s8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: SpotstockSizes.s6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isConnected ? Icons.wifi : Icons.wifi_off,
                    color: isConnected
                        ? ColorScheme.fromSeed(
                                seedColor: Colors.green, brightness: Theme.of(context).brightness)
                            .onPrimaryContainer
                        : Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: SpotstockSizes.s8),
                  Expanded(
                    child: Text(
                      isConnected ? SpotstockStrings.youAreOnline : SpotstockStrings.youAreOffline,
                      style: TextStyle(
                        color: isConnected
                            ? ColorScheme.fromSeed(
                                    seedColor: Colors.green,
                                    brightness: Theme.of(context).brightness)
                                .onPrimaryContainer
                            : Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                  SpotstockIconButton(
                    icon: Icon(
                      Icons.close,
                      color: isConnected
                          ? ColorScheme.fromSeed(
                                  seedColor: Colors.green, brightness: Theme.of(context).brightness)
                              .onPrimaryContainer
                          : Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    onPressed: () {
                      overlayEntry.remove();
                      _currentBannerEntry = null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    _currentBannerEntry = overlayEntry;

    if (isConnected) {
      Future.delayed(SpotstockDurations.networkBannerDisplayTime, () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
          _currentBannerEntry = null;
        }
      });
    }
  }
}
