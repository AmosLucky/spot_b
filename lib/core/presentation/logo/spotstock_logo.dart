import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets/spotstock_assets.dart';
import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const SpotstockLogo({
    super.key,
    this.width = SpotstockSizes.s100,
    this.height = SpotstockSizes.s60,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      SpotstockIconAssets.logo,
      width: width,
      height: height,
      colorFilter:
          ColorFilter.mode(color ?? Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
    );
  }
}
