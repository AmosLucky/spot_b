import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/widgets/custom_widgets.dart';

class RegisterTile extends StatelessWidget {
  final double openingAmt;
  final double closingAmt;
  final DateTime createdAt;
  final bool isClosed;
  final VoidCallback onView;
  final VoidCallback onClose;

  const RegisterTile({
    super.key,
    required this.openingAmt,
    required this.closingAmt,
    required this.createdAt,
    required this.isClosed,
    required this.onView,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tileWidth = constraints.maxWidth;
        final double fontSize = (tileWidth * 0.035).clamp(10, 12); // Dynamic font size
        final double padding = tileWidth * 0.02; // Dynamic padding

        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: (tileWidth * 0.025).clamp(6, 8),
                      height: (tileWidth * 0.025).clamp(6, 8),
                      margin: EdgeInsets.only(right: padding),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isClosed ? Colors.green : Colors.red,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: tileWidth * 0.55), // Limit text width
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            searchDate(createdAt.toLocal()),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: fontSize * 1.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: padding * 0.5),
                          Text(
                            'Opening: ${Money.format(openingAmt)}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (isClosed)
                            Text(
                              'Closing: ${Money.format(closingAmt)}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: fontSize,
                                color: secondaryColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: onView,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        padding: EdgeInsets.zero,
                        minimumSize: Size((tileWidth * 0.1).clamp(30, 40), 30),
                      ),
                      child: Text(
                        'View',
                        style: TextStyle(
                          fontSize: fontSize * 0.9,
                        ),
                      ),
                    ),
                    SizedBox(width: padding),
                    if (!isClosed)
                      TextButton(
                        onPressed: onClose,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          padding: EdgeInsets.zero,
                          minimumSize: Size((tileWidth * 0.1).clamp(30, 40), 30),
                        ),
                        child: Text(
                          'Close',
                          style: TextStyle(
                            fontSize: fontSize * 0.9,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/widgets/custom_widgets.dart';

// class RegisterTile extends StatelessWidget {
//   final double openingAmt;
//   final double closingAmt;
//   final DateTime createdAt;
//   final bool isClosed;
//   final VoidCallback onView;
//   final VoidCallback onClose;

//   const RegisterTile({
//     super.key,
//     required this.openingAmt,
//     required this.closingAmt,
//     required this.createdAt,
//     required this.isClosed,
//     required this.onView,
//     required this.onClose,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Status Indicator + Date
//             Row(
//               children: [
//                 Container(
//                   width: 10,
//                   height: 10,
//                   margin: const EdgeInsets.only(right: 8),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: isClosed ? Colors.green : Colors.red,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       searchDate(createdAt.toLocal()),
//                       style: const TextStyle(
//                           fontSize: 14, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       'Opening: ${Money.format(openingAmt)}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           color: blackColor,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     if (isClosed)
//                       Text(
//                         'Closing: ${Money.format(closingAmt)}',
//                         style: TextStyle(fontSize: 12, color: secondaryColor),
//                       ),
//                   ],
//                 ),
//               ],
//             ),

//             // Actions
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: onView,
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.blue,
//                     padding: EdgeInsets.zero,
//                     minimumSize: const Size(50, 30),
//                   ),
//                   child: const Text('View'),
//                 ),
//                 const SizedBox(width: 10), // Space between buttons
//                 if (!isClosed)
//                   TextButton(
//                     onPressed: onClose,
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.red,
//                       padding: EdgeInsets.zero,
//                       minimumSize: const Size(50, 30),
//                     ),
//                     child: const Text('Close'),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }