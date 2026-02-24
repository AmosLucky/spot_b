import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';

const int borderAlpha = 102;

class SpotstockSecondaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final bool? enabled;

  const SpotstockSecondaryButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderColor,
    this.textColor,
    this.height = SpotstockSizes.s54,
    this.width = double.infinity,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled ?? true;
    final effectiveBorderColor = isEnabled
        ? borderColor ?? Theme.of(context).colorScheme.primary
        : borderColor?.withAlpha(borderAlpha);
    final effectiveTextColor = isEnabled
        ? textColor ?? Theme.of(context).colorScheme.primary
        : textColor?.withAlpha(borderAlpha);

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveTextColor,
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: effectiveBorderColor ?? Theme.of(context).colorScheme.primary,
            width: SpotstockSizes.s1_5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SpotstockSizes.s5),
          ),
        ),
        child: child,
      ),
    );
  }
}
