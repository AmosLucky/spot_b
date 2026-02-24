import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Color? color;
  const SpotstockIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconButton = SizedBox(
      width: SpotstockSizes.s25,
      height: SpotstockSizes.s25,
      child: Material(
        shape: CircleBorder(),
        color: Colors.transparent,
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: icon,
          ),
        ),
      ),
    );

    return tooltip != null ? Tooltip(message: tooltip!, child: iconButton) : iconButton;
  }
}
