import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Enhanced Custom reusable button widget with better touch support and clickability
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
  bool _isHovered = false;

  void _handleTap() {
    if (widget.enabled && !widget.isLoading) {
      // Add haptic feedback
      HapticFeedback.lightImpact();
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTapDown: widget.enabled ? (_) {
          setState(() => _isPressed = true);
          HapticFeedback.lightImpact();
        } : null,
        onTapUp: widget.enabled ? (_) {
          setState(() => _isPressed = false);
        } : null,
        onTapCancel: widget.enabled ? () {
          setState(() => _isPressed = false);
        } : null,
        onTap: _handleTap,
        // Additional touch handling for better compatibility
        child: InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(10),
          // Ensure the InkWell responds to taps
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: widget.height,
            width: widget.width,
            // Ensure minimum touch target size (48x48 logical pixels for better accessibility)
            constraints: const BoxConstraints(
              minHeight: 48,
              minWidth: 48,
            ),
            decoration: BoxDecoration(
              color: widget.enabled 
                ? (_isPressed 
                  ? widget.color.withOpacity(0.8) 
                  : _isHovered 
                    ? widget.color.withOpacity(0.9)
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
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
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// /// Enhanced Custom reusable button widget with better touch support
// class CustomButton extends StatefulWidget {
//   final String label;
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;
//   final double? height;
//   final double? width;
//   final bool isLoading;
//   final bool enabled;

//   const CustomButton({
//     super.key,
//     required this.label,
//     required this.icon,
//     required this.color,
//     required this.onTap,
//     this.height = 50,
//     this.width,
//     this.isLoading = false,
//     this.enabled = true,
//   });

//   @override
//   State<CustomButton> createState() => _CustomButtonState();
// }

// class _CustomButtonState extends State<CustomButton> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: widget.enabled ? (_) {
//         setState(() => _isPressed = true);
//         // Add haptic feedback for touch devices
//         HapticFeedback.lightImpact();
//       } : null,
//       onTapUp: widget.enabled ? (_) {
//         setState(() => _isPressed = false);
//       } : null,
//       onTapCancel: widget.enabled ? () {
//         setState(() => _isPressed = false);
//       } : null,
//       onTap: widget.enabled && !widget.isLoading ? widget.onTap : null,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         height: widget.height,
//         width: widget.width,
//         // Ensure minimum touch target size (44x44 logical pixels)
//         constraints: const BoxConstraints(
//           minHeight: 44,
//           minWidth: 44,
//         ),
//         decoration: BoxDecoration(
//           color: widget.enabled 
//             ? (_isPressed 
//               ? widget.color.withOpacity(0.8) 
//               : widget.color)
//             : widget.color.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: _isPressed ? [] : [
//             BoxShadow(
//               color: widget.color.withOpacity(0.3),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//         child: Center(
//           child: widget.isLoading
//             ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//             : Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     widget.label,
//                     style: TextStyle(
//                       color: widget.enabled ? Colors.white : Colors.white70,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Icon(
//                     widget.icon,
//                     color: widget.enabled ? Colors.white : Colors.white70,
//                     size: 20,
//                   ),
//                 ],
//               ),
//         ),
//       ),
//     );
//   }
// }