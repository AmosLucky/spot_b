import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Alignment gradientStart;
  final Alignment gradientEnd;
  final Widget body;
  final List<Color> gradientColors;

  const GradientBackground({
    Key? key,
    required this.body,
    required this.width,
    required this.height,
    this.borderRadius = 0.0,
    this.gradientStart = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.gradientColors = const [
      Color(0xFFF2FCFE),
      Color(0xFFFAF1FE),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: gradientStart,
          end: gradientEnd,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: body,
    );
  }
}
