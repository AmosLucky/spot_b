import 'package:flutter/material.dart';

/// Custom reusable button widget
class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double? height;
  final double? width;

  const CustomButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.color,
      required this.onTap,
      this.height = 50,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10), // Set the border radius
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min, // Adjust Row width to its children
            mainAxisAlignment:
                MainAxisAlignment.center, // Center items horizontally
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 8), // Add spacing between text and icon
              Icon(
                icon,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
