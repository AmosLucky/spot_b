import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final int? status; // Nullable for cases like "All"
  final double size;
  final String name;

  const StatusIndicator({
    super.key,
    this.status,
    this.size = 16.0,
    required this.name, // Default size
  });

  Color getStatusColor(int? status) {
    switch (status) {
      case 1:
        return const Color(0xFF279B0A); // Available
      case 2:
        return const Color(0xFFE96D3A); // Checked In
      case 3:
        return const Color(0xFFDAA520); // Reserved
      case 4:
        return const Color(0xFFF62947); // Under Maintenance
      case 5:
        return const Color(0xFFFF679b);
      default:
        return const Color(0xFF279B0A); // Default to Available color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Colored box
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: getStatusColor(status),
            borderRadius: BorderRadius.circular(4),
          ),
          margin:
              const EdgeInsets.only(right: 5), // Margin between box and text
        ),
        // Text
        Text(
          name,
          style: const TextStyle(
              fontSize: 16, // Adjust size as needed
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
