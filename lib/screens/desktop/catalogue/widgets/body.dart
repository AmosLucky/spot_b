import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
import 'card.dart';
import 'header.dart';
import '../../../../widgets/sidebar.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final String app;
  const Body({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.app,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ValueNotifier<String> _activeItem = ValueNotifier<String>("Catalogues");

  @override
  void dispose() {
    _activeItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate dynamic crossAxisCount based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = (screenWidth / 300).floor().clamp(2, 4); // Min 2, max 4 cards per row

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: SizedBox(
                width: 250,
                child: widget.app == "HOTEL"
                    ? SideBarHotel(
                        vertical: 20,
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                      )
                    : SideBarInventory(
                        vertical: 20,
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                        activeItem: _activeItem,
                      ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    user: widget.user,
                    systemProvider: widget.systemProvider,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView(
                      shrinkWrap: true, // Prevent GridView from taking full height
                      // physics: const NeverScrollableScrollView(), // Disable GridView scrolling
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300, // Maximum width of each card
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: screenWidth > 1200 ? 1.5 : 1.3, // Adjust aspect ratio for smaller screens
                      ),
                      children: [
                        HomeCard(
                            title: "Products",
                            value: "${widget.systemProvider.dashboardStats['productCount'] ?? '0'}"),
                        HomeCard(
                            title: "In Stock",
                            value: "${widget.systemProvider.dashboardStats['productStockOut'] ?? '0'}"),
                        HomeCard(
                            title: "Out of stock",
                            value: "${widget.systemProvider.dashboardStats['productsOutOfStock'] ?? '0'}"),
                        HomeCard(
                            title: "Categories",
                            value: "${widget.systemProvider.dashboardStats['categoryCount'] ?? '0'}"),
                        HomeCard(
                            title: "Customers",
                            value: "${widget.systemProvider.dashboardStats['customerCount'] ?? '0'}"),
                        HomeCard(
                            title: "Hotel Categories",
                            value: "${widget.systemProvider.dashboardStats['hotelCategoryCount'] ?? '0'}"),
                        HomeCard(
                            title: "Hotel Amenities",
                            value: "${widget.systemProvider.dashboardStats['hotelAmenityCount'] ?? '0'}"),
                        HomeCard(
                            title: "Hotel Rooms",
                            value: "${widget.systemProvider.dashboardStats['hotelRoomCount'] ?? '0'}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}







// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
// // import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
// import 'card.dart';
// import 'header.dart';
// import '../../../../widgets/sidebar.dart';

// class Body extends StatefulWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final String app;
//   const Body({
//     super.key,
//     required this.user,
//     required this.systemProvider,
//     required this.app,
//   });

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final ValueNotifier<String> _activeItem = ValueNotifier<String>("Catalogues");

//   @override
//   void dispose() {
//     _activeItem.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxHeight: MediaQuery.of(context).size.height,
//                   ),
//                   child: SizedBox(
//                     width: 250,
//                     child: widget.app == "HOTEL"
//                         ? SideBarHotel(
//                             vertical: 20,
//                             user: widget.user,
//                             systemProvider: widget.systemProvider,
//                           )
//                         : SideBarInventory(
//                             vertical: 20,
//                             user: widget.user,
//                             systemProvider: widget.systemProvider,
//                             activeItem: _activeItem,
//                           ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Header(
//                         user: widget.user,
//                         systemProvider: widget.systemProvider,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.height,
//                           child: GridView(
//                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 4,
//                               crossAxisSpacing: 16,
//                               mainAxisSpacing: 16,
//                               childAspectRatio: 1.5,
//                             ),
//                             children: [
//                               HomeCard(
//                                   title: "Products",
//                                   value: "${widget.systemProvider.dashboardStats['productCount'] ?? '0'}"),
//                               HomeCard(
//                                   title: "In Stock",
//                                   value: "${widget.systemProvider.dashboardStats['productStockOut'] ?? '0'}"),
//                               HomeCard(
//                                   title: "Out of stock",
//                                   value: "${widget.systemProvider.dashboardStats['productsOutOfStock'] ?? '0'}"),
//                               HomeCard(
//                                   title: "Categories",
//                                   value: "${widget.systemProvider.dashboardStats['categoryCount'] ?? '0'}"),
//                               HomeCard(
//                                   title: "Customers",
//                                   value: "${widget.systemProvider.dashboardStats['customerCount'] ?? '0'}"),
//                               HomeCard(
//                                   title: "Hotel Categories",
//                                   value: "${widget.systemProvider.dashboardStats['hotelCategoryCount'] ?? '0'}"),
//                               HomeCard(
//                                   title: "Hotel Amenities",
//                                   value: "${widget.systemProvider.dashboardStats['hotelAmenityCount'] ?? '0'}"),
//                               HomeCard(
//                                   title: "Hotel Rooms",
//                                   value: "${widget.systemProvider.dashboardStats['hotelRoomCount'] ?? '0'}"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }