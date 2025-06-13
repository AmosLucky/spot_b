import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Enhanced Custom reusable button widget with better touch support
class CustomButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final bool isLoading;
  final bool enabled;

  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.height = 50,
    this.width,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) {
        setState(() => _isPressed = true);
        // Add haptic feedback for touch devices
        HapticFeedback.lightImpact();
      } : null,
      onTapUp: widget.enabled ? (_) {
        setState(() => _isPressed = false);
      } : null,
      onTapCancel: widget.enabled ? () {
        setState(() => _isPressed = false);
      } : null,
      onTap: widget.enabled && !widget.isLoading ? widget.onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: widget.height,
        width: widget.width,
        // Ensure minimum touch target size (44x44 logical pixels)
        constraints: const BoxConstraints(
          minHeight: 44,
          minWidth: 44,
        ),
        decoration: BoxDecoration(
          color: widget.enabled 
            ? (_isPressed 
              ? widget.color.withOpacity(0.8) 
              : widget.color)
            : widget.color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isPressed ? [] : [
            BoxShadow(
              color: widget.color.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Center(
          child: widget.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.enabled ? Colors.white : Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    widget.icon,
                    color: widget.enabled ? Colors.white : Colors.white70,
                    size: 20,
                  ),
                ],
              ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';

// /// Custom reusable button widget
// class CustomButton extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;
//   final double? height;
//   final double? width;

//   const CustomButton(
//       {super.key,
//       required this.label,
//       required this.icon,
//       required this.color,
//       required this.onTap,
//       this.height = 50,
//       this.width});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(10), // Set the border radius
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//         child: Center(
//           child: Row(
//             mainAxisSize: MainAxisSize.min, // Adjust Row width to its children
//             mainAxisAlignment:
//                 MainAxisAlignment.center, // Center items horizontally
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const SizedBox(width: 8), // Add spacing between text and icon
//               Icon(
//                 icon,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }