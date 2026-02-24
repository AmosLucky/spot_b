import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets/spotstock_assets.dart';
import '../../constants/sizes/spotstock_sizes.dart';

class NairaSymbol extends StatelessWidget {
  final double? size;
  final Color? color;
  const NairaSymbol({super.key, this.size = SpotstockSizes.s16, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SpotstockSizes.s2),
      child: SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(
          SpotstockIconAssets.nairaSymbol,
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(
            color ?? Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
