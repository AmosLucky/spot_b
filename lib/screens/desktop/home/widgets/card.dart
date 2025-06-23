import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/widgets/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String value;

  const HomeCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate dynamic sizes based on card constraints
        final double cardWidth = constraints.maxWidth;
        final double iconSize = cardWidth * 0.15; // 15% of card width
        final double fontSizeTitle = cardWidth * 0.08; // 8% of card width
        final double fontSizeValue = cardWidth * 0.12; // 12% of card width
        final double spacing = cardWidth * 0.05; // 5% of card width for spacing

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: primaryColor,
          child: Padding(
            padding: EdgeInsets.all(cardWidth * 0.05), // Dynamic padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: Material(
                        elevation: 10,
                        shadowColor: Colors.black45,
                        borderRadius: BorderRadius.circular(iconSize / 2),
                        child: CircleAvatar(
                          radius: iconSize / 2,
                          backgroundColor: secondaryColor,
                          child: Center(
                            child: Icon(
                              MdiIcons.syncCircle,
                              color: Colors.white,
                              size: iconSize * 0.6, // 60% of icon container size
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spacing),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: fontSizeTitle.clamp(12, 16), // Min 12, max 16
                          overflow: TextOverflow.ellipsis, // Prevent text overflow
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing),
                DottedLine(
                  height: 2.0,
                  color: secondaryColor,
                ),
                SizedBox(height: spacing * 0.5),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeValue.clamp(18, 24), // Min 18, max 24
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

//   const HomeCard({super.key, required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     Size hquery = MediaQuery.of(context).size;

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//       color: primaryColor, // Background color of the card
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(children: [
//               SizedBox(
//                   height: 38,
//                   width: 38,
//                   child: Material(
//                       elevation: 10,
//                       shadowColor: Colors.black45,
//                       borderRadius: BorderRadius.circular(30.0),
//                       child: CircleAvatar(
//                           radius: 30,
//                           backgroundColor: secondaryColor,
//                           child: Center(
//                             child: IconButton(
//                               icon: Icon(
//                                 MdiIcons.syncCircle,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {},
//                             ),
//                           )))),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(title,
//                   style: const TextStyle(color: Colors.grey, fontSize: 16))
//             ]),
//             SizedBox(height: hquery.height * 0.05),
//             DottedLine(
//               height: 2.0, // Thickness of the dotted line
//               color: secondaryColor, // Color of the dotted line
//             ),
//             SizedBox(height: hquery.height * 0.02),
//             Text(value,
//                 overflow: TextOverflow.fade,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }
// }
