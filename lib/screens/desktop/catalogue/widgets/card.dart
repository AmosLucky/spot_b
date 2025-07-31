import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Color? color;
  final VoidCallback? onViewPressed;

  const HomeCard({
    Key? key,
    required this.title,
    required this.value,
    this.subtitle,
    this.color,
    this.onViewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: color != null
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color!.withOpacity(0.1),
                    color!.withOpacity(0.05),
                  ],
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (color != null)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.black87,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (onViewPressed != null) ...[
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: onViewPressed,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    backgroundColor: (color ?? Colors.blue).withOpacity(0.1),
                    foregroundColor: color ?? Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}






// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/widgets/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class HomeCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final VoidCallback? onViewPressed; // Callback for View button

//   const HomeCard({
//     super.key,
//     required this.title,
//     required this.value,
//     this.onViewPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Calculate dynamic sizes based on card constraints
//         final double cardWidth = constraints.maxWidth;
//         final double iconSize = cardWidth * 0.15; // 15% of card width
//         final double fontSizeTitle = cardWidth * 0.08; // 8% of card width
//         final double fontSizeValue = cardWidth * 0.12; // 12% of card width
//         final double spacing = cardWidth * 0.05; // 5% of card width for spacing

//         return Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//           color: primaryColor,
//           child: Padding(
//             padding: EdgeInsets.all(cardWidth * 0.05), // Dynamic padding
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     SizedBox(
//                       height: iconSize,
//                       width: iconSize,
//                       child: Material(
//                         elevation: 10,
//                         shadowColor: Colors.black45,
//                         borderRadius: BorderRadius.circular(iconSize / 2),
//                         child: CircleAvatar(
//                           radius: iconSize / 2,
//                           backgroundColor: secondaryColor,
//                           child: Center(
//                             child: Icon(
//                               MdiIcons.syncCircle,
//                               color: Colors.white,
//                               size: iconSize * 0.6, // 60% of icon container size
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: spacing),
//                     Expanded(
//                       child: Text(
//                         title,
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: fontSizeTitle.clamp(12, 16), // Min 12, max 16
//                           overflow: TextOverflow.ellipsis, // Prevent text overflow
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: spacing),
//                 DottedLine(
//                   height: 2.0,
//                   color: secondaryColor,
//                 ),
//                 SizedBox(height: spacing * 0.5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       value,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: fontSizeValue.clamp(18, 24), // Min 18, max 24
//                         fontWeight: FontWeight.bold,
//                         overflow: TextOverflow.ellipsis, // Prevent text overflow
//                       ),
//                     ),
//                     if (title == "Out of stock" && onViewPressed != null)
//                       TextButton(
//                         onPressed: onViewPressed,
//                         child: Text(
//                           "View",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: fontSizeTitle.clamp(12, 16),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }