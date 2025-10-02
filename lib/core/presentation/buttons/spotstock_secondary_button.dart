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
    this.borderColor = Colors.deepPurple,
    this.textColor = Colors.deepPurple,
    this.height = SpotstockSizes.s54,
    this.width = double.infinity,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled ?? true;
    final effectiveBorderColor = isEnabled ? borderColor! : borderColor!.withAlpha(borderAlpha);
    final effectiveTextColor = isEnabled ? textColor! : textColor!.withAlpha(borderAlpha);

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveTextColor,
          backgroundColor: Colors.transparent,
          side: BorderSide(color: effectiveBorderColor, width: SpotstockSizes.s1_5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SpotstockSizes.s5),
          ),
        ),
        child: child,
      ),
    );
  }
}
