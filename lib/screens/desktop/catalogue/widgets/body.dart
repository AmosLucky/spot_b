import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/product_detail.dart';
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

  void _showOutOfStockProducts() async {
    final products = await widget.systemProvider.getProducts(0);
    final outOfStockProducts = products
        .where((product) => product['attributes']['stock']['quantity'] == 0)
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Out of Stock Products",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: outOfStockProducts.isEmpty
                  ? const Center(child: Text("No out-of-stock products found"))
                  : GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16.0),
                      itemCount: outOfStockProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (context, index) {
                        var product = outOfStockProducts[index]['attributes'];
                        return ProductDetails(product: product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build store-specific cards
  List<Widget> _buildStoreCards() {
    return [
      HomeCard(
          title: "Products",
          value: "${widget.systemProvider.dashboardStats['productCount'] ?? '0'}"),
      HomeCard(
          title: "In Stock",
          value: "${widget.systemProvider.dashboardStats['productStockOut'] ?? '0'}"),
      HomeCard(
          title: "Out of stock",
          value: "${widget.systemProvider.dashboardStats['productsOutOfStock'] ?? '0'}",
          onViewPressed: _showOutOfStockProducts),
      HomeCard(
          title: "Categories",
          value: "${widget.systemProvider.dashboardStats['categoryCount'] ?? '0'}"),
    ];
  }

  // Method to build hotel-specific cards
  List<Widget> _buildHotelCards() {
    return [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    // Determine which cards to show based on user access permissions
    List<Widget> cardsToShow = [];
    
    if (widget.user.isSuperAdmin) {
      // Super admin sees all cards
      cardsToShow = [..._buildStoreCards(), ..._buildHotelCards()];
    } else if (widget.user.canAccessHotel && widget.user.canAccessStore) {
      // User has access to both hotel and store
      cardsToShow = [..._buildStoreCards(), ..._buildHotelCards()];
    } else if (widget.user.canAccessHotel) {
      // Hotel-only access
      cardsToShow = _buildHotelCards();
    } else if (widget.user.canAccessStore) {
      // Store-only access
      cardsToShow = _buildStoreCards();
    } else {
      // Fallback - show store cards for basic users
      cardsToShow = _buildStoreCards();
    }

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
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: screenWidth > 1200 ? 1.5 : 1.3,
                      ),
                      children: cardsToShow,
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
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/product_detail.dart';
// import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
// // import 'package:spotstock_inventory/utils/role_detector.dart'; // Add this import
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

//   void _showOutOfStockProducts() async {
//     final products = await widget.systemProvider.getProducts(0);
//     final outOfStockProducts = products
//         .where((product) => product['attributes']['stock']['quantity'] == 0)
//         .toList();

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => DraggableScrollableSheet(
//         initialChildSize: 0.7,
//         minChildSize: 0.4,
//         maxChildSize: 0.9,
//         expand: false,
//         builder: (context, scrollController) => Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Out of Stock Products",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: outOfStockProducts.isEmpty
//                   ? const Center(child: Text("No out-of-stock products found"))
//                   : GridView.builder(
//                       controller: scrollController,
//                       padding: const EdgeInsets.all(16.0),
//                       itemCount: outOfStockProducts.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4,
//                         crossAxisSpacing: 16,
//                         mainAxisSpacing: 16,
//                         childAspectRatio: 1.5,
//                       ),
//                       itemBuilder: (context, index) {
//                         var product = outOfStockProducts[index]['attributes'];
//                         return ProductDetails(product: product);
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Method to build store-specific cards
//   List<Widget> _buildStoreCards() {
//     return [
//       HomeCard(
//           title: "Products",
//           value: "${widget.systemProvider.dashboardStats['productCount'] ?? '0'}"),
//       HomeCard(
//           title: "In Stock",
//           value: "${widget.systemProvider.dashboardStats['productStockOut'] ?? '0'}"),
//       HomeCard(
//           title: "Out of stock",
//           value: "${widget.systemProvider.dashboardStats['productsOutOfStock'] ?? '0'}",
//           onViewPressed: _showOutOfStockProducts),
//       HomeCard(
//           title: "Categories",
//           value: "${widget.systemProvider.dashboardStats['categoryCount'] ?? '0'}"),
//       // HomeCard(
//       //     title: "Customers",
//       //     value: "${widget.systemProvider.dashboardStats['customerCount'] ?? '0'}"),
//     ];
//   }

//   // Method to build hotel-specific cards
//   List<Widget> _buildHotelCards() {
//     return [
//       HomeCard(
//           title: "Customers",
//           value: "${widget.systemProvider.dashboardStats['customerCount'] ?? '0'}"),
//       HomeCard(
//           title: "Hotel Categories",
//           value: "${widget.systemProvider.dashboardStats['hotelCategoryCount'] ?? '0'}"),
//       HomeCard(
//           title: "Hotel Amenities",
//           value: "${widget.systemProvider.dashboardStats['hotelAmenityCount'] ?? '0'}"),
//       HomeCard(
//           title: "Hotel Rooms",
//           value: "${widget.systemProvider.dashboardStats['hotelRoomCount'] ?? '0'}"),
//     ];
//   }

//   // Method to build super admin cards (all cards)
//   List<Widget> _buildSuperAdminCards() {
//     return [
//       ..._buildStoreCards(),
//       ..._buildHotelCards(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;

//     // Determine which cards to show based on user role
//     List<Widget> cardsToShow;
//     if (widget.user.isSuperAdmin) {
//       cardsToShow = _buildSuperAdminCards();
//     } else if (widget.user.isHotelAdmin) {
//       cardsToShow = _buildHotelCards();
//     } else {
//       cardsToShow = _buildStoreCards();
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//       child: SingleChildScrollView(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxHeight: MediaQuery.of(context).size.height,
//               ),
//               child: SizedBox(
//                 width: 250,
//                 child: widget.app == "HOTEL"
//                     ? SideBarHotel(
//                         vertical: 20,
//                         user: widget.user,
//                         systemProvider: widget.systemProvider,
//                       )
//                     : SideBarInventory(
//                         vertical: 20,
//                         user: widget.user,
//                         systemProvider: widget.systemProvider,
//                         activeItem: _activeItem,
//                       ),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Header(
//                     user: widget.user,
//                     systemProvider: widget.systemProvider,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: GridView(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                         maxCrossAxisExtent: 300,
//                         crossAxisSpacing: 16,
//                         mainAxisSpacing: 16,
//                         childAspectRatio: screenWidth > 1200 ? 1.5 : 1.3,
//                       ),
//                       children: cardsToShow,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }