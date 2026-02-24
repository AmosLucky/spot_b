import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockFloatingActionButton extends StatelessWidget {
  final Widget icon;
  final String? label;
  final VoidCallback? onPressed;
  final bool? enabled;

  const SpotstockFloatingActionButton({
    super.key,
    required this.icon,
    this.label,
    this.onPressed,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SpotstockSizes.s5),
    );

    final buttonColor = enabled == false ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary;

    return label == null
        ? FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: buttonColor,
            shape: buttonShape,
            elevation: SpotstockSizes.s2,
            child: icon,
          )
        : FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: buttonColor,
            shape: buttonShape,
            elevation: SpotstockSizes.s2,
            icon: icon,
            label: Text(label!, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          );
  }
}
