import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;

  const DottedLine({
    super.key,
    this.height = 1.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height), // Takes full width of the parent
      painter: _DottedLinePainter(color: color, height: height),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final double height;
  final Color color;

  _DottedLinePainter({required this.height, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = height
      ..style = PaintingStyle.stroke;

    double dashWidth = 4.0;
    double dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      // Draw the dash (line segment)
      canvas.drawLine(
        Offset(startX, 0), // Start point
        Offset(startX + dashWidth, 0), // End point
        paint,
      );
      // Move the start position forward by dash width + dash space
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
