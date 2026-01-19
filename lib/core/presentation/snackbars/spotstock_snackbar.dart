import 'package:flutter/material.dart';

import '../../constants/keys/spotstock_app_keys.dart';
import '../../constants/sizes/spotstock_sizes.dart';
import '../../constants/strings/spotstock_strings.dart';
import '../../error_handling/app_error.dart';
import 'spotstock_snackbar_type.dart';

mixin SpotstockSnackbarMixin {
  void showErrorSnackbar(AppError? error, {String? title, String? subtitle}) {
    spotstockScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    spotstockScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(
          horizontal: SpotstockSizes.s20,
          vertical: SpotstockSizes.s27,
        ),
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.red.shade700,
              size: SpotstockSizes.s26,
            ),
            const SizedBox(width: SpotstockSizes.s13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title ?? error?.code ?? SpotstockStrings.EMPTY,
                    style: TextStyle(
                      fontSize: SpotstockSizes.s14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle ?? error?.message ?? SpotstockStrings.EMPTY,
                    style: TextStyle(
                      fontSize: SpotstockSizes.s10,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade100,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showSpotstockSnackbar({
    required SpotstockSnackbarType type,
    String? title,
    String? message,
  }) {
    spotstockScaffoldMessengerKey.currentState?.removeCurrentSnackBar();

    final config = _getConfig(type);

    spotstockScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(
          horizontal: SpotstockSizes.s20,
          vertical: SpotstockSizes.s27,
        ),
        content: Row(
          children: [
            Icon(
              config.icon,
              color: config.iconColor,
              size: SpotstockSizes.s26,
            ),
            const SizedBox(width: SpotstockSizes.s13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title ?? config.defaultTitle,
                    style: TextStyle(
                      fontSize: SpotstockSizes.s14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    message ?? config.defaultMessage,
                    style: TextStyle(
                      fontSize: SpotstockSizes.s10,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: config.backgroundColor,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  _SpotstockSnackbarConfig _getConfig(SpotstockSnackbarType type) {
    switch (type) {
      case SpotstockSnackbarType.error:
        return _SpotstockSnackbarConfig(
          icon: Icons.error,
          iconColor: Colors.red.shade700,
          backgroundColor: Colors.red.shade100,
          defaultTitle: SpotstockStrings.error,
          defaultMessage: SpotstockStrings.EMPTY,
        );
      case SpotstockSnackbarType.success:
        return _SpotstockSnackbarConfig(
          icon: Icons.check_circle,
          iconColor: Colors.green.shade700,
          backgroundColor: Colors.green.shade100,
          defaultTitle: SpotstockStrings.success,
          defaultMessage: SpotstockStrings.EMPTY,
        );
      case SpotstockSnackbarType.info:
        return _SpotstockSnackbarConfig(
          icon: Icons.info,
          iconColor: Colors.blue.shade700,
          backgroundColor: Colors.blue.shade100,
          defaultTitle: SpotstockStrings.info,
          defaultMessage: SpotstockStrings.EMPTY,
        );
      case SpotstockSnackbarType.warning:
        return _SpotstockSnackbarConfig(
          icon: Icons.warning,
          iconColor: Colors.orange.shade700,
          backgroundColor: Colors.orange.shade100,
          defaultTitle: SpotstockStrings.warning,
          defaultMessage: SpotstockStrings.EMPTY,
        );
    }
  }
}

class _SpotstockSnackbarConfig {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String defaultTitle;
  final String defaultMessage;

  _SpotstockSnackbarConfig({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.defaultTitle,
    required this.defaultMessage,
  });
}
