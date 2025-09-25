import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';
import '../../constants/strings/spotstock_strings.dart';
import '../../error_handling/app_error.dart';

mixin SpotstockSnackbarMixin {
  void showErrorSnackbar(BuildContext context, AppError? error, {String? title, String? subtitle}) {
    ScaffoldMessenger.of(context).showSnackBar(
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
}
