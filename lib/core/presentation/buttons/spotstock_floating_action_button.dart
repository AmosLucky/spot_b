import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockFloatingActionButton extends StatelessWidget {
  final Widget icon;
  final String? label;
  final VoidCallback? onPressed;

  const SpotstockFloatingActionButton({
    super.key,
    required this.icon,
    this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(SpotstockSizes.s5),
    );

    return label == null
        ? FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: buttonShape,
            elevation: SpotstockSizes.s2,
            child: icon,
          )
        : FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: buttonShape,
            elevation: SpotstockSizes.s2,
            icon: icon,
            label: Text(label!, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          );
  }
}
