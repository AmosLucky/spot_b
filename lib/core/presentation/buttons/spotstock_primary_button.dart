import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockPrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final bool? enabled;

  const SpotstockPrimaryButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color = Colors.deepPurple,
    this.textColor = Colors.white,
    this.height = SpotstockSizes.s54,
    this.width = double.infinity,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled ?? true;
    final disabledColor = color?.withAlpha(87);

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: isEnabled ? color : disabledColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SpotstockSizes.s5)),
          side: BorderSide.none,
        ),
        child: child,
      ),
    );
  }
}
