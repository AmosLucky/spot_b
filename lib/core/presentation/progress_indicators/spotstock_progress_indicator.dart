import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockProgressIndicator extends StatelessWidget {
  const SpotstockProgressIndicator({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? Theme.of(context).colorScheme.onPrimary,
      strokeWidth: SpotstockSizes.s2,
    );
  }
}
